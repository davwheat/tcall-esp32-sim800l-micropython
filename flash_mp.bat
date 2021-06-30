@echo off

echo We're displaying some ports we think your T-Call might be plugged into below:
echo.
wmic path Win32_SerialPort Where "Caption LIKE '%%UART%%'" Get DeviceID
echo.

set /p "comPort=What COM port is the T-Call ESP32 on? (e.g. COM4) "

echo.
echo This script will completely wipe your ESP32 flash. Now is your last chance to back away!
echo.
pause

cd _micropython

esptool --chip esp32 --port %comPort% --baud 115200 erase_flash
esptool --chip esp32 --port %comPort% --baud 460800 write_flash -z 0x1000 esp32spiram-20210418-v1.15.bin

cd ..

pause
