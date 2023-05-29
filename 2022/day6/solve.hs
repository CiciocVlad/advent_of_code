import Data.List

allDifferent :: Int -> String -> Int
allDifferent index (x : xs)
    | take 14 (x : xs) == (nub $ take 14 (x : xs)) = index
    | otherwise = allDifferent (index + 1) xs

main :: IO ()
main = interact $ show . allDifferent 14
