#!/usr/bin/env bash
set -euo pipefail

proto_dir="${PROTO_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
proto_dir="$(cd "${proto_dir}" && pwd)"
if [ -n "${PROTOGEN_DIR:-}" ]; then
  out_dir="$(cd "${PROTOGEN_DIR}" && pwd)"
elif [ -d "$(dirname "$0")/../../protogen" ]; then
  out_dir="$(cd "$(dirname "$0")/../../protogen" && pwd)"
else
  out_dir="$(pwd)"
fi

# buf generate does not delete stubs for removed .proto files.
# Drop previous plugin output; keep go.mod / go.sum.
if [ -d "${out_dir}/go" ]; then
  find "${out_dir}/go" -name '*.pb.go' -delete
  find "${out_dir}/go" -type d -empty -mindepth 1 -delete
fi

cd "${out_dir}"
buf generate "${proto_dir}" --template "${proto_dir}/buf.gen.yaml"
