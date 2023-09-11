#!/usr/bin/env bash
set -e
# Load secrets from *_FILE or environment variables
has_error=0
load_secret() {
  local var_name="$1"
  local file_var_name="${var_name}_FILE"

  if [ -n "${!file_var_name}" ]; then
    export "$var_name"=$(cat "${!file_var_name}")
  elif [ -n "${!var_name}" ]; then
    export "$var_name=${!var_name}"
  else
    echo "Warning: Neither $var_name nor $file_var_name are set."
    has_error=1
  fi
}

# Load secrets
load_secret "HIVEMIND_SAT_KEY"
load_secret "HIVEMIND_SAT_PASSWORD"
load_secret "HIVEMIND_CORE_HOST"
load_secret "HIVEMIND_CORE_PORT"


if [ "$has_error" -eq 1 ]; then
  echo "Error: Missing required environment variables."
  exit 1
fi

HIVEMIND_SELFSIGNED=${HIVEMIND_SELFSIGNED:-no}

audio_list=~/.config/mycroft/audio.list
listener_list=~/.config/mycroft/listener.list
phal_list=~/.config/mycroft/phal.list

# Install TTS plugins, OCP plugins or others Python libraries via pip command when a setup.py exists
if [ -f "$audio_list" ]; then
    pip3 install -r "$audio_list"
fi

# Install STT plugins, plugins or others Python libraries via pip command when a setup.py exists
if [ -f "$listener_list" ]; then
    pip3 install -r "$listener_list"
fi

# Install PHAL plugins via pip command when a setup.py exists
if test -f "$phal_list"; then
    pip3 install -r "$phal_list"
fi

# Clear Python cache
rm -rf ~/.cache/pip

# Auto-detect which sound server is running (PipeWire or PulseAudio)
if pactl info &> /dev/null; then
    echo -e 'pcm.!default pulse\nctl.!default pulse' > ~/.asoundrc
elif pw-link --links &> /dev/null; then
    echo -e 'pcm.!default pipewire\nctl.!default pipewire' > ~/.asoundrc
fi

sed -i 's/disable_ocp=True/disable_ocp=False/' /home/ovos/.venv/lib/python3.11/site-packages/hivemind_voice_satellite/__main__.py

hivemind-voice-sat --host "$HIVEMIND_CORE_HOST" \
    --key "$HIVEMIND_SAT_KEY" \
    --password "$HIVEMIND_SAT_PASSWORD" \
    --port "$HIVEMIND_CORE_PORT" \
    $( [ "$HIVEMIND_SELFSIGNED" = "yes" ] || [ "$HIVEMIND_SELFSIGNED" = "true" ] && echo "--selfsigned" )
