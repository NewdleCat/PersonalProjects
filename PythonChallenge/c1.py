thing = "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."

result = ""
for x in thing:
	e = x
	if x == "a":
		e = "c"
	elif x == "b":
		e = "d"
	elif x == "c":
		e = "e"
	elif x == "d":
		e = "f"
	elif x == "e":
		e = "g"	
	elif x == "f":
		e = "h"
	elif x == "g":
		e = "i"
	elif x == "h":
		e = "j"
	elif x == "i":
		e = "k"
	elif x == "j":
		e = "l"
	elif x == "k":
		e = "m"
	elif x == "l":
		e = "n"
	elif x == "m":
		e = "o"
	elif x == "n":
		e = "p"
	elif x == "o":
		e = "q"
	elif x == "p":
		e = "r"
	elif x == "q":
		e = "s"
	elif x == "r":
		e = "t"
	elif x == "s":
		e = "u"
	elif x == "t":
		e = "v"
	elif x == "u":
		e = "w"
	elif x == "v":
		e = "x"
	elif x == "w":
		e = "y"
	elif x == "x":
		e = "z"
	elif x == "y":
		e = "a"
	elif x == "z":
		e = "b"

	if e != x:
		result = result + e


print(result)