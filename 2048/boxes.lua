boxList = {}
shiftCoords = {}

function newBox(x, y, val, state)
	local box = {}
	box.boardX = x
	box.boardY = y
	box.x = (love.graphics.getWidth()/2) + ((x - 3) * boxGap)
	box.y = (love.graphics.getHeight()/4) + (y * boxGap)
	box.width = 90
	box.height = 90
	box.color = {1, 1, 1}
	box.text = 0
	box.val = val
	box.state = state

	if state == "new" then
		box.expandCooldown = 0.125
		box.scale = 0
	elseif state == "combined" then
		box.scale = 2
		box.expandCooldown = 1 
	else
		box.expandCooldown = 0
		box.scale = 1
	end

	return box
end

function boxInflate(dt)
	for _,v in pairs(boxList) do
		if v.expandCooldown > 0 and v.state == "new" then
			v.expandCooldown = v.expandCooldown - dt
			v.scale = v.scale + (dt * 8)
		else
			v.state = ""
		end

		if v.expandCooldown > 0 and v.state == "combined" then
			v.expandCooldown = v.expandCooldown - dt
			v.scale = v.scale - (dt)
		end
	end
end

function shiftBoxes(coords, dt, i, shiftDirection)
	local startBox
	local destBox = {}
	destBox.boardX = coords.destX
	destBox.boardY = coords.destY
	destBox.x = (love.graphics.getWidth()/2) + ((destBox.boardX - 3) * boxGap)
	destBox.y = (love.graphics.getHeight()/4) + (destBox.boardY * boxGap)


	for _,v in pairs(boxList) do
		if v.boardX == coords.startX and v.boardY == coords.startY then
			startBox = v
		end
	end
	
	if startBox and coords.direction == "right" then
		if startBox.x < destBox.x then
			startBox.x = startBox.x + (dt * boxSpeed * coords.speedMultiplier)
		else
			table.remove(shiftCoords, i)
		end
	end

	if startBox and coords.direction == "left" then
		if startBox.x > destBox.x then
			startBox.x = startBox.x - (dt * boxSpeed * coords.speedMultiplier)
		else
			table.remove(shiftCoords, i)
		end
	end 

	if startBox and coords.direction == "up" then
		if startBox.y > destBox.y then
			startBox.y = startBox.y - (dt * boxSpeed * coords.speedMultiplier)
		else
			table.remove(shiftCoords, i)
		end
	end

	if startBox and coords.direction == "down" then
		if startBox.y < destBox.y then
			startBox.y = startBox.y + (dt * boxSpeed * coords.speedMultiplier)
		else
			table.remove(shiftCoords, i)
		end
	end

end

