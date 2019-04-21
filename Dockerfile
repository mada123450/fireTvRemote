FROM golang:1.8
RUN ["mkdir", "/material-design-icons"]
COPY material-design-icons/ /material-design-icons

RUN go get github.com/robbiet480/nfa

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get clean && apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:123' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

WORKDIR "/"
RUN "ls"
RUN ["cp", "-R", "go", "root"]
CMD ["/usr/sbin/sshd", "-D"]
