[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f ~/.xprofile ] && source ~/.xprofile

exec stumpwm
