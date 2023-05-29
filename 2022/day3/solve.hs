import Data.List
import Data.Maybe

getHalf :: [a] -> Int
getHalf = (flip div) 2 . length

halves :: [a] -> ([a], [a])
halves = (,) . (take . getHalf <*> id) <*> (drop . getHalf <*> id)

same :: Eq a => ([a], [a]) -> [a]
same ([], _) = []
same (x:xs, ys)
  | x `elem` ys = x : same (xs, delete x ys)
  | otherwise = same (xs, ys)

getDuplicate :: String -> Char
getDuplicate = head . same . halves

count :: String -> Int
count str = fst $ fromMaybe (0, 'a') $ find ((==c) . snd) arr
  where c = getDuplicate str
        arr = if c <= 'Z' then zip [27..52] ['A'..'Z'] else zip [1..26] ['a'..'z']

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n l = (take n l) : (chunks n (drop n l))

elves :: [String] -> String
elves = map head . map (foldl (curry same) . head <*> tail) . chunks 3

countStickers :: String -> [Int]
countStickers = map (\x -> fst $ fromMaybe (0, 'a') $ find ((==x) . snd) $ if x <= 'Z'
                                                                              then zip [27..52] ['A'..'Z']
                                                                              else zip [1..26] ['a'..'z'])

main :: IO ()
main = interact $ show . sum . countStickers . elves . lines
