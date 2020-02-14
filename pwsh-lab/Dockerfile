FROM ubuntu:16.04

# Install Powershell
RUN apt-get update --fix-missing && apt-get install -y wget apt-transport-https ca-certificates
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y powershell nano
RUN rm /packages-microsoft-prod.deb

# Install SSH Server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:--PowerShellLabRootPassword--' | chpasswd

# Create Low Priv User
COPY add-users.sh /add-users.sh
RUN chmod +x /add-users.sh
RUN /add-users.sh
RUN rm /add-users.sh

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Configure Login Message
COPY motd.txt /etc/motd
RUN chmod -x /etc/update-motd.d/*

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]