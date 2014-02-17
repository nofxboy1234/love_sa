local pretty = require("pl.pretty")
local dbg = require("lib.lua_debugger.debugger")

require("menu")
require("game")

local facing_right = true

function love.load()
  -- love.graphics.setBackgroundColor(255, 255, 255, 255)

  -- Grab window size
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  get_joystick()

  changegamestate("menu")
end


function love.update(dt)
  if _G[gamestate .. "_update"] then
      _G[gamestate .. "_update"](dt)
  end

end

function love.draw()
  -- love.graphics.setColor(255, 255, 255, 255)
  if _G[gamestate .. "_draw"] then
    _G[gamestate .. "_draw"]()
  end

end

function get_joystick()
  joystick_01 = love.joystick.getJoysticks()[1]
end

-- function love.keypressed(key, isrepeat)
--   if key == "w" then
--     print("W pressed" .. " " .. tostring(isrepeat))
--   end
-- end

function changegamestate(s)
  gamestate = s
  if _G[gamestate .. "_load"] then
      _G[gamestate .. "_load"]()
  end
end

function love.keypressed(key, unicode)
  if _G[gamestate .. "_keypressed"] then
    _G[gamestate .. "_keypressed"](key, unicode)
  end
end

