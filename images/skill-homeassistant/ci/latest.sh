#!/usr/bin/env bash
channel=$1
if [[ "${channel}" == "dev" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/mikejgray/neon-homeassistant-skill/commits  | jq --raw-output '.[0].sha')
    printf "%s" "${version}"
fi
if [[ "${channel}" == "stable" ]]; then
    version=$(curl -sX GET https://api.github.com/repos/mikejgray/neon-homeassistant-skill/tags  | jq --raw-output '.[0].name')
    version="${version#*V}"
    version="${version#*v}"
    version="${version#*release-}"
    printf "%s" "${version}"
fi
