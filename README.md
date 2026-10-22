# Set up Docker in WSL

[![GitHub Marketplace](https://img.shields.io/badge/marketplace-setup--docker--wsl-blue?logo=github&labelColor=333&style=flat-square)](https://github.com/marketplace/actions/set-up-docker-wsl)
[![Release](https://img.shields.io/github/v/release/gh-workflow/setup-docker-wsl?style=flat-square)](https://github.com/gh-workflow/setup-docker-wsl/releases)
[![Immutable Releases](https://img.shields.io/badge/releases-immutable-blue?labelColor=333)](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/immutable-releases)
[![Tests](https://img.shields.io/github/actions/workflow/status/gh-workflow/setup-docker-wsl/.github/workflows/ci_live-test.yml?branch=main&label=test&style=flat-square)](https://github.com/gh-workflow/setup-docker-wsl/actions/workflows/ci_live-test.yml)

Set up a Linux Docker engine in WSL on a Windows GitHub Actions runner with [Skrog](https://github.com/wslkit/skrog).

Run `docker` in later workflow steps. The Docker engine runs in WSL

## Usage

Run the action before Docker commands:

```yaml
- name: Set up Docker in WSL
  uses: gh-workflow/setup-docker-wsl@v1

- name: Build image
  run: docker build --tag example .

- name: Run image
  run: docker run --rm example
```

## Inputs

<!-- markdownlint-disable MD013 -->
| Name                          | Required | Default  | Description                            |
|-------------------------------|----------|----------|----------------------------------------|
| `skrog-version`               | No       | `0.10.0` | Skrog release version to install.      |
| `verify-docker`               | No       | `true`   | Verify Docker.                         |
| `verify-docker-in-containers` | No       | `false`  | Verify Docker access from a container. |
<!-- markdownlint-enable MD013 -->
