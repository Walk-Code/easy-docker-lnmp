FROM php:7.3-fpm

# 添加源

# apt-get clean
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list && rm -rf /var/lib/apt/lists/*

RUN cat /etc/apt/sources.list && \
    rm -Rf /var/lib/apt/lists/* && \
    apt-get update && apt-get install -y cron && apt-get install -y vim git supervisor libpq-dev libmemcached-dev cmake
# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ ----filename=composer && \
    mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
    # 国内镜像加速
    composer self-update --1 && \
    composer config -g repo.packagist composer https://packagist.phpcomposer.com
    #composer global require hirak/prestissimo

#USER www-data
# 预先加载 Composer 包依赖，优化 Docker 构建镜像的速度
#RUN cd /var/www/gf-school-admin && composer install  --no-autoloader --no-scripts

# ampq
RUN apt-get install -y \
        librabbitmq-dev \
        libssh-dev \
    && docker-php-ext-install \
        bcmath \
        sockets \
    && pecl install amqp \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable amqp


# phpredis
COPY redis-4.2.0.tgz /home
RUN pecl install /home/redis-4.2.0.tgz && \
    docker-php-ext-enable redis && \
    rm /home/redis-4.2.0.tgz

# swoole
COPY swoole-4.5.2.tgz /home
RUN pecl install swoole-4.5.2.tgz && \
    docker-php-ext-enable swoole && \
    rm /home/swoole-4.5.2.tgz

# mongodb
COPY mongodb-1.5.3.tgz /home
RUN pecl install /home/mongodb-1.5.3.tgz && \
    docker-php-ext-enable mongodb && \
    rm /home/mongodb-1.5.3.tgz

# memcached
# COPY memcached-3.0.3.tgz /home
#RUN mkdir -p /home/memcached && tar -C /home/memcached -zxvf /home/memcached-3.0.3.tgz --strip 1 && \
#    docker-php-ext-configure memcached && \
#    docker-php-ext-install memcached && \
#    rm /home/memcached-3.0.3.tgz

# opcache
RUN docker-php-ext-install opcache
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Supervisord
COPY supervisord.conf /etc/supervisord.conf

# pdo_mysql # bcmath
#RUN set -eux; apt-get update; apt-get install -y libzip-dev zlib1g-dev; docker-php-ext-install mysqli pdo pdo_mysql bcmath zip
RUN apt-get install -y libzip-dev libmcrypt-dev libpng-dev curl openssl \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-configure gd \
  && docker-php-ext-install mysqli pdo pdo_mysql bcmath zip gd sockets pcntl 
# php配置文件
ADD php.ini    /usr/local/etc/php/php.ini

USER root

# 清理
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www
RUN chown -R www-data:www-data /var/www
#  添加时区环境变量，亚洲，上海
ENV TimeZone=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TimeZone /etc/localtime && echo $TimeZone > /etc/timezone

#ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
CMD ["php-fpm"]

EXPOSE 9000
