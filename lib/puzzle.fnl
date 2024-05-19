(local fun (require :fun))

(fn parse [f]
  (let [parsed {; coordinates of walls
               :walls {}
               ; coordinates of movable block
               :blocks {}
               ; coordinates of sinks
               :sinks {}}]
    (each [[jj line] (fun.enumerate (io.lines f))]
      (each [ii char (fun.iter line)]
        (fn tile [id] (table.insert (. parsed id) [ii jj]))
        (case char
          "#" (tile :walls)
          "$" (tile :blocks)
          "." (tile :sinks)
          "*" (do
            (tile :blocks)
            (tile :sinks))
          "@" (tset parsed :avi [ii jj]))))
    parsed))

{: parse}
