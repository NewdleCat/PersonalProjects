snake = {}
snake.x = 100
snake.y = 100
snake.speed = 1

function snake_move()

	if love.keyboard.isDown("down") then
		snake.y = snake.y + 1 * snake.speed
	end

	if love.keyboard.isDown("up") then
		snake.y = snake.y - 1 * snake.speed
	end

	if love.keyboard.isDown("left") then
		snake.x = snake.x - 1 * snake.speed
	end

	if love.keyboard.isDown("right") then
		snake.x = snake.x + 1 * snake.speed
	end

end
