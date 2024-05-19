(fn line-iter [l]
  "iterator over each character of a string"
  (string.gmatch l "."))

(local parse {})

(fn parse.line [l]
  "parse a sokoban puzzle string"
  (icollect [c (line-iter l)]
    (case c
      " " :air
      "#" :wall
      "$" :block
      "*" :sunk
      "." :hole
      "@" :avi)))

(fn parse.puzzle [f]
  "parse a sokoban puzzle"
  (icollect [l (io.lines f)] (parse.line l)))

; exports
{:parse parse.puzzle}
