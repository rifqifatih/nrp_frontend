FROM hbpneurorobotics/nrp_frontend:dev

RUN /bin/bash -c "/bin/sed -e 's/localhost/"$external_frontend_ip"/' -i /home/bbpnrsoa/nrp/src/ExDFrontend/dist/config.json"
RUN /bin/bash -c "/bin/sed -e \"s=localhost="$external_nrp_ip"=\" -i /home/bbpnrsoa/nrp/src/nrpBackendProxy/config.json"
RUN /bin/bash -c "source /home/bbpnrsoa/nrp/src/user-scripts/nrp_variables"

USER root

CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 9000
