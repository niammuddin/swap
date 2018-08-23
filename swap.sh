#!/bin/bash
if [ "$*" == "" ]; then
    echo
    echo "Usage:"
    echo
    echo "$0 <swap size>"
    echo
    echo "$0 2G"
    echo "to create a 2GB swap file"
    echo
    echo
    exit 1
fi

TAMANHO=$1;

fallocate -l $TAMANHO /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
sysctl -p

echo "Swap file created and enabled."