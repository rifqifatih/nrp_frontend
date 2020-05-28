#!/bin/bash

# Get public IP
export NODE_IP=$(curl -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)

source /home/bbpnrsoa/nrp/src/user-scripts/nrp_variables
/bin/sed -e 's/localhost/'"$NODE_IP"'/' -i /home/bbpnrsoa/nrp/src/ExDFrontend/dist/config.json
/bin/sed -e 's/localhost/'"$NODE_IP"'/' -i /home/bbpnrsoa/nrp/src/nrpBackendProxy/config.json

sudo /usr/bin/supervisord -n