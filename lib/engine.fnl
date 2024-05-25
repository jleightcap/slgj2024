(fn coordinateMatch? [pos1 pos2]
  (let [[x1 y1] pos1
        [x2 y2] pos2]
    (and (= x1 x2) (= y1 y2))))

(fn addCoordinate [pos1 pos2]
  (let [[x1 y1] pos1
        [x2 y2] pos2]
    [(+ x1 x2) (+ y1 y2)]))

(fn isPositionTileType? [pos tiles]
  (accumulate [isTile false _ tilePos (ipairs tiles)]
    (or isTile (coordinateMatch? pos tilePos))))

(fn isWall? [pos puzzle]
  (isPositionTileType? pos puzzle.static.walls))

(fn isBlock? [pos puzzle]
  (isPositionTileType? pos puzzle.dynamic.blocks))

(fn replaceBlock [oldBlocks targetBlock newBlock]
  (icollect [_ block (ipairs oldBlocks)]
    (if (coordinateMatch? block targetBlock)
        newBlock
        block)))

(fn tick [event puzzle]
  (let [[x y] puzzle.dynamic.avi]
    ;; TODO: update blocks based on collision
    ;; NOTE: construction of keys matching parse.fnl
    {:avi (case event
            :w [x (- y 1)]
            :a [(- x 1) y]
            :s [x (+ y 1)]
            :d [(+ x 1) y])
     :blocks puzzle.dynamic.blocks
     :moves (+ puzzle.dynamic.moves 1)}))

(fn won? [game]
  ;; TODO: some kind of equality check between dynamic.blocks and static.sinks
  false)

{: tick}
