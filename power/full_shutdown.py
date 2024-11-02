import os
import tkinter as tk
from tkinter import messagebox

def prompt_shutdown():
    root = tk.Tk()
    root.withdraw()
    response = messagebox.askyesno("Full-Shutdown Confirmation", "Do you want to shutdown Windows?")
    root.destroy()
    return response

def shutdown_windows():
    print("Shutting down Windows...")
    os.system("shutdown /s /t 0")

def main():
    response = prompt_shutdown()

    if response:
        shutdown_windows()
    else:
        print("shutdown aborted.")

if __name__ == "__main__":
    main()