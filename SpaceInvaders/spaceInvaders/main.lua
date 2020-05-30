require "particles"
require "enemy"
require "player"

love.graphics.setDefaultFilter('nearest', 'nearest')

powerups = {}
powerups.list = {}

function powerups:spawnPowerup(x, y)
    pup = {}
    pup.x = x
    pup.y = y
    table.insert(powerups.list, pup)
end


------------------------------------------------------------------------------------
--                          COLLISIONS
------------------------------------------------------------------------------------

function checkCollisions(enemies, bullets)
    for i, e in ipairs(enemies) do
        for j, b in ipairs(bullets) do
            if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
                particle_system:spawn(e.x, e.y)

                powerups:spawnPowerup(e.x + e.width/2, e.y + e.height/2)

                temp = e.x

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

function checkPowerupCollisions()
    for i, p in ipairs(powerups.list) do
        if p.y >= player.y and p.y <= player.y + player.height and p.x > player.x and p.x < player.x + player.width then
            table.remove(powerups.list, i)
            player.shootMode = "double"
            player.powerupCooldown = 2000
        end
    end
end
------------------------------------------------------------------------------------
--                          MAIN FUNCTIONS
------------------------------------------------------------------------------------
function love.load()
    love.window.setMode(1024,768)

    pos = 0
    wave = 0
    temp = false

    game_over = false
    game_win = false
    enemy_go_left = false
    enemy_go_right = true

    gameLevel = 1

    background_image = love.graphics.newImage('images/background.png')

    enemies_controller.image = love.graphics.newImage('images/sad.png')
    enemies_controller.death_sound = love.audio.newSource('sounds/thud1.wav', "static")
    enemies_controller.moan1 = love.audio.newSource('sounds/zachMoan1.wav', "static")
    enemies_controller.moan2 = love.audio.newSource('sounds/zachMoan2.wav', "static")
    enemies_controller.moan3 = love.audio.newSource('sounds/zachMoan3.wav', "static")

    particle_system.image = love.graphics.newImage('images/sad.png')

    player.fire_sound = love.audio.newSource('sounds/laser.wav', "static")
    player.image = love.graphics.newImage('images/P.png')
end

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
        playerFire()
    end

    --Enemy Spawning
    -- spawnLevel(gameLevel)
    pos = pos + 100*dt
    wave = pos + 100*dt

    -- ENEMY MOVEMENT
    -- enemyMovement() -- enemy.lua

    -- win function
    if level == 3 then
        game_win = true
    end

    if #enemies_controller.enemies == 0 then
        gameLevel = gameLevel + 1
        have_spawned = false
        enemy_go_left = false
        enemy_go_right = true
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
    end

    -- BULLETS
    for i,b in ipairs(player.bullets) do
        if b.y < -10 then
            table.remove(player.bullets, i)
        end
        b.y = b.y - 5
    end

    -- POWERUPS
    for i,p in ipairs(powerups.list) do
        if p.y > player.y + 100 then
            table.remove(powerups.list, i)
        end
        p.y = p.y + 2
    end

    if player.shootMode == "double" and player.powerupCooldown > 0 then
        player.powerupCooldown = player.powerupCooldown - 1
    end

    if player.powerupCooldown < 0 then
        player.shootMode = "normal"
    end

    -- COLLISIONS
    checkCollisions(enemies_controller.enemies, player.bullets)
    checkPowerupCollisions(dt)
end

function love.draw()
    -- love.graphics.draw(background_image)
    if game_over == true then
        love.graphics.print("GAME OVER", 150, 300, 0, 10)
        return
    elseif game_win == true then
        love.graphics.print("WIIIIIIIIN")
        -- return
    end

    particle_system:draw()

    -- love.graphics.print("Player:", 150, 400)
    -- love.graphics.print(player.x, 200, 400)
    -- love.graphics.print("Powerup:", 150, 430)
    -- love.graphics.print(temp, 220, 430)
    love.graphics.print(#enemies_controller.enemies, 100, 100)
    -- love.graphics.rectangle("fill", 500, 0, 2, 1000)

    love.graphics.rectangle("fill", 200 + math.cos((wave/100) - 200)*100, 200 + math.sin((wave/100) - 200)*100, 10, 10)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 200 + math.cos((wave/100))*100, 200 + math.sin((wave/100))*100, 10, 10)

    -- love.graphics.print(player.powerupCooldown, player.x - 80, player.y - 30)
    love.graphics.print(math.floor(player.powerupCooldown/100), player.x - 80, player.y - 30)

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
    -- love.graphics.rectangle("fill", player.x, player.y, 2, 2)
    love.graphics.draw(player.image, player.x, player.y, 0, 1)

    love.graphics.setColor(1, 1, 1)
    for _,e in pairs(enemies_controller.enemies) do -- ENEMY SPAWNER
        love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 1)
    end

    love.graphics.setColor(0, 1, 0)
    for _,p in pairs(powerups.list) do
        love.graphics.rectangle("fill", p.x, p.y, 10, 10)
    end

    love.graphics.setColor(1, 1, 1)
end
