Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Confirm that Skrog, rather than another runner-installed Docker context, is active.
$dockerContext = docker context show
if ($dockerContext -ne "skrog") {
  throw "Expected Docker context 'skrog'."
}

# Verify the expected Linux daemon, bundled CLI plugins, registry access, and bind mounting.
$dockerOsType = docker info --format '{{.OSType}}'
if ($dockerOsType -ne "linux") {
  throw "Expected a Linux Docker engine."
}

docker buildx version

docker buildx imagetools inspect --raw ghcr.io/aicage-dev/aicage:codex-ubuntu | Out-Null

docker run --rm --mount "type=bind,src=$env:RUNNER_TEMP,dst=/host,readonly" alpine:3.22 test -d /host
