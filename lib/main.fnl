(local lume (require :lume))
(local grid (require :lib.grid))

(local (speed ball-speed) (values 10 200))
(local state {:x 100 :y 100})
(local (w h) (love.window.getMode))

(local keys {:w [:y -1] :a [:x -1] :s [:y 1] :d [:x 1]})

(local (speed) (values 10))
(local state {:x 100 :y 100})

(fn love.update [dt]
  ;; continuous behavior
  ;; (set state.x (+ state.x 1))
  ;; keypress
  (each [key action (pairs keys)]
    (let [[axis change] action]
      (when (love.keyboard.isDown key)
        (tset state axis (+ (. state axis) (* change speed))))))
  (print w h state.x state.y)
  (print (lume.clamp state.x 0 w))
  ;; conditionals for dynamic behavior, responding to input
  (when (or (< state.y 0) (> state.y h))
    (set state.y (lume.clamp state.y 0 h)))
  (when (or (< state.x 0) (> state.x w))
    (set state.x (lume.clamp state.x 0 w))))

(fn love.keypressed [key]
  (when (= :escape key) (love.event.quit)))

(fn love.draw []
  (love.graphics.rectangle :fill state.x state.y 10 10)
  ;; draw bounding rectangle
  (love.graphics.rectangle :line 10 10 (- w 10) (- h 10)))
