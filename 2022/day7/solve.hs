import Data.List
import Data.Char

getSize :: [Int] -> [Int] -> [String] -> [Int]
getSize sizes folders [] = reverse folders ++ sizes
getSize sizes (folder:folders) ("$ cd .." : input) = getSize (folder : sizes) folders input
getSize sizes folders (x:xs)
  | isPrefixOf "$ cd" x = getSize sizes (0 : folders) xs
  | isDigit $ head x = getSize sizes (map (+ (read $ head $ words x)) folders) xs
  | otherwise = getSize sizes folders xs

toDelete :: [Int] -> Int
toDelete i = head $ sort $ filter ((>= 30000000) . (+) availableSpace) i
  where availableSpace = 70000000 - head i

main :: IO ()
main = interact $ show . toDelete . getSize [] [] . lines

