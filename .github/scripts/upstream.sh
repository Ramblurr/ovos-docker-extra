#!/usr/bin/env bash

APP="${1}"
CHANNEL="${2}"

if test -f "./images/${APP}/ci/latest.sh"; then
    bash ./images/"${APP}"/ci/latest.sh "${CHANNEL}"
fi
