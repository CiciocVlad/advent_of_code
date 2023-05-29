import Data.List.Split
import Control.Monad

type Pair = [Int]

comp :: (Int -> Int -> Bool) -> (Pair -> Int) -> (Pair -> Int) -> [Pair] -> Bool
comp f g h = liftM2 f (g . head) (h . last)

firstContained :: [Pair] -> Bool
firstContained = (&&) . (comp (<=) head head) <*> (comp (>=) last last)

secondContained :: [Pair] -> Bool
secondContained = (&&) . (comp (>=) head head) <*> (comp (<=) last last)

fullyContained :: [Pair] -> Bool
fullyContained = (||) . firstContained <*> secondContained

partiallyOverlap :: [Pair] -> Bool
partiallyOverlap = (&&) . (comp (<=) head last) <*> (comp (>=) last head)

main :: IO ()
main = interact $ show
                  . length
                  . filter (==True)
                  . map partiallyOverlap
                  . map (map (map read . splitOn "-") . splitOn ",")
                  . lines

