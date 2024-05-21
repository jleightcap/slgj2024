(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local puzzle (require :lib.parse))

(local (w-px h-px) (values style.w-px style.h-px))
(local scale style.scale)

(local (world state) (let [parsed (puzzle.parse :puzzles/microban-1.txt)
                           static {:walls parsed.walls :sinks parsed.sinks}
                           [x y] parsed.avi
                           dynamic {: x
                                    : y
                                    :blocks parsed.blocks
                                    :direction :none
                                    :moves 0}]
                       (values static dynamic)))

(local font (love.graphics.newFont :font/ProggyTiny.ttf scale))
(love.graphics.setFont font)
(love.graphics.setBackgroundColor (/ 43 255) (/ 43 255) (/ 43 255))

(fn love.draw []
  (style.monitor)
  (style.tput (.. "[löve:soko]$ " state.moves) 2 1)
  (each [tile locs (pairs {"#" world.walls
                           :! world.sinks
                           :O state.blocks
                           :u [[state.x state.y]]})]
    (each [_ [ii jj] (ipairs locs)]
      (style.tput tile (+ ii 1) (+ jj 1)))))

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
