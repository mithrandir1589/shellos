FROM alpine:3.9
RUN mkdir /updateEntitiesLog
#RUN mkdir /etc/periodic/everymin
COPY ./updateEntities /etc/periodic/daily
COPY ./ReadFile /updateEntitiesLog
#RUN apk add --update apk-cron && rm -rf /var/cache/apk/*
RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add --update coreutils && rm -rf /var/cache/apk/*
RUN apk add curl
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/America/Bogota /etc/localtime
RUN apk del tzdata
RUN chmod a+x /etc/periodic/daily/updateEntities
RUN sed -i '5 s/.*/2      17      *       *       *       run-parts \/etc\/periodic\/daily/' /etc/crontabs/root
CMD ["crond","-f"]