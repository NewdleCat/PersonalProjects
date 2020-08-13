io.stdout:setvbuf("no")
require "board"
require "boxes"

function love.load()
	love.window.setMode(1280, 900)
	shiftDirection = ""
	boxSpeed = 1000
	newFont = love.graphics.newFont("ClearSans-Regular.ttf", 30)
	titleFont = love.graphics.newFont("ClearSans-Regular.ttf", 120)
	gameWin = false
	gameLose = false
	doneShifting = false
	gameScore = 0
	keyCooldown = 0
	boxGap = 110

	resetButton = {}
	resetButton.x = 100 + love.graphics.getWidth()/2 - 30
	resetButton.y = 220
	resetButton.width = 140
	resetButton.height = 50
	resetButton.text = "New Game"
	resetButton.color = {187/255, 173/255, 160/255}
	resetButton.textColor = {1, 1, 1}
	resetButton.shade = false

	shiftOccured = false

	board = {}
	for x = 1, 4 do
		board[x] = {}
		for y = 1, 4 do
			board[x][y] = newCell(x, y, 0)
		end
	end
	spawnCell()
	spawnCell()


end

function love.update(dt)

	-- if keyCooldown > 0 then
	if doneShifting == false then
		shiftDirection = ""
	end

	if doneShifting then
		shiftCells(shiftDirection)
	end

	if doneShifting and #shiftCoords == 0 then
		createCoords(shiftDirection)
		doneShifting = false
	end

	for i,v in pairs(shiftCoords) do
		shiftBoxes(v, dt, i)
	end

	boxInflate(dt)

	if #shiftCoords == 0 then
		boxCreator()
		boxCleanup()
		boxColors()
		resetCells(board)
		doneShifting = true
		-- shiftDirection = ""
	end


	x, y = GetMousePosition()

	if x >= resetButton.x and x <= resetButton.x + resetButton.width and y >= resetButton.y and y <= resetButton.y + resetButton.height then
		resetButton.shade = true
	else
		resetButton.shade = false
	end
	-- print(shiftOccured)

	-- for _,v in pairs(shiftCoords) do
	-- 	print(v.startX .. v.startY .. " | " .. v.destX .. v.destY)
	-- end

	-- Score Updater
	for i,v in pairs(addToScore) do
		if v.added == false then
			gameScore = gameScore + v.val
			v.added = true
		end

		if v.elevation < 70 then
			v.elevation = v.elevation + (dt * 70)
			v.alpha = v.alpha - (dt)
		else
			table.remove(addToScore, i)
		end
	end
	------------------


	-- CHECKS FOR WIN CONDITION
	gameWin = checkWin()

	-- CHECKS FOR LOSE CONDITION
	gameLost = checkLost()
	-- print("1"0)

	if shiftOccured and doneShifting then
		spawnCell()
		shiftOccured = false
	end

	::skip::
end



function love.draw()
	love.graphics.setBackgroundColor(68/255, 61/255, 61/255)

	-- title
	love.graphics.setFont(titleFont)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("2048", love.graphics.getWidth()/4, 100, 0, 1)
	--------	
	love.graphics.setFont(newFont)

	love.graphics.setColor(187/255, 173/255, 160/255)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2 + (-2 * boxGap)) - 20, (love.graphics.getHeight()/4 + boxGap) - 20, (boxGap * 4) + 20, (boxGap * 4) + 20, 10, 10)
	for x = -2, 1 do
		for y = 1, 4 do
			love.graphics.setColor(205/255, 193/255, 180/255)
			love.graphics.rectangle("fill", love.graphics.getWidth()/2 + (x * boxGap), love.graphics.getHeight()/4 + (y * boxGap), 90, 90, 10, 10)
		end
	end

	for i,v in pairs(boxList) do
		-- love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.setColor(unpack(v.color))
		-- love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", v.x + (1 - v.scale)*(v.width/2), v.y + (1 - v.scale)*(v.height/2), v.width * v.scale, v.height * v.scale, 10, 10)
		love.graphics.setColor(v.text, v.text, v.text)
		love.graphics.print(v.val , v.x + (v.width - newFont:getWidth(v.val)*v.scale)/2, v.y + (v.height - newFont:getHeight(v.val)*v.scale)/2, 0, v.scale)
	end

	

	for x = 1, 4 do
		for y = 1, 4 do
			cell = board[x][y]
			if cell.val ~= 0 then
			end
			love.graphics.setColor(cell.text, cell.text, cell.text)
			love.graphics.print(cell.val , (cell.x * 50), (cell.y * 50) + 500)
		end
	end



	if gameLost == true then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("LOST")
	end

	if gameWin == true then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("WIN")
	end

	-- SCORE BOARD
	love.graphics.setColor(187/255, 173/255, 160/255)
	love.graphics.rectangle("fill", 100 + love.graphics.getWidth()/2 - 30, 140, 140, 75, 10, 10)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Score", 100 + love.graphics.getWidth()/2, 140)
	love.graphics.print(gameScore, 100 + love.graphics.getWidth()/2 + (newFont:getWidth("Score") - newFont:getWidth(gameScore))/2, 170)

	for _,v in pairs(addToScore) do
		love.graphics.setColor(0, 0, 0, v.alpha)
		love.graphics.print(v.val, v.x, v.y - v.elevation)
	end
	-------------------------------------------------------

	---------------Reseet Button---------------------------
	love.graphics.setColor(unpack(resetButton.color))
	love.graphics.rectangle("fill", resetButton.x, resetButton.y, resetButton.width, resetButton.height, 10, 10)

	love.graphics.setColor(unpack(resetButton.textColor))
	love.graphics.print(resetButton.text, resetButton.x + 5, resetButton.y, 0, 0.9)

	if resetButton.shade then
		love.graphics.setColor(0, 0, 0, 0.2)
		love.graphics.rectangle("fill", resetButton.x, resetButton.y, resetButton.width, resetButton.height, 10, 10)
	end
	-------------------------------------------------------
end

function love.keypressed(key)

	if key == "right" or key == "d" then
		shiftDirection = "right"
	elseif key == "left" or key == "a" then
		shiftDirection = "left"
	elseif key == "up" or key == "w" then
		shiftDirection = "up"
	elseif key == "down" or key == "s" then
		shiftDirection = "down"
	end
end

function love.mousepressed(x,y, button)
    -- relay this event to all things that exist
    if button == 1 and x >= resetButton.x and x <= resetButton.x + resetButton.width and y >= resetButton.y and y <= resetButton.y + resetButton.height then
    	print("RESET GAME")
    	resetGame()
    end
end

function GetMousePosition()
    return love.mouse.getX(), love.mouse.getY()
end

function resetGame()
	for x = 1, 4 do
		for y = 1, 4 do
			board[x][y].val = 0
		end
	end

	for i,_ in pairs(boxList) do
		table.remove(boxList, i)
	end

	spawnCell()
	spawnCell()

	gameScore = 0
end