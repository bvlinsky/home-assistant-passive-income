FROM alpine:latest

RUN apk add --no-cache bash

COPY --from=iproyal/pawns-cli:0.36.2 /pawns-cli /pawns-cli

ENV email ""
ENV password ""
ENV deviceName "HomeAssistant"
ENV deviceId "homeassistant"

ENTRYPOINT ["/bin/sh", "-c", "/pawns-cli -accept-tos -email=$email -password=$password -device-name=$deviceName -device-id=$deviceId"]
