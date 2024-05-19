(local lume (require :lume))

(local (speed ball-speed) (values 10 200))
(local state {:x 100 :y 100})
(local (w h) (love.window.getMode))

(local keys {:w [:y -1] :a [:x -1] :s [:y 1] :d [:x 1]})

(local (speed) (values 10))
(local state {:x 100 :y 100})
(local (w h) (love.window.getMode))

(fn love.update [dt]
  ;; continuous behavior
  ;; (set state.x (+ state.x 1))

  ;; keypress
  (each [key action (pairs keys)]
    (let [[axis change] action]
      (when (love.keyboard.isDown key)
        (tset state axis (+ (. state axis) (* change speed))))))

  ;; conditionals for dynamic behavior, responding to input
  (when (or (< state.y 0) (> state.y h))
    (set state.y (mod state.y state.y)))
  (when (or (< state.x 0) (> state.x w))
    (set state.x (- 0 state.x))))

(fn love.keypressed [key]
  (when (= :escape key) (love.event.quit)))

(fn love.draw []
  ;; (love.graphics.circle "fill" 30 40 10)
  (love.graphics.rectangle :fill state.x state.y 10 100))
