(local (w-px h-px) (love.window.getMode))
(local scale (/ w-px 10))

(fn universe []
  (-> (love.graphics.newFont :font/ProggyTiny.ttf scale)
      (love.graphics.setFont))
  (love.graphics.setBackgroundColor (/ 43 255) (/ 43 255) (/ 43 255))
  ;; screen gradient
  (love.graphics.setColor (love.math.colorFromBytes 47 47 47))
  (love.graphics.rectangle :fill (/ w-px 5) (/ h-px 3) w-px h-px 200 200)
  ;; border
  (love.graphics.setColor (love.math.colorFromBytes 153 117 90))
  (love.graphics.rectangle :fill 0 0 30 h-px)
  (love.graphics.rectangle :fill 0 0 w-px 15)
  ;; border shadow
  (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
  (love.graphics.rectangle :fill 30 15 20 h-px)
  (love.graphics.rectangle :fill 30 15 w-px 10))

(fn tput [s i j]
  (let [i (* 30 i)
        j (* 40 j)]
    ;; black 'shadow' character at an offset, to be partially drawn over
    (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
    (love.graphics.print s (+ i 5) (+ j 5))
    ;; character itself
    (love.graphics.setColor (love.math.colorFromBytes 255 204 153))
    (love.graphics.print s i j)))

(fn render [game]
  (tput (.. "[löve:soko]$ " game.dynamic.moves) 2 1)
  (each [tile locs (pairs {"#" game.static.walls
                           :! game.static.sinks
                           :O game.dynamic.blocks
                           :u [game.dynamic.avi]})]
    (each [_ [ii jj] (ipairs locs)]
      (tput tile (+ ii 1) (+ jj 1)))))

{: universe : render}
