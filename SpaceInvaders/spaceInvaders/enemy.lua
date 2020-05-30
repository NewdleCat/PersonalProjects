enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}

have_spawned = false

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

function enemyMovement()
    for _,e in pairs(enemies_controller.enemies) do
        if e.x + e.width >= 1014 then
            enemy_go_right = false
            enemy_go_left = true
            for _,e in pairs(enemies_controller.enemies) do
                e.y = e.y + 30
            end
        elseif e.x <= 10 then
            enemy_go_right = true
            enemy_go_left = false
            for _,e in pairs(enemies_controller.enemies) do
                e.y = e.y + 30
            end
        end
    end
end

function spawnLevel(level)

    if level == 1 and have_spawned == false then
        for i=0, 10, 1 do
            enemies_controller:spawnEnemy((i * 70) + 30, 100)
            enemies_controller:spawnEnemy((i * 70) + 30, 170)
        end
        have_spawned = true
    elseif level == 2 and have_spawned == false then

        have_spawned = true
    end


end
