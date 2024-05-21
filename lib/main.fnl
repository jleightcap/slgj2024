(local lume (require :lume))
(local fun (require :fun))

(local graphics (require :lib.graphics))
(local puzzle (require :lib.parse))

(local (world state) (let [parsed (puzzle.parse :puzzles/microban-1.txt)
                           static {:walls parsed.walls :sinks parsed.sinks}
                           [x y] parsed.avi
                           dynamic {: x
                                    : y
                                    :blocks parsed.blocks
                                    :direction :none
                                    :moves 0}]
                       (values static dynamic)))

(local (w-px h-px) (love.window.getMode))
(assert (= (/ w-px h-px) (/ 4 3)))
(local scale (/ w-px 10))
(local font (love.graphics.newFont :font/ProggyTiny.ttf scale))
(fn love.load []
  (love.graphics.setFont font))

(love.graphics.setBackgroundColor (/ 43 255) (/ 43 255) (/ 43 255))
(fn love.draw []
  (fn tput [s i j]
    (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
    (love.graphics.print s (+ i 5) (+ j 5))
    (love.graphics.setColor (love.math.colorFromBytes 255 204 153))
    (love.graphics.print s i j))

  ;; border
  (love.graphics.setColor (love.math.colorFromBytes 153 117 90))
  (love.graphics.rectangle :fill 0 0 30 h-px)
  (love.graphics.rectangle :fill 0 0 w-px 15)
  ;; border shadow
  (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
  (love.graphics.rectangle :fill 30 15 15 h-px)
  (love.graphics.rectangle :fill 30 15 w-px 10)
  ;; terminal screen
  (tput (.. "[soko:slgj24]$ LÖVE " state.moves) 60 40)
  (each [tile locs (pairs {"#" world.walls
                           :O world.sinks
                           "!" state.blocks
                           "@" [[state.x state.y]]})]
    (each [_ [ii jj] (ipairs locs)]
      (tput tile (* 30 (+ ii 1)) (* 40 (+ jj 1))))))

(fn tick []
  (case state.direction
    :up (set state.y (- state.y 1))
    :left (set state.x (- state.x 1))
    :down (set state.y (+ state.y 1))
    :right (set state.x (+ state.x 1)))
  (set state.moves (+ state.moves 1))
  ;; clamp at screen boundaries
  (when (or (< state.y 0) (<= h-px state.y))
    (set state.y (lume.clamp state.y 0 (- h-px 1))))
  (when (or (< state.x 0) (<= w-px state.x))
    (set state.x (lume.clamp state.x 0 (- w-px 1)))))

(fn love.keypressed [event]
  ;; handle keypresses
  (when (= :escape event) (love.event.quit))
  (set state.direction :none)
  (let [keys {:w :up :a :left :s :down :d :right}]
    (each [key direction (pairs keys)]
      (when (= event key)
        (set state.direction direction))))
  ;; use keypress event to trigger tick
  (tick))
