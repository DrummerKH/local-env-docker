FROM nginx:1.10

MAINTAINER Mahmoud Zalt <mahmoud@zalt.me>

ADD nginx.conf /etc/nginx/
COPY dhparams.pem /etc/ssl/private/

RUN rm /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

CMD ["nginx"]
