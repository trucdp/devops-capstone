#!/usr/bin/env bash

COMMAND="eksctl"

test -e ./scripts/${COMMAND} ||
    {
        curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ./scripts
        chmod +x ./scripts/${COMMAND}
    }

echo "./scripts/${COMMAND}: $(./scripts/${COMMAND} version)"
