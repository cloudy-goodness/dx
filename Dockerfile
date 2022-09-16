# DOCKER-VERSION 1.2.0
# Allow override of image as environment variable
FROM docker.io/redhat/ubi8

RUN env

CMD ["sleep", "infinity"]
