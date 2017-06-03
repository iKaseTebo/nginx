FROM ikasetebo/ubuntu-14.04:v0.01

WORKDIR /etc/nginx/sites-available/
COPY nginx-conf/sites-available/default default

WORKDIR /
COPY ./entrypoint/entrypoint.sh /
RUN apt-get install -y nginx \
    -y dos2unix \
    && dos2unix ./entrypoint.sh \
    && ln -sf /shared/stdout /var/log/nginx/access.log \
	&& ln -sf /shared/stderr /var/log/nginx/error.log

EXPOSE 80 443

VOLUME ["/shared/","/etc/nginx/","/usr/share/nginx/html]

ENTRYPOINT ["./entrypoint.sh"]