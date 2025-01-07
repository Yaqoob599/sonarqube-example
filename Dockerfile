FROM ubuntu:latest
RUN apt-get update && apt-get install bash -y \
    git \
    openjdk-11-jdk \
    maven
WORKDIR /app
RUN git clone https://github.com/guruvenkatakrishna/sonarqube-example.git .
RUN mvn clean package
CMD ["bash"]


