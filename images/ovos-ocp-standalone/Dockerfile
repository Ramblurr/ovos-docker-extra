ARG TAG=alpha
FROM smartgic/ovos-skill-base:${TAG}

ARG BUILD_DATE=unknown
ARG VERSION=unknown

LABEL org.opencontainers.image.title="Open Voice OS OCI standalone OCP"
LABEL org.opencontainers.image.description="OVOS Common Play is a full-fledged voice media player packaged as a ovos audio plugin."
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.documentation="https://openvoiceos.github.io/community-docs"
LABEL org.opencontainers.image.source="https://github.com/OpenVoiceOS/ovos-docker"
LABEL org.opencontainers.image.vendor="Open Voice OS"

ARG ALPHA=false

COPY ./images/ovos-ocp-standalone/files/requirements.txt /tmp/requirements.txt
RUN if [ "${ALPHA}" == "true" ]; then \
      pip3 install --no-cache -r /tmp/requirements.txt --pre; \
    else \
      pip3 install --no-cache -r /tmp/requirements.txt; \
    fi \
    && rm -rf ${HOME}/.cache

COPY --chmod=0755 ./images/ovos-ocp-standalone/files/ocp-launcher.py /usr/local/bin/ocp-launcher

ENTRYPOINT ["ocp-launcher"]
