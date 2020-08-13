addToScore = {}

function newCell(x, y, val)
	local self = {}
	self.x = x
	self.y = y
	self.val = val
	self.hasChanged = false
	self.text = 1

	return self
end

function resetCells(board)
	for x = 1, 4 do
		for y = 1, 4 do
			board[x][y].hasChanged = false
		end
	end
end

function checkWin()
	for x = 1, 4 do
		for y = 1, 4 do
			if board[x][y].val == 2048 then
				return true
			end
		end
	end

	return false
end

function checkLost()
	-- CHECKS INSIDE 2x2
	for x = 2, 3 do
		for y = 2, 3 do
			if board[x][y].val == board[x + 1][y].val then
				return false
			elseif board[x][y].val == board[x - 1][y].val then
				return false
			elseif board[x][y].val == board[x][y + 1].val then
				return false
			elseif board[x][y].val == board[x][y - 1].val then
				return false
			end
			
		end
	end

	for x = 1, 3 do
		if board[x][1].val == board[x + 1][1].val then
			return false
		end
		if board[x][4].val == board[x + 1][4].val then
			return false
		end
	end

	for y = 1, 3 do
		if board[1][y].val == board[1][y + 1].val then
			return false
		end
		if board[4][y].val == board[4][y + 1].val then
			return false
		end
	end

	return true
end

function shiftCells(shiftDirection)
	local function newScore(val)
		local self = {}
		self.val = "+" .. val
		self.added = false
		self.x = 100 + love.graphics.getWidth()/2 + (newFont:getWidth("Score") - newFont:getWidth(self.val))/2
		self.y = 155
		self.elevation = 0
		self.alpha = 1

		return self
	end

	local scoreGain = 0

	if shiftDirection == "right" then
		for i = 1, 3 do -- run it 3 times
			for y = 1, 4 do
				for x = 4, 2, -1 do
					currCell = board[x][y]
					nextCell = board[x - 1][y]

					if nextCell.val == 0 then
						goto skip
					end

					if currCell.val == nextCell.val and currCell.hasChanged == false and nextCell.hasChanged == false then
						currCell.val = currCell.val + nextCell.val
						nextCell.val = 0
						currCell.hasChanged = true

						scoreGain = scoreGain + currCell.val
					elseif currCell.val == 0 then
						currCell.val = nextCell.val
						nextCell.val = 0
					end

					::skip::
				end
			end
		end


	elseif shiftDirection == "left" then

		for i = 1, 4 do
			for y = 1, 4 do
				for x = 1, 3 do
					currCell = board[x][y]
					nextCell = board[x + 1][y]

					if nextCell.val == 0 then
						goto skip
					end

					if currCell.val == nextCell.val and currCell.hasChanged == false and nextCell.hasChanged == false then
						currCell.val = currCell.val + nextCell.val
						nextCell.val = 0
						currCell.hasChanged = true
						scoreGain = scoreGain + currCell.val
					elseif currCell.val == 0 then
						currCell.val = nextCell.val
						nextCell.val = 0
					end

					::skip::
				end
			end
		end


	elseif shiftDirection == "up" then

		for i = 1, 4 do
			for x = 1, 4 do
				for y = 1, 3 do
					currCell = board[x][y]
					nextCell = board[x][y + 1]

					if nextCell.val == 0 then
						goto skip
					end

					if currCell.val == nextCell.val and currCell.hasChanged == false and nextCell.hasChanged == false then
						currCell.val = currCell.val + nextCell.val
						nextCell.val = 0
						currCell.hasChanged = true
						scoreGain = scoreGain + currCell.val
					elseif currCell.val == 0 then
						currCell.val = nextCell.val
						nextCell.val = 0
					end

					::skip::
				end
			end
		end

	elseif shiftDirection == "down" then

		for i = 1, 4 do
			for x = 1, 4 do
				for y = 4, 2, -1 do
					currCell = board[x][y]
					nextCell = board[x][y - 1]

					if nextCell.val == 0 then
						goto skip
					end

					if currCell.val == nextCell.val and currCell.hasChanged == false and nextCell.hasChanged == false then
						currCell.val = currCell.val + nextCell.val
						nextCell.val = 0
						currCell.hasChanged = true
						scoreGain = scoreGain + currCell.val
					elseif currCell.val == 0 then
						currCell.val = nextCell.val
						nextCell.val = 0
					end

					::skip::
				end
			end
		end

	end

	if scoreGain ~= 0 then
		table.insert(addToScore, newScore(scoreGain))
	end

end

function spawnCell()
	local emptyCells = {}

	for x = 1, 4 do
		for y = 1, 4 do
			if board[x][y].val == 0 then
				table.insert(emptyCells, {x, y})
			end
		end
	end

	tx, ty = unpack(emptyCells[love.math.random(1, #emptyCells)])
	rand = love.math.random(0, 100)

	if rand <= 10 then
		board[tx][ty].val = 4
	else
		board[tx][ty].val = 2
	end

	table.insert(boxList, newBox(tx, ty, board[tx][ty].val, "new"))

end