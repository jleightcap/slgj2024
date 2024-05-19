(local grid (require :lib.grid))
(local lume (require :lume))
(local tick (require :tick))

(local state {:x 100 :y 100})
(local (w h) (love.window.getMode))

(local keys {:w [:y -1] :a [:x -1] :s [:y 1] :d [:x 1]})
(local state {:x 100 :y 100})

(fn love.keypressed [key]
  (when (= :escape key) (love.event.quit)))

;;; TODO: function frame -> frame rather than tset/set
(fn frame []
  (local (speed) (values 30))
  (each [key action (pairs keys)]
    (let [[axis change] action]
      (when (love.keyboard.isDown key)
        (tset state axis (+ (. state axis) (* change speed))))))
  (when (or (< state.y 0) (> state.y h))
    (set state.y (lume.clamp state.y 0 h)))
  (when (or (< state.x 0) (> state.x w))
    (set state.x (lume.clamp state.x 0 w))))

(fn love.load []
  ;; set up event scheduling
  (tick.recur (lambda [] (frame)) (/ 1 10))
  ;; screen border
  (love.graphics.rectangle :line 10 10 (- w 10) (- h 10)))

(fn love.update [dt]
  (tick.update dt))

(fn love.draw []
  (love.graphics.rectangle :fill state.x state.y 10 10))
