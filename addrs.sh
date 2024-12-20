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
    constant=$1
    addrs=${@:2}
    search="${addrs// /\\\| ; }"  # join 2nd arg onward into "arg2\|; arg3\|; arg4"
    echo "/; $search/s/\$..\s\{$((${#constant}-3))\}/$constant/;"
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

add_constant GAMESTATE_LEADERBOARD 91E5 9415
add_constant GAMESTATE_GAMEOVER 82D2 83ED 8B39
add_constant GAMESTATE_TITLE 9C06 9E81 A9D4 AA09 AA74 AA9A
add_constant GAMESTATE_DEMO 82CE 8B3D 95C6 997A 9C02
add_constant GAMESTATE_GAME_TYPE 9EED 9FCF A01D
add_constant GAMESTATE_LEVEL_SELECT 9F3A 9FE5 A021
add_constant GAMESTATE_HANDICAP A025
add_constant GAMESTATE_MUSIC_SELECT 9FCB A006
add_constant GAMESTATE_PLAYING 90C1 95E3
add_constant GAMESTATE_PAUSED B5DF
add_constant GAMESTATE_LEVELUP 8B41 8CB5 8CE7

add_constant MENU_GAMEMODE_1P A068
# add_constant MENU_GAMEMODE_2P
add_constant MENU_GAMEMODE_COOP 9665
add_constant MENU_GAMEMODE_VS 805B 81F7 8308 983F 9989 9AD5 9C4F
# add_constant MENU_GAMEMODE_WITH

add_constant BUTTON_START B5D8 A011
add_constant BUTTON_SELECT 9291
add_constant BUTTON_SELECT+BUTTON_START 9FA4
add_constant BUTTON_UP+BUTTON_DOWN+BUTTON_SELECT 9FBC 9FED 9FF6
add_constant BUTTON_LEFT 923A 8079 9246 808B 9C6C
add_constant BUTTON_RIGHT 809B 9263 9240 80AD 9C68
add_constant BUTTON_LEFT+BUTTON_RIGHT 8065
add_constant BUTTON_UP A04F 9C21
add_constant BUTTON_DOWN 806B 80F5 9C2C 8108
add_constant ~BUTTON_DOWN 8052
add_constant BUTTON_DOWN+BUTTON_LEFT 8077
add_constant BUTTON_A+BUTTON_B 82F5 82F7 9280
add_constant BUTTON_RIGHT+BUTTON_DOWN 8099
add_constant BUTTON_B 80BB 80CD 9C87
add_constant BUTTON_A 80D7 80E9 9C83
add_constant BUTTON_DOWN+BUTTON_LEFT+BUTTON_RIGHT 80F3

add_constant PLAYER1 B5CA 8033 803D 8054
add_constant PLAYER2 B5CF 8038 8042

add_constant \'0\' B4F2 953B 94F3 956A 9644 964C 9651 A949 A96F
add_constant \'1\' B4FB 9536
add_constant \'7\' 953F 9572 9576
add_constant \'8\' B4F7
add_constant \'9\'+1 B4E6 9505 9514 9523 9532 956C A94D


add_constant MUSIC_SUSPEND B5E7 95CE
add_constant MUSIC_RESUME B5F2
add_constant MUSIC_SILENCE 83F3 8CE0 9043 A035
add_constant MUSIC_LEVELUP 8D6F
add_constant MUSIC_LEVELUP_INTRO 95BC
add_constant MUSIC_TITLESCREEN 9E97
add_constant MUSIC_GAMEOVER 8406

add_constant SOUND_SCREEN_SWITCH B51F
add_constant SOUND_SCREEN_SWITCH B554
add_constant SOUND_DROP 841B
add_constant SOUND_LINECLEAR 95C1
add_constant SOUND_SCREEN_SWITCH 9F02
add_constant SOUND_MENU_SELECT 9FC4
add_constant SOUND_SCREEN_SWITCH A016

add_constant TETROMINO_Y_INIT B537 9954 9145 9102

add_constant rngSeed 800A 9A0F
add_constant player1RNGSeed 9938

add_constant '>player1Playfield' 9155
add_constant '<player1Playfield' 9159
add_constant '>player2Playfield' 9112
add_constant '<player2Playfield' 9116
)" main.asm

# These remove labels that end up in the middle of instructions (label := * + 1, etc)
sed -i "
/^L98A6/d
s/L98A6/$(get_label 98A7)-1/
/^LAD23/d
/^LAD24/d
s/LAD23/$(get_label AD25)-2/
s/LAD24/$(get_label AD25)-1/" main.asm


# remove ram definitions (included in entry.asm)
perl -i -p0e "s/^ppuControl.*?(?=^PPUCTRL)//ms" main.asm

# Remove trailing whitespace
sed -i 's/[ \t]*$//' main.asm

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
