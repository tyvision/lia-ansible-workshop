# SCRIPT for the 
# REQUIRES: root privileges
#
echo "================================"
echo "Welcome to the deployment script"
echo "================================"
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

# TODO: install git and docker engine
echo "Installing git curl"
echo "================================"
apt-get update
apt-get -y install git curl

echo "============================="
echo "installing docker"
echo "============================="
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh && rm get-docker.sh

# change to root
echo "============================="
echo "downloading docker-compose..."
echo "============================="
curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# option for speeding up the docker
echo "================================"
echo "adding overlay as kernel module"
echo "================================"
modprobe overlay
echo """
{
  \"storage-driver\": \"overlay2\"
}
""" >> /etc/docker/daemon.sh

# apply changes
echo "================="
echo "restarting docker"
echo "================="
systemctl restart docker
