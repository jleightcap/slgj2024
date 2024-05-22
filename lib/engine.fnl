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
  ;; TODO: some kind of equality check between dynamic.blocks and static.sinks
  false)

{: tick}
