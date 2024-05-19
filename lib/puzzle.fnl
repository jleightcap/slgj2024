(local fun (require :fun))

(local puzzle {})

(fn puzzle.parse [f]
  (tset puzzle :world {; coordinates of walls
                       :walls {}
                       ; coordinates of movable block
                       :blocks {}
                       ; coordinates of sinks
                       :sinks {}})

  (fn zip [iter]
    (ipairs (icollect [x _ (iter)] x)))
  (each [jj line (zip (io.lines f))]
    (each [ii char (ipairs (icollect [c _ (string.gmatch line ".")] c))]
      (case char
        "#" (table.insert puzzle.world.walls [ii jj])
        "$" (table.insert puzzle.world.blocks [ii jj])
        "*" (do
              (table.insert puzzle.world.sinks [ii jj])
              (table.insert puzzle.world.blocks [ii jj]))
        "." (table.insert puzzle.world.sinks [ii jj])
        "@" (tset puzzle.world :avi [ii jj])))))

(local p (puzzle.parse :puzzles/microban-1.txt))

(let [[x y] puzzle.world.avi] (print :avi x y))
(each [ii vv (ipairs puzzle.world.blocks)]
  (let [[x y] vv] (print ii vv)))

; exports
{:parse puzzle.parse}
