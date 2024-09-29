import pygame
import os
from ctypes import cast, POINTER
from comtypes import CLSCTX_ALL
from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume

def init_audio():
    pygame.mixer.init()

def toggle_microphone_mute():
    # Get the microphone volume control
    devices = AudioUtilities.GetMicrophone()
    interface = devices.Activate(
        IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    mic_volume = cast(interface, POINTER(IAudioEndpointVolume))

    # Get the current mute state of the microphone
    current_mute_state = mic_volume.GetMute()

    # Toggle the microphone mute state
    mic_volume.SetMute(not current_mute_state, None)

    # Get the script directory
    script_dir = os.path.dirname(__file__)

    # Play audio cue based on mute state
    if not current_mute_state:  # Microphone was previously unmuted
        mute_sound = os.path.join(script_dir, "sound", "mute.mp3")
        pygame.mixer.music.load(mute_sound)
        pygame.mixer.music.play()
    else:  # Microphone was previously muted
        unmute_sound = os.path.join(script_dir, "sound", "unmute.mp3")
        pygame.mixer.music.load(unmute_sound)
        pygame.mixer.music.play()
    
    pygame.time.wait(1300)  # Adjust delay time as needed

if __name__ == "__main__":
    init_audio()
    toggle_microphone_mute()
