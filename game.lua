
function game_load()
  bg_img = love.graphics.newImage("graphics/SA_bg.png")

  music = love.audio.newSource("sounds/TownTheme.mp3", "stream")
  music:setLooping(true)
  music:setVolume(0.2)
  music:play()

end


function game_update(dt)

end

function game_draw()

  love.graphics.setBackgroundColor(255, 255, 255, 255)

end

function game_keypressed(key, isrepeat)
  if key == "escape" then
      -- love.event.quit()
      music:stop()
      changegamestate("menu")
  end
end

