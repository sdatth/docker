# If a dns resolver is being used on the linux distro then do this

sudo systemctl status [ systemd-resolved | resolvconf ]
sudo systemctl stop service-name
sudo systemctl disable service-name
sudo rm -rf /etc/resolv.conf
sudo touch /etc/resolv.conf
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf > /dev/null
