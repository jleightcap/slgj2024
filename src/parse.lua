local fun = require("fun")
local function line_iter(lines)
  local function _1_()
    local v = lines()
    return v, v
  end
  return _1_
end
local function parse(f)
  local function _2_(tiles, jj, line)
    _G.assert((nil ~= line), "Missing argument line on src/parse.fnl:10")
    _G.assert((nil ~= jj), "Missing argument jj on src/parse.fnl:10")
    _G.assert((nil ~= tiles), "Missing argument tiles on src/parse.fnl:10")
    local function _3_(tiles0, ii, char)
      _G.assert((nil ~= char), "Missing argument char on src/parse.fnl:11")
      _G.assert((nil ~= ii), "Missing argument ii on src/parse.fnl:11")
      _G.assert((nil ~= tiles0), "Missing argument tiles on src/parse.fnl:11")
      if (char == "#") then
        table.insert(tiles0.static.walls, {ii, jj})
      elseif (char == "$") then
        table.insert(tiles0.dynamic.blocks, {ii, jj})
      elseif (char == ".") then
        table.insert(tiles0.static.sinks, {ii, jj})
      elseif (char == "*") then
        table.insert(tiles0.dynamic.blocks, {ii, jj})
        table.insert(tiles0.static.sinks, {ii, jj})
      elseif (char == "+") then
        tiles0.dynamic.avi = {ii, jj}
        table.insert(tiles0.static.sinks, {ii, jj})
      elseif (char == "@") then
        tiles0.dynamic.avi = {ii, jj}
      else
      end
      return tiles0
    end
    return fun.foldl(_3_, tiles, fun.enumerate(line))
  end
  return fun.foldl(_2_, {static = {walls = {}, sinks = {}}, dynamic = {avi = {}, blocks = {}, moves = 0}}, fun.enumerate(line_iter(io.lines(f))))
end
local function coordinate_3c(_5_, _7_)
  local _arg_6_ = _5_
  local x1 = _arg_6_[1]
  local y1 = _arg_6_[2]
  local _arg_8_ = _7_
  local x2 = _arg_8_[1]
  local y2 = _arg_8_[2]
  if (x1 == x2) then
    return (y1 < y2)
  else
    return (x1 < x2)
  end
end
local function inplace_sort_tile(t)
  return table.sort(t, coordinate_3c)
end
local function invariants(parsed)
  assert((#parsed.static.sinks == #parsed.dynamic.blocks))
  inplace_sort_tile(parsed.static.walls)
  inplace_sort_tile(parsed.static.sinks)
  inplace_sort_tile(parsed.dynamic.blocks)
  return parsed
end
return {parse = parse, invariants = invariants, ["inplace-sort-tile"] = inplace_sort_tile}
