ARG BUILD_FROM
FROM ${BUILD_FROM} AS traffmonetizer

FROM alpine:3.22
RUN apk add --no-cache ca-certificates jq

COPY --from=traffmonetizer /usr/local/bin/cli /usr/local/bin/cli
COPY run.sh /usr/local/bin/run-traffmonetizer
RUN chmod 755 /usr/local/bin/run-traffmonetizer

ENTRYPOINT ["/usr/local/bin/run-traffmonetizer"]
