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


