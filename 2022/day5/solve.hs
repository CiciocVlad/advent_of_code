import Data.List
import Data.List.Split

type Stack = [String]

edit :: Int -> Int -> Int -> [Stack] -> [Stack]
edit move from to stacks = map (\x -> if fst x == from then new_from else if fst x == to then new_to else snd x) $ zip [1..] stacks
    where new_to = (take move $ stacks !! (from - 1)) ++ (stacks !! (to - 1))
          new_from = (drop move $ stacks !! (from - 1))

parseRequests :: String -> [Int]
parseRequests str = map read [move, from, to]
    where [_, move, _, from, _, to] = words str

parseInput :: [String] -> ([Stack], [[Int]])
parseInput [stacks, requests] = (map (filter (/="    ")) $ transpose $ map (chunksOf 4) $ lines stacks, map parseRequests $ lines requests)

solve :: ([Stack], [[Int]]) -> String
solve (stacks, []) = filter (`notElem` "[] ") $ unwords $ map head stacks
solve (stacks, [move, from, to] : requests) = solve (edit move from to stacks, requests)

main :: IO ()
main = interact $ solve . parseInput . splitOn "\n\n"
