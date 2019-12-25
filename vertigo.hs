{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RankNTypes #-}

-- Vertigo blog post
module Main where

import Control.Monad.Fix
import Reflex.Dom
import qualified Reflex.Dom.Main as RMain
import Data.Text (Text)
import qualified Data.Text as Text
import Data.String.QQ (s)

#ifndef ghcjs_HOST_OS
import Language.Javascript.JSaddle.WebSockets
#endif

p1 :: Text
p1 = Text.pack [s|
To get into the right headspace, here is a vertigo simulator. You're
already familiar with the feeling of a room spinning - this happens as your eyes
repeatedly drift to one side, and jerk back to their starting position when they
reach the end of their travel. The muscles that move your eyes up and down can
do this too. And, as I was surprised to learn, there is a third direction in
which the eye muscles can dance the Nystagmus: they can twist. Your eyes
naturally twist as you tilt your head toward either shoulder, helping keep the
top of your eyeballs pointed toward the ceiling. The ability to twist is limited
of course - turning a cartwheel does not send your eyes for a full spin in your
head, just as doing a somersault doesn't. To experience twist-vertigo, play with
the "Roll" slider.
|]


vertigoPost
  :: forall t m.
     ( DomBuilder t m
     , DomBuilderSpace m ~ GhcjsDomSpace
     , PostBuild t m, MonadFix m)
  => m ()
vertigoPost = do
  elAttr "div" ("class" =: "ypr-and-content" <> "style" =: "display:flex; flex-direction: column-reverse; border-right: 10px solid lightgray") $ do
    rec
      ypr <- yawPitchRollWidget
      nystagmusContent ypr $ do
        el "p" (text p1)
      return ()
    return ()
  return ()


nystagmusContent
  :: ( DomBuilder t m
     , DomBuilderSpace m ~ GhcjsDomSpace
     , PostBuild t m)
  => YawPitchRoll t
  -> m a
  -> m ()
nystagmusContent YawPitchRoll{..} innerEl = do
  rec
  (container,_) <- elAttr' "div" ("class" =: "container" <> "style" =: "position:relative;") $ do
     el "style" $ dynText $ keyframes <$> yaw <*> pitch <*> roll
     (contained,a) <- elDynAttr' "div" (containedStyle <$> yaw <*> pitch <*> roll) $ innerEl
     return ()
  return ()
  where
    tshow = Text.pack . show
    containedStyle y p r =
      let
        animTime = (10 - maximum [y, p, r]) / 10
      in
        "style" =: ("animation-name: nystagmus; animation-timing-function:linear; animation-iteration-count:infinite; animation-duration:" <> tshow animTime <> "s;")
    keyframes y p r =
      let
        top  = p * 10
        left = y * 10
        rot =  r * 10
      in
        Text.unlines
        [ "@keyframes nystagmus {"
        , " 0%  { top: " <> tshow top <> "px; left: 0px; transform:rotate(0deg) translate(0px, " <> tshow top <> "px) }"
        , " 90% { top: 0px; left: "<> tshow left <> "px; transform:rotate("<> tshow rot <>"deg) translate(" <> tshow left <> "px, 0px)}"
        , " 100% { top: " <> tshow top <> "px; left: 0px; transform:rotate(0deg) translate(0px, " <> tshow top <> "px) }"
        ]



yawPitchRollWidget
  :: ( DomBuilder t m
     , DomBuilderSpace m ~ GhcjsDomSpace
     , PostBuild t m
     )
  => m (YawPitchRoll t)
yawPitchRollWidget = elClass "table" "xyz" $ do
  let
    sliderStyle  = "height:15px;border-radius:5px;"
    mySlider lbl =
      elClass "tr" "range-input" $ do
        el "td" $ text lbl
        ri <- el "td"    $
              rangeInput $
              RangeInputConfig
                0.01
                never
                (constDyn $ "min" =: "0.01" <> "max" =: "10")
        return $ value ri
  YawPitchRoll <$> mySlider "yaw" <*> mySlider "pitch" <*> mySlider "roll"
 
data YawPitchRoll t = YawPitchRoll
  { yaw   :: Dynamic t Float
  , pitch :: Dynamic t Float
  , roll  :: Dynamic t Float
  }

header :: DomBuilder t m => m ()
header = do
  el "style" $ text style
  where style = Text.pack [s|
body {
  background-color: white;
}

.range-input{
  z-order: 2;
}

.nystagmus {
  animation-name: nystagmus;
  animation-duration: 1s;
}

@keyframes nystagmus {
0% { left: 0px; }
95% { left: 20px; }
100% { left: 0px; }
}
|]

#ifndef ghcjs_HOST_OS
main = debug 8000 $ RMain.mainWidgetWithHead header vertigoPost
#else
main = RMain.mainWidgetInElementById "vertigo-simulator" vertigoPost
#endif
