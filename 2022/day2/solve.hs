import Data.List
import Data.Function
import Data.Maybe

data Outcome = Win | Lose | Draw deriving (Eq)

choices :: [String]
choices = ["Rock", "Paper", "Scissors"]

input :: [Char]
input = ['A', 'B', 'C']

convert :: Char -> Int
convert x = fromMaybe (-1) $ findIndex (elem x) ["AX", "BY", "CZ"]

winCondition :: String -> String -> Outcome
winCondition "Rock" "Scissors" = Lose
winCondition "Rock" "Paper" = Win
winCondition "Paper" "Scissors" = Win
winCondition "Paper" "Rock" = Lose
winCondition "Scissors" "Rock" = Win
winCondition "Scissors" "Paper" = Lose
winCondition _ _ = Draw

points :: Char -> Char -> Int
points a b
  | winCondition first second == Win = 6 + second_point + 1
  | winCondition first second == Lose = second_point + 1
  | winCondition first second == Draw = 3 + second_point + 1
  where first_point = convert a
        second_point = convert b
        first = choices !! first_point
        second = choices !! second_point

whatToPick :: Char -> Char -> Char
whatToPick 'A' 'Z' = 'B'
whatToPick 'A' 'X' = 'C'
whatToPick 'A' 'Y' = 'A'
whatToPick 'B' 'Z' = 'C'
whatToPick 'B' 'X' = 'A'
whatToPick 'B' 'Y' = 'B'
whatToPick 'C' 'Z' = 'A'
whatToPick 'C' 'X' = 'B'
whatToPick 'C' 'Y' = 'C'

partA :: [Char] -> Int
partA = points . head <*> last

partB :: [Char] -> Int
partB = points . head <*> (whatToPick . head <*> last)

main :: IO ()
main = interact $ show . sum . map partB . map (map head . words) . lines
