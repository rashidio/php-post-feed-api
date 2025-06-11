FROM alpine:latest

RUN apk --no-cache add build-base openssl-dev git \
    && git clone https://github.com/wg/wrk.git /wrk \
    && cd /wrk && make

WORKDIR /wrk
ENTRYPOINT ["./wrk"]