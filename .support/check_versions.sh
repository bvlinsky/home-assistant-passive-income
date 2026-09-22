#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")/.." && pwd)"

ADDONS=(
  "bitping bitping/bitpingd"
  "earnapp madereddy/earnapp"
  "earnfm earnfm/earnfm-client"
  "grass mrcolorrain/grass-node"
  "honeygain honeygain/honeygain"
  "packetstream packetstream/psclient"
  "pawns iproyal/pawns-cli"
  "proxyrack proxyrack/pop"
  "repocket repocket/repocket"
  "traffmonetizer traffmonetizer/cli_v2"
)

printf "%-15s %-15s %-15s %s\n" "ADDON" "LOCAL" "REMOTE" "STATUS"

for item in "${ADDONS[@]}"; do
  set -- $item
  addon=$1
  img=$2

  cfg="$DIR/$addon/config.yaml"
  [ ! -f "$cfg" ] && cfg="$DIR/$addon/config.yml"
  local_ver=$(grep -E '^version:' "$cfg" | awk '{print $2}' | tr -d "\"\'")

  json=$(curl -s "https://hub.docker.com/v2/repositories/$img/tags?page_size=25")
  remote_ver=$(echo "$json" | jq -r '.results[].name' 2>/dev/null | grep -E '^(v?[0-9])' | grep -vE 'test|cache|staging' | sort -V | tail -n 1)
  [ -z "$remote_ver" ] && remote_ver=$(echo "$json" | jq -r '(.results[] | select(.name == "latest") | .last_updated[:10] | gsub("-"; ".")) // "unknown"' 2>/dev/null)

  status="OK"
  [ "$local_ver" != "$remote_ver" ] && status="UPDATE"

  printf "%-15s %-15s %-15s %s\n" "$addon" "$local_ver" "$remote_ver" "$status"
done
