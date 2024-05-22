(local (w-px h-px) (love.window.getMode))
(local scale (/ w-px 10))

(fn universe []
  (-> (love.graphics.newFont :font/ProggyTiny.ttf scale)
      (love.graphics.setFont))
  (love.graphics.setBackgroundColor (/ 210 255) (/ 180 255) (/ 40 255)) ; NOTE: not RBG, [0,1]
  ;; screen
  (love.graphics.setColor (love.math.colorFromBytes 30 30 30))
  (love.graphics.rectangle :fill 30 15 (- w-px 45) (- h-px 60))
  ;; screen gradient
  (love.graphics.setColor (love.math.colorFromBytes 35 35 35))
  (love.graphics.rectangle :fill 70 45 (- w-px 110) (- h-px 115) 100 100)
  ;; border shadow
  (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
  (love.graphics.rectangle :fill 30 15 20 (- h-px 60))
  (love.graphics.rectangle :fill 30 15 (- w-px 45) 10))

(fn tput [s i j]
  (let [i (* 30 i)
        j (* 40 j)]
    ;; black 'shadow' character at an offset, to be partially drawn over
    (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
    (love.graphics.print s (+ i 5) (+ j 5))
    ;; character itself
    (love.graphics.setColor (love.math.colorFromBytes 255 127 0))
    (love.graphics.print s i j)))

(fn titlescreen [title-cursor]
  ;; TODO: decorate (authors? press enter? controls? diagram?)
  (tput "$ ./soko.bin" 2 1)
  (not title-cursor))

(fn render [game]
  (tput (string.format "$ ./soko.bin") 2 1)
  (tput game.puzzle.dynamic.moves 16 1)
  (tput (.. :# game.number) 21 1)
  (each [tile locs (pairs {"#" game.puzzle.static.walls
                           :! game.puzzle.static.sinks
                           :O game.puzzle.dynamic.blocks
                           :u [game.puzzle.dynamic.avi]})]
    (each [_ [ii jj] (ipairs locs)]
      (tput tile (+ ii 2) (+ jj 1)))))

{: universe : render : titlescreen}
