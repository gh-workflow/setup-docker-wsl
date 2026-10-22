Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Install Skrog's Docker CLI bundle without changing the runner's machine-wide PATH.
skrog cli install --no-path

# Read Skrog's generated locations instead of assuming a runner-specific user profile path.
$cliStatus = skrog cli status --json
$cliBinDir = ($cliStatus | ConvertFrom-Json).binDir
if (-not $cliBinDir -or -not (Test-Path -LiteralPath $cliBinDir)) {
  throw "Skrog Docker CLI bin directory was not found: $cliBinDir"
}

$dockerConfig = Join-Path $env:USERPROFILE ".docker"
if (-not (Test-Path -LiteralPath $dockerConfig)) {
  throw "Skrog Docker config directory was not found: $dockerConfig"
}

# These files affect later composite-action and workflow steps. GITHUB_PATH is prepended by the runner.
Add-Content -Path $env:GITHUB_PATH -Value $cliBinDir
Add-Content -Path $env:GITHUB_ENV -Value "DOCKER_CONFIG=$dockerConfig"
