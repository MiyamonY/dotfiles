[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f ~/.xprofile ] && source ~/.xprofile
[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ] && source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec stumpwm
