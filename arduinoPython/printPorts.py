import serial.tools.list_ports


print("fuck")
ports = list(serial.tools.list_ports.comports(include_links = False))
for p in ports:
    print(p)