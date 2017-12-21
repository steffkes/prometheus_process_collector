FROM rabbitmq:3.7.0

ENV REVISION=v1.3.1

RUN apt-get update && \
    apt-get install -y git make gcc erlang-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/deadtrickster/prometheus_process_collector.git /tmp/prometheus_process_collector && \
    cd /tmp/prometheus_process_collector && \
    git checkout ${REVISION}

WORKDIR /tmp/prometheus_process_collector

RUN ./elvis rock && \
    ./rebar3 compile

ENTRYPOINT /bin/bash