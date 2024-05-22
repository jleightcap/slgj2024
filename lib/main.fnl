(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local parser (require :lib.parse))
(local engine (require :lib.engine))

(fn game-data [parsed]
  {:static {:walls parsed.walls :sinks parsed.sinks}
   :dynamic {:avi parsed.avi :blocks parsed.blocks :moves 0}})

;; TODO: abstract :puzzles/microban-1.txt into an argument
;; first decide on how puzzles are selected, or advanced when won
(local game (-> :puzzles/microban-1.txt parser.parse game-data))

(fn love.draw []
  ;; TODO: this is re-drawing some constant parts of the screen
  ;; refactor into one-time setup and continuous components
  (style.universe)
  (style.render game))

(fn love.keypressed [event]
  (->> (engine.tick event game.static game.dynamic)
       (set game.dynamic)))
