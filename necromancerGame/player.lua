require "anim"

player = {}
player.x = 200
player.y = 200
player.width = 36
player.height  = 64
player.color = {255/255, 255/255, 255/255}
player.speed = 400
-- player.direction = ""
player.directionHorizontal = 1

player.moving = false

player.up = false
player.down = false
player.left = false
player.right = false
player.slowDown = false

animation = newAnimation(love.graphics.newImage("necro-sheet.png"), 36, 64, 1)

local function resetDirections()
	player.up = false
	player.down = false
	player.left = false
	player.right = false	
end

player.update = function(dt)

	if love.keyboard.isDown("w") then
		player.y = player.y - (dt * player.speed)
		player.up = true
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - (dt * player.speed)
		player.left = true
		player.directionHorizontal = -1 
	end
	if love.keyboard.isDown("s") then
		player.y = player.y + (dt * player.speed)
		player.down = true
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + (dt * player.speed)
		player.right = true
		player.directionHorizontal = 1
	end

	-- if player.slowDown and player.up and player.left and player.speed > 0 then
	-- 	player.y = player.y - (dt * player.speed)
	-- 	player.x = player.x - (dt * player.speed)
	-- elseif player.slowDown and player.down and player.left and player.speed > 0 then
	-- 	player.y = player.y + (dt * player.speed)
	-- 	player.x = player.x - (dt * player.speed)
	-- elseif player.slowDown and player.up and player.right and player.speed > 0 then
	-- 	player.y = player.y - (dt * player.speed)
	-- 	player.x = player.x + (dt * player.speed)
	-- elseif player.slowDown and player.down and player.right and player.speed > 0 then	
	-- 	player.y = player.y + (dt * player.speed)
	-- 	player.x = player.x + (dt * player.speed)
	-- elseif player.slowDown and player.up == true and player.speed > 0 then -- UP
	-- 	player.y = player.y - (dt * player.speed)
	-- elseif player.slowDown and player.left == true and player.speed > 0 then -- LEFT
	-- 	player.x = player.x - (dt * player.speed)
	-- elseif player.slowDown and player.down == true and player.speed > 0 then -- DOWN
	-- 	player.y = player.y + (dt * player.speed)
	-- elseif player.slowDown and player.right == true and player.speed > 0 then -- RIGHT
	-- 	player.x = player.x + (dt * player.speed)
	-- end



	if love.keyboard.isDown("w", "a", "s", "d") then
		-- player.speed = player.speed + (dt * 400)
		resetDirections()
		print("FUCK")
		player.slowDown = false
		player.moving = true
	elseif not(love.keyboard.isDown("w", "a", "s", "d")) then
		-- player.speed = player.speed - (dt * 400)
		player.slowDown = true
		player.moving = false
		-- resetDirections()
	end

	-- if player.speed <= 0 then
	-- 	player.moving = false
	-- 	-- player.up = false
	-- 	-- player.left = false
	-- 	-- player.down = false
	-- 	-- player.right = false
	-- 	resetDirections()
	-- end
	

	animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
end

player.draw = function(self)

	love.graphics.setColor(1, 1, 1)
	-- UNCOMMENT LATER
	-- if player.moving == true then
	-- 	local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
	--     love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], player.x - (player.width/2)*player.directionHorizontal, player.y - player.height/2, 0, player.directionHorizontal, 1)
	-- elseif player.moving == false then
	-- 	love.graphics.rectangle("fill", player.x - player.width/2, player.y - player.height/2, player.width, player.height)
	-- end

	-- love.graphics.rectangle("fill", player.x - player.width/2, player.y - player.height/2, player.width, player.height)
	local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
	love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], player.x - (player.width/2)*player.directionHorizontal, player.y - player.height/2, 0, player.directionHorizontal, 1)


	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("line", player.x, player.y, 100)
end
