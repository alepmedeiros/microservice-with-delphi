FROM ubuntu:20.04
RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y curl && \
    apt-get autoclean -y && \
    apt-get autoremove -y
RUN mkdir /app && chmod -R 777 /app
ENV DATABASE /app/dados.sdb
ADD ./bin/pedidosapi /app/pedidosapi
COPY ./bin/dados.sdb /app/dados.sdb
ENTRYPOINT /app/pedidosapi