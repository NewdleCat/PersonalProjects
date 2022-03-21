# import simpleaudio as sa

# filename = 'audio.wav'
# wave_obj = sa.WaveObject.from_wave_file(filename)
# play_obj = wave_obj.play()
# play_obj.wait_done()  # Wait until sound has finished playing


from playsound import playsound

for i in range(0,2):
	playsound('audio.wav')

# import pygame
# pygame.mixer.init()
# pygame.mixer.music.load("audio.wav")
# pygame.mixer.music.play()
# while pygame.mixer.music.get_busy() == True:
#     continue