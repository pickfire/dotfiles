#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ]    && xrdb -merge $sysresources
[ -f $sysmodmap ]       && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ]    && xmodmap "$usermodmap"

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Start game
if [ "$2" = 'oxy' ]; then
  exec wine ~/usr/get/oxygen_not_included/OxygenNotIncluded.exe
fi

# Different customization for different os
. /etc/os-release
if [ $ID = 'alpine' ]; then
  # Set keyboard mapping
  #setxkbmap -layout 'us,us,us' -variant 'dvorak,dvp,' -option 'compose:ralt,ctrl:swapcaps,grp:rctrl_rshift_toggle,terminate:ctrl_alt_bksp'
  setxkbmap -layout us -variant dvorak -option caps:swapcaps,ctrl:swap_lalt_lctl,terminate:ctrl_alt_bksp

  # Swap control keys
  xmodmap ~/.Xmodmap
elif [ $ID = 'arch' ]; then
  # Random wallpaper
  #qiv -zr ~/.config/wallpaper/* &

  # Set fallback keyboard mapping
  #setxkbmap -layout 'us,us' -variant 'dvorak,dvp' -option 'compose:ralt,ctrl:swapcaps,grp:rctrl_rshift_toggle,terminate:ctrl_alt_bksp'

  # Autostart fcitx
  # fcitx -r &
  fcitx5 -r &

  # ssh-agent
  eval $(ssh-agent | tee ~/.ssh/env)
fi

if [ "$2" = 'lxde' ]; then
  exec startlxde
fi

# Fix java on tiling WM
export _JAVA_AWT_WM_NONREPARENTING=1

# Firefox pixel-perfect scrolling
export MOZ_USE_XINPUT2=1

# Trackpoint scroll
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5

# Auto lockscreen
#xautolock -time 5 -locker "slock" &

# Set backlight
xbacklight -set 5 &

# DPMS
#xset +dpms &
#xset dpms 0 0 240 &
xset s noblank
xset s off
xset -dpms

# Reduce typematic delay
xset r rate 150 60

# Mouse acceleration
xset m 2/1 4

# Lower volume bell
xset b 1 3 10000

# Disable bell
#xset -b

# Show mouse
#xsetroot -cursor_name left_ptr

# Disable trackpad
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Natural Scrolling Enabled' 1
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
xinput disable 'SynPS/2 Synaptics TouchPad'

# Set color spaces
#xiccd &
#dispwin -c /usr/share/color/icc/TPLCD.icm &

# Listen to new events
autorandr-launcher -d

# Reset dmenu's cache
IFS=:
stest -flx $PATH | sort -u > $HOME/.cache/dmenu_run

# Add-on for tiling window managers
#pcmanfm --daemon-mode &
redshift &
systembus-notify &  # earlyoom
dunst &
#xsnow -nosanta -notrees &

# Use dwm as default (restart if binary changes)
csum=$(sha1sum $(which dwm))
new_csum=""
while true
do
	if [ "$csum" != "$new_csum" ]
	then
		csum=$new_csum
		dwms &
		dwm 2>/tmp/dwm.log
	else
		exit 0
	fi
	new_csum=$(sha1sum $(which dwm))
	sleep 0.5
done
