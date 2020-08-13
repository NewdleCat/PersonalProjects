bill = {}

def main():
	totalBill = float(input("Enter Total Bill: $"))

	userInput = ""
	while userInput != "e":
		printMenu()
		userInput = input("Enter your option: ")	

		if userInput == "n":
			name = input("Enter section name: ")
			bill[name] = createEntryList()
		elif userInput == "p":
			printBill(totalBill)
		elif userInput == "r":
			removeInput = ""

			while removeInput != "exit":
				print("What do you want to remove?")
				print("1 - An entire section")
				print("2 - Entries from a section")
				removeInput = input("Enter Selection(exit to go back): ")

				if removeInput == "1":
					removeEntryList()
				elif removeInput == "2":
					removeElementFromList()
				elif rmeoveInput == "exit":
					print("Leaving....")
					continue
				else:
					print("WRONG INPUT")
					continue


			removeInput = ()
		elif userInput == "e":
			printBill(totalBill)
			print("----- END OF PROGRAM -----")
		else:
			print("\n WRONG INPUT")
			continue


			# bill[name] = 

def printBill(totalBill):
	unsorted = totalBill
	print("\nTOTAL BILL: $", round(totalBill, 2))
	print("-----------------------------------")
	for x in bill.items():
		print(x[0], "--- Total: $", x[1]["total"])
		unsorted -= x[1]["total"]
		for item in x[1].items():
			if x[0] != "total":
				print("  ", item[0], " - $", item[1])

	print("UNSORTED: ", unsorted)


def removeEntryList():
	print("removeEntryList")

def removeElementFromList():
	print("removeElementFromList")

def createEntryList():
	entryList = {}
	inputPrice = 0
	inputName = ""
	totalPrice = 0
	while inputName != "exit":
		wrongInput = False
		# printMenu()
		inputName = input("Enter New Entry(exit for quit): ")

		if inputName == "exit" :
			continue

		inputPrice = input("Enter the Price: ")

		for c in inputPrice:
			if c.isdigit() == False and c != ".":
				wrongInput = True

		if wrongInput == True:
			print("\n WRONG INPUT")
			continue

		inputPrice = float(inputPrice)
		entryList[inputName] = inputPrice

		totalPrice = totalPrice + inputPrice

	entryList["total"] = totalPrice

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