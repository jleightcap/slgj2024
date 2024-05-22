(local fun (require :fun))

(fn line-iter [lines]
  "luafun-compatible `io.lines` iterator"
  "https://github.com/luafun/luafun/issues/20#issuecomment-170504253"
  #(let [v (lines)] (values v v)))

;; fnlfmt: skip
(fn parse [f]
  ;; {:static {:walls parsed.walls :sinks parsed.sinks}
   ;; :dynamic {:avi parsed.avi :blocks parsed.blocks :moves 0}})
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
          "@" (tset tiles.dynamic :avi [ii jj]))
        tiles))
      tiles
      (-> line fun.enumerate)))
    {:static {:walls {} :sinks {}} :dynamic {:blocks {} :moves 0}}
    (-> f io.lines line-iter fun.enumerate)))

{: parse}
