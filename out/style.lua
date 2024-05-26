local w_px, h_px = love.window.getMode()
local scale = (w_px / 10)
local background = love.graphics.newImage("assets/background.png")
local font = love.graphics.newFont("assets/ProggyTiny.ttf", scale)
local function universe()
  love.graphics.setFont(font)
  return love.graphics.draw(background, 0, 0)
end
local function tput(s, i, j)
  love.graphics.push("all")
  do
    local i0 = (30 + (25 * i))
    local j0 = (30 + (40 * j))
    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0))
    love.graphics.print(s, (i0 + 4), (j0 + 4))
    love.graphics.setColor(love.math.colorFromBytes(255, 127, 0))
    love.graphics.print(s, i0, j0)
  end
  return love.graphics.pop()
end
local function help()
  tput("*r   > restart", 4, 2)
  tput("*esc > back", 4, 3)
  tput("*b   > boss key", 4, 4)
  tput("*m   > mute", 4, 5)
  tput(" u   = you (wasd)", 4, 6)
  tput(" !", 4, 7)
  tput(" O/O = push on", 4, 7)
  return tput(" !   = switches", 4, 8)
end
local function boss()
  tput("aaaaaaaaaaaaaaaaaaaa", 2, 1)
  return tput("aaaaaaaaaaaaaaaaaaaa", 2, 8)
end
local function titlescreen(title_cursor)
  tput("$ ./soko.bin", 6, 5)
  return not title_cursor
end
local function complete()
  tput(" $ ./soko.bin -h", 2, 2)
  tput("     Albert Chae", 2, 3)
  tput("   Jack Leightcap", 2, 4)
  tput("     Spring Lisp", 2, 6)
  tput("      Game Jam  ", 2, 7)
  return tput("        2024    ", 2, 8)
end
local function render(game)
  tput(("#" .. game.number), 2, 4)
  tput(game.puzzle.dynamic.moves, 2, 5)
  for tile, locs in pairs({["#"] = game.puzzle.static.walls, ["!"] = game.puzzle.static.sinks, O = game.puzzle.dynamic.blocks, u = {game.puzzle.dynamic.avi}}) do
    for _, _1_ in ipairs(locs) do
      local _each_2_ = _1_
      local ii = _each_2_[1]
      local jj = _each_2_[2]
      tput(tile, (ii + 5), jj)
    end
  end
  return nil
end
return {universe = universe, render = render, titlescreen = titlescreen, help = help, boss = boss, complete = complete}
