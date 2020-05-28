FROM hbpneurorobotics/nrp_frontend:dev

COPY docker-entrypoint.sh /usr/local/bin/
COPY proxy.ini /etc/supervisord.d/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9000
