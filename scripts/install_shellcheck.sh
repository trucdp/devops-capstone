#!/usr/bin/env bash

OS=$(uname | tr "[:upper:]" "[:lower:]")
VERSION="stable"
ARCH=$(uname -m)
COMMAND="shellcheck"
SHELLCHECK_FILE=https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-${VERSION}.${OS}.${ARCH}.tar.xz

test -e ./scripts/${COMMAND} ||
  {
    wget -qO- "${SHELLCHECK_FILE}" | tar xJC scripts
    mv ./scripts/${COMMAND}-${VERSION}/${COMMAND} ./scripts
    chmod +x ./scripts/${COMMAND}
    rm -r ./scripts/${COMMAND}-${VERSION}
  }

echo "./scripts/${COMMAND}: $(./scripts/${COMMAND} --version)"
