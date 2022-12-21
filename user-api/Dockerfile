FROM ubuntu:20.04
RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y curl && \
    apt-get autoclean -y && \
    apt-get autoremove -y
RUN mkdir /app && chmod -R 777 /app
ENV DATABASE /app/dados.sdb
#ENV PORT 9000
ADD ./bin/userapi /app/userapi
COPY ./bin/dados.sdb /app/dados.sdb
#EXPOSE ${PORT}
ENTRYPOINT /app/userapi