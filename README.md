# Set up Docker in WSL on Windows

[![GitHub Marketplace](https://img.shields.io/badge/marketplace-setup--docker--in --wsl--on--windows-blue?logo=github&labelColor=333&style=flat-square)](https://github.com/marketplace/actions/set-up-docker-in-wsl-on-windows)
[![Release](https://img.shields.io/github/v/release/gh-workflow/setup-docker-wsl?style=flat-square)](https://github.com/gh-workflow/setup-docker-wsl/releases)
[![Immutable Releases](https://img.shields.io/badge/releases-immutable-blue?labelColor=333)](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/immutable-releases)
[![Tests](https://img.shields.io/github/actions/workflow/status/gh-workflow/setup-docker-wsl/.github/workflows/ci_live-test.yml?branch=main&label=test&style=flat-square)](https://github.com/gh-workflow/setup-docker-wsl/actions/workflows/ci_live-test.yml)

Set up a Linux Docker engine in WSL on a Windows GitHub Actions runner with [Skrog](https://github.com/wslkit/skrog).

Run `docker` in later workflow steps. The Docker engine runs in WSL.

## Usage

Run the action before Docker commands:

```yaml
- name: Set up Docker in WSL on Windows
  uses: gh-workflow/setup-docker-wsl@v1

- name: Build image
  run: docker build --tag example .

- name: Run image
  run: docker run --rm example
```

## Inputs

<!-- markdownlint-disable MD013 -->
| Name                          | Required | Default                                                                                      | Description                                   |
|-------------------------------|----------|----------------------------------------------------------------------------------------------|-----------------------------------------------|
| `skrog-version`               | No       | `0.12.0`<!-- renovate: datasource=github-releases depName=wslkit/skrog versioning=semver --> | Skrog release version to install or "latest". |
| `enable-unix-socket`          | No       | `true`                                                                                       | Enable Unix socket `/var/run/docker.sock`.    |
| `verify-docker`               | No       | `true`                                                                                       | Verify Docker.                                |
| `verify-docker-in-containers` | No       | `false`                                                                                      | Verify Docker access from a container.        |
<!-- markdownlint-enable MD013 -->

On persistent self-hosted runners, set `enable-unix-socket: "false"` to preserve a running Docker Engine.

## Unix socket and Docker access from containers

For containers to use the host's Docker daemon, one would typically use the Unix socket `/var/run/docker.sock`.

Example:

```shell
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock docker:cli version
```

The default `enable-unix-socket` stops Docker Engine before Skrog starts so the
Unix socket mount above works.

For pipe and context details, see the [Skrog installation docs](https://wslkit.github.io/skrog/install/?utm_source=chatgpt.com#which-pipe-and-when-you-need-a-context)
and [CI runner docs](https://wslkit.github.io/skrog/ci-runners/?utm_source=chatgpt.com#point-a-runner-at-the-engine).
