(local lume (require :lume))

(local graphics (require :lib.graphics))
(local puzzle (require :lib.puzzle))

(local (w-px h-px) (love.window.getMode))
(assert (= (/ w-px h-px) (/ 4 3)))
(local subdivisions 4)
(local (w h) (values (* 4 subdivisions) (* 3 subdivisions)))
(local (w-scale h-scale) (values (/ w-px w) (/ h-px h)))
(local (world state) (let [parsed (puzzle.parse :puzzles/microban-1.txt)
                           static {:walls parsed.walls :sinks parsed.sinks}
                           [avi-x avi-y] parsed.avi
                           dynamic {;; actor coordinates
                                    :x avi-x
                                    :y avi-y
                                    ;; blocks coordinates
                                    :blocks parsed.blocks
                                    ;; actor direction
                                    :direction :none}]
                       (values static dynamic)))

(fn love.load []
  ;; set background
  (love.graphics.setBackgroundColor 255 255 255))

(fn love.draw []
  (love.graphics.scale w-scale h-scale)
  ;; screen border
  (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
  (love.graphics.rectangle :line 0 0 w h)
  ;; render walls
  (love.graphics.setColor (love.math.colorFromBytes 70 70 70))
  (each [_ [ii jj] (ipairs world.walls)]
    (love.graphics.rectangle :fill ii jj 1 1))
  ;; render sinks
  (love.graphics.setColor (love.math.colorFromBytes 0 70 0))
  (each [_ [ii jj] (ipairs world.sinks)]
    (love.graphics.rectangle :fill ii jj 1 1))
  ;; render blocks (TODO: render different graphic for block in sink)
  (love.graphics.setColor (love.math.colorFromBytes 70 0 0))
  (each [_ [ii jj] (ipairs state.blocks)]
    (love.graphics.rectangle :fill ii jj 1 1))
  ;; render avatar
  (love.graphics.setColor (love.math.colorFromBytes 0 0 70))
  (love.graphics.rectangle :fill state.x state.y 1 1))

(fn tick []
  (case state.direction
    :up (set state.y (- state.y 1))
    :left (set state.x (- state.x 1))
    :down (set state.y (+ state.y 1))
    :right (set state.x (+ state.x 1)))
  ;; clamp at screen boundaries
  (when (or (< state.y 0) (<= h state.y))
    (set state.y (lume.clamp state.y 0 (- h 1))))
  (when (or (< state.x 0) (<= w state.x))
    (set state.x (lume.clamp state.x 0 (- w 1)))))

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
