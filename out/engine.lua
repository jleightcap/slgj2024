local parser = require("parse")
local fun = require("fun")
local function coordinate_3c(_1_, _3_)
  local _arg_2_ = _1_
  local x1 = _arg_2_[1]
  local y1 = _arg_2_[2]
  local _arg_4_ = _3_
  local x2 = _arg_4_[1]
  local y2 = _arg_4_[2]
  if (x1 == x2) then
    return (y1 < y2)
  else
    return (x1 < x2)
  end
end
local function coordinateMatch_3f(pos1, pos2)
  local _let_6_ = pos1
  local x1 = _let_6_[1]
  local y1 = _let_6_[2]
  local _let_7_ = pos2
  local x2 = _let_7_[1]
  local y2 = _let_7_[2]
  return ((x1 == x2) and (y1 == y2))
end
local function addCoordinate(pos1, pos2)
  local _let_8_ = pos1
  local x1 = _let_8_[1]
  local y1 = _let_8_[2]
  local _let_9_ = pos2
  local x2 = _let_9_[1]
  local y2 = _let_9_[2]
  return {(x1 + x2), (y1 + y2)}
end
local function isPositionTileType_3f(pos, tiles)
  local isTile = false
  for _, tilePos in ipairs(tiles) do
    isTile = (isTile or coordinateMatch_3f(pos, tilePos))
  end
  return isTile
end
local function isWall_3f(pos, puzzle)
  return isPositionTileType_3f(pos, puzzle.static.walls)
end
local function isBlock_3f(pos, puzzle)
  return isPositionTileType_3f(pos, puzzle.dynamic.blocks)
end
local function replaceBlock(oldBlocks, targetBlock, newBlock)
  local tbl_19_auto = {}
  local i_20_auto = 0
  for _, block in ipairs(oldBlocks) do
    local val_21_auto
    if coordinateMatch_3f(block, targetBlock) then
      val_21_auto = newBlock
    else
      val_21_auto = block
    end
    if (nil ~= val_21_auto) then
      i_20_auto = (i_20_auto + 1)
      do end (tbl_19_auto)[i_20_auto] = val_21_auto
    else
    end
  end
  return tbl_19_auto
end
local function attemptMove(avi, move, puzzle)
  local nextAvi = addCoordinate(avi, move)
  if isWall_3f(nextAvi, puzzle) then
    return {avi, puzzle.dynamic.blocks}
  elseif isBlock_3f(nextAvi, puzzle) then
    local nextBlockPos = addCoordinate(nextAvi, move)
    local blockCanMove = not (isWall_3f(nextBlockPos, puzzle) or isBlock_3f(nextBlockPos, puzzle))
    if blockCanMove then
      return {nextAvi, replaceBlock(puzzle.dynamic.blocks, nextAvi, nextBlockPos)}
    else
      return {avi, puzzle.dynamic.blocks}
    end
  else
    return {nextAvi, puzzle.dynamic.blocks}
  end
end
local function tick(event, puzzle)
  local currentAvi = puzzle.dynamic.avi
  local move
  if (event == "w") then
    move = {0, -1}
  elseif (event == "a") then
    move = {-1, 0}
  elseif (event == "s") then
    move = {0, 1}
  elseif (event == "d") then
    move = {1, 0}
  else
    move = nil
  end
  local _let_15_ = attemptMove(currentAvi, move, puzzle)
  local nextAvi = _let_15_[1]
  local nextBlocks = _let_15_[2]
  local _16_
  if coordinateMatch_3f(currentAvi, nextAvi) then
    _16_ = puzzle.dynamic.moves
  else
    _16_ = (puzzle.dynamic.moves + 1)
  end
  return {avi = nextAvi, blocks = nextBlocks, moves = _16_}
end
local function won_3f(game)
  parser["inplace-sort-tile"](game.puzzle.dynamic.blocks)
  local function _22_(_18_, _20_)
    local _arg_19_ = _18_
    local x1 = _arg_19_[1]
    local y1 = _arg_19_[2]
    local _arg_21_ = _20_
    local x2 = _arg_21_[1]
    local y2 = _arg_21_[2]
    _G.assert((nil ~= y2), "Missing argument y2 on src/engine.fnl:68")
    _G.assert((nil ~= x2), "Missing argument x2 on src/engine.fnl:68")
    _G.assert((nil ~= y1), "Missing argument y1 on src/engine.fnl:68")
    _G.assert((nil ~= x1), "Missing argument x1 on src/engine.fnl:68")
    return ((x1 == x2) and (y1 == y2))
  end
  return fun.all(_22_, fun.zip(game.puzzle.static.sinks, game.puzzle.dynamic.blocks))
end
return {tick = tick, ["won?"] = won_3f}
