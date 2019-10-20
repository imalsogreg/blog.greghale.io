---
title: Configuration phases
description: A pattern for connecting configuration data to capabilities
tags: Haskell
---

\long\def\ignore#1{}

\ignore{
\begin{code}
{-# LANGUAGE RecordWildCards, DeriveGeneric, DuplicateRecordFields, KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses, DataKinds, TypeFamilies, FunctionalDependencies #-}
{-# LANGUAGE AllowAmbiguousTypes, TypeApplications, FlexibleContexts, FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
import           Data.Text    (Text)
import           GHC.Generics (Generic)
import           Control.Lens
import qualified Katip
import qualified Database.PostgreSQL.Simple as PG
import qualified Data.Generics.Product.Constraints as GenericLens
loadConfig = undefined
\end{code}
}

<h2>Configuration sprawl</h2>

Have you found your configuration handling begins to sprawl as you add more
configuration to your program? This example makes two database connections
and allows the hostname and logging level to be configured. Imagine how
`main` might grow over time as different people follow the patterns they
find here while adding more parameters.

\begin{code}
data ConfigExample1 = ConfigExample1
  { hostname   :: Text
  , userDBUser :: String
  , userDBPass :: String
  , userDBDB   :: String
  , userDBPort :: Integer
  , userDBHost :: String
  , logLevel :: Katip.Severity
  , analysisDBUser :: String
  , analysisDBHost :: String
  , analysisDBPort :: Integer
  , analysisDBDB   :: String
  , analysisDBPass :: String
  } deriving (Generic)


main :: IO ()
main = do
  ConfigExample1{..} <- loadConfig "local.yaml"
  print "Connecting to User Database"
  userDB <- PG.connect PG.ConnectInfo
      { PG.connectUser     = userDBUser
      , PG.connectHost     = userDBHost
      , PG.connectPort     = fromIntegral userDBPort
      , PG.connectPassword = userDBPass
      , PG.connectDatabase = userDBDB
      }
  -- ... a block of initialization code
  -- ... maybe written by other team members
  --
  analysisDB <- PG.connect PG.ConnectInfo
      { PG.connectUser     = analysisDBUser
      , PG.connectHost     = analysisDBHost
      , PG.connectPort     = fromIntegral analysisDBPort
      , PG.connectPassword = analysisDBPass
      , PG.connectDatabase = analysisDBDB
      }  
  return ()


runBusinessLogic
  :: PG.Connection
  -> PG.Connection
  -> Katip.Severity
  -> String
  -> IO ()
runBusinessLogic userDB analysisDB logLevel myHostname = do
  undefined

\end{code}

What problems will we run into as we try to scale this program up?

 - *Flat format* Without organization, it's easy for config files
   and their parsers to become confusing
 - *Unchecked Redundancy* The fields of `ConfigExample1` correspond to
   the arguments of `runBusinessLogic`, but the correspondence is
   loose (we have a collection of `Text` and `Int` fields in the config
   but a `PG.Connection` in the arguments.
 - *Ad-hoc resource acquisition* The code used for reading config fields
   and creating resources from them can get messy quickly


<h2>Organizing configuration</h2>

We can address these problems and add a lot of structure to our
 configuration. Let's start by drawing a connection between
the configuration phase, and the running phase. We'll start by
using a single configuration type that abstracts over the _phase_
at which it is used:

\begin{code}
data ConfigF (p :: Phase) = Config
  { userDB     :: AtPhase p PG.Connection
  , analysisDB :: AtPhase p PG.Connection
  , hostname   :: Text
  , logLevel   :: Katip.Severity
  } deriving (Generic)

type Config    = ConfigF 'ConfigTime
type Resources = ConfigF 'RunTime
\end{code}

Some of our configuration fields are regular Haskell datatypes, like
`Text` and `Katip.Severity`. These values are specified and used in
the same way. But the `userDB` and `analysisDB` fields are defined
in terms of `Phase` and `AtPhase`, which we are about to define.

Accepting some complexity here allows us to share a single type definition
for specifying two things (a) the configuration _data_ and (b) the
configuration _result_, in one go.

Our `main` function will look mork like this:

\begin{code}
main' = do
  cfg :: Config    <- loadConfig "local.yaml"
  res :: Resources <- buildConfig cfg
  runBusinessLogic' res

runBusinessLogic' :: Resources -> IO ()
runBusinessLogic' = undefined
\end{code}

Whether the added complexity is worth it depends on a few things.

<ul>
  <li>
    <em>Configuration complexity</em> If your configuration is simple,
    then you don't benefit from deduplicating the configuration
    and runtime types
  </li>
  <li>
     <em>Complexity budget</em> We'll be adding a typeclass and
     a type family. If there are other aspects of your codebase
     that use your complexity budget, or if the budget is low
     for other reasons, then it's best to treat this technique
     as a fun curiosity. Use your budget on something with a
     higher power-to-weight ratio, like <a href="https://dhall-lang.org">dhall</a>
  </li>
</ul>

Let's build the required machinery.

First, we use <code>DataKinds</code> to
define a new kind <code>Phase</code>
inhabited by two types <code>'ConfigTime</code> and <code>'RunTime</code>
to specialize our application's configuration for one phase or the other.

\begin{code}
data Phase
  = ConfigTime
  | RunTime
\end{code}

Next, a type family will let us associate a configuration type
to a runtime type for some particular resource.

\begin{code}
class HasPhases t where
  type AtPhase (p :: Phase) t

instance HasPhases PG.Connection where
  type AtPhase 'ConfigTime PG.Connection = PG.ConnectInfo
  type AtPhase 'RunTime    PG.Connection = PG.Connection
\end{code}

Another typeclass allows the construction of a resource
from its configuration data. The two type parameters correspond
to the configtime and runtime types.

There is a catchall instance for cases when the configtime
type is the same as the runtime type. When we eventually
process our configuration record, the catchall instance will
apply to any field with a regular type, like our
<code>hostname</code> field. (It would also match any
<code>AtPhase</code> fields where configtime type is equal
to the runtime type.. but if we ever use <code>AtPhase</code>,
we would do that <em>in order to</em> let the types differ
across phases, so we won't encounter this case. Sorry for
the aside, I hope it makes sense)

\begin{code}
class ToRuntime cty rty where
  toRuntime :: cty -> IO rty

instance ToRuntime ty ty where
  toRuntime = return

instance ToRuntime PG.ConnectInfo PG.Connection where
  toRuntime = PG.connect
\end{code}

In order to have our <code>buildConfig</code> function, we
will use some fabulous magic from
[generic-lens](http://hackage.haskell.org/package/generic-lens).
Specifically, [<code>constraints</code>](http://hackage.haskell.org/package/generic-lens-1.2.0.1/docs/Data-Generics-Product-Constraints.html#v:constraints)
allows us to traverse a record, applying an effectful function
at every field with a type satisfying some particular constraint.

We choose that constraint to be our <code>ToRuntime</code> class.

Now we can write <code>buildConfig</code> without repeating any
details about the internals of our configuration record.

\begin{code}
buildConfig :: ConfigF ConfigTime -> IO (ConfigF RunTime)
buildConfig = GenericLens.constraints @ToRuntime toRuntime 
\end{code}

Summing up, we have removed a few types of duplication and
informality from the process of building runtime resources
from configuration data.

We parameterized a single configuration record by the
phase, either configuration time or runtime.

And we concentrated the work of instantiating a runtime
resource record from the configuration record into a very generic
function.

Was it worth it? In effect, we sacrificed <code>Haskell98</code>'s
simplicity at the alter of the DRY (Don't Repeat Yourself)
principle. Repetition is legitimately dangerous, especially
in a codebase with multiple authors, written in a language
where type safety encourages us to skimp on testing. The
competing interests here (redundancy vs. complexity) depend
on just how much redundancy you are cleaning up.


