FROM arm32v7/node:10
WORKDIR /var/www
EXPOSE 8888
ENV NODE_PATH /var/www
COPY . .
ENV WORKER_COUNT 2
CMD ["bash", "init.sh"]
