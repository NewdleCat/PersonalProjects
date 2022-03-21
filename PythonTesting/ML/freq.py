data = [
	[3, 1, 2, 2, 3, 5],
	[5, 5, 3, 3, 5, 3],
	[5, 3, 5, 3, 5, 2],
	[2, 5, 5, 5, 2, 1],
	[3, 5, 1, 3, 5, 2],
]

S = 0 #sum of all data
k = 0 #number of data points

numbers = [0, 0, 0, 0, 0]
relativeFreq = []
laplaceCorr = []
mEstFive = []
mEstTwenty = []

for i in data:
	for num in i:
		if num == 1:
			numbers[0] += 1
		elif num == 2:
			numbers[1] += 1
		elif num == 3:
			numbers[2] += 1
		elif num == 4:
			numbers[3] += 1
		elif num == 5:
			numbers[4] += 1

S = 0
k = 0
for i in numbers:
	S += i
	k += 1

for i in numbers:
	relativeFreq.append(round(i/S, 3))
	laplaceCorr.append(round((i+1)/(S+k), 3))
	mEstFive.append(round((i+(5*(1/5)))/(S+5), 3))
	mEstTwenty.append(round((i+(20*(1/5)))/(S+20), 3))

print(numbers)
print(relativeFreq)
print(laplaceCorr)
print(mEstFive)
print(mEstTwenty)
