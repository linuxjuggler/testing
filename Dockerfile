FROM zaherg/php-swoole:7.2

ARG BUILD_DATE \
	VCS_REF \
	IMAGE_NAME \
	DOCKER_REPO

LABEL Maintainer="Zaher Ghaibeh <z@zah.me>" \
      Description="Lightweight PHP 7.2 container based on Alpine Linux with Swoole installed and enabled by default." \
      org.label-schema.name=$IMAGE_NAME \
      org.label-schema.description="Lightweight PHP 7.2 container based on Alpine Linux with Swoole installed and enabled by default." \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/linuxjuggler/testing.git" \
      org.label-schema.build-repo=$DOCKER_REPO \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

ENV APP_NAME ${APP_NAME:-laravel} \
	APP_ENV ${APP_ENV:-production} \
	APP_KEY ${APP_KEY} \
	APP_DEBUG ${APP_DEBUG:-false} \
	APP_URL ${APP_URL:-"http://localhost"} \
	LOG_CHANNEL ${LOG_CHANNEL:-stack} \
	APP_TIMEZONE ${APP_TIMEZONE:-UTC} \
	DB_CONNECTION ${DB_CONNECTION:-mysql} \
	DB_HOST ${DB_HOST:-database} \
	DB_PORT ${DB_PORT:-3306} \
	DB_DATABASE ${DB_DATABASE:-docker} \
	DB_USERNAME ${DB_USERNAME:-docker} \
	DB_PASSWORD ${DB_PASSWORD:-secret} \
	DB_COLLATION ${DB_COLLATION:-utf8mb4_unicode_ci} \
	DB_CHARSET ${DB_CHARSET:-utf8mb4} \
	BROADCAST_DRIVER ${BROADCAST_DRIVER:-log} \
	CACHE_DRIVER ${CACHE_DRIVER:-file} \
	QUEUE_CONNECTION ${QUEUE_CONNECTION:-sync} \
	SESSION_DRIVER ${SESSION_DRIVER:-file} \
	SESSION_LIFETIME ${SESSION_LIFETIME:-120} \
	REDIS_HOST ${REDIS_HOST:-"127.0.0.1"} \
	REDIS_PORT ${REDIS_PORT:-6379} \
	REDIS_PASSWORD ${REDIS_PASSWORD:-null} \
	MAIL_DRIVER ${MAIL_DRIVER:-smtp} \
	MAIL_HOST ${MAIL_DRIVER:-smtp.mailtrap.io} \
	MAIL_PORT ${MAIL_PORT:-2525} \
	MAIL_USERNAME ${MAIL_USERNAME:-null} \
	MAIL_PASSWORD ${MAIL_PASSWORD:-null} \
	MAIL_ENCRYPTION ${MAIL_ENCRYPTION:-null} \
	PUSHER_APP_ID ${PUSHER_APP_ID} \
	PUSHER_APP_KEY ${PUSHER_APP_KEY} \
	PUSHER_APP_SECRET ${PUSHER_APP_SECRET} \
	PUSHER_APP_CLUSTER ${PUSHER_APP_CLUSTER} \
	MIX_PUSHER_APP_KEY ${PUSHER_APP_KEY:-""} \
	MIX_PUSHER_APP_CLUSTER ${PUSHER_APP_CLUSTER:-""} \
	SWOOLE_HTTP_PORT ${SWOOLE_HTTP_PORT:-80} \
	SWOOLE_HTTP_HOST ${SWOOLE_HTTP_HOST:-"0.0.0.0"}


USER root

ADD ./src /var/www
ADD ./bin /var/test

WORKDIR /var/www

RUN composer global require hirak/prestissimo && \
	composer install --no-progress --no-suggest --prefer-dist --optimize-autoloader


CMD ["php", "artisan","swoole:http","start"]
