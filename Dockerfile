FROM golang:1.4.0

MAINTAINER Luo Tao <lotreal@gmail.com>

RUN cd /opt && \
    git clone git://github.com/elasticsearch/logstash-forwarder.git && \
    cd logstash-forwarder && \
    git checkout ISSUE-221 && \
    go build

# RUN cd /opt && \
#     git clone git://github.com/elasticsearch/logstash-forwarder.git && \
#     cd logstash-forwarder && \
#     go build

ENTRYPOINT ["/opt/logstash-forwarder/logstash-forwarder", "-config", "/etc/logstash/forwarder.json"]
