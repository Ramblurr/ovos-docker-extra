ARG TAG=alpha
FROM smartgic/ovos-skill-base:${TAG}

ARG BUILD_DATE=unknown
ARG VERSION=unknown
ARG CHANNEL=unknown

LABEL org.opencontainers.image.title="Open Voice OS OCI ChatGPT Persona Fallback Skill"
LABEL org.opencontainers.image.description="When in doubt, ask chatgpt, powered by OVOS Persona"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.documentation="https://openvoiceos.github.io/community-docs"
LABEL org.opencontainers.image.source="https://github.com/OpenVoiceOS/ovos-docker"
LABEL org.opencontainers.image.vendor="Open Voice OS"


RUN if [ "${CHANNEL}" == "dev" ]; then \
    pip3 install skill-ovos-fallback-chatgpt --pre; \
    else \
    pip3 install skill-ovos-fallback-chatgpt; \
    fi \
    && rm -rf ${HOME}/.cache

ENTRYPOINT ["ovos-skill-launcher", "skill-ovos-fallback-chatgpt.openvoiceos"]
