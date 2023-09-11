ARG TAG=alpha
FROM docker.io/smartgic/ovos-sound-base:${TAG}

ARG BUILD_DATE=unknown
ARG VERSION=unknown

LABEL org.opencontainers.image.title="Open Voice OS OCI HiveMind Voice Satellite"
LABEL org.opencontainers.image.description="OpenVoiceOS Satellite, connect to HiveMind"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.documentation="https://openvoiceos.github.io/community-docs"
LABEL org.opencontainers.image.source="https://github.com/OpenVoiceOS/ovos-docker"
LABEL org.opencontainers.image.vendor="Open Voice OS"

ARG ALPHA=false
ARG USER=ovos

SHELL ["/bin/bash", "-c"]

USER root

ENV DEBIAN_FRONTEND noninteractive

COPY ./images/hivemind-voice-sat/files/requirements.txt /tmp/requirements.txt

RUN set -e; \
  curl -sS https://forslund.github.io/mycroft-desktop-repo/mycroft-desktop.gpg.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/mimic.gpg; \
  echo "deb http://forslund.github.io/mycroft-desktop-repo bionic main" | tee -a /etc/apt/sources.list.d/mimic.list; \
  apt-get update; \
  apt-get install -o Dpkg::Options::="--force-confold" -y procps ddcutil pipewire pipewire-alsa libatomic1 portaudio19-dev libpulse-dev build-essential python3-dev libasound2-dev mimic vlc; \
  mkdir -p ${HOME}/.config/hivemind ${HOME}/.local/share/hivemind; \
  pip3 install -f 'https://whl.smartgic.io/' tflite_runtime; \
  if [ "${ALPHA}" == "true" ]; then \
  pip3 install -r /tmp/requirements.txt --pre; \
  else \
  pip3 install -r /tmp/requirements.txt; \
  fi; \
  mkdir -p /home/${USER}/.local/share/{vosk,precise-lite,mycroft/listener}; \
  chown ${USER}:${USER} -R /home/${USER}; \
  apt-get --purge remove -y portaudio19-dev build-essential python3-dev portaudio19-dev libpulse-dev libasound2-dev; \
  apt-get --purge autoremove -y; \
  apt-get clean; \
  rm -rf ${HOME}/.cache /var/lib/apt /var/log/{apt,dpkg.log} /tmp/requirements.txt

USER ${USER}

ENV EDITOR=vim
COPY --chmod=0755 ./images/hivemind-voice-sat/files/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
WORKDIR /home/${USER}
