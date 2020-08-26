io.stdout:setvbuf("no")

function love.load()
	minionList = {}
	player = {}
	player.x = 100
	player.y = 100
	player.w = 50
	player.h = 50
	player.speed = 300
	player.count = 0
	player.m = ""


	player.update = function(dt)

		local tempList = {}
		local distanceList = {}
		for i,v in pairs(minionList) do
			table.insert(tempList, v)
			table.insert(distanceList, distance(player.x, player.y, v.x, v.y))
		end

		local min = 0
		local minIndex = 1
		local count = 0
		for i,v in pairs(distanceList) do
			count = count + 1
			if min == 0 or min > v then
				min = v
				minIndex = count
			end
		end

		m = tempList[minIndex]
		player.m = m

		m.xRange = false
		m.yRange = false

		if player.x > (m.x - m.w/2) and player.x  < (m.x + m.w/2) then
			m.xRange = true
		elseif (player.x - player.w/2) - 2 > (m.x - m.w/2) and (player.x - player.w/2) - 2 < (m.x + m.w/2) then
			m.xRange = true
		elseif (player.x + player.w/2) - 2 > (m.x - m.w/2) and (player.x + player.w/2) - 2 < (m.x + m.w/2) then
			m.xRange = true
		end 

		if player.y > (m.y - m.h/2) and player.y < (m.y + m.h/2) then
			m.yRange = true
		elseif (player.y - player.h/2) > (m.y - m.h/2) and (player.y - player.h/2) < (m.y + m.h/2) then
			m.yRange = true
		elseif (player.y + player.h/2) > (m.y - m.h/2) and (player.y + player.h/2) < (m.y + m.h/2) then
			m.yRange = true
		end			

		if (player.x + player.w/2) > (m.x + m.w/2) then
			m.xStatus = "left"
		elseif (player.x - player.w/2) < (m.x - m.w/2) then
			m.xStatus = "right"
		end

		if (player.y + player.h/2) > (m.y + m.h/2) then
			m.yStatus = "top"
		elseif (player.y - player.h/2) < (m.y - m.h/2) then
			m.yStatus = "bottom"
		end

		if love.keyboard.isDown("w") then
			if (m.y + m.h/2) < (player.y - player.h/2) or not m.xRange or m.yStatus == "bottom" then
				player.y = player.y - (dt * player.speed)
				m.touching = ""
			else
				m.touching = "bottom"
			end
		end
		if love.keyboard.isDown("a") then
			if (m.x + m.w/2) < (player.x - player.w/2) or not m.yRange or m.xStatus == "right" then
				player.x = player.x - (dt * player.speed)
				m.touching = ""
			else
				m.touching = "right"
			end
		end
		if love.keyboard.isDown("s") then
			if (m.y - m.h/2) > (player.y + player.h/2) or not m.xRange or m.yStatus == "top" then
				player.y = player.y + (dt * player.speed)
				m.touching = ""
			else
				m.touching = "top"
			end
		end
		if love.keyboard.isDown("d") then
			if (m.x - m.w/2) > (player.x + player.w/2) or not m.yRange or m.xStatus == "left" then
				player.x = player.x + (dt * player.speed)
				m.touching = ""
			else
				m.touching = "left"
			end
		end

		-- print(m.touching)

	end

	player.draw = function()
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", player.x - player.w/2, player.y - player.h/2, player.w, player.h)
		love.graphics.setColor(1, 0, 0)
		love.graphics.circle("fill", player.x, player.y, 2)

		local m = player.m
		-- love.graphics.line(player.x, player.y, m.x, m.y)
		if m.xStatus == "right" then
			if distance(player.x + player.w/2, player.y - player.h/2, m.x - m.w/2, m.y - m.h/2) < 20 then
				love.graphics.setColor(0, 1, 0)
			else
				love.graphics.setColor(1, 0, 0)
			end
			love.graphics.line(player.x + player.w/2, player.y - player.h/2, m.x - m.w/2, m.y - m.h/2)

			if distance(player.x + player.w/2, player.y + player.h/2, m.x - m.w/2, m.y + m.h/2) < 20 then
				love.graphics.setColor(0, 1, 0)
			else
				love.graphics.setColor(1, 0, 0)
			end
			love.graphics.line(player.x + player.w/2, player.y + player.h/2, m.x - m.w/2, m.y + m.h/2)

			if distance(player.x + player.w/2, player.y - player.h/2, m.x - m.w/2, m.y + m.h/2) < 20 then
				love.graphics.setColor(0, 1, 0)
			else
				love.graphics.setColor(1, 0, 0)
			end
			love.graphics.line(player.x + player.w/2, player.y - player.h/2, m.x - m.w/2, m.y + m.h/2)

			if distance(player.x + player.w/2, player.y + player.h/2, m.x - m.w/2, m.y - m.h/2) < 20 then
				love.graphics.setColor(0, 1, 0)
			else
				love.graphics.setColor(1, 0, 0)
			end
			love.graphics.line(player.x + player.w/2, player.y + player.h/2, m.x - m.w/2, m.y - m.h/2)
		end

	end


	table.insert(minionList, newMinion(200, 200))
	table.insert(minionList, newMinion(400, 200))
end

function love.update(dt)
	player.update(dt)

	for i,v in pairs(minionList) do
		-- print(v.xRange)
		v.update(dt)
	end

	print(testList)
end

function love.draw()
	for i,v in pairs(minionList) do
		love.graphics.setColor(1, 1, 1)
		v.draw()
		love.graphics.circle("fill", v.x, v.y, 2)
	end

	player.draw()
end


function newMinion(x, y)
	local self = {}
	self.x = x
	self.y = y
	self.w = 50
	self.h = 50
	self.xRange = false
	self.yRange = false
	self.yStatus = ""
	self.xStatus = ""
	self.touching = ""
	self.coordList = {}

	local function newCoords(x, y)
		local coord = {}
		coord.x = x
		coord.y = y

		return coord
	end

	local function updateCoords(self)
		self.coordList = {}
		print("updating")
		for x = self.x - self.w/2, self.x + self.w/2, 1 do
			table.insert(self.coordList, newCoords(x, self.y - self.h/2))
			table.insert(self.coordList, newCoords(x, self.y + self.h/2))
		end

		for y = self.y - self.h/2, self.y + self.h/2, 1 do
			table.insert(self.coordList, newCoords(self.x - self.w/2, y))
			table.insert(self.coordList, newCoords(self.x + self.w/2, y))
		end
	end

	self.update = function(dt)
		-- print(self.touching)

		-- if #self.coordList == 0 or self.touching ~= "" then
		-- 	updateCoords(self)
		-- end

		if self.touching == "bottom" and love.keyboard.isDown("w") then
			self.y = self.y - (dt * player.speed)
		elseif self.touching == "right" and love.keyboard.isDown("a") then
			self.x = self.x - (dt * player.speed)
		elseif self.touching == "top" and love.keyboard.isDown("s") then
			self.y = self.y + (dt * player.speed)
		elseif self.touching == "left" and love.keyboard.isDown("d") then
			self.x = self.x + (dt * player.speed)
		end
	end

	self.draw = function()
		love.graphics.rectangle("line", self.x - self.w/2, self.y - self.h/2, self.w, self.h)

		for i,v in pairs(self.coordList) do
			love.graphics.setColor(1, 0, 0)
			love.graphics.circle("fill", v.x, v.y, 1)
		end
	end

	return self
end

function distance(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1))
end