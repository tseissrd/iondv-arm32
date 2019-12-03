FROM arm32v7/debian
RUN mkdir /var/log/mongodb && mkdir /var/lib/mongodb
COPY ./mongod.conf /etc
COPY ./mongod.service /lib/systemd/system
COPY ./bin/mongo /usr/bin
COPY ./bin/mongod /usr/bin
VOLUME ["/data/db"]
WORKDIR /data
CMD mongod --config /etc/mongod.conf
EXPOSE 27017
EXPOSE 28017
