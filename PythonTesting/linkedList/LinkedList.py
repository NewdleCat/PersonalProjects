class Node:
	def __init__(self, data):
		self.data = data
		self.next = None
		self.prev = None

class LinkedList:
	def __init__(self):
		self.head = None
	# end

	def insertNode(self, num):
		temp = self.head

		if temp == None:
			self.head = Node(num)
		else:
			while temp.next != None:
				temp = temp.next
			# end
			temp.next = Node(num)
			temp.next.prev = temp
		# end
	# end

	def printList(self):
		print("-------------------")
		temp = self.head
		while temp != None:
			print(temp.data, end=" ")
			temp = temp.next
		# end
		print("\n-------------------")
	# end

	def removeNode(self, num):
		temp = self.head
		wasRemoved = False

		if self.head == None:
			print("Could not remove Node as list is empty")
			return
		# end


		while temp != None:
			if self.head.data == num:
				self.head = self.head.next
				wasRemoved = True
				break
			# end

			if temp.data == num:
				temp.prev.next = temp.next
				if temp.next != None:
					temp.next.prev = temp.prev
				# end
				wasRemoved = True
				break
			# end
			temp = temp.next
		# end

		if wasRemoved:
			print(num, " was removed!")
		else:
			print(num, " is not within this list")
		# end
	# end