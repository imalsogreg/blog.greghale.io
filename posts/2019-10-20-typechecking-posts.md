---
title: Typechecking code in a Hakyll blog
description: Easy setup for hacking on Literate Haskell blog posts
tags: haskell, nix
---

# Typechecking code in a Hakyll blog

After years of programming in Haskell, my natural ability to
scrutinize my code for type errors (and even more mundane things,
like parse errors and spelling errors) has atrophied. Usually
my friends `ghc` and `ghcid` take care of this for me so I can
think about other things.

Recovering this workflow when writing _blog posts_ took a little
time.

## Literate Haskell

`Hakyll` handles Literate Haskell files already - you don't have
to do any work. Just create a file in `posts/` with the `.lhs`
file extension.

The format is described well in the
[Haskell Wiki](https://wiki.haskell.org/Literate_programming).
The only features I've used so far are

### Code blocks

Most of my code blocks are long, so I prefer the latex-like
command over bird-tracks

```latex
\begin{code}
example = do
  x <- getTheX
  useX x
\end{code}
```

### Hidden imports

Of course we need to import some modules if `ghc` is to
typecheck our `.lhs` file. Since the imports are often not
important to the explanation in the blog, I hide them.

Imaginary functions that I will later use in the blog post
but which aren't important to the topic at hand can be defined
here, too.

```latex
\long\def\ignore#1{}

\ignore{
\begin{code}
{-# LANGUAGE ScopedTypeVariables, OverloadedStrings, TypeApplications #-}
import qualified Servant.Server as Servant
import Servant.API ((:<|>), (:>))
import qualified Database.PostgreSQL.Simple as PG

processInputs :: Inputs -> IO Outputs
processInputs = undefined
\end{code}
```

## nix-shell

A separate `nix-shell` is available for every post, in `shells.nix`.
At the top of this file is a record that maps post names to the names
of `Haskell` packages that I need to have in scope. There's only one
entry at the time of writing, because I only have one Literate Haskell
blog post:

```nix
let
  shellPkgs =
    { config-phases = ["generic-lens" "lens" "postgresql-simple" "katip"]; };
```

Later in the file, these lists are turned into derivations, so that I
can say

```bash
nix-shell ./shells.nix -A config-phases \
  --run 'ghcid --command "ghci posts/2019-10-17-config-phase.lhs"'
```

and now `ghcid` is recompiling my post and showing me the type errors
every time the post is saved.
