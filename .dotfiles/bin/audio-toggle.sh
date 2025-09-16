#!/usr/bin/env bash
# ← change these if you ever re-discover different names
CARD=47
USB_SINK="alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.iec958-stereo"
LABEL_USB="Headphones"
LABEL_SPK="Speakers"

# find current default sink
CUR=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

if [[ "$CUR" == "$USB_SINK" ]]; then
  # switch to analog speakers
  pactl set-card-profile $CARD output:analog-stereo+input:analog-stereo
  # wait a moment for PipeWire to create the sink
  sleep 0.1
  # find the new analog-stereo sink name
  NEW=$(pactl list short sinks \
        | awk '/pci-0000_31_00.4.*analog-stereo/ {print $2}')
  FRIENDLY="$LABEL_SPK"
else
  # switch to USB Modi
  NEW="$USB_SINK"
  FRIENDLY="$LABEL_USB"
fi

# set new default sink
pactl set-default-sink "$NEW"
# move all playing streams to it
pactl list short sink-inputs \
  | cut -f1 \
  | xargs -r -I{} pactl move-sink-input {} "$NEW"

# pop up a notification
notify-send "Audio switched to" "$FRIENDLY"