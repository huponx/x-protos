#!/usr/bin/env bash
set -euo pipefail

proto_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "${proto_dir}"

buf lint
buf build

if [ -n "${BUF_BREAKING_AGAINST:-}" ]; then
  buf breaking --against "${BUF_BREAKING_AGAINST}"
fi
