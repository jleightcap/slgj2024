(fn tick [direction static dynamic]
  (let [[x y] dynamic.avi]
    ;; TODO: update blocks based on collision
    {:avi (case direction
            :w [x (- y 1)]
            :a [(- x 1) y]
            :s [x (+ y 1)]
            :d [(+ x 1) y])
     :blocks dynamic.blocks
     :moves (+ dynamic.moves 1)}))

(fn won? [static dynamic]
  ;; TODO: some kind of equality check between dynamic.blocks and static.sinks
  false)

{: tick}
