ARG TAG=alpha
FROM docker.io/smartgic/ovos-sound-base:${TAG}

ARG BUILD_DATE=unknown
ARG VERSION=unknown
ARG CHANNEL=unknown

LABEL org.opencontainers.image.title="Open Voice OS OCI Fasterwhisper"
LABEL org.opencontainers.image.description=""
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.documentation="https://openvoiceos.github.io/community-docs"
LABEL org.opencontainers.image.source="https://github.com/OpenVoiceOS/ovos-docker"
LABEL org.opencontainers.image.vendor="Open Voice OS"

ARG USER=ovos

SHELL ["/bin/bash", "-c"]

USER root

ENV DEBIAN_FRONTEND noninteractive
COPY ./images/ovos-stt-plugin-fasterwhisper/files/requirements.txt /tmp/requirements.txt
RUN set -e; \
  apt-get update; \
  apt-get install -o Dpkg::Options::="--force-confold" -y git python3 python3-dev python3-pip curl build-essential swig portaudio19-dev libpulse-dev; \
  if [ "${CHANNEL}" == "dev" ]; then \
  pip3 install --no-cache -r /tmp/requirements.txt --pre; \
  else \
  pip3 install --no-cache -r /tmp/requirements.txt; \
  fi; \
  apt-get --purge remove -y portaudio19-dev build-essential python3-dev portaudio19-dev libpulse-dev libasound2-dev; \
  apt-get --purge autoremove -y; \
  rm -rf /root/cache /var/lib/apt/lists/* /var/log/{apt,dpkg.log} /tmp/requirements.txt

USER ${USER}

ENTRYPOINT ["ovos-stt-server", "--engine", "ovos-stt-plugin-fasterwhisper"]
