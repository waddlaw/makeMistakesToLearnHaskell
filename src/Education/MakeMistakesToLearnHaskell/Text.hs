{-# OPTIONS_GHC -Wno-unused-imports #-}

module Education.MakeMistakesToLearnHaskell.Text
  ( canonicalizeNewlines
  , decodeUtf8
  , readUtf8File
  , writeUtf8FileS
  , removeAllTrailingSpace
  ) where


#include <imports/external.hs>


canonicalizeNewlines :: ByteString -> Text
canonicalizeNewlines = Text.replace "\r\n" "\n" . decodeUtf8


decodeUtf8 :: ByteString -> Text
decodeUtf8 = TextEncoding.decodeUtf8With handler
  where
    handler _ (Just _) = Just ' '
    handler cause nothing =
      throw $ TextEncoding.DecodeError cause nothing


readUtf8File :: FilePath -> IO Text
readUtf8File path = do
  hd <- IO.openFile path IO.ReadMode
  IO.hSetEncoding hd IO.utf8
  Text.hGetContents hd


writeUtf8FileS :: FilePath -> TextS.Text -> IO ()
writeUtf8FileS path dat =
  IO.withFile path IO.WriteMode $ \hd -> do
    IO.hSetEncoding hd IO.utf8
    TextS.hPutStr hd dat


removeAllTrailingSpace :: Text -> Text
removeAllTrailingSpace = Text.unlines . map Text.stripEnd . Text.lines
