#!/usr/bin/env sh
set -euo pipefail

# Fix discovery of audio devices after restarting Engine DJ.
wine cmd /c start REG DELETE 'HKLM\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture' /REG:64 /F

wine "C:\Program Files\Engine DJ\Engine DJ.exe"
