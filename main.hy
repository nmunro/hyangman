(defn game-loop [data]
  (board data)
  (if (= (get data "lives") 0)
    "GAME OVER, YOU LOOSE!"
    (do
      (setv l (get-letter data))
      (if-not (= (word (into data :letters (doto (.get data "letters") (.append l)))) (.get data "word"))
        (game-loop
          (if (not (in l (.get data "word")))
            (into data :lives (- (.get data "lives") 1) :counter (inc (.get data "counter" 0)) :body (build-body data))
            data))
        (+ "GAME OVER, YOU WIN, THE WORD WAS: " (word data))))))

(defn board [data]
  (defn body-part [part]
    (.get (.get data "body") part " "))

  (print (+
    " |---|\n"
    (.format " |   {}\n" (body-part "head"))
    (.format " |  {}{}{}\n" (body-part "l_arm") (body-part "torso") (body-part "r_arm"))
    (.format " |  {} {}\n" (body-part "l_leg") (body-part "r_leg"))
    " |\n"
    " |------\n"
    " You've already used: [" (or (.join ", " (.get data "letters" [])) "No letters") "]\n"
    (.format " Lives: {} / Word: {}" (.get data "lives") (word data)))))

(defn into [data &kwargs kwargs]
  (setv new-data {})
  (for [(, k v) (.items data)]
    (assoc new-data k v))
  (for [(, k v) (.items kwargs)]
    (assoc new-data k v))
  new-data)

(defn get-letter [data]
  (setv x (.lower (first (input "Please enter a letter: "))))
  (if (or (not x) (in x (.get data "letters")))
    (get-letter data)
    x))

(defn build-body [data]
  (setv part (nth (.items (.get data "parts")) (.get data "counter")))
  (setv new-data (.get data "body"))
  (assoc new-data (first part) (second part))
  new-data)

(defn word [data]
  (.join "" (lfor l (.get data "word") (if (in l (.get data "letters")) l "_")))) 
