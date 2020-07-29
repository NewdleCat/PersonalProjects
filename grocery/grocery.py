
def main():
	totalBill = float(input("Enter Total Bill: $"))

	bill = {}
	userInput = ""
	while userInput != "e":
		printMenu()
		userInput = input("Enter your option: ")	

		if userInput == "n":
			name = input("Enter section name: ")
			bill[name] = createEntryList()
		elif userInput == "p":
			print("\nTOTAL BILL: $", round(totalBill, 2))
			print("-----------------------------------")
			for x in bill.items():
				print(x[0])
				for item in x[1]:
					print("  ", item[0], " - $", item[1])

		elif userInput == "r":
			print()
		elif userInput == "e":
			print()
		else:
			print("\n WRONG INPUT")
			continue


			# bill[name] = 


def createEntryList():
	entryList = []
	inputPrice = 0
	inputName = ""
	while inputName != "exit":
		wrongInput = False
		# printMenu()
		inputName = input("Enter New Entry(exit for quit): ")

		if inputName == "exit" :
			continue

		inputPrice = input("Price: ")

		for c in inputPrice:
			if c.isdigit() == False and c != ".":
				wrongInput = True

		if wrongInput == True:
			print("\n WRONG INPUT")
			continue

		inputPrice = float(inputPrice)
		entryList.append((inputName, inputPrice))

	return entryList.copy()



def printMenu():
	print()
	print("OPTIONS: ")
	print("n - new section")
	print("p - print current bill")
	print("r - remove section")
	print("e - print final bill and exit")



if __name__ == "__main__":
	main()