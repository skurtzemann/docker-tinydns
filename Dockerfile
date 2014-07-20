FROM ubuntu:14.04

## Install djbdns
RUN apt-get update && \
	apt-get install daemontools daemontools-run ucspi-tcp djbdns -y

## Configure tinydns
# users
RUN useradd -s /bin/false tinydns && \
	useradd -s /bin/false axfrdns && \
	useradd -s /bin/false dnslog
# config dir
RUN tinydns-conf tinydns dnslog /etc/tinydns 0.0.0.0 && \
	ln -s /etc/tinydns /etc/service/tinydns
# symlink tinydns data file to /data/tinydns.data (volume mountpoint)
RUN rm /etc/tinydns/root/data && \
	ln -s /data/tinydns.data /etc/tinydns/root/data

## Container addons scripts
ADD ./rebuild_tinydns-data.sh /rebuild_tinydns-data.sh
ADD ./init.sh /init.sh
RUN chmod u+x /rebuild_tinydns-data.sh && \
	chmod u+x /init.sh

## Docker config
EXPOSE 53/udp 
CMD ["/init.sh"]