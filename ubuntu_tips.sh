# Customize minimize dock
gsettings set org.gnome.shell.extentions.dash-to-dock click-action 'minimize'

# Enable FireWall

sudo systemctl status ufw # Check status

sudo systemctl enable ufw # Enable service

sudo apt-get install gufw # Install Firewall Config

sudo ufw status

sudo ufw allow 22/tcp

sudo ufw status

sudo ufw deny 22/tcp

sudo ufw status


# Speed up app launch with preload
sudo apt-get install preload
