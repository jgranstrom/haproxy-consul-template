FROM ubuntu:14.04
MAINTAINER John Granström <granstrom.john@gmail.com>

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:vbernat/haproxy-1.6
RUN apt-get update && apt-get install -y haproxy && apt-get install -y unzip
ADD https://releases.hashicorp.com/consul-template/0.13.0/consul-template_0.13.0_linux_amd64.zip /
RUN unzip /consul-template_0.13.0_linux_amd64.zip -d /usr/bin && rm /consul-template_0.13.0_linux_amd64.zip
RUN sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy
COPY "./init.sh" "/root/init.sh"
RUN chmod +x /root/init.sh

VOLUME ["/haproxy-cfg/haproxy.ctmpl"]

EXPOSE 80/tcp 443/tcp

ENTRYPOINT ["/root/init.sh"]
CMD ["-consul", "consul.service.consul:8500", "-template", "/haproxy-cfg/haproxy.ctmpl:/etc/haproxy/haproxy.cfg:service haproxy reload"]