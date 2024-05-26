local fun = require("fun")
local style = require("style")
local parser = require("parse")
local engine = require("engine")
local function load_puzzle(n)
  return parser.invariants(parser.parse(("puzzles/microban-" .. n)))
end
local game = {mode = "titlescreen", number = 0, puzzle = load_puzzle(0), booted = false}
local hum
do
  local _1_ = love.audio.newSource("assets/transformer.wav", "static")
  _1_:setVolume(0.25)
  hum = _1_
end
local boot = love.audio.newSource("assets/crt-on.wav", "static")
love.conf = function(t)
  t.modules.joystick = false
  t.modules.physics = false
  t.version = "11.5"
  t.window.title("./soko.bin")
  t.window.width = 640
  t.window.height = 480
  return nil
end
love.update = function(dt)
  if not game.booted then
    love.audio.play(boot)
    game.booted = true
  else
  end
  if not hum:isPlaying() then
    return love.audio.play(hum)
  else
    return nil
  end
end
love.draw = function()
  style.universe()
  local _4_ = game.mode
  if (_4_ == "titlescreen") then
    return style.titlescreen()
  elseif (_4_ == "help") then
    return style.help()
  elseif (_4_ == "boss") then
    return style.boss()
  elseif (_4_ == "solving") then
    return style.render(game)
  elseif (_4_ == "complete") then
    return style.complete()
  else
    return nil
  end
end
local function next_puzzle()
  if (game.number == 78) then
    game.mode = "complete"
    return nil
  else
    game.number = (game.number + 1)
    game.puzzle = load_puzzle(game.number)
    return nil
  end
end
love.keypressed = function(event)
  if ((event == "w") or (event == "a") or (event == "s") or (event == "d")) then
    game.puzzle.dynamic = engine.tick(event, game.puzzle)
    if engine["won?"](game) then
      return next_puzzle()
    else
      return nil
    end
  elseif (event == "m") then
    hum:setVolume(0)
    return hum
  elseif (event == "b") then
    game.mode = "boss"
    return nil
  elseif (event == "escape") then
    if ((game.mode == "titlescreen") or (game.mode == "complete")) then
      return love.event.quit()
    else
      game.mode = "titlescreen"
      return nil
    end
  elseif (event == "return") then
    local _9_ = game.mode
    if (_9_ == "titlescreen") then
      game.mode = "help"
      return nil
    elseif (_9_ == "help") then
      game.mode = "solving"
      return nil
    elseif (_9_ == "boss") then
      game.mode = "solving"
      return nil
    else
      return nil
    end
  elseif (event == "n") then
    local _11_ = game.mode
    if (_11_ == "solving") then
      return next_puzzle()
    else
      return nil
    end
  elseif (event == "r") then
    game.puzzle = load_puzzle(game.number)
    return nil
  else
    return nil
  end
end
return love.keypressed
