#!/usr/bin/env bash
channel=$1
repo="OpenVoiceOS/ovos-stt-plugin-whispercpp"
if [[ "${channel}" == "stable" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/$repo/releases  | jq --raw-output '.[0].tag_name')
    version="${version#*V}"
    version="${version#*v}"
    version="${version#*release-}"
    printf "%s" "${version}"
fi
if [[ "${channel}" == "dev" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/$repo/commits  | jq --raw-output '.[0].sha')
    printf "%s" "${version}"
fi
