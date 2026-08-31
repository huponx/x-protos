# x-protos

gRPC contracts (`.proto` only). Generated stubs live in `x-protogen`

```
ping/v1/ping.proto
```

Add a new API by adding `bill/v1/bill.proto` here — do not create a new repo.

## Versioning

Tag semver (`v0.2.0`) on `main`. The [notify-protogen](.github/workflows/notify-protogen.yml) workflow sends `repository_dispatch` to `x-protogen` with `proto_ref` and `proto_repo` (`github.repository` of this repo).

Secret: `PROTOGEN_DISPATCH_TOKEN` (PAT or GitHub App with `code: write` and `actions: write` on `protogen`).  
Optional variable: `PROTOGEN_REPO` (default `huponx/x-protogen`).

Job outputs and summary: `proto_ref`, `proto_repo`, `target_repo`, `dispatched`.

## Local

Generate with [`buf.gen.yaml`](buf.gen.yaml) and [`scripts/generate.sh`](scripts/generate.sh). Output is written into `protogen` (`out: go` → `protogen/go`).

```bash
make generate
# or: PROTO_DIR=proto PROTOGEN_DIR=protogen bash proto/scripts/generate.sh
```

To add a language: enable a plugin in `buf.gen.yaml`. The `protogen` workflow only needs extra tool setup and `git add` if required.
