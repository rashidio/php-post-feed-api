FROM alpine:latest

RUN apk --no-cache add build-base openssl-dev git perl \
    && git clone https://github.com/wg/wrk.git --depth=1 /wrk \
    && cd /wrk && make

WORKDIR /wrk
ENTRYPOINT ["./wrk"]