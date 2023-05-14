#!/usr/bin/env bash

OS=$(uname | tr "[:upper:]" "[:lower:]")
COMMAND="kubectl"

test -e ./scripts/${COMMAND} ||
    {
        curl -sSLo ./scripts/${COMMAND} "https://dl.k8s.io/release/$(curl -L -s \
            https://dl.k8s.io/release/stable.txt)/scripts/${OS}/amd64/kubectl"
        chmod +x ./scripts/${COMMAND}
    }

echo "./scripts/${COMMAND}: $(./scripts/${COMMAND} version --client)"
