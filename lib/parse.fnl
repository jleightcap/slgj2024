(local fun (require :fun))

(fn line-iter [lines]
  "luafun-compatible `io.lines` iterator"
  "https://github.com/luafun/luafun/issues/20#issuecomment-170504253"
  #(let [v (lines)] (values v v)))

;; fnlfmt: skip
(fn parse [f]
  (fun.foldl (lambda [tiles jj line]
    (fun.foldl (lambda [tiles ii char]
      (do
        (case char
          "#" (table.insert tiles.static.walls [ii jj])
          "$" (table.insert tiles.dynamic.blocks [ii jj])
          "." (table.insert tiles.static.sinks [ii jj])
          "*" (do
                (table.insert tiles.dynamic.blocks [ii jj])
                (table.insert tiles.static.sinks [ii jj]))
          "+" (do
                (set tiles.dynamic.avi [ii jj])
                (table.insert tiles.static.sinks [ii jj]))
          "@" (set tiles.dynamic.avi [ii jj]))
        tiles))
      tiles
      (-> line fun.enumerate)))
    {:static {:walls {} :sinks {}} :dynamic {:avi [] :blocks {} :moves 0}}
    (-> f io.lines line-iter fun.enumerate)))

(fn inplace-sort-tile [t]
  "inplace sort the coordinates of a tile sequential table"
  ;; FIXME: if x1==x2, then compare y1 y2
  (table.sort t (lambda [[x1 _] [x2 _]] (< x1 x2))))

(fn invariants [parsed]
  "apply, inplace, the game invariants"
  (assert (= (length parsed.static.sinks) (length parsed.dynamic.blocks)))
  (doto parsed
    (-> (. :static) (. :walls) (inplace-sort-tile))
    (-> (. :static) (. :sinks) (inplace-sort-tile))
    (-> (. :dynamic) (. :blocks) (inplace-sort-tile))))

{: parse : invariants : inplace-sort-tile}
