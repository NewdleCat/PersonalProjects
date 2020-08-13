function love.load()
	health = 100
	rage = 0
	keyBuffer = false
end

function love.update(dt)

	if love.keyboard.isDown("space") and keyBuffer == false then
		health = health - 5
	end

	if health <= 10 then
		rage = 100
	end

	if love.keyboard.isDown("space") then
		keyBuffer = true
	else
		keyBuffer = false
	end 

end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	if rage > 0 then
		love.graphics.setColor(1, 0, 0)
	end
	love.graphics.circle("fill", 300, 300, 50)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Health: ", 90, 100)
	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", 140, 100, 5 * health, 10)

end
