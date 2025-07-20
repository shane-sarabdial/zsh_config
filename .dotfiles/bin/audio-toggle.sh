#!/usr/bin/env bash
SINK1="alsa_output.pci-0000_31_00.4.iec958-stereo"
LABEL1="Speakers"
SINK2="alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.iec958-stereo"
LABEL2="Headphones"

# detect current default
CUR=$(pactl info | awk '/Default Sink:/ {print $3}')

# choose the other sink
if [[ "$CUR" == "$SINK1" ]]; then
  NEW="$SINK2"
  FRIENDLY="$LABEL2"
else
  NEW="$SINK1"
  FRIENDLY="$LABEL1"
fi

# switch default
pactl set-default-sink "$NEW"
# move all streams to it
for s in $(pactl list short sink-inputs | cut -f1); do
  pactl move-sink-input "$s" "$NEW"
done

# notify
notify-send "Audio switched to" "$FRIENDLY"