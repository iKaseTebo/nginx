FROM ikasetebo/ubuntu:v0.01

WORKDIR /
COPY ./entrypoint/entrypoint.sh /
RUN apt-get update && apt-get install -y nginx \
    -y dos2unix \
    && dos2unix ./entrypoint.sh \
    && ln -sf /shared/stdout /var/log/nginx/access.log \
	&& ln -sf /shared/stderr /var/log/nginx/error.log

EXPOSE 80 443

VOLUME ["/shared/","/etc/nginx/","/usr/share/nginx/html]

ENTRYPOINT ["./entrypoint.sh"]