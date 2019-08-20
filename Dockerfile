FROM rastasheep/ubuntu-sshd:18.04

COPY sendKey.sh/ sendKey.sh
RUN chmod 755 sendKey.sh
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get update
RUN apt-get clean && apt-get update && apt-get install -y android-tools-adb

WORKDIR "/"
CMD ["/usr/sbin/sshd", "-D"]
