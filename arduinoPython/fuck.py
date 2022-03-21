#Python code for connecting Arduino to Python
#That's Engineering
#29/04/2020

import serial
from playsound import playsound
# import time
# import schedul

import serial.tools.list_ports

arduino = serial.Serial("COM3", 9600)
# arduino = serial.Serial("/dev/ttyS3", 9600)

def main_func():
    # arduino = serial.Serial(0)
    arduino_data = arduino.readline()
    # print(len(arduino_data))
    # print(arduino_data[2:len(arduino_data) - 2])

    decoded_values = str(arduino_data[0:len(arduino_data)].decode("utf-8"))
    # print(decoded_values)

    if ("FUCK" in decoded_values):
        print("Stop! You Violated the Law")
        playsound('stop.wav')
        # playsound('fart.wav')

    # # list_values = decoded_values.split('x')

    # # for item in list_values:
    # #     list_in_floats.append(float(item))

    # # print(f'Collected readings from Arduino: {list_in_floats}')

    # arduino_data = 0
    # # list_in_floats.clear()
    # # list_values.clear()
    # arduino.close()





# # ----------------------------------------Main Code------------------------------------
# # Declare variables to be used
list_values = []
list_in_floats = []

print('Program started')

# # Setting up the Arduino
# schedule.every(1).seconds.do(main_func)

while True:
    # schedule.run_pending()
    # time.sleep(1)
    main_func()