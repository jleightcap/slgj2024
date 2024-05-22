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
          "#" (table.insert tiles.walls [ii jj])
          "$" (table.insert tiles.blocks [ii jj])
          "." (table.insert tiles.sinks [ii jj])
          "*" (do
                (table.insert tiles.blocks [ii jj])
                (table.insert tiles.sinks [ii jj]))
          "@" (tset tiles :avi [ii jj]))
        tiles))
      tiles
    (-> line fun.enumerate)))
    {:walls {} :blocks {} :sinks {}}
    (-> f io.lines line-iter fun.enumerate)))

{: parse}
