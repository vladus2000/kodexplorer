FROM vladus2000/alpine-base-php-user
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /

ENV STARTUP_CMD="/runuserorroot.sh php -S 0000:80 -t /var/www/html"

RUN \
        /update.sh && \
        apk add --no-cache wget bash && \
	wget -O /tmp/master.zip https://github.com/kalcaddle/KODExplorer/archive/master.zip && \
	cd /usr/src && \
	mkdir kodexplorer kodexplorer_data && \
	cd kodexplorer && \
	unzip -o /tmp/master.zip && \
	mv KodExplorer-master/* . && \
	mv data ../kodexplorer_data/. && \
	rm -rf KodExplorer-master && \
	rm -f /tmp/master.zip && \
	chmod +x /*.sh && \
	set -x && \
	apk add --no-cache --update freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
	docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd && \
	apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/html

EXPOSE 80/tcp

CMD /bin/ash -c /startup.sh

