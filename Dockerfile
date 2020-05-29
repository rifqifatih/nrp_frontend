FROM hbpneurorobotics/nrp_frontend:dev

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]

EXPOSE 9000
