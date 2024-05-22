(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local parser (require :lib.parse))
(local engine (require :lib.engine))

;; TODO: mess
(fn load-puzzle [number]
  (let [puzzle (-> (string.format "puzzles/microban-%d.txt" number)
                   parser.parse)]
    (do
      (tset puzzle :initial puzzle.dynamic)
      puzzle)))

;; TODO: mess
(fn load-game []
  (let [game {;; current microban puzzle number
              :number 1
              ;; :mode one of :titlescreen :puzzle
              :mode :titlescreen}]
    (do
      (tset game :puzzle (load-puzzle game.number))
      game)))

(local game (load-game))

(fn love.draw []
  ;; TODO: this is re-drawing some constant parts of the screen
  ;; refactor into one-time setup and continuous components
  (style.universe)
  (case game.mode
    :titlescreen (style.titlescreen)
    :puzzle (style.render game.puzzle)))

(fn love.keypressed [event]
  (case event
    :escape (case game.mode
              :titlescreen (love.event.quit)
              :puzzle (set game.mode :titlescreen))
    :return (case game.mode :titlescreen (set game.mode :puzzle))
    :n (case game.mode
         :puzzle (do
                   (set game.number (+ game.number 1))
                   (set game.puzzle (load-puzzle game.number))))
    :r (set game.puzzle.dynamic game.puzzle.initial)
    (where (or :w :a :s :d))
    (->> (engine.tick event game.puzzle.static game.puzzle.dynamic)
         (set game.puzzle.dynamic))))
