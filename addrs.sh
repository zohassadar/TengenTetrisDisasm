#!/usr/bin/env bash

# The purpose of this script is to replace constant values with label references

set -e

get_label () {
    label_addr=$1
    printf $(grep -nB1 "; $label_addr" main.asm | head -1 | awk -F- '{print $2}' | sed s/://)
    }

apply_high() {
    label_addr=$1
    byte_addr=$2
    label=$3
    # echo high $3 ${1::-2} $2
    echo "/; $byte_addr/s/\$${label_addr::-2}/>$label/;"
    echo "/; $byte_addr/s/\s\{$((${#label}-2))\};/;/;"
    }

apply_low() {
    label_addr=$1
    byte_addr=$2
    label=$3
    # echo low $3 ${1:2} $2
    echo "/; $byte_addr/s/\$${label_addr:2}/<$label/;"
    echo "/; $byte_addr/s/\s\{$((${#label}-2))\};/;/;"
    }

apply_label() {
    label=$(get_label $1)
    label_addr=$1
    low_byte_addr=$2
    high_byte_addr=$3
    apply_low $label_addr $low_byte_addr $label
    apply_high $label_addr $high_byte_addr $label
    }

add_constant() {
    address=$1
    constant=$2
    echo "/; $address/s/\$..\s\{$((${#constant}-3))\}/$constant/;"
    }


# label, lowloc, highloc
sed -i "$(
apply_label 8A1F 89FD 8A01
apply_label 93DC 9310 9314
apply_label A788 A779 A77D
apply_label A6E6 A6D0 A6D6
apply_label CDC0 AB2D AB2D
apply_label CDC0 AB30 AB30
apply_label CDF1 AB33 AB33
apply_label CDF1 AB36 AB36
apply_label CE22 AB39 AB39
apply_label CE22 AB3C AB3C
apply_label CE53 AB3F AB3F
apply_label CE53 AB42 AB42
apply_label CE53 AB45 AB45
apply_label CE84 AB48 AB48
apply_label CE84 AB4B AB4B
apply_label CE84 AB4E AB4E
apply_label CDC0 AB52 AB52
apply_label CDC0 AB55 AB55
apply_label CDF1 AB58 AB58
apply_label CDF1 AB5B AB5B
apply_label CE22 AB5E AB5E
apply_label CE22 AB61 AB61
apply_label CE53 AB64 AB64
apply_label CE53 AB67 AB67
apply_label CE53 AB6A AB6A
apply_label CEB5 AB6E AB6E
apply_label CEE6 AB71 AB71
apply_label CF17 AB74 AB74
apply_label CF48 AB77 AB77
apply_label CEB5 AB7B AB7B
apply_label CEE6 AB7E AB7E
apply_label CF17 AB81 AB81
apply_label CF48 AB84 AB84
apply_label CEB5 AB88 AB88
apply_label CEE6 AB8B AB8B
apply_label CF17 AB8E AB8E
apply_label CF48 AB91 AB91
apply_label CEB5 AB95 AB95
apply_label CEE6 AB98 AB98
apply_label CF17 AB9B AB9B
apply_label CF48 AB9E AB9E
apply_label CEB5 ABA2 ABA2
apply_label CEE6 ABA5 ABA5
apply_label CF17 ABA8 ABA8
apply_label CF48 ABAB ABAB
apply_label CEB5 ABAF ABAF
apply_label CEE6 ABB2 ABB2
apply_label CF17 ABB5 ABB5
apply_label CF48 ABB8 ABB8
apply_label CEB5 ABBC ABBC
apply_label CEE6 ABBF ABBF
apply_label CF17 ABC2 ABC2
apply_label CF48 ABC5 ABC5
apply_label CDC0 ABC9 ABC9
apply_label CDC0 ABCC ABCC
apply_label CDF1 ABCF ABCF
apply_label CDF1 ABD2 ABD2
apply_label CE22 ABD5 ABD5
apply_label CE22 ABD8 ABD8
apply_label CE53 ABDB ABDB
apply_label CE53 ABDE ABDE
apply_label CE53 ABE1 ABE1
apply_label CEB5 ABE5 ABE5
apply_label CEE6 ABE8 ABE8
apply_label CF17 ABEB ABEB
apply_label CF48 ABEE ABEE
apply_label CEB5 ABF2 ABF2
apply_label CEE6 ABF5 ABF5
apply_label CF17 ABF8 ABF8
apply_label CF48 ABFB ABFB
apply_label CEB5 ABFF ABFF
apply_label CEE6 AC02 AC02
apply_label CF17 AC05 AC05
apply_label CF48 AC08 AC08
apply_label CEB5 AC0C AC0C
apply_label CEE6 AC0F AC0F
apply_label CF17 AC12 AC12
apply_label CF48 AC15 AC15
apply_label CEB5 AC19 AC19
apply_label CEE6 AC1C AC1C
apply_label CF17 AC1F AC1F
apply_label CF48 AC22 AC22
apply_label CEB5 AC26 AC26
apply_label CEE6 AC29 AC29
apply_label CF17 AC2C AC2C
apply_label CF48 AC2F AC2F
apply_label CEB5 AC33 AC33
apply_label CEE6 AC36 AC36
apply_label CF17 AC39 AC39
apply_label CF48 AC3C AC3C
apply_label CEB5 AC40 AC40
apply_label CEE6 AC43 AC43
apply_label CF17 AC46 AC46
apply_label CF48 AC49 AC49
apply_label CEB5 AC4D AC4D
apply_label CEE6 AC50 AC50
apply_label CF17 AC53 AC53
apply_label CF48 AC56 AC56
apply_label CDC0 AC5B AC5B
apply_label CDF1 AC5E AC5E
apply_label CDF1 AC61 AC61
apply_label CDC0 AC65 AC65
apply_label CDF1 AC68 AC68
apply_label CDF1 AC6B AC6B
apply_label CDC0 AC6F AC6F
apply_label CDF1 AC72 AC72
apply_label CDF1 AC75 AC75
apply_label CDC0 AC79 AC79
apply_label CDC0 AC7C AC7C
apply_label CDF1 AC7F AC7F
apply_label CDF1 AC82 AC82
apply_label CDC0 AC86 AC86
apply_label CDC0 AC89 AC89
apply_label CDF1 AC8C AC8C
apply_label CDF1 AC8F AC8F
apply_label CDC0 AC93 AC93
apply_label CDC0 AC96 AC96
apply_label CDF1 AC99 AC99
apply_label CDF1 AC9C AC9C
apply_label DFCF D2AB D2B2
apply_label DF13 D12C D133
apply_label DF13 D187 D18E
apply_label DF13 D211 D218
apply_label DF42 D13E D145
apply_label DF42 D226 D22D
apply_label DF71 D245 D24C
apply_label DD32 D1FF D207
# apply_label F703 D320 D319  This one was wrong
apply_label C8BC B079 B07D
apply_label B14D B04A B050
apply_label B181 B0AF B0B3
apply_label B181 B0F1 B0F5
add_constant 82CE GAMESTATE_DEMO
add_constant 82D2 GAMESTATE_GAMEOVER
add_constant B5D8 BUTTON_START
add_constant 9291 BUTTON_SELECT
add_constant 9FA4 BUTTON_SELECT+BUTTON_START
add_constant 9FBC BUTTON_UP+BUTTON_DOWN+BUTTON_SELECT
add_constant 9FED BUTTON_UP+BUTTON_DOWN+BUTTON_SELECT
add_constant A011 BUTTON_START
add_constant 8052 ~BUTTON_DOWN
add_constant 923A BUTTON_LEFT
add_constant 9240 BUTTON_RIGHT
add_constant 9FF6 BUTTON_UP+BUTTON_DOWN+BUTTON_SELECT
add_constant 9280 BUTTON_A+BUTTON_B
add_constant A04F BUTTON_UP
add_constant 806B BUTTON_DOWN
add_constant 8077 BUTTON_DOWN+BUTTON_LEFT
add_constant 8079 BUTTON_LEFT
add_constant 82F5 BUTTON_A+BUTTON_B
add_constant 82F7 BUTTON_A+BUTTON_B
add_constant 8099 BUTTON_RIGHT+BUTTON_DOWN
add_constant 809B BUTTON_RIGHT
add_constant 80BB BUTTON_B
add_constant 80D7 BUTTON_A
add_constant 80F3 BUTTON_DOWN+BUTTON_LEFT+BUTTON_RIGHT
add_constant 80F5 BUTTON_DOWN
add_constant 9246 BUTTON_LEFT
add_constant 9263 BUTTON_RIGHT
add_constant 9C21 BUTTON_UP
add_constant 9C2C BUTTON_DOWN
)" main.asm

