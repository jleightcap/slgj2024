(local lume (require :lume))

(local graphics (require :lib.graphics))
(local puzzle (require :lib.puzzle))
(local puzzle (puzzle.parse :puzzles/microban-1.txt))

(local (w-px h-px) (love.window.getMode))
(assert (= (/ w-px h-px) (/ 4 3)))
(local subdivisions 4)
(local (w h) (values (* 4 subdivisions) (* 3 subdivisions)))
(local (w-scale h-scale) (values (/ w-px w) (/ h-px h)))
(local state {; actor coordinates
              :x 1
              :y 1
              ; actor direction
              :direction :none})

(fn love.load []
  (love.graphics.setBackgroundColor 255 255 255))

(fn love.draw []
  (love.graphics.scale w-scale h-scale)
  ;; screen border
  ;; (love.graphics.rectangle :line 0 0 w h)

  (fn render-tile [ii jj]
    (love.graphics.rectangle :fill (- ii 1) (- jj 1) 1 1))

  (each [jj line (pairs puzzle)]
    (each [ii tile (pairs line)]
      (case tile
        :wall (do
                (love.graphics.setColor (love.math.colorFromBytes 70 70 70))
                (render-tile ii jj))
        :block (do
                 (love.graphics.setColor (love.math.colorFromBytes 255 0 0))
                 (render-tile ii jj))
        :sunk (do
                (love.graphics.setColor (love.math.colorFromBytes 0 255 0))
                (render-tile ii jj))
        :hole (do
                (love.graphics.setColor (love.math.colorFromBytes 0 0 0))
                (render-tile ii jj))
        :avi (do
               (love.graphics.setColor (love.math.colorFromBytes 0 0 255))
               (love.graphics.rectangle :fill state.x state.y 1 1))))))

(fn tick [] ; movement
  (case state.direction
    :up (set state.y (- state.y 1))
    :left (set state.x (- state.x 1))
    :down (set state.y (+ state.y 1))
    :right (set state.x (+ state.x 1)))
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
  ;; advance frame
  (tick))
