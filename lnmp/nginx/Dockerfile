FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY ./module /usr/local
RUN cd /etc/nginx \
    #&& ./configure --add-module=/usr/local/fastdfs-nginx-module/src/ \
#
EXPOSE 80