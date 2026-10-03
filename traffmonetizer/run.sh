#!/bin/sh
set -eu

options_file=/data/options.json
token="$(jq -r '.token // empty' "$options_file")"
device_name="$(jq -r '.device_name // "HomeAssistant"' "$options_file")"

if [ -z "$token" ]; then
  echo 'Traffmonetizer: configure your token before starting' >&2
  exit 1
fi

if [ -z "$device_name" ]; then
  device_name=HomeAssistant
fi

exec /usr/local/bin/cli start accept --token "$token" --device-name "$device_name"
