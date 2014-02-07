local sti = require "lib.sti.sti"

function love.load()
    -- Grab window size
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    -- Load a map exported to Lua from Tiled
    map = sti.new("maps/02_01")

    -- Set a Collision Map to use with your own collision code
    collision = map:getCollisionMap("Collision_Layer")

    -- Create a Custom Layer
    map:addCustomLayer("Sprite Layer", 3)

    -- Add data to Custom Layer
    -- local spriteLayer = map.layers["Sprite Layer"]
    spriteLayer = map.layers["Sprite Layer"]
    spriteLayer.sprites = {
        player = {
            image = love.graphics.newImage("maps/player.png"),
            x = 64,
            y = 64,
            r = 0,
        }
    }

    spriteLayer.sprites.player.velocity = {}
    spriteLayer.sprites.player.velocity.x = 400
    spriteLayer.sprites.player.velocity.y = 400

    -- Update callback for Custom Layer
    function spriteLayer:update(dt)
        for _, sprite in pairs(self.sprites) do
            sprite.r = sprite.r + math.rad(90 * dt)
        end
    end

    -- Draw callback for Custom Layer
    function spriteLayer:draw()
        for _, sprite in pairs(self.sprites) do
            local x = math.floor(sprite.x)
            local y = math.floor(sprite.y)
            local r = sprite.r
            -- love.graphics.draw(sprite.image, x, y, r)
            love.graphics.draw(sprite.image, x, y)
        end
    end
end

function love.update(dt)
    map:update(dt)

  if love.keyboard.isDown("right") then
    spriteLayer.sprites.player.x = spriteLayer.sprites.player.x + (spriteLayer.sprites.player.velocity.x * dt)
  end
  if love.keyboard.isDown("left") then
    spriteLayer.sprites.player.x = spriteLayer.sprites.player.x - (spriteLayer.sprites.player.velocity.x * dt)
  end

  if love.keyboard.isDown("down") then
    spriteLayer.sprites.player.y = spriteLayer.sprites.player.y + (spriteLayer.sprites.player.velocity.y * dt)
  end
  if love.keyboard.isDown("up") then
    spriteLayer.sprites.player.y = spriteLayer.sprites.player.y - (spriteLayer.sprites.player.velocity.y * dt)
  end
end

function love.draw()
    -- Translation would normally be based on a player's x/y
    local translateX = 0
    local translateY = 0

    -- Draw Range culls unnecessary tiles
    map:setDrawRange(translateX, translateY, windowWidth, windowHeight)

    map:draw()

    -- Draw Collision Map (useful for debugging)
    map:drawCollisionMap(collision)
end