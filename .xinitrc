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

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Different customization for different os
. /etc/os-release
if [ $ID = 'alpine' ]; then
  # Set keyboard mapping
  setxkbmap -layout 'us,us,us' -variant 'dvorak,dvp,' -option 'compose:ralt,ctrl:swapcaps,grp:rctrl_rshift_toggle,terminate:ctrl_alt_bksp'
elif [ $ID = 'arch' ]; then
	#exec startlxde
	# Random wallpaper
	#qiv -zr ~/.config/wallpaper/* &

  # Set fallback keyboard mapping
  setxkbmap -layout 'us,us' -variant 'dvorak,dvp' -option 'compose:ralt,ctrl:swapcaps,grp:rctrl_rshift_toggle,terminate:ctrl_alt_bksp'

	# Autostart fcitx
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS="@im=fcitx"
	fcitx -r &

	# ssh-agent
	#eval $(ssh-agent | tee ~/.ssh/env)
fi

# Fix android studio for tiling WM
export _JAVA_AWT_WM_NONREPARENTING=1
#export _JAVA_OPTIONS=-Djava.io.tmpdir=/var/cache/android

# Trackpoint scroll
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5

# Auto lockscreen
xautolock -time 5 -locker "slock" &

# Set backlight
xbacklight -set 5 &

# DPMS
xset +dpms &
xset dpms 0 0 240 &

# Reduce typematic delay
xset r rate 150 40

# Mouse acceleration
xset m 2/1 4

# Disable bell
xset -b &

# Show mouse
xsetroot -cursor_name left_ptr &

# Disable trackpad
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Natural Scrolling Enabled' 1
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
xinput disable 'SynPS/2 Synaptics TouchPad'

# Set color spaces
#xiccd &
#dispwin -c /usr/share/color/icc/TPLCD.icm &

# Reset dmenu's cache
IFS=:
stest -flx $PATH | sort -u > $HOME/.cache/dmenu_run

# Add-on for tiling window managers
pcmanfm --daemon-mode &
redshift &
dwmstatus &
dunst &
#xsnow -nosanta -notrees &

# Use dwm as default
exec dwm 2>/tmp/dwm.log || clear
