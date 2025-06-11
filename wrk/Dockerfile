FROM alpine:latest

RUN apk --no-cache add build-base openssl-dev git perl linux-headers  \
    && git clone https://github.com/wg/wrk.git --depth=1 /wrk \
    && cd /wrk && make
RUN cp /wrk/wrk /usr/local/bin/wrk
COPY scripts /wrk/scripts
WORKDIR /wrk
ENTRYPOINT ["./wrk"]