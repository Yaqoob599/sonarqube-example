FROM ubuntu:latest


RUN apt-get update && apt-get install -y \
    git \
    openjdk-11-jdk \
    maven


WORKDIR /app


RUN git clone https://github.com/guruvenkatakrishna/java-example.git .

RUN mvn clean package


CMD ["bin/bash"]

