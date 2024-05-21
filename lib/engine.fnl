(fn tick [event world state]
  ;; handle interrupting keypresses
  (when (= :escape event) (love.event.quit))
  ;; TODO: button to reset puzzle in case of unwinnable state
  ;; new state
  (let [[x y] state.avi
        direction (. {:w :up :a :left :s :down :d :right} event)]
    ;; TODO: collision detection based on direction pressed
    {:avi (case direction
            :up [x (- y 1)]
            :left [(- x 1) y]
            :down [x (+ y 1)]
            :right [(+ x 1) y]
            nil [x y])
     ;; TODO: update blocks based on collision
     :blocks state.blocks
     :moves (+ state.moves 1)}))

(fn won? [world state]
  ;; TODO: some kind of equality check between state.blocks and world.sinks
  false)

{: tick}
