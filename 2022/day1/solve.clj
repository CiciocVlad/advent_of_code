(require '[clojure.string :as str])

(defn split [arg]
  (loop [res (split-with (complement #{""}) arg)
		 result []]
	(if (= (first res) ())
	  result
	  (recur (split-with (complement #{""}) (rest (first (rest res)))) (conj result (first res))))))

(defn turn_to_int [arg]
  (cond
	(empty? arg) nil
	(= (first arg) "") (recur (rest arg))
	:else (cons (Integer/parseInt (first arg)) (turn_to_int (rest arg)))))

(defn get_arr [string]
  (def lines (str/split string #"\n"))
  (->>
	lines
	(split)
	(map turn_to_int)
	(map #(reduce + %))))

(defn get_max [string]
  (apply max (get_arr string)))

(defn get_top_3 [string]
  (->>
	string
	(get_arr)
	(sort)
	(reverse)
	(take 3)))

(defn get_result [string]
  (def part1 (get_max string))
  (def part2 (apply + (get_top_3 string)))
  (str "part 1: " part1 "\npart 2: " part2 "\n"))

(defn main []
  (let [input (read-line)]
	(println (get_result (slurp input)))))

(main)
