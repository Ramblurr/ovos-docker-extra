# ovos-docker-extra

Extra container images for OVOS.

Refer to [OpenVoiceOS/ovos-docker](https://github.com/OpenVoiceOS/ovos-docker/) for more info.

## List of images

| Image                                                |
|------------------------------------------------------|
| `ghcr.io/ramblurr/skill-homeassistant`               |
| `ghcr.io/ramblurr/skill-homeassistant-dev`           |
| `ghcr.io/ramblurr/hivemind-voice-sat`                |
| `ghcr.io/ramblurr/hivemind-voice-sat-dev`            |
| `ghcr.io/ramblurr/ovos-ocp-standalone`               |
| `ghcr.io/ramblurr/ovos-ocp-standalone-dev`           |
| `ghcr.io/ramblurr/ovos-stt-plugin-fasterwhisper`     |
| `ghcr.io/ramblurr/ovos-stt-plugin-fasterwhisper-dev` |
| `ghcr.io/ramblurr/ovos-stt-plugin-whispercpp`        |
| `ghcr.io/ramblurr/ovos-stt-plugin-whispercpp-dev`    |
| `ghcr.io/ramblurr/skill-ovos-fallback-chatgpt`       |
| `ghcr.io/ramblurr/skill-ovos-fallback-chatgpt-dev`   |

## Tag immutability

The containers built here do not use immutable tags, as least not in the more common way you have seen from [linuxserver.io](https://fleet.linuxserver.io/) or [Bitnami](https://bitnami.com/stacks/containers).

We take do take a similar approach but instead of appending a `-ls69` or `-r420` prefix to the tag we instead insist on pinning to the sha256 digest of the image, while this is not as pretty it is just as functional in making the images immutable.

| Container                                                                                          | Immutable |
|----------------------------------------------------------------------------------------------------|-----------|
| `ghcr.io/ramblurr/skill-homeassistant:rolling`                                                     | ❌        |
| `ghcr.io/ramblurr/skill-homeassistant:0.0.8`                                                       | ❌        |
| `ghcr.io/ramblurr/skill-homeassistant:rolling@sha256:8053...`                                      | ✅        |
| `ghcr.io/ramblurr/skill-homeassistant:0.0.8@sha256:8053...`                                        | ✅        |
| `ghcr.io/ramblurr/skill-homeassistant-dev:rolling@sha256:8053...`                                  | ✅        |
| `ghcr.io/ramblurr/skill-homeassistant-dev:f15c17c9d955489d480969aa36c3216ba4c32be5@sha256:8053...` | ✅        |

_If pinning an image to the sha256 digest, tools like [Renovate](https://github.com/renovatebot/renovate) support updating the container on a digest or application version change._


## Automated tags

Here's an example of how tags are created in the GitHub workflows, be careful with `metadata.json` as it does affect the outcome of how the tags will be created when the application is built.

| Application           | Channel  | Stable  | Base    | Generated Tag                                                       |
|-----------------------|----------|---------|---------|---------------------------------------------------------------------|
| `skill-homeassistant` | `stable` | `true`  | `false` | `skill-homeassistant:rolling`                                       |
| `skill-homeassistant` | `stable` | `true`  | `false` | `skill-homeassistant:0.0.8`                                         |
| `skill-homeassistant` | `dev`    | `false` | `false` | `skill-homeassistant-dev:rolling`                                   |
| `skill-homeassistant` | `dev`    | `false` | `false` | `skill-homeassistant-dev:f15c17c9d955489d480969aa36c3216ba4c32be5%` |


## Source

The build system used in this repo is from [onedr0p/containers](https://github.com/onedr0p/containers), many thanks to him and the [Kubernetes @Home](https://discord.gg/k8s-at-home) community.
