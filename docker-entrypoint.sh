#!/bin/bash

# Get public IP
export NODE_IP=$(curl -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)

source /home/bbpnrsoa/nrp/src/user-scripts/nrp_variables
sudo chown -R bbpnrsoa:bbp-ext /home/bbpnrsoa/nrp/src/Experiments && sudo chown -R bbpnrsoa:bbp-ext /home/bbpnrsoa/nrp/src/Models
# For kubernetes
/bin/sed -e 's/localhost:9000/'"$NODE_IP"':30000/' -i /home/bbpnrsoa/nrp/src/ExDFrontend/dist/config.json
/bin/sed -e 's/localhost/'"$NODE_IP"'/' -i /home/bbpnrsoa/nrp/src/nrpBackendProxy/config.json
/bin/sed -e 's/8080/30001/' -i /home/bbpnrsoa/nrp/src/nrpBackendProxy/config.json

# For local docker
# /bin/sed -e 's/localhost/host.docker.internal/' -i /home/bbpnrsoa/nrp/src/ExDFrontend/dist/config.json
# /bin/sed -e 's/localhost/host.docker.internal/' -i /home/bbpnrsoa/nrp/src/nrpBackendProxy/config.json

# Update environment variable for proxy supervisord config
sudo sed -i '/environment/c\environment=HBP=%(ENV_HBP)s,NODE_IP=%(ENV_NODE_IP)s' /etc/supervisord.d/proxy.ini

sudo ROS_IP=$(hostname -I | cut -d " " -f 1) HBP=/home/bbpnrsoa/nrp/src NODE_IP=$NODE_IP /usr/bin/supervisord -n