(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local puzzle (require :lib.parse))
(local engine (require :lib.engine))

(local (w-px h-px) (values style.w-px style.h-px))
(local scale style.scale)

(local universe
       (let [parsed (puzzle.parse :puzzles/microban-1.txt)]
         {:static {:walls parsed.walls :sinks parsed.sinks}
          :dynamic {:avi parsed.avi :blocks parsed.blocks :moves 0}}))

(fn love.draw []
  (style.monitor)
  (style.tput (.. "[löve:soko]$ " universe.dynamic.moves) 2 1)
  (each [tile locs (pairs {"#" universe.static.walls
                           :! universe.static.sinks
                           :O universe.dynamic.blocks
                           :u [universe.dynamic.avi]})]
    (each [_ [ii jj] (ipairs locs)]
      (style.tput tile (+ ii 1) (+ jj 1)))))

(fn love.keypressed [event]
  ;; use keypress event to trigger engine tick
  (set universe.dynamic (engine.tick event universe.static universe.dynamic)))
