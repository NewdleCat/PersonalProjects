from LinkedList import LinkedList
from LinkedList import Node

def main():
	print("I am a gay")
	l = LinkedList()

	userIn = input("test: ")

	numList = [1, "fuck", 3, 4, 5]

	for x in numList:
		l.insertNode(x)

	# l.head = Node(1)
	l.printList()

	l.removeNode(6)

	l.printList()

if __name__ == "__main__":
	main()