# These remove labels that end up in the middle of instructions (label := * + 1, etc)
sed -i "
/^L98A6/d
s/L98A6/$(get_label 98A7)-1/
/^LAD23/d
/^LAD24/d
s/LAD23/$(get_label AD25)-2/
s/LAD24/$(get_label AD25)-1/" main.asm

extract_nt () {
    grep -Pzo "(?sm)${1}:\\n\\K.*?(?=^\\S)" main.asm | grep -a byte > nametables/${1}.asm
    perl -i -p0e "s/^${1}:\\n\\K.*?(?=^\\S)/.include \"nametables\/${1}.asm\"\n/ms" main.asm
    }

extract_nt titleScreenNametable
extract_nt menuNametable
extract_nt gameModeNametableCoop
extract_nt gameModeNametable1P
extract_nt gameModeNametable2P


# This was used to keep the tail in a steady spot while narrowing down where sound related labels were
# PRG_chunk2=LFD31

# lineNo=$(awk "/^${PRG_chunk2}:/ {print FNR}" main.asm)
# address=$(grep -zoP "(?sm)^${PRG_chunk2}:.*?; \K[0-9A-F]{4}" main.asm | tr -d '\0')
# sed -i "$lineNo i .segment \"PRG_chunk2\": absolute" main.asm
# sed -i "/PRG_chunk2/s/\$..../\$${address}/" tetris.nes.cfg


# ending_anchor=$(awk '/^unknownData02:/ {print FNR}' main.asm)
# ending=$(($ending_anchor+3))
# sed -i "$ending i .code" main.asm
