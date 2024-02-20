#!/usr/bin/env bash

set -e

RUNNER_OS="${RUNNER_OS:-$OSTYPE}"
RUNNER_OS="$(echo "$RUNNER_OS" | tr '[:upper:]' '[:lower:]')"

TARGET_OS="linux"
case "$RUNNER_OS" in
linux*)
  TARGET_OS="linux"
  ;;
macos*)
  TARGET_OS="darwin"
  ;;
*)
  echo "Unsupported OS: $RUNNER_OS"
  exit 1
  ;;
esac

RUNNER_ARCH="${RUNNER_ARCH:-$(uname -m)}"
RUNNER_ARCH="$(echo "$RUNNER_ARCH" | tr '[:upper:]' '[:lower:]')"
TARGET_ARCH="amd64"
case "$RUNNER_ARCH" in
x86_64 | amd64 | x64)
  TARGET_ARCH="amd64"
  ;;
aarch64 | arm64)
  TARGET_ARCH="arm64"
  ;;
*)
  echo "Unsupported architecture: $RUNNER_ARCH"
  exit 1
  ;;
esac

VERSION="${VERSION:-latest}"
DOWNLOAD_URL="https://github.com/vietanhduong/auto-approve/releases/download/v${VERSION#v}/auto-approve_${VERSION#v}_${TARGET_OS}_${TARGET_ARCH}.tar.gz"
if [[ "$VERSION" == "latest" ]]; then
  DOWNLOAD_URL="$(curl -sSL "https://api.github.com/repos/vietanhduong/auto-approve/releases/latest" | grep "browser_download_url.*${TARGET_OS}_${TARGET_ARCH}.tar.gz" | cut -d : -f 2,3 | tr -d \")"
fi

echo "::debug::Download auto-approve URL: $DOWNLOAD_URL"

curl -sSL $DOWNLOAD_URL | tar -xz -C /tmp auto-approve && sudo mv /tmp/auto-approve /usr/local/bin/auto-approve
