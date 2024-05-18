(local (speed ball-speed) (values 10 200))
(local state {:x 100 :y 100})
(local (w h) (love.window.getMode))

(local keys {:w [:up] :a [:left] :s [:down] :d [:right]})

(fn on-paddle? []
  (or (and (< state.x 20)
           (< state.left state.y (+ state.left 100)))
      (and (< (- w 20) state.x)
           (< state.right state.y (+ state.right 100)))))

(fn love.update [dt]
  -- (set state.x (+ state.x (* state.dx dt ball-speed)))
  -- (set state.y (+ state.y (* state.dy dt ball-speed)))
  (each [key action (pairs keys)]
    (when (love.keyboard.isDown key)
      (tset state player (+ (. state player) (* dir speed))))))

  (when (or (< state.y 0) (> state.y h))
    (set state.dy (- 0 state.dy)))

  (when (on-paddle?)
    (set state.dx (- 0 state.dx)))

  (when (< state.x 0)
    (print "Right player wins")
    (love.event.quit))
  (when (> state.x w)
    (print "Left player wins")
    (love.event.quit)))

(fn love.keypressed [key]
  (when (= "escape" key) (love.event.quit)))

(fn love.draw []
  (love.graphics.rectangle "fill" 10 state.left 10 100)
  (love.graphics.rectangle "fill" (- w 10) state.right 10 100)
  (love.graphics.circle "fill" state.x state.y 10))
