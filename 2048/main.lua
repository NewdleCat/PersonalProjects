function love.load()
	board = {}
	for i = 1, 4 do
		board[i] = {}
		for j = 1, 4 do
			board[i][j] = 0
		end
	end

	board[2][1] = 2
	board[3][3] = 2

	zeroCount = 16
	gameOver = false
	playerTurn = true
	lastPressed = nil
	tilesShifted = true
end

function love.update(dt)

	-- playerTurn = true

	zeroCount = 0
	for y = 1, 4, 1 do
		for x = 1, 4, 1 do
			if board[x][y] == 0 then
				zeroCount = zeroCount + 1
			end
		end
	end

	if zeroCount == 0 then
		gameOver = true
	end

	while zeroCount ~= 0 and playerTurn == false and tilesShifted == true do
		randY = love.math.random(1, 4)
		randX = love.math.random(1, 4)

		if board[randX][randY] == 0 then
			board[randX][randY] = 2
			playerTurn = true
			tilesShifted = false
		end
	end


	if keyBuffer == false and love.keyboard.isDown("right") then
		for i = 1, 3, 1 do
			for y = 1, 4, 1 do
				for x = 3, 1, -1 do
					currTile = board[x][y]
					while x < 4 and board[]

					nextTile = board[x+1][y]
					if currTile == nextTile or nextTile == 0 then
						board[x+1][y] = currTile + nextTile
						board[x][y] = 0
						tilesShifted = true
					end
				end
			end
		end
		playerTurn = false
		lastPressed = "right"
    
    elseif keyBuffer == false and love.keyboard.isDown("left") then
		for y = 1, 4, 1 do
			for x = 2, 4, 1 do
				currTile = board[x][y]
				nextTile = board[x-1][y]
				if currTile == nextTile or nextTile == 0 then
					board[x-1][y] = currTile + nextTile
					board[x][y] = 0
					tilesShifted = true
				end
			end
		end
		playerTurn = false
		lastPressed = "left"
    
    elseif keyBuffer == false and love.keyboard.isDown("up") then
    	for i = 1, 3, 1 do
    		for x = 1, 4, 1 do
				for y = 2, 4, 1 do
					currTile = board[x][y]
					nextTile = board[x][y - 1]
					if currTile == nextTile or nextTile == 0 then
						board[x][y - 1] = currTile + nextTile
						board[x][y] = 0
						tilesShifted = true
					end
				end
			end
    	end
		playerTurn = false
		lastPressed = "up"
    
    elseif keyBuffer == false and love.keyboard.isDown("down") then
    	for i = 1, 3, 1 do
    		for x = 1, 4, 1 do
				for y = 3, 1, -1 do
					currTile = board[x][y]
					nextTile = board[x][y + 1]
					if currTile == nextTile or nextTile == 0 then
						board[x][y + 1] = currTile + nextTile
						board[x][y] = 0
						tilesShifted = true
					end
				end
			end
    	end
		playerTurn = false
		lastPressed = "down"
    end

    if love.keyboard.isDown("left", "right", "up", "down") then
        keyBuffer = true
    	print(tilesShifted)
    else
        keyBuffer = false
    end


end

function love.draw()
	for i = 1, 4 do
		for j = 1, 4 do
			love.graphics.setColor(1 - (2 * board[i][j]/256), 1, 1 - (2 * board[i][j]/256))
			love.graphics.rectangle("fill", 100 * i - 30, 100 * j - 30, 60, 60)
			love.graphics.setColor(0, 0, 0)
			love.graphics.print(board[i][j], 100 * i - 15, 100 * j - 15, 0, 2)
		end
	end

	if gameOver == true then
		love.graphics.print("GAME OVER")
		return
	end
end
