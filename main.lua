local sti = require "lib.sti.sti"
local pretty = require("pl.pretty")
local hc = require("lib.hc")
local class = require("lib.hump.class")
local dbg = require("lib.lua_debugger.debugger")

require("player")
require("hitbox")

local facing_right = true

function love.load()
  -- Grab window size
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  -- Load a map exported to Lua from Tiled
  map = sti.new("maps/02_01")
  -- map = sti.new("maps/test/maps/map02")


  collider = hc(100, on_collision, collision_stop)

  -- create environment collision shapes
  -- dbg()
  layer_objects = {}
  -- Store objects that have been added to layer_objects to stop duplicates
  -- sti's map.layers method returns layers as a number AND a name
  layer_objects_done = {}
  for _, l in pairs(map.layers) do
    if (l.type == "objectgroup") then

      local found = false
      for _, v in pairs(layer_objects_done) do
        if l.name == v then
          found = true
        end
      end

      if not found then
        for _, layer_object in pairs(l.objects) do
          table.insert(layer_objects, layer_object)
          table.insert(layer_objects_done, l.name)
        end
      end
    end
  end
  -- pretty.dump(layer_objects)

  env_objects = {}
  for _, lo in pairs(layer_objects) do
    local x = lo.x
    local y = lo.y
    local width = lo.width
    local height = lo.height

    rect = collider:addRectangle(x, y, width, height)
    table.insert(env_objects, rect)
  end
  -- pretty.dump(env_objects)

  -- Set a Collision Map to use with your own collision code
  -- collision = map:getCollisionMap("boxes")

  -- Create a Custom Layer
  map:addCustomLayer("Sprite Layer", 4)

  -- Add data to Custom Layer
  spriteLayer = map.layers["Sprite Layer"]
  spriteLayer.sprites = {}
  spriteLayer.sprites.player = Player(64, 64, 400, 400)



  -- Update callback for Custom Layer
  function spriteLayer:update(dt)
    for _, sprite in pairs(self.sprites) do
      sprite:update(dt)
    end
  end

  -- Draw callback for Custom Layer
  function spriteLayer:draw()
    for _, sprite in pairs(self.sprites) do
      sprite:draw()
    end
  end

  get_joystick()
end


function love.update(dt)
  map:update(dt)

  collider:update(dt)

end

function love.draw()
  -- Translation would normally be based on a player's x/y
  local translateX = 0
  local translateY = 0

  -- love.graphics.translate(translateX, translateY)

  -- Draw Range culls unnecessary tiles
  map:setDrawRange(translateX, translateY, windowWidth, windowHeight)

  map:draw()

  -- Draw Collision Map (useful for debugging)
  -- map:drawCollisionMap(collision)

  -- draw environment objects
  love.graphics.setColor(255, 0, 0, 255)
  for _, env_object in pairs(env_objects) do
    env_object:draw('line')
  end

  love.graphics.setColor(255, 255, 255, 255)
end

function get_joystick()
  joystick_01 = love.joystick.getJoysticks()[1]
end

function love.keypressed(key, isrepeat)
  if key == "w" then
    print("W pressed" .. " " .. tostring(isrepeat))
  end
end

function on_collision(dt, shape_a, shape_b)
  print("COLLISION!")

end

function collision_stop(dt, shape_a, shape_b)
  print("COLLISION STOPPED!")
end


