require("menu")
require("game")
-- hc = require("Libraries.HardonCollider")
-- anim8 = require("Libraries.anim8.anim8")

function love.load(arg)
  -- Set initial gamestate
  changegamestate("menu")

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  -- array to hold collision messages
  text = {}

end

function love.update(dt)
  if _G[gamestate .. "_update"] then
    _G[gamestate .. "_update"](dt)
  end
end

function love.draw()
  if _G[gamestate .. "_draw"] then
    _G[gamestate .. "_draw"]()
  end

end

function love.keypressed(key, isrepeat)
  if _G[gamestate .. "_keypressed"] then
    _G[gamestate .. "_keypressed"](key, isrepeat)
  end
end

-- main seems to act like the central game manager
function changegamestate(s)
  gamestate = s
  if _G[gamestate .. "_load"] then
    _G[gamestate .. "_load"]()
  end
end

