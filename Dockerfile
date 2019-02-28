FROM alpine:3.9
RUN mkdir /updateEntitiesLog
RUN mkdir /etc/periodic/everymin
COPY ./updateEntities /etc/periodic/everymin
COPY ./ReadFile /updateEntitiesLog
#RUN apk add --update apk-cron && rm -rf /var/cache/apk/*
RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add --update coreutils && rm -rf /var/cache/apk/*
RUN apk add curl
RUN chmod a+x /etc/periodic/everymin/updateEntities
RUN sed -i '$ a *       *       *       *       *       run-parts /etc/periodic/everymin' /etc/crontabs/root
CMD ["crond","-f"]