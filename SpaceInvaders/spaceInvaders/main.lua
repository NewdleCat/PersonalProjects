enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage('enemy.png')

function love.conf(t)
    t.console = true
end

function checkCollisions(enemies, bullets)
    for _, e in pairs(enemies) do
        for _, b in pairs(bullets) do
            if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
                print("COLLISION")
            end
        end
    end
end

function love.load()
    player = {}
    player.x = 350
    player.y = 550
    player.speed = 8;
    player.bullets = {}
    player.cooldown = 20
    player.fire_sound = love.audio.newSource('laser.wav', "static")
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

    enemies_controller:spawnEnemy(0, 0)
    enemies_controller:spawnEnemy(200, 0)

end

function enemies_controller:spawnEnemy(x, y)
    enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.width = 10
    enemy.height = 10
    enemy.bullets = {}
    enemy.cooldown = 20
    enemy.speed = 8
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
        e.y = e.y + 1
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
    love.graphics.setColor(1, 1, 1)
    for _,v in pairs(player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 10, 10)
    end

    --PLAYER SPAWN
    love.graphics.rectangle("fill", player.x, player.y, 100, 20)

    love.graphics.setColor(1, 1, 1)
    for _,e in pairs(enemies_controller.enemies) do -- ENEMY SPAWNER
        love.graphics.draw(enemies_controller.image, e.x, e.y, 0, 0.25)
    end


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
