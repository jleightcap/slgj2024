(local (w-px h-px) (love.window.getMode))
(local scale (/ w-px 10))

(local background (love.graphics.newImage :bg.png))
(local font (love.graphics.newFont :font/ProggyTiny.ttf scale))
(fn universe []
  (love.graphics.setFont font)
  (love.graphics.draw background 0 0))

(fn tput [s i j]
  (let [i (+ 30 (* 25 i))
        j (+ 30 (* 40 j))]
    ;; black 'shadow' character at an offset, to be partially drawn over
    (love.graphics.push :all)
    (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
    (love.graphics.print s (+ i 4) (+ j 4))
    ;; character itself
    (love.graphics.setColor (love.math.colorFromBytes 255 127 0))
    (love.graphics.print s i j)
    (love.graphics.pop)))

(fn help []
  (tput "*r   | restart" 4 2)
  (tput "*esc | back" 4 3)
  (tput "*b   | boss key" 4 4)
  (tput "u    | you" 4 5)
  (tput "!" 4 6)
  (tput "O/O  | push on" 4 6)
  (tput "!    | switch" 4 7))

(fn titlescreen [title-cursor]
  ;; TODO: decorate (authors? press enter? controls? diagram?)
  (tput "$ ./soko.bin" 5 5)
  (not title-cursor))

(fn render [game]
  (tput (string.format :./soko.bin) 2 1)
  (tput (.. "#" game.number) 12 1)
  (tput game.puzzle.dynamic.moves 16 1)
  (each [tile locs (pairs {"#" game.puzzle.static.walls
                           :! game.puzzle.static.sinks
                           :O game.puzzle.dynamic.blocks
                           :u [game.puzzle.dynamic.avi]})]
    (each [_ [ii jj] (ipairs locs)]
      (tput tile (+ ii 2) (+ jj 1)))))

{: universe : render : titlescreen : help}
