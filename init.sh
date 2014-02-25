#!/bin/bash
#
# AWS initial setup script
#

# change host to google dns and set hostname to mserve
sudo sed -i 's/127.0.0.1/8.8.8.8/g' /etc/resolv.conf
sudo sed -i 's/.*/mserve/g' /etc/hostname

# check to see that the hostname got updated
if grep '8.8.8.8' /etc/resolv.conf && grep 'mserve' /etc/hostname
then
  echo "Got google host"
	echo "Hostname is set to:" && hostname
else
  echo "error no host or no hostname..."
  exit 1
fi

# now update and upgrade system
if sudo apt-get update
then
	sudo apt-get upgrade -y
else
	echo "Error.. updating system"
fi

# install dns-server
if sudo tasksel install dns-server
then
  echo "DNS server installed"
else
  echo "DNS server install failed.."
  exit 1
fi

# change host to localhost dns
if sudo sed -i 's/8.8.8.8/127.0.0.1/g' /etc/resolv.conf
then
  cat /etc/resolv.conf
  dig yr.no
else
  echo "Error ..."
  exit 1
fi

# install zsh
sudo apt-get install zsh

# add user superuser
if sudo useradd superuser ; then
	echo "Added user superuser"
	if sudo useradd superuser sudo ; then
		echo "Superuser added to sudo group"
	else
		echo "Error adding superuser to sudo group"
		exit 1
	fi
else
	echo "Error adding user superuser"
	exit 1
fi

# install git
if sudo apt-get install git -y
then
  echo "Git intstalled"
	git clone https://github.com/kajohansen/my-zsh.git /home/superuser/.my-zsh
	echo "my-zsh installed"
	mv /home/superuser/my-zsh/zshrc /home/superuser/.zshrc
	echo "zshrc moved to superuser home folder ."
	sudo chsh -s /bin/zsh superuser
	echo "changed shell for user superuser to zsh"
else
	echo "Error installing git.."
	exit 1
fi

# done restart
sudo shutdown -r now
