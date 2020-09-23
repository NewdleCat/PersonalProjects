io.stdout:setvbuf("no")
require "player"
require "anim"

function love.load()
	love.window.setMode(1280, 1024)

	attackImage = love.graphics.newImage("test.png")


	attackList = {}
	enemyList = {}
	minionList = {}

	pause = false

	angle = 0
	dx = 0
	dy = 0

	-- table.insert(enemyList, newEnemy(100, 100))
	-- table.insert(enemyList, newEnemy(300, 100))

	for i = 1, 10 do
		table.insert(enemyList, newEnemy(100, 100*i))
	end

	for i,v in pairs(enemyList) do
		v.dead = true
	end

	-- animation = newAnimation(love.graphics.newImage("necro.png"), 36, 64, 1)

end

function love.update(dt)

	if paused then return end

	cameraX = -(player.x*5 + love.mouse.getX())/6 + love.graphics.getWidth()/2
	cameraY = -(player.y*5 + love.mouse.getY())/6 + love.graphics.getHeight()/2

	-- print(#minionList)

	player.update(dt)

	for i,v in pairs(attackList) do
		if v.cooldown >= 0 and v.hit == false then
			v.update(v, dt)
		else
			table.remove(attackList, i)
		end
	end

	for i,v in pairs(enemyList) do
		v.update(dt)
		-- if v.health <= 0 then
		-- 	table.remove(enemyList, i)
		-- end
	end

	for i,v in pairs(minionList) do
		v.update(dt)
	end

	-- minionCollisions(dt)

	print(player.moving)
	-- print(player.direction)


	angle = angle + dt
	dx = 100 * math.cos(angle)
	dy = 100 * math.sin(angle)
end

function love.draw()
	-- love.graphics.setBackgroundColor(1, 1, 1)
	love.graphics.setBackgroundColor(0, 0, 0)


	love.graphics.push()
	love.graphics.translate(cameraX, cameraY)

	-- love.graphics.setColor(0, 0, 0)
	-- love.graphics.line(player.x, player.y, dx * 10, dy * 10)

	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", -200, -200, 1000, 1000, 10, 10)
	-- love.graphics.rectangle("fill", 0, 0,)
	-- love.graphics.print("x: " .. player.x .. "y: " .. player.y, player.x + 30, player.y + 50)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(#enemyList, 10, 10)

	love.graphics.setColor(unpack(player.color))
	player.draw()

	love.graphics.setColor(1, 0, 0)

	-- drawing bullets/attacks
	for _,v in pairs(attackList) do
		love.graphics.setColor(unpack(v.color))
		v.draw(v)
	end
	-----------------------------

	-- drawing enemies---------------
	for _,v in pairs(enemyList) do
		love.graphics.setColor(unpack(v.color))
		v.draw(v)
	end
	-- -----------------------------

	-- drawing minons------------
	for _,v in pairs(minionList) do
		v.draw(v)
	end



	--------------------------

    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.circle("fill", player.x, player.y, 5)

    love.graphics.pop()

end

function newEnemy(x, y)
	local self = {}
	self.x = x
	self.y = y
	self.radius = 25
	self.health = 100
	self.color = {1, 0, 0}
	self.speed = 100
	self.dead = false

	self.update = function(dt)
		self.angle = math.atan2((player.y - self.y), (player.x - self.x))
		self.dx = self.speed * math.cos(self.angle)
		self.dy = self.speed * math.sin(self.angle)

		if self.dead == false then
			self.x = self.x + (dt * self.dx)
			self.y = self.y + (dt * self.dy)
		end

		if self.health <= 0 then
			self.dead = true
		end
	end

	self.draw = function(self)
		if self.dead == false then
			love.graphics.circle("fill", self.x, self.y, self.radius)
			love.graphics.rectangle("fill", self.x - self.health/2, self.y - 40, self.health, 10)
		else
			love.graphics.setColor(0, 0, 1)
			love.graphics.circle("fill", self.x, self.y, self.radius)
		end
	end

	return self
end

function newMinion(x, y)
	local self = {}
	self.x = x
	self.y = y
	self.radius = 20
	self.color = {1, 0, 0}
	self.speed = 200
	self.angle = 0
	self.moving = true
	self.maxDistance = 50 + (50 * math.floor(#minionList/2))
	self.dx = 0
	self.dy = 0
	self.tx = 0
	self.ty = 0

	self.idleImage = love.graphics.newImage("skeletonIdle.png")
	self.walkAnimation = newAnimation(love.graphics.newImage("skeleton.png"), 45, 64, 1)
	self.horizontalDirection = 1

	self.update = function(dt)
		self.angle = math.atan2((player.y - self.y), (player.x - self.x))
		self.dx = self.speed * math.cos(self.angle)
		self.dy = self.speed * math.sin(self.angle)

		if self.x - player.x < 0 then
			self.horizontalDirection = 1
		elseif self.x - player.x > 0 then
			self.horizontalDirection = -1
		end

		if distance(self.x, self.y, player.x, player.y) >= self.maxDistance then
			self.x = self.x + (dt * self.dx)
			self.y = self.y + (dt * self.dy)
			moving = true
		else
			moving = false
		end

		minionCollisions(self, dt)

		self.walkAnimation.currentTime = self.walkAnimation.currentTime + dt
	    if self.walkAnimation.currentTime >= self.walkAnimation.duration then
	       	self.walkAnimation.currentTime = self.walkAnimation.currentTime - self.walkAnimation.duration
	    end

	end

	self.draw = function(self)
		love.graphics.setColor(0, 0, 1)
		-- love.graphics.circle("line", self.x, self.y, self.radius)
		-- love.graphics.print("nono u sexy", self.x - 25, self.y - 40)

		-- love.graphics.setColor(0, 0, 0)
		-- love.graphics.line(self.x, self.y, (self.dx * 10), (self.dy * 10))

		-- love.graphics.setColor(1, 0, 0)
		-- love.graphics.line(self.x, self.y, (self.tx * 10), (self.ty * 10))

		love.graphics.setColor(1, 1, 1)

		if moving then
			local spriteNum = math.floor(self.walkAnimation.currentTime / self.walkAnimation.duration * #self.walkAnimation.quads) + 1
		    love.graphics.draw(self.walkAnimation.spriteSheet, self.walkAnimation.quads[spriteNum], self.x - (45/2)*self.horizontalDirection, self.y - 64/2, 0, self.horizontalDirection, 1)
		elseif not moving then
			love.graphics.draw(self.idleImage, self.x - (45/2)*self.horizontalDirection, self.y - 64/2, 0, self.horizontalDirection, 1)
		end

	end

	return self
end

function minionCollisions(curr, dt)
	local speed = curr.speed * 2 

	for _,v in pairs(minionList) do
		if curr.x ~= v.x and curr.y ~= v.y then
			if distance(curr.x, curr.y, v.x, v.y) < curr.radius*2 then
				-- print("Minon Collisiosn!!!")

				local angle = math.atan2((v.y - curr.y), (v.x - curr.x))
				local dx = speed * math.cos(angle)
				local dy = speed * math.sin(angle)

				curr.tx = -dx
				curr.ty = -dy

				curr.x = curr.x - (dt * dx) - (dt * (v.dx))
				curr.y = curr.y - (dt * dx) - (dt * (v.dy))

				moving = false
			
			end
		end
	end

end

function love.keypressed(key)
	 if key == "space" then
	 	paused = not paused
	 end
end

function newAttack(destX, destY)
	local self = {}
	self.x = player.x
	self.y = player.y
	self.speed = 800
	self.angle = math.atan2((destY - self.y), (destX - self.x))
	self.dx = self.speed * math.cos(self.angle)
	self.dy = self.speed * math.sin(self.angle)
	self.cooldown = 1
	self.color = {0, 0, 1}
	self.hit = false

	self.update = function(self, dt)
		self.cooldown = self.cooldown - dt
		self.x = self.x + (dt * self.dx)
		self.y = self.y + (dt * self.dy)

		for _,v in pairs(enemyList) do
			if distance(v.x, v.y, self.x, self.y) < v.radius and self.hit == false then
				v.health = v.health - 10
				self.hit = true
			end
		end
	end

	self.draw = function(self)
		-- love.graphics.circle("fill", self.x, self.y, 10)
		love.graphics.draw(attackImage, self.x, self.y, self.angle + 1.6)
	end

	return self
end

function love.mousepressed(x, y, button)

	realX = x - cameraX
	realY = y - cameraY

	if button == 1 then
		print("New Attack Towards: " .. "x: ".. x .. " y: " .. y)
		table.insert(attackList, newAttack(realX, realY))
	end 

	if button == 2 then
		print("right click")
		for i,v in pairs(enemyList) do
			if distance(v.x, v.y, realX, realY) <= v.radius and v.dead == true then
				table.insert(minionList, newMinion(v.x, v.y))
				table.remove(enemyList, i)
				print("new minion")
			end
		end
	end
end

function distance(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1))
end