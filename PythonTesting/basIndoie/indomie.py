import random

def main():
	indomie = 0

	while indomie != 3:
		indomie = random.randint(1, 5)
		if indomie != 3:
			print("Bas has to eat",indomie, "indomie. Actually lying")
		else:
			print("Bas has to eat",indomie, "indomie")

	# print("Bas has to eat", indomie ,"indomie")


if __name__ == "__main__":
	main()