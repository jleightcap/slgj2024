(local parser (require :parse))
(local fun (require :fun))

(fn coordinate< [[x1 y1] [x2 y2]]
  (if (= x1 x2) (< y1 y2) (< x1 x2)))

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

;; given a move in a cardinal direction
;; return avatar's next position and updated blocks
;; If the current move isn't valid, the returned next position and blocks will be unchanged
(fn attemptMove [avi move puzzle]
  (let [nextAvi (addCoordinate avi move)]
    (if (isWall? nextAvi puzzle)
        [avi puzzle.dynamic.blocks]
        (isBlock? nextAvi puzzle)
        (let [nextBlockPos (addCoordinate nextAvi move)
              blockCanMove (not (or (isWall? nextBlockPos puzzle)
                                    (isBlock? nextBlockPos puzzle)))]
          (if blockCanMove
              [nextAvi
               (replaceBlock puzzle.dynamic.blocks nextAvi nextBlockPos)]
              [avi puzzle.dynamic.blocks]))
        [nextAvi puzzle.dynamic.blocks])))

(fn tick [event puzzle]
  (let [currentAvi puzzle.dynamic.avi]
    ;; NOTE: construction of keys matching parse.fnl
    (let [move (case event
                 :w [0 -1]
                 :a [-1 0]
                 :s [0 1]
                 :d [1 0])
          [nextAvi nextBlocks] (attemptMove currentAvi move puzzle)]
      {:avi nextAvi
       :blocks nextBlocks
       :moves (if (coordinateMatch? currentAvi nextAvi)
                  puzzle.dynamic.moves
                  (+ puzzle.dynamic.moves 1))})))

(fn won? [game]
  ;; NOTE: game.puzzle.static tiles are pre-sorted on construction (see: parser.invariants)
  (parser.inplace-sort-tile game.puzzle.dynamic.blocks)
  (fun.all (lambda [[x1 y1] [x2 y2]] (and (= x1 x2) (= y1 y2)))
           (fun.zip game.puzzle.static.sinks game.puzzle.dynamic.blocks)))

{: tick : won?}
