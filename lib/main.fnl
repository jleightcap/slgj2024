(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local parser (require :lib.parse))
(local engine (require :lib.engine))

(fn load-puzzle [n]
  (->> n (.. :puzzles/microban-) (parser.parse) (parser.invariants)))

(local game {:number 1 :puzzle (load-puzzle 1) :mode :titlescreen})

(fn love.draw []
  ;; TODO: this is re-drawing some constant parts of the screen
  ;; refactor into one-time setup and continuous components
  (style.universe)
  (case game.mode
    :titlescreen (style.titlescreen)
    :solving (style.render game)))

(fn next-puzzle []
  (set game.number (+ game.number 1))
  (set game.puzzle (load-puzzle game.number)))

;; fnlfmt: skip
(fn love.keypressed [event]
  (case event
    (where (or :w :a :s :d))
      (do
        (->> (engine.tick event game.puzzle)
            (set game.puzzle.dynamic))
        (when (engine.won? game)
          (next-puzzle)))
    :escape (case game.mode
      :titlescreen (love.event.quit)
      :solving (set game.mode :titlescreen))
    :return (case game.mode
      :titlescreen (set game.mode :solving))
    ;; FIXME: debug
    ;; TODO: copy this logic into won check
    :n (case game.mode
       :solving (next-puzzle))
    :r (->> game.number (load-puzzle) (set game.puzzle))))
