FROM dimovnike/alpine-supervisord
MAINTAINER nikolay dimov <>

# add openssh and clean
RUN apk add --update openssh && rm  -rf /tmp/* /var/cache/apk/*
# assure new keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

ADD supervisord-sshd.conf /etc/supervisor/conf.d/
ADD run-sshd.sh /usr/local/bin/

EXPOSE 22
