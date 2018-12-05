
docker build -t qhsoft/geeps .


nvidia-docker run -d qhsoft/geeps /usr/sbin/sshd -D