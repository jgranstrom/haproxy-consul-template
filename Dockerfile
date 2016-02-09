FROM ubuntu:14.04

RUN apt-get update && apt-get install -y haproxy && apt-get install -y unzip
ADD https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip /
RUN unzip /consul-template_0.12.2_linux_amd64.zip -d /usr/bin && rm /consul-template_0.12.2_linux_amd64.zip
RUN sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy
COPY "./init.sh" "/root/init.sh"
RUN chmod +x /root/init.sh

EXPOSE 80/tcp
ENTRYPOINT ["/root/init.sh"]
CMD ["-consul", "consul.service.consul:8500", "-template", "/haproxy-cfg/haproxy.ctmpl:/etc/haproxy/haproxy.cfg:service haproxy restart"]