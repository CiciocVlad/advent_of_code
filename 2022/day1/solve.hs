import Data.List.Split
import Data.List

get_arr :: String -> [Int]
get_arr = map (sum . map read) . splitWhen (=="") . lines

get_max :: String -> Int
get_max = maximum . get_arr

get_top_3 :: String -> [Int]
get_top_3 = take 3 . reverse . sort . get_arr

getResult :: String -> String
getResult str = "part 1: " ++ part1 ++ "\npart 2: " ++ part2 ++ "\n"
  where part1 = show $ get_max str
        part2 = show $ sum $ get_top_3 str

main :: IO ()
main = interact $ getResult
