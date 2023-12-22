#!/usr/bin/env bash

# The purpose of this script is to replace constant values with label references


set -e

get_label () {
    printf $(grep -nB1 "; $1" main.asm | head -1 | awk -F- '{print $2}' | sed s/://)
    }

# Do not know what this is for yet
label=$(get_label A788)
sed -i "/; A779/s/#\$88/#<$label/" main.asm
sed -i "/; A77D/s/#\$A7/#>$label/" main.asm


# This is used to load palette info
label=$(get_label A6E6)
sed -i "/; A6D0/s/#\$E6/#<$label/" main.asm
sed -i "/; A6D6/s/#\$A6/#>$label/" main.asm

label=$(get_label F703)
sed -i "/; D319/s/#\$F7/#>$label/" main.asm
sed -i "/; D320/s/#\$03/#<$label/" main.asm

label=$(get_label DFCF)
sed -i "/; D2B2/s/#\$DF/#>$label/" main.asm
sed -i "/; D2AB/s/#\$CF/#<$label/" main.asm

label=$(get_label DF13)
sed -i "/; D133/s/#\$DF/#>$label/" main.asm
sed -i "/; D12C/s/#\$13/#<$label/" main.asm

sed -i "/; D18E/s/#\$DF/#>$label/" main.asm
sed -i "/; D187/s/#\$13/#<$label/" main.asm

label=$(get_label DF42)
sed -i "/; D145/s/#\$DF/#>$label/" main.asm
sed -i "/; D13E/s/#\$42/#<$label/" main.asm


extract_nt () {
    grep -Pzo "(?sm)${1}:\\n\\K.*?(?=^\\S)" main.asm | grep -a byte > nametables/${1}.asm
    perl -i -p0e "s/^${1}:\\n\\K.*?(?=^\\S)/.include \"nametables\/${1}.asm\"\n/ms" main.asm
    }

extract_nt titleScreenNametable
extract_nt menuNametable
extract_nt gameModeNametableCoop
extract_nt gameModeNametable1P
extract_nt gameModeNametable2P



starting=$(awk '/^drawCathedralSprites:/ {print FNR}' main.asm)
sed -i "$starting i .segment \"PRG_chunk2\": absolute" main.asm


ending_anchor=$(awk '/^unknownData02:/ {print FNR}' main.asm)
ending=$(($ending_anchor+3))
sed -i "$ending i .code" main.asm
