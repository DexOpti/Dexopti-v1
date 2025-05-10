#DexOpti v1
**DexOpti** is a lightweight Windows optimization tool built with PowerShell and a graphical interface using Windows Forms.

## Features

- Disable transparency effects
- Disable window animations
- Set Windows for best performance
- Disable unnecessary services like Windows Search and SysMain (Superfetch)
- Simple graphical user interface
- Runs directly from the internet via PowerShell

## Screenshot

![DexOpti UI](logo.jpg)

## How to Use

To run DexOpti directly from GitHub using PowerShell:

```powershell
iwr -useb "https://raw.githubusercontent.com/DexOpti/Dexopti-v1/main/DexOpti_v1_GUI.ps1" | iex
