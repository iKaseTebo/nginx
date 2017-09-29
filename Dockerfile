FROM ikasetebo/ubuntu-16.04:v0.01


WORKDIR /
COPY ./entrypoint/entrypoint.sh /
RUN apt-get update && apt-get install -y nginx \
    -y dos2unix \
    && dos2unix ./entrypoint.sh \
    && ln -sf /shared/stdout /var/log/nginx/access.log \
	&& ln -sf /shared/stderr /var/log/nginx/error.log

COPY ./nginx-conf/ssl /etc/nginx/ssl
COPY ./nginx-conf/conf/conf.d/ /etc/nginx/conf.d/
COPY ./nginx-conf/conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx-conf/sites-available/default /etc/nginx/sites-available/default

EXPOSE 80 443

VOLUME ["/shared/","/usr/share/nginx/html"]

ENTRYPOINT ["./entrypoint.sh"]