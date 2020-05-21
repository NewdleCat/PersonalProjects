function love.load()
    player = {}
        player.x = 350
        player.bullets = {}
        player.cooldown = 20
        player.fire = function()
            if player.cooldown <= 0 then
                player.cooldown = 20
                bullet = {}
                bullet.x = player.x + 50
                bullet.y = 500
                table.insert(player.bullets, bullet)
            end
        end
    end

function love.update(dt)
    player.cooldown = player.cooldown - 1
    if love.keyboard.isDown("right") then
        player.x = player.x + 2
    elseif love.keyboard.isDown("left") then
        player.x = player.x - 2
    end

    if love.keyboard.isDown("a") then
        player.fire()
    end

    for i,b in ipairs(player.bullets) do
        if b.y < -10 then
            table.remove(player.bullets, i)
        end
        b.y = b.y - 10
    end
end

function love.draw()
    love.graphics.setColor(255 , 255, 255)
    for _,v in pairs(player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 10, 10)
    end

    love.graphics.rectangle("fill", player.x, 520, 100, 20)

    -- SECRET MODEL DO NOT USE
    -- love.graphics.setColor(255, 0, 255)
    -- love.graphics.circle("fill", player.x + 15, 450, 15)
    --
    -- love.graphics.setColor(255, 128, 0)
    -- love.graphics.rectangle("fill", player.x, 450, 30, 80)
    --
    -- love.graphics.setColor(255, 0, 255)
    -- love.graphics.circle("fill", player.x, 520, 20)
    -- love.graphics.circle("fill", player.x + 30, 520, 20)

end
