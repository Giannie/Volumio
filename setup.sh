#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we
                                               # need to resolve it relative to the path
                                               # where the symlink file was located
done
dir="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

sudo apt-get update && sudo apt-get install lirc lirc-x

[ "$( grep lirc /boot/config.txt )" ] || echo "dtoverlay=lirc-rpi" | sudo tee -a /boot/config.txt

[ "$( grep lirc_dev /etc/modules )" ] || echo  "lirc_dev" | sudo tee -a /etc/modules

[ "$( grep lirc_rpi /etc/modules )" ] || echo "lirc_rpi" | sudo tee -a /etc/modules

[ "$( grep lirc_rpi /etc/modprobe.d/etc-modules-parameters.conf )" ] || echo options lirc_rpi gpio_in_pin=18 gpio_out_pin=17 | sudo tee -a /etc/modprobe.d/etc-modules-parameters.conf

cd /tmp
wget http://heyu.tanj.com/download/heyu-2.10.tar.gz
tar xzvf heyu-2.10.tar.gz
cd heyu-2.10
./Configure
make
sudo make install

cd $dir
sudo cp lirc/* /etc/lirc

sudo cp heyu/* /etc/heyu

sudo cp playlists/* /var/lib/mpd/playlists/

sudo chown mpd:audio /var/lib/mpd/playlists/*