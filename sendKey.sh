#!/bin/sh
echo "adb tcpip 5555"

if (adb devices | grep :) then
        echo already connected
else
        echo disconnected... trying new connection
        adb tcpip 5555
        adb connect $1:5555
        sleep 1
        echo reconnected
fi
adb shell input keyevent $2
