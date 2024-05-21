(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local puzzle (require :lib.parse))
(local engine (require :lib.engine))

;; TODO: abstract :puzzles/microban-1.txt into an argument
;; first decide on how puzzles are selected, or advanced when won
(local game
       (let [parsed (puzzle.parse :puzzles/microban-1.txt)]
         {:static {:walls parsed.walls :sinks parsed.sinks}
          :dynamic {:avi parsed.avi :blocks parsed.blocks :moves 0}}))

(fn love.draw []
  ;; TODO: this is re-drawing some constant parts of the screen
  ;; refactor into one-time setup and continuous components
  (style.universe)
  (style.render game))

(fn love.keypressed [event]
  (set game.dynamic (engine.tick event game.static game.dynamic)))