function createCoords(shiftDirection)
	local function getBox(x, y)
		for i,v in pairs(boxList) do
			if v.boardX == x and v.boardY == y then
				return v
			end
		end

		return false
	end

	local function newShiftOrder(startX, startY, destX, destY, speed, direction)
		local self = {}
		self.startX = startX
		self.startY = startY
		self.destX = destX
		self.destY = destY
		self.speedMultiplier = speed
		self.direction = direction

		shiftOccured = true

		return self
	end	


	if shiftDirection == "right" and #shiftCoords == 0 then
		sameCount = 0

		for y = 1, 4 do
			shiftCounter = 0
			
			for x = 4, 1, -1 do
				if getBox(x, y) == false then

					shiftCounter = shiftCounter + 1
					goto skip
				else
					currBox = getBox(x, y)
				end

				sameCount = 0
				for i = 1, 4 - x do
					if getBox(x + i, y) == false then
						break
					elseif getBox(x + i, y).val == currBox.val then
						sameCount = sameCount + 1
					elseif getBox(x + i, y).val ~= currBox.val then
						break
					end
				end

				shiftCounter = shiftCounter + (sameCount % 2)

				if shiftCounter ~= 0 then
					table.insert(shiftCoords, newShiftOrder(x, y, x + shiftCounter, y, shiftCounter, "right"))
				end


				::skip::
			end
		end
	end

	if shiftDirection == "left" and #shiftCoords == 0 then
		sameCount = 0

		for y = 1, 4 do
			shiftCounter = 0
			
			for x = 1, 4 do
				if getBox(x, y) == false then

					shiftCounter = shiftCounter + 1
					goto skip
				else
					currBox = getBox(x, y)
				end

				sameCount = 0
				for i = 1, x - 1 do
					if getBox(x - i, y) == false then
						break
					elseif getBox(x - i, y).val == currBox.val then
						sameCount = sameCount + 1
					elseif getBox(x - i, y).val ~= currBox.val then
						break
					end
				end

				shiftCounter = shiftCounter + (sameCount % 2)

				if shiftCounter ~= 0 then
					table.insert(shiftCoords, newShiftOrder(x, y, x - shiftCounter, y, shiftCounter, "left"))
				end

				::skip::
			end
		end
	end

	if shiftDirection == "up" and #shiftCoords == 0 then
		sameCount = 0

		for x = 1, 4 do
			shiftCounter = 0
			
			for y = 1, 4 do
				if getBox(x, y) == false then

					shiftCounter = shiftCounter + 1
					goto skip
				else
					currBox = getBox(x, y)
				end

				sameCount = 0
				for i = 1, y - 1 do
					if getBox(x, y - i) == false then
						break
					elseif getBox(x, y - i).val == currBox.val then
						sameCount = sameCount + 1
					elseif getBox(x, y - i).val ~= currBox.val then
						break
					end
				end

				shiftCounter = shiftCounter + (sameCount % 2)

				if shiftCounter ~= 0 then
					table.insert(shiftCoords, newShiftOrder(x, y, x, y - shiftCounter, shiftCounter, "up"))
				end


				::skip::
			end
		end
	end

	if shiftDirection == "down" and #shiftCoords == 0 then
		sameCount = 0

		for x = 1, 4 do
			shiftCounter = 0
			
			for y = 4, 1, -1 do
				if getBox(x, y) == false then
					shiftCounter = shiftCounter + 1
					goto skip
				else
					currBox = getBox(x, y)
				end

				sameCount = 0
				for i = 1, 4 - y do
					if getBox(x, y + i) == false then
						break
					elseif getBox(x, y + i).val == currBox.val then
						sameCount = sameCount + 1
					elseif getBox(x, y + i).val ~= currBox.val then
						break
					end
				end

				shiftCounter = shiftCounter + (sameCount % 2)

				if shiftCounter ~= 0 then
					table.insert(shiftCoords, newShiftOrder(x, y, x, y + shiftCounter, shiftCounter, "down"))
				end

				::skip::
			end
		end
	end

end

function boxCreator()
	local exists = false
	for x = 1, 4 do
		for y = 1, 4 do
			if board[x][y].val > 0 then
				exists = false
				for i,v in pairs(boxList) do
					if v.boardX == x and v.boardY == y then
						exists = true
						-- update the box value
						v.val = board[v.boardX][v.boardY].val
						v.boardX = x
						v.boardY = y
						v.x = (love.graphics.getWidth()/2) + ((x - 3) * boxGap)
						v.y = (love.graphics.getHeight()/4) + (y * boxGap)

					end
				end
				
				if exists == false then
					table.insert(boxList, newBox(x, y, board[x][y].val))
				end
			end
		end
	end
end

function boxCleanup()
	for i,v in pairs(boxList) do
		if board[v.boardX][v.boardY].val == 0 then
			table.remove(boxList, i)
		end
	end
end

function boxColors()
	for i,v in pairs(boxList) do
		val = board[v.boardX][v.boardY].val

		if val == 2 then
			v.color = {229, 239, 193}
			v.text = 0
		elseif val == 4 then
			v.color = {162, 213, 171}
			v.text = 0
		elseif val == 8 then
			v.color = {57, 174, 140}
			v.text = 1
		elseif val == 16 then
			v.color = {57, 174, 167}
			v.text = 1
		elseif val == 32 then
			v.color = {85, 123, 131}
			v.text = 1
		elseif val == 64 then
			v.color = {85, 123, 116}
			v.text = 1
		elseif val == 128 then
			v.color = {168, 100, 193}
			v.text = 1
		elseif val == 256 then
			v.color = {151, 90, 173}
			v.text = 1
		elseif val == 512 then
			v.color = {122, 72, 140}
			v.text = 1
		elseif val == 1024 then
			v.color = {111, 66, 127}
			v.text = 1
		elseif val == 2048 then
			v.color = {95, 57, 109}
			v.text = 1
		end

		local r, g, b = unpack(v.color)
		v.color = {r/255, g/255, b/255}
	end
end

function getBox(x, y)
	for _,v in pairs(boxList) do
		if x == v.boardX and y == v.boardY then
			return v
		end
	end

	return false
end