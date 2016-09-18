#!/bin/bash
#
# This script is intended to install all necessary packages
#
# Note: It is also expected that you will have configured another user
# on the system with the appropriate groups and that you will run this
# script as that user using sudo
#
# Written and maintained by: Zach Brewer
# Adapted by: Tiago Silva 
#

script_name="install_packages"

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

EDITOR=vim 

# Must not be run as root
if [ $(whoami) == "root" ]; then
  echo "Error: This script must not be run as root"
  exit 1
fi



# All of the packages that need to be installed
CODECS="gst-libav gst-plugins-bad gst-plugins-good gst-plugins-ugly gstreamer0.10-ffmpeg mpg123 x264"

WM="xmonad xmonad-contrib  dmenu2 xdotool conky-cli dzen2-xft-xpm-xinerama-git"

AUDIO="alsa-utils alsa-plugins alsa-tools pulseaudio-alsa"

FONTS="otf-exo ttf-fantasque-sans"

BROWSERS="firefox firefox-i18n-pt-br"

APPLICATIONS="vim  mpv mpc mpd ncmpcpp nitrogen  redshift-minimal rxvt-unicode udevil udislie  telegram-desktop-bin thefuck rsync scrot  rtorrent-color xorg-xkill xorg-xprop downgrade dunst ffmpegthumbnailer gparted grc gvfs gvfs-mtp imagemagick lm_sensors maim mlocate most net-tools polkit-gnome slop sudo ufw ufw-extras xarchiver"

EXTRAS="neofetch i3lock-blur imdb-thumbnailer imgur.sh mkinitcpio-colors-git setcolors-git  ananicy-git thunar-extended thunar-thumbnailers-openraster thunar-volman-git thunar-archive-plugin thunar-media-tags-plugin xdiff-ext-git unp unrar unzip p7zip numlockx oblogout pastebinit powerline powerline-fonts zsh reflector curl wget w3m youtube-dl zsh-syntax-highlighting xdg-user-dirs compton ctags dkms"


# Functions to actually install things
function installPacaur() {
  cd $HOME
  gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53

  curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
  tar -xvf cower.tar.gz
  rm $HOME/cower.tar.gz
  cd $HOME/cower/
  makepkg -sri
  cd $HOME
  rm -rf $HOME/cower

  curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz
  tar -xvf pacaur.tar.gz
  rm $HOME/pacaur.tar.gz
  cd $HOME/pacaur/
  makepkg -sri
  cd $HOME
  rm -rf $HOME/pacaur
}

function installPackages() {
  pacaur -Syyu
  pacaur -S $CODECS
  pacaur -S $WM
  pacaur -S $AUDIO
  pacaur -S $FONTS
  pacaur -S $BROWSERS
  pacaur -S $APPLICATIONS
  pacaur -S $EXTRAS
}

function detectSensors() {
  (while :; do echo ""; done ) | sensors-detect
}



installPacaur
installPackages
detectSensors

echo ""
echo "All done!"
