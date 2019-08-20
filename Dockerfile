FROM ubuntu:1.8

COPY sendKey.sh/ sendKey.sh
RUN chmod 755 sendKey.sh
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get clean && apt-get update && apt-get install -y openssh-server
RUN apt-get install android-tools-adb
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
CMD ["/usr/sbin/sshd", "-D"]
