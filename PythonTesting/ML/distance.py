import math
pointList = [
	[2,2,3,"+"],
	[3,3,2,"+"],
	[1,2,3,"+"],
	[1,4,1,"+"],
	[4,4,4,"+"],
	[2,2,2,"+"],
	[3,3,1,"-"],
	[1,1,1,"-"],
	[3,3,2,"-"],
	[0,4,2,"-"],
	[4,0,0,"-"],
	[0,0,3,"-"]
]

a = 3
b = 2
c = 4
d = -18


for i in pointList:
	print("Point:", i, end="    ")
	x,y,z,case = i[0],i[1],i[2],i[3]
	# print(x, y, z)
	distance = a*x + b*y + c*z + d
	distance = abs(distance)
	div = math.sqrt(a*a + b*b + c*c)
	distance = distance/div

	val = a*x + b*y + c*z
	if val < -d and case == "+":
		distance = -distance
	elif val >= -d and case == "-":
		distance = -distance

	print("\\textbf{a)}", round(distance, 3), end="    ")

	zeroOneLoss = 0
	if distance <= 0:
		zeroOneLoss = 1

	print("\\textbf{b)}", zeroOneLoss, end="     ")

	hingeLoss = 1 - distance
	squaredLoss = hingeLoss ** 2
	if hingeLoss < 0:
		hingeLoss = 0
	if squaredLoss < 0 or distance > 1:
		squaredLoss = 0

	print("\\textbf{c)}", round(hingeLoss, 3), end="     ")
	print("\\textbf{d)}", round(squaredLoss, 3), "\\\\")

# print(pointList)