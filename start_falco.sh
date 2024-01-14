#!/bin/bash
# echo "" > /etc/falco/log/new_log.jsonl
docker run --rm -i -t \
    -e HOST_ROOT=/ \
    --cap-add SYS_PTRACE --pid=host $(ls /dev/falco* | xargs -I {} echo --device {}) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /etc/falco/falco_rules.yaml:/etc/falco/falco_rules.yaml \
    -v /etc/falco/falco.yaml:/etc/falco/falco.yaml \
    -v /etc/falco/log:/var/log/falco \
    --security-opt apparmor:unconfined \
    falcosecurity/falco-no-driver:latest /usr/bin/falco -A