love.graphics.setDefaultFilter('nearest', 'nearest')
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('sad.png')
enemies_controller.death_sound = love.audio.newSource('thud1.wav', "static")
enemies_controller.moan1 = love.audio.newSource('zachMoan1.wav', "static")
enemies_controller.moan2 = love.audio.newSource('zachMoan2.wav', "static")
enemies_controller.moan3 = love.audio.newSource('zachMoan3.wav', "static")

particle_system = {}
particle_system.list = {}
particle_system.image = love.graphics.newImage('sad.png')

function particle_system:spawn(x, y)
    local ps = {}
    ps.x = x
    ps.y = y
    ps.stopped = false
    ps.timer = 45
    ps.delete_timer = 200
    ps.ps = love.graphics.newParticleSystem(particle_system.image, 32)
    ps.ps:setParticleLifetime(2, 4)
    ps.ps:setEmissionRate(50)
    ps.ps:setSizes(0.3)
    ps.ps:setLinearAcceleration(-1000, -1000, 1000, 1000)
    ps.ps:setEmissionArea("uniform", 0, 0, 0, false)
    -- ps.ps:setRadialAcceleration(5000)
    ps.ps:setSpeed(0)
    -- ps:setColors(100, 255, 100, 255, 0, 255, 0, 255)
    table.insert(particle_system.list, ps)
end

function particle_system:draw()
    for _, v in pairs(particle_system.list) do
        love.graphics.draw(v.ps, v.x + 30, v.y + 30)
    end
end

function particle_system:update(dt)
    for _, v in pairs(particle_system.list) do
        v.timer = v.timer - 1

        if v.timer <= 0 then
            v.delete_timer = v.delete_timer - 1
        end

        v.ps:update(dt)
    end
end

function particle_system:cleaner()
    for i, v in ipairs(particle_system.list) do
        if v.timer <= 0 then
            -- table.remove(particle_system.list, i)
            -- v.ps:setSpeed(10)
            v.ps:stop()
        end

        if v.delete_timer <= 0 then
            table.remove(particle_system.list, i)
        end
    end
end

function checkCollisions(enemies, bullets)
    for i, e in ipairs(enemies) do
        for j, b in ipairs(bullets) do
            if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
                particle_system:spawn(e.x, e.y)

                table.remove(enemies, i)
                table.remove(bullets, j)

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
    love.window.setMode(1024,768)

    game_over = false
    game_win = false
    enemy_go_left = false
    enemy_go_right = true
    background_image = love.graphics.newImage('background.png')
    player = {}
    player.x = 500
    player.y = 700
    player.speed = 8;
    player.bullets = {}
    player.cooldown = 0
    player.fire_sound = love.audio.newSource('laser.wav', "static")
    player.image = love.graphics.newImage('P.png')
    player.fire = function()
        if player.cooldown <= 0 then
            love.audio.play(player.fire_sound)
            player.cooldown = 60
            bullet = {}
            bullet.x = player.x + 21
            bullet.y = player.y
            table.insert(player.bullets, bullet)
        end
    end

    for i=0, 10, 1 do
        enemies_controller:spawnEnemy((i * 70) + 30, 100)
        enemies_controller:spawnEnemy((i * 70) + 30, 170)
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
    enemy.speed = 0.2
    table.insert(self.enemies,enemy)
end

-- function enemy:fire() -- simpler way to say enemy.fire(self)
--     if self.cooldown <= 0 then
--         self.cooldown = 20
--         bullet = {}
--         bullet.x = player.x + 50
--         bullet.y = player.y
--         table.insert(self.bullets, bullet)
--     end
-- end




function love.update(dt)
    particle_system:update(dt)
    particle_system:cleaner()
    player.cooldown = player.cooldown - 1
    if love.keyboard.isDown("right") then
        player.x = player.x + 2
    elseif love.keyboard.isDown("left") then
        player.x = player.x - 2
    end

    if love.keyboard.isDown("a") then
        player.fire()
    end

    -- win function
    if #enemies_controller.enemies == 0 then
        game_win = true
    end

    --check lost
    for _,e in pairs(enemies_controller.enemies) do
        if e.y >= love.graphics.getHeight() then
            game_over = true
        end

        if enemy_go_right == true then
            e.x = e.x + 1 * e.speed
        elseif enemy_go_left == true then
            e.x = e.x - 1 * e.speed
        end

        if e.x + e.width >= 1014 then
            enemy_go_right = false
            enemy_go_left = true
            for _,e in pairs(enemies_controller.enemies) do
                e.y = e.y + 20
            end
        elseif e.x <= 10 then
            enemy_go_right = true
            enemy_go_left = false
            for _,e in pairs(enemies_controller.enemies) do
                e.y = e.y + 20
            end
        end


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
    -- love.graphics.draw(background_image)
    if game_over == true then
        love.graphics.print("GAME OVER")
        return
    elseif game_win == true then
        love.graphics.print("WIIIIIIIIN")
        -- return
    end

    particle_system:draw()

    love.graphics.print(#particle_system.list)

    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", player.x + 25, player.y, 2, -1000)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 10, 0, 1, 1000)
    love.graphics.rectangle("fill", 1014, 0, 1, 1000)

    love.graphics.setColor(1, 1, 1)
    for _,v in pairs(player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 10, 10)
    end

    --PLAYER SPAWN
    -- love.graphics.rectangle("fill", player.x, player.y, 100, 20)
    love.graphics.draw(player.image, player.x, player.y, 0, 1)

    love.graphics.setColor(1, 1, 1)
    for _,e in pairs(enemies_controller.enemies) do -- ENEMY SPAWNER
        love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 1)
    end

end
