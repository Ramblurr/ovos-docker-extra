#!/usr/bin/env bash
channel=$1
if [[ "${channel}" == "stable" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/OpenVoiceOS/ovos-ocp-audio-plugin/releases  | jq --raw-output '.[0].tag_name')
    version="${version#*V}"
    version="${version#*v}"
    printf "%s" "${version}"
fi

if [[ "${channel}" == "dev" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/OpenVoiceOS/ovos-ocp-audio-plugin/commits  | jq --raw-output '.[0].sha')
    printf "%s" "${version}"
fi
