# For more help, visit: https://protonvpn.com/support/official-linux-vpn-ubuntu/

# ========================= Installation ====================
# 1. Download
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb

# 2. Install Proton VPN repository
sudo dpkg -i ./protonvpn-stable-release_1.0.6_all.deb && sudo apt update

# Check the repo package
echo "e5e03976d0980bafdf07da2f71b14fbc883c091e72b16772199742c98473002f protonvpn-stable-release_1.0.6_all.deb" | sha256sum --check -

# 3. If you running an old version
sudo apt-get update && sudo apt-get upgrade

# If you don't have Proton
sudo apt-get install proton-vpn-gnome-desktop

# Update to ensure you have running the latest version
sudo apt-get update && sudo apt-get upgrade

# Linux system tray icon (optional)

sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator

# ============================== Remove =============================
# Remove the official app
sudo apt-get autoremove proton-vpn-gnome-desktop && sudo apt-get purge protonvpn-stable-release

# Uninstall
sudo apt-get autoremove protonvpn

# Remove repository
sudo rm -rf ~/.cache/protonvpn

sudo rm -rf ~/.config/protonvpn
