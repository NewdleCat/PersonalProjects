love.graphics.setDefaultFilter('nearest', 'nearest')
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('sad.png')
enemies_controller.death_sound = love.audio.newSource('thud1.wav', "static")
enemies_controller.moan1 = love.audio.newSource('zachMoan1.wav', "static")
enemies_controller.moan2 = love.audio.newSource('zachMoan2.wav', "static")
enemies_controller.moan3 = love.audio.newSource('zachMoan3.wav', "static")
hit = false


function love.conf(t)
    t.console = true
end

function checkCollisions(enemies, bullets)
    for i, e in ipairs(enemies) do
        for _, b in pairs(bullets) do
            if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
                table.remove(enemies, i)

                love.audio.setVolume(0.2)

                love.audio.play(enemies_controller.death_sound)
                -- num = love.math.random(1, 3)
                -- if num == 1 then
                --     love.audio.play(enemies_controller.moan1)
                -- elseif num == 2 then
                --     love.audio.play(enemies_controller.moan2)
                -- elseif num ==3 then
                --     love.audio.play(enemies_controller.moan3)
                -- end
            end
        end
    end
end

function love.load()
    game_over = false
    background_image = love.graphics.newImage('background.png')
    player = {}
    player.x = 350
    player.y = 550
    player.speed = 8;
    player.bullets = {}
    player.cooldown = 20
    player.fire_sound = love.audio.newSource('laser.wav', "static")
    player.image = love.graphics.newImage('P.png')
    player.fire = function()
        if player.cooldown <= 0 then
            love.audio.play(player.fire_sound)
            player.cooldown = 60
            bullet = {}
            bullet.x = player.x + 50
            bullet.y = player.y
            table.insert(player.bullets, bullet)
        end
    end

    for i=0, 10, 1 do
        enemies_controller:spawnEnemy(i * 70, 100)
    end

    -- enemies_controller:spawnEnemy(100,100)

end

function enemies_controller:spawnEnemy(x, y)
    enemy = {}
    enemy.x = x
    enemy.y = y

    enemy.width = 60
    enemy.height = 60

    enemy.bullets = {}
    enemy.cooldown = 20
    enemy.speed = 1
    table.insert(self.enemies,enemy)
end

function enemy:fire() -- simpler way to say enemy.fire(self)
    if self.cooldown <= 0 then
        self.cooldown = 20
        bullet = {}
        bullet.x = player.x + 50
        bullet.y = player.y
        table.insert(self.bullets, bullet)
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

    for _,e in pairs(enemies_controller.enemies) do
        if e.y >= love.graphics.getHeight() then
            game_over = true
        end
        e.y = e.y + 1 * e.speed
    end

    for i,b in ipairs(player.bullets) do
        if b.y < -10 then
            table.remove(player.bullets, i)
        end
        b.y = b.y - 5
    end

    checkCollisions(enemies_controller.enemies, player.bullets)
end

function love.draw()
    if game_over == true then
        love.graphics.print("GAME OVER")
        return
    end

    love.graphics.draw(background_image)

    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", player.x + 55, player.y, 2, -1000)


    love.graphics.setColor(1, 1, 1)
    for _,v in pairs(player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 10, 10)
    end

    --PLAYER SPAWN
    -- love.graphics.rectangle("fill", player.x, player.y, 100, 20)
    love.graphics.draw(player.image, player.x + 35, player.y, 0, 1)

    love.graphics.setColor(1, 1, 1)
    for _,e in pairs(enemies_controller.enemies) do -- ENEMY SPAWNER
        love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 1)
        -- love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
    end



end
