(local parser (require :lib.parse))
(local fun (require :fun))

(fn tick [event puzzle]
  (let [[x y] puzzle.dynamic.avi]
    ;; TODO: update blocks based on collision
    ;; NOTE: construction of keys matching parse.fnl
    {:avi (case event
            :w [x (- y 1)]
            :a [(- x 1) y]
            :s [x (+ y 1)]
            :d [(+ x 1) y])
     :blocks puzzle.dynamic.blocks
     :moves (+ puzzle.dynamic.moves 1)}))

(fn won? [game]
  ;; NOTE: game.puzzle.static tiles are pre-sorted on construction (see: parser.invariants)
  (parser.inplace-sort-tile game.puzzle.dynamic.blocks)
  (fun.all (lambda [[x1 y1] [x2 y2]] (and (= x1 x2) (= y1 y2)))
           (fun.zip game.puzzle.static.sinks game.puzzle.dynamic.blocks)))

{: tick : won?}
