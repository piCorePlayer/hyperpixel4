#!/bin/sh

# start pigpiod daemon
pigpiod -t 1 -f -l -s 10

eventno=$( cat /proc/bus/input/devices | awk '/Goodix/{for(a=0;a>=0;a++){getline;{if(/mouse/==1){ print $NF;exit 0;}}}}')
if [ x"" != x"$eventno" ]; then
  export JIVE_NOCURSOR=1
  export TSLIB_TSDEVICE=/dev/input/$eventno
  export SDL_MOUSEDRV=TSLIB
  export SDL_MOUSEDEV=$TSLIB_TSDEVICE
fi

export LOG=/var/log/jivelite.log

if [ -f /usr/local/sbin/config.cfg ]; then
    source /usr/local/sbin/config.cfg
fi

if [ ! -z ${JL_FRAME_BUFFER} ]; then
    export SDL_FBDEV=$JL_FRAME_BUFFER
    echo "Using $SDL_FBDEV as frame buffer device." >> $LOG
fi

if [ -z ${JL_FRAME_RATE} ]; then
    JL_FRAME_RATE=22
fi

export JIVE_FRAMERATE=$JL_FRAME_RATE

echo "Frame rate set to $JIVE_FRAMERATE frames per second." >> $LOG

if [ -z ${JL_FRAME_DEPTH} ]; then
    JL_FRAME_DEPTH=32
fi

/usr/sbin/fbset -depth $JL_FRAME_DEPTH >> $LOG
 
echo "Frame buffer color bit depth set to $JL_FRAME_DEPTH." >> $LOG

if [ ! -z ${SDL_TOUCHSCREEN} ]; then
    export JIVE_NOCURSOR=1
fi

export HOME=/home/tc

while true; do
    sleep 3
    /opt/jivelite/bin/jivelite >> $LOG 2>&1
done
