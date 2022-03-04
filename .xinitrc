#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

while true
do
    # Set root title
    sh .xsetroot.sh

    # Check battery level
    BATT=$( acpi -b | sed 's/.*[charging|unknown], ([0-9]*)%.*/1/gi' )
    STATUS=$( acpi -b | sed 's/.*: ([a-zA-Z]*),.*/1/gi' )
    if ([ $BATT -le 5 ] && [ $STATUS == 'Discharging' ]); then
        # Beep
        echo -e "07" >/dev/tty10 && sleep 0.2
        echo -e "07" >/dev/tty10 && sleep 0.2
        echo -e "07" >/dev/tty10 && sleep 0.2
        # Blink
        echo 'on' > /proc/acpi/ibm/light && sleep 1
        echo 'off' > /proc/acpi/ibm/light
    fi

    sleep 1s
done &

setxkbmap br &
xrdb ~/.Xresources
xrandr --output HDMI-1 --mode 1920x1080 &
nitrogen --restore &


exec dwm

