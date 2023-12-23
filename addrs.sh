#!/usr/bin/env bash

# The purpose of this script is to replace constant values with label references


set -e

get_label () {
    printf $(grep -nB1 "; $1" main.asm | head -1 | awk -F- '{print $2}' | sed s/://)
    }

apply_high() {
    label=$(get_label $1)
    # echo high $label ${1::-2} $2
    sed -i "/; $2/s/#\$${1::-2}/#>$label/" main.asm
    }

apply_low() {
    label=$(get_label $1)
    # echo low $label ${1:2} $2
    sed -i "/; $2/s/#\$${1:2}/#<$label/" main.asm
    }

apply_label() {
    apply_low $1 $2
    apply_high $1 $3
    }


# label, lowloc, highloc
apply_label A788 A779 A77D
apply_label A6E6 A6D0 A6D6
apply_label F703 D320 D319
apply_label DFCF D2AB D2B2
apply_label DF13 D12C D133
apply_label DF13 D187 D18E
apply_label DF13 D211 D218
apply_label DF42 D13E D145
apply_label DF42 D226 D22D
apply_label DF71 D245 D24C
apply_label DD32 D1FF D207


extract_nt () {
    grep -Pzo "(?sm)${1}:\\n\\K.*?(?=^\\S)" main.asm | grep -a byte > nametables/${1}.asm
    perl -i -p0e "s/^${1}:\\n\\K.*?(?=^\\S)/.include \"nametables\/${1}.asm\"\n/ms" main.asm
    }

extract_nt titleScreenNametable
extract_nt menuNametable
extract_nt gameModeNametableCoop
extract_nt gameModeNametable1P
extract_nt gameModeNametable2P


# move the start of prg_chunk2.  Come back and nudge this forward until sound breaks
PRG_chunk2=LFD31

lineNo=$(awk "/^${PRG_chunk2}:/ {print FNR}" main.asm)
address=$(grep -zoP "(?sm)^${PRG_chunk2}:.*?; \K[0-9A-F]{4}" main.asm | tr -d '\0')
sed -i "$lineNo i .segment \"PRG_chunk2\": absolute" main.asm
sed -i "/PRG_chunk2/s/\$..../\$${address}/" tetris.nes.cfg


ending_anchor=$(awk '/^unknownData02:/ {print FNR}' main.asm)
ending=$(($ending_anchor+3))
sed -i "$ending i .code" main.asm
