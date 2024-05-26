love.conf = function(t)
  t.modules.joystick = false
  t.modules.physics = false
  t.version = "11.5"
  t.window.title = "./soko.bin"
  t.window.width = 640
  t.window.height = 480
  return nil
end
return love.conf
