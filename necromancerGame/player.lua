require "anim"

player = {}
player.x = 200
player.y = 200
player.width = 36
player.height  = 64
player.color = {255/255, 255/255, 255/255}
player.speed = 400
player.direction = 1

animation = newAnimation(love.graphics.newImage("necro.png"), 36, 64, 1)

player.update = function(dt)
	if love.keyboard.isDown("w") then
		player.y = player.y - (dt * player.speed)
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - (dt * player.speed)
		player.direction = -1 
	end
	if love.keyboard.isDown("s") then
		player.y = player.y + (dt * player.speed)
	end
	if love.keyboard.isDown("d")then
		player.x = player.x + (dt * player.speed)
		player.direction = 1
	end

	animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
end

player.draw = function(self)
	-- love.graphics.rectangle("fill", player.x - player.width/2, player.y - player.height/2, player.width, player.height)

	love.graphics.setColor(1, 1, 1)
	local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], player.x - (player.width/2)*player.direction, player.y - player.height/2, 0, player.direction, 1)
end
