# Docker image for HAProxy consul-template setup

Get an automated HAProxy configuration using consul service discovery.

In difference to other images it includes an init script for making sure HAProxy is always started on container restart.

## Usage
```
docker run -p 8080:80 -v '/srv/haproxy/haproxy.ctmpl:/haproxy-cfg/haproxy.ctmpl' jgranstrom/haproxy-consul-template
```
