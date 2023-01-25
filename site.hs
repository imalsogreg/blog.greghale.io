--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith myConfig $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*.css" $ do
        route   idRoute
        compile compressCssCompiler

    match "css/*.ttf" $ do
        route   idRoute
        compile copyFileCompiler

    match (fromList ["about.rst", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        vertigoCtx <- preprocess vertigoChartCtx
        let ctx = postCtx `mappend` vertigoCtx
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

    create ["vertigo-chart.html"] $ do
      vertigoCtx <- preprocess vertigoChartCtx
      let chartCtx = vertigoCtx <> defaultContext
      route idRoute
      compile $ do
        makeItem ""
          >>= loadAndApplyTemplate "templates/vertigo-chart.html" chartCtx
          >>= loadAndApplyTemplate "templates/post.html" chartCtx
          >>= loadAndApplyTemplate "templates/default.html" chartCtx
          >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "CNAME" $ do
      route idRoute
      compile copyFileCompiler

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

myConfig :: Configuration
myConfig = defaultConfiguration { destinationDirectory = "./docs/" }

vertigoChartCtx :: IO (Context String)
vertigoChartCtx = do
  return $
    constField "testing" "Hello"
    <> constField "vertigo-chart-code" "alert('Hello');"
