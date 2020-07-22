
def main():
	totalBill = float(input("Enter Total Bill: $"))

	bill = {}
	bill["unsorted"] = totalBill
	userInput = ""
	while userInput != "e":
		printMenu()
		userInput = input("Enter your option: ")	

		if userInput == "n":
			name = input("Enter section name: ")
			bill[name] = 0
			inputAmount = 1
			while inputAmount != 0:
				# printMenu()
				inputAmount = float(input("Enter your amount (0 for exit): "))

				if isinstance(inputAmount, int) == False and isinstance(inputAmount, float) == False:
					print("\n WRONG INPUT")
					continue

				if inputAmount != 0:
					bill[name] += inputAmount
					bill["unsorted"] -= inputAmount


		elif userInput == "p":
			print("\nTOTAL BILL: $", round(totalBill))
			print("---------------------")
			for x in bill.items():
				print(x[0], ": $", round(x[1]))

		elif userInput == "r":
			print()
		elif userInput == "e":
			print()
		else:
			print("\n WRONG INPUT")
			continue


			# bill[name] = 





def printMenu():
	print()
	print("OPTIONS: ")
	print("n - new section")
	print("p - print current bill")
	print("r - remove section")
	print("e - print final bill and exit")



if __name__ == "__main__":
	main()