import os
import tkinter as tk
from tkinter import messagebox

def prompt_restart():
    root = tk.Tk()
    root.withdraw()
    response = messagebox.askyesno("Restart Confirmation", "Do you want to restart Windows?")
    root.destroy()
    return response

def restart_windows():
    print("Restarting Windows...")
    os.system("shutdown /r /t 0")

def main():
    response = prompt_restart()

    if response:
        restart_windows()
    else:
        print("Restart aborted.")

if __name__ == "__main__":
    main()  