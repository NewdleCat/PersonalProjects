require "snake"

function love.load()

end

function love.update(dt)

	snake_move()
end

function love.draw()
	love.graphics.circle("fill", snake.x, snake.y, 10)
end

