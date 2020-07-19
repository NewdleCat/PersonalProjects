y = 0

equation = []

for x in range(1, 11):
	y = x*x*x - 5*x*x + 228 - x
	equation.append((x, y))
	# print("At x = ", x, " y = ", y)

print(equation)

