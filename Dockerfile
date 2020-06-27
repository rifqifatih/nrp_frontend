FROM hbpneurorobotics/nrp_frontend:dev

COPY docker-entrypoint.sh /usr/local/bin/
COPY nrpBackendProxy/package.json /home/bbpnrsoa/nrp/src/nrpBackendProxy/
WORKDIR /home/bbpnrsoa/nrp/src/nrpBackendProxy
RUN npm install
COPY nrpBackendProxy/proxy/KubernetesDiscoveryService.ts /home/bbpnrsoa/nrp/src/nrpBackendProxy/proxy/
COPY nrpBackendProxy/proxy/requestHandler.ts /home/bbpnrsoa/nrp/src/nrpBackendProxy/proxy/

CMD ["docker-entrypoint.sh"]

EXPOSE 9000
