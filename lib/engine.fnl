(fn tick [event static dynamic]
  ;; handle interrupting keypresses
  (when (= :escape event) (love.event.quit))
  ;; TODO: button to reset puzzle in case of unwinnable dynamic
  ;; new dynamic
  (let [[x y] dynamic.avi
        direction (. {:w :up :a :left :s :down :d :right} event)]
    ;; TODO: collision detection based on direction pressed
    {:avi (case direction
            :up [x (- y 1)]
            :left [(- x 1) y]
            :down [x (+ y 1)]
            :right [(+ x 1) y]
            nil [x y])
     ;; TODO: update blocks based on collision
     :blocks dynamic.blocks
     :moves (+ dynamic.moves 1)}))

(fn won? [static dynamic]
  ;; TODO: some kind of equality check between dynamic.blocks and static.sinks
  false)

{: tick}
