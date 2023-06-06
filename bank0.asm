; da65 V2.19 - Git c097401f8
; Created:    2023-06-05 19:16:54
; Input file: clean.nes
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
ppuScrollX      := $0002
ppuScrollY      := $0003
ppuDataAddress1 := $0008
ppuDataAddress2 := $000A
ppuDataAddress3 := $000C
ppuDataAddress4 := $000E
ppuDataAddress5 := $0010
ppuDataAddress6 := $0012
ppuDataAddress7 := $0014
gameStatePossible:= $0029
frameCounterLowLastFrame:= $002B
playMode        := $002F                        ; FF: Coop, 00: 1p, 01: 2p
frameCounterLow := $0032
frameCounterHigh:= $0033
rngSeed         := $0034
player1ControllerLastFrame:= $003E
player2ControllerLastFrame:= $003F
player1ExpansionLastFrame:= $0040
player2ExpansionLastFrame:= $0041
player1ControllerHeld:= $0042
player2ControllerHeld:= $0043
player1ExpansionHeld:= $0044
player2ExpansionHeld:= $0045
player1ControllerNew:= $0046
player2ControllerNew:= $0047
savedRNGSeedForSomething:= $005A
player1RNGSeed  := $005C
player2RNGSeed  := $005E
player1TetriminoY:= $0060
player2TetriminoY:= $0061
player1TetriminoX:= $0062
player2TetriminoX:= $0063
player1TetriminoCurrent:= $0064
player2TetriminoCurrent:= $0065
player1TetriminoNext:= $0066
player2TetriminoNext:= $0067
player1TetriminoOrientation:= $0068
player2TetriminoOrientation:= $0069
player1FallTimer:= $006A
player2FallTimer:= $006B
codeInputPlayer1:= $01B6
codeInputPlayer2:= $01B7
longBarCodeUsedP1:= $01B8
longBarCodeUsedP2:= $01B9
removeBlockCodeUsedP1:= $01BA
removeBlockCodeUsedP2:= $01BB
lastCurrentBlockP1:= $01BC
lastCurrentBlockP2:= $01BD
lastOrientationP1:= $01BE
lastOrientationP2:= $01BF
lastTetriminoYP1:= $01C0
lastTetriminoYP2:= $01C1
lastTetriminoXP1:= $01C2
lastTetriminoXP2:= $01C3
lastRNGSeedP1   := $01C4
lastRNGSeedP2   := $01C6
stack           := $01D3
player1ScoreHundredThousands:= $0418
player1ScoreTenThousands:= $0419
player1ScoreThousands:= $041A
player1ScoreHundreds:= $041B
player1ScoreTens:= $041C
player1ScoreOnes:= $041D
player2ScoreHundredThousands:= $041E
player2ScoreTenThousands:= $041F
player2ScoreThousands:= $0420
player2ScoreHundreds:= $0421
player2ScoreTens:= $0422
player2ScoreOnes:= $0423
player1LinesThousands:= $0424
player1LinesHundreds:= $0425
player1LinesTens:= $0426
player1LinesOnes:= $0427
player2LinesThousands:= $0428
player2LinesHundreds:= $0429
player2LinesTens:= $042A
player2LinesOnes:= $042B
player1LevelTens:= $042C
player1LevelOnes:= $042D
player2LevelTens:= $042E
player2LevelOnes:= $042F
player1ScoreMirrorPossible:= $0430
unknownScoreSlot:= $0436
highScoreHundredThousands:= $043C
highScoreTenThousands:= $043D
highScoreThousands:= $043E
highScoreHundreds:= $043F
highScoreTens   := $0440
highScoreOnes   := $0441
leaderboardScores::= $0442
leaderboardLines:= $0496
leaderboardInitials:= $04C3
menuGameMode    := $04F0
menuPlayer1StartLevel:= $04F1
menuPlayer2StartLevel:= $04F2
menuPlayer1Handicap:= $04F3
menuPlayer2Handicap:= $04F4
menuMusic       := $04F5
ppuScrollYOffset:= $04F6
oamStaging      := $0500
player1Playfield:= $0600
player2Playfield:= $0700
PPUCTRL         := $2000
PPUMASK         := $2001
PPUSTATUS       := $2002
OAMADDR         := $2003
OAMDATA         := $2004
PPUSCROLL       := $2005
PPUADDR         := $2006
PPUDATA         := $2007
SQ1_VOL         := $4000
SQ1_SWEEP       := $4001
SQ1_LO          := $4002
SQ1_HI          := $4003
SQ2_VOL         := $4004
SQ2_SWEEP       := $4005
SQ2_LO          := $4006
SQ2_HI          := $4007
TRI_LINEAR      := $4008
TRI_LO          := $400A
TRI_HI          := $400B
NOISE_VOL       := $400C
NOISE_LO        := $400E
NOISE_HI        := $400F
DMC_FREQ        := $4010
DMC_RAW         := $4011
DMC_START       := $4012                        ; start << 6 + $C000
DMC_LEN         := $4013                        ; len << 4 + 1 
OAMDMA          := $4014
SND_CHN         := $4015
player1controllerPort:= $4016
player2controllerPort:= $4017
; ----------------------------------------------------------------------------
        jmp     reset                           ; 8000 4C 11 A9                 L..

; ----------------------------------------------------------------------------
L8003:
        lda     #$01                            ; 8003 A9 01                    ..
        sta     $49                             ; 8005 85 49                    .I
        jsr     L9E61                           ; 8007 20 61 9E                  a.
mainLoop:
        ldx     #$34                            ; 800A A2 34                    .4
        jsr     genNextPseudoRandom             ; 800C 20 FA 99                  ..
        lda     frameCounterLow                 ; 800F A5 32                    .2
        cmp     frameCounterLowLastFrame        ; 8011 C5 2B                    .+
        beq     mainLoop                        ; 8013 F0 F5                    ..
        sta     frameCounterLowLastFrame        ; 8015 85 2B                    .+
        lda     $25                             ; 8017 A5 25                    .%
        cmp     $27                             ; 8019 C5 27                    .'
        bne     L8021                           ; 801B D0 04                    ..
        lda     #$00                            ; 801D A9 00                    ..
        sta     $48                             ; 801F 85 48                    .H
L8021:
        jsr     pollController                  ; 8021 20 00 A4                  ..
        jsr     L9F87                           ; 8024 20 87 9F                  ..
        jsr     LB5C5                           ; 8027 20 C5 B5                  ..
        jsr     L8CE5                           ; 802A 20 E5 8C                  ..
        jsr     L91E3                           ; 802D 20 E3 91                  ..
        jsr     L9BFC                           ; 8030 20 FC 9B                  ..
        ldx     #$00                            ; 8033 A2 00                    ..
        jsr     L8848                           ; 8035 20 48 88                  H.
        ldx     #$01                            ; 8038 A2 01                    ..
        jsr     L8848                           ; 803A 20 48 88                  H.
        ldx     #$00                            ; 803D A2 00                    ..
        jsr     L82C7                           ; 803F 20 C7 82                  ..
        ldx     #$01                            ; 8042 A2 01                    ..
        jsr     L82C7                           ; 8044 20 C7 82                  ..
        jsr     L8B37                           ; 8047 20 37 8B                  7.
        jsr     L9B62                           ; 804A 20 62 9B                  b.
        jmp     mainLoop                        ; 804D 4C 0A 80                 L..

; ----------------------------------------------------------------------------
L8050:
        lda     player1ControllerNew,x          ; 8050 B5 46                    .F
@allButtonsExceptDown:
        and     #$DF                            ; 8052 29 DF                    ).
        cpx     #$00                            ; 8054 E0 00                    ..
        beq     @player1Active                  ; 8056 F0 07                    ..
        ldy     menuGameMode                    ; 8058 AC F0 04                 ...
        cpy     #$03                            ; 805B C0 03                    ..
        bcs     @ret                            ; 805D B0 04                    ..
@player1Active:
        ldy     gameStatePossible               ; 805F A4 29                    .)
        beq     doSomethingWithInputDuringGameplay; 8061 F0 01                  ..
@ret:
        rts                                     ; 8063 60                       `

; ----------------------------------------------------------------------------
doSomethingWithInputDuringGameplay:
        tay                                     ; 8064 A8                       .
@LeftAndRight:
        and     #$C0                            ; 8065 29 C0                    ).
        beq     L8073                           ; 8067 F0 0A                    ..
        lda     player1ControllerLastFrame,x    ; 8069 B5 3E                    .>
@CheckForDown:
        and     #$20                            ; 806B 29 20                    ) 
        beq     L8073                           ; 806D F0 04                    ..
        tya                                     ; 806F 98                       .
        and     #$3F                            ; 8070 29 3F                    )?
        tay                                     ; 8072 A8                       .
L8073:
        lda     player1ControllerHeld,x         ; 8073 B5 42                    .B
        sta     $36                             ; 8075 85 36                    .6
@LeftAndDown:
        and     #$60                            ; 8077 29 60                    )`
        cmp     #$40                            ; 8079 C9 40                    .@
        bne     @LeftNotPressed                 ; 807B D0 15                    ..
        lda     $01AA,x                         ; 807D BD AA 01                 ...
        clc                                     ; 8080 18                       .
        adc     #$01                            ; 8081 69 01                    i.
        sta     $01AA,x                         ; 8083 9D AA 01                 ...
        cmp     #$0B                            ; 8086 C9 0B                    ..
        bcc     L8097                           ; 8088 90 0D                    ..
        tya                                     ; 808A 98                       .
        ora     #$40                            ; 808B 09 40                    .@
        tay                                     ; 808D A8                       .
        lda     #$05                            ; 808E A9 05                    ..
        bne     L8094                           ; 8090 D0 02                    ..
@LeftNotPressed:
        lda     #$00                            ; 8092 A9 00                    ..
L8094:
        sta     $01AA,x                         ; 8094 9D AA 01                 ...
L8097:
        lda     $36                             ; 8097 A5 36                    .6
@RightAndDown:
        and     #$A0                            ; 8099 29 A0                    ).
        cmp     #$80                            ; 809B C9 80                    ..
        bne     @RightNotPressed                ; 809D D0 15                    ..
        lda     $01AC,x                         ; 809F BD AC 01                 ...
        clc                                     ; 80A2 18                       .
        adc     #$01                            ; 80A3 69 01                    i.
        sta     $01AC,x                         ; 80A5 9D AC 01                 ...
        cmp     #$0B                            ; 80A8 C9 0B                    ..
        bcc     L80B9                           ; 80AA 90 0D                    ..
        tya                                     ; 80AC 98                       .
        ora     #$80                            ; 80AD 09 80                    ..
        tay                                     ; 80AF A8                       .
        lda     #$05                            ; 80B0 A9 05                    ..
        bne     L80B6                           ; 80B2 D0 02                    ..
@RightNotPressed:
        lda     #$00                            ; 80B4 A9 00                    ..
L80B6:
        sta     $01AC,x                         ; 80B6 9D AC 01                 ...
L80B9:
        lda     $36                             ; 80B9 A5 36                    .6
        and     #$02                            ; 80BB 29 02                    ).
        beq     @BNotPressed                    ; 80BD F0 11                    ..
        lda     $01AE,x                         ; 80BF BD AE 01                 ...
        clc                                     ; 80C2 18                       .
        adc     #$01                            ; 80C3 69 01                    i.
        sta     $01AE,x                         ; 80C5 9D AE 01                 ...
        cmp     #$0F                            ; 80C8 C9 0F                    ..
        bcc     L80D5                           ; 80CA 90 09                    ..
        tya                                     ; 80CC 98                       .
        ora     #$02                            ; 80CD 09 02                    ..
        tay                                     ; 80CF A8                       .
@BNotPressed:
        lda     #$00                            ; 80D0 A9 00                    ..
        sta     $01AE,x                         ; 80D2 9D AE 01                 ...
L80D5:
        lda     $36                             ; 80D5 A5 36                    .6
        and     #$01                            ; 80D7 29 01                    ).
        beq     @ANotPressed                    ; 80D9 F0 11                    ..
        lda     $01B0,x                         ; 80DB BD B0 01                 ...
        clc                                     ; 80DE 18                       .
        adc     #$01                            ; 80DF 69 01                    i.
        sta     $01B0,x                         ; 80E1 9D B0 01                 ...
        cmp     #$0F                            ; 80E4 C9 0F                    ..
        bcc     L80F1                           ; 80E6 90 09                    ..
        tya                                     ; 80E8 98                       .
        ora     #$01                            ; 80E9 09 01                    ..
        tay                                     ; 80EB A8                       .
@ANotPressed:
        lda     #$00                            ; 80EC A9 00                    ..
        sta     $01B0,x                         ; 80EE 9D B0 01                 ...
L80F1:
        lda     $36                             ; 80F1 A5 36                    .6
@DownLeftRight:
        and     #$E0                            ; 80F3 29 E0                    ).
        cmp     #$20                            ; 80F5 C9 20                    . 
        bne     L8122                           ; 80F7 D0 29                    .)
        lda     $01B2,x                         ; 80F9 BD B2 01                 ...
        clc                                     ; 80FC 18                       .
        adc     #$01                            ; 80FD 69 01                    i.
        sta     $01B2,x                         ; 80FF 9D B2 01                 ...
        cmp     $01B4,x                         ; 8102 DD B4 01                 ...
        bcc     L8120                           ; 8105 90 19                    ..
        tya                                     ; 8107 98                       .
        ora     #$20                            ; 8108 09 20                    . 
        sta     $36                             ; 810A 85 36                    .6
        lda     $01B4,x                         ; 810C BD B4 01                 ...
        cmp     #$02                            ; 810F C9 02                    ..
        bcc     L8116                           ; 8111 90 03                    ..
        dec     $01B4,x                         ; 8113 DE B4 01                 ...
L8116:
        jsr     L9AEE                           ; 8116 20 EE 9A                  ..
        ldy     $36                             ; 8119 A4 36                    .6
L811B:
        lda     #$00                            ; 811B A9 00                    ..
        sta     $01B2,x                         ; 811D 9D B2 01                 ...
L8120:
        tya                                     ; 8120 98                       .
        rts                                     ; 8121 60                       `

; ----------------------------------------------------------------------------
L8122:
        lda     #$05                            ; 8122 A9 05                    ..
        sta     $01B4,x                         ; 8124 9D B4 01                 ...
        bne     L811B                           ; 8127 D0 F2                    ..
L8129:
        ldy     L8198,x                         ; 8129 BC 98 81                 ...
        stx     $39                             ; 812C 86 39                    .9
        lda     $2D                             ; 812E A5 2D                    .-
        asl     a                               ; 8130 0A                       .
        asl     a                               ; 8131 0A                       .
        asl     a                               ; 8132 0A                       .
        sec                                     ; 8133 38                       8
        sbc     #$D8                            ; 8134 E9 D8                    ..
        eor     #$FF                            ; 8136 49 FF                    I.
        cmp     #$4F                            ; 8138 C9 4F                    .O
        bcs     L813E                           ; 813A B0 02                    ..
        lda     #$4F                            ; 813C A9 4F                    .O
L813E:
        sec                                     ; 813E 38                       8
        sbc     ppuScrollYOffset                ; 813F ED F6 04                 ...
        sta     oamStaging,y                    ; 8142 99 00 05                 ...
        sta     oamStaging+4,y                  ; 8145 99 04 05                 ...
        sta     oamStaging+8,y                  ; 8148 99 08 05                 ...
        lda     #$00                            ; 814B A9 00                    ..
        sta     oamStaging+3,y                  ; 814D 99 03 05                 ...
        sta     oamStaging+7,y                  ; 8150 99 07 05                 ...
        sta     oamStaging+11,y                 ; 8153 99 0B 05                 ...
        bit     playMode                        ; 8156 24 2F                    $/
        bpl     L815C                           ; 8158 10 02                    ..
        inx                                     ; 815A E8                       .
        inx                                     ; 815B E8                       .
L815C:
        lda     $36                             ; 815C A5 36                    .6
        bne     L8165                           ; 815E D0 05                    ..
        lda     L8194,x                         ; 8160 BD 94 81                 ...
        bne     L8168                           ; 8163 D0 03                    ..
L8165:
        lda     L8190,x                         ; 8165 BD 90 81                 ...
L8168:
        sta     oamStaging+2,y                  ; 8168 99 02 05                 ...
        clc                                     ; 816B 18                       .
        lda     $36                             ; 816C A5 36                    .6
        beq     L8173                           ; 816E F0 03                    ..
        ora     #$30                            ; 8170 09 30                    .0
        sec                                     ; 8172 38                       8
L8173:
        sta     oamStaging+1,y                  ; 8173 99 01 05                 ...
        lda     $37                             ; 8176 A5 37                    .7
        bcs     L817C                           ; 8178 B0 02                    ..
        beq     L817E                           ; 817A F0 02                    ..
L817C:
        ora     #$30                            ; 817C 09 30                    .0
L817E:
        sta     oamStaging+5,y                  ; 817E 99 05 05                 ...
        lda     $38                             ; 8181 A5 38                    .8
        ora     #$30                            ; 8183 09 30                    .0
        sta     oamStaging+9,y                  ; 8185 99 09 05                 ...
        ldx     $39                             ; 8188 A6 39                    .9
        lda     #$3C                            ; 818A A9 3C                    .<
        sta     $01C8,x                         ; 818C 9D C8 01                 ...
        rts                                     ; 818F 60                       `

; ----------------------------------------------------------------------------
L8190:
        .byte   $60,$88,$28,$C0                 ; 8190 60 88 28 C0              `.(.
L8194:
        .byte   $58,$88,$28,$B8                 ; 8194 58 88 28 B8              X.(.
L8198:
        .byte   $E0,$EC                         ; 8198 E0 EC                    ..
; ----------------------------------------------------------------------------
L819A:
        lda     $01CE,x                         ; 819A BD CE 01                 ...
        bne     L81DC                           ; 819D D0 3D                    .=
        lda     $01C8,x                         ; 819F BD C8 01                 ...
        beq     L81DC                           ; 81A2 F0 38                    .8
        ldy     L8198,x                         ; 81A4 BC 98 81                 ...
        cmp     #$3C                            ; 81A7 C9 3C                    .<
        bne     L81CC                           ; 81A9 D0 21                    .!
        lda     oamStaging+2,y                  ; 81AB B9 02 05                 ...
        sta     oamStaging+3,y                  ; 81AE 99 03 05                 ...
        clc                                     ; 81B1 18                       .
        adc     #$08                            ; 81B2 69 08                    i.
        sta     oamStaging+7,y                  ; 81B4 99 07 05                 ...
        adc     #$08                            ; 81B7 69 08                    i.
        sta     oamStaging+11,y                 ; 81B9 99 0B 05                 ...
        lda     #$03                            ; 81BC A9 03                    ..
        bit     playMode                        ; 81BE 24 2F                    $/
        beq     L81C3                           ; 81C0 F0 01                    ..
        txa                                     ; 81C2 8A                       .
L81C3:
        sta     oamStaging+2,y                  ; 81C3 99 02 05                 ...
        sta     oamStaging+6,y                  ; 81C6 99 06 05                 ...
        sta     oamStaging+10,y                 ; 81C9 99 0A 05                 ...
L81CC:
        dec     $01C8,x                         ; 81CC DE C8 01                 ...
        bne     L81DC                           ; 81CF D0 0B                    ..
        lda     #$F7                            ; 81D1 A9 F7                    ..
        sta     oamStaging,y                    ; 81D3 99 00 05                 ...
        sta     oamStaging+4,y                  ; 81D6 99 04 05                 ...
        sta     oamStaging+8,y                  ; 81D9 99 08 05                 ...
L81DC:
        rts                                     ; 81DC 60                       `

; ----------------------------------------------------------------------------
L81DD:
        bit     playMode                        ; 81DD 24 2F                    $/
        bpl     L81EC                           ; 81DF 10 0B                    ..
        txa                                     ; 81E1 8A                       .
        eor     #$01                            ; 81E2 49 01                    I.
        tax                                     ; 81E4 AA                       .
        jsr     L81EC                           ; 81E5 20 EC 81                  ..
        txa                                     ; 81E8 8A                       .
        eor     #$01                            ; 81E9 49 01                    I.
        tax                                     ; 81EB AA                       .
L81EC:
        txa                                     ; 81EC 8A                       .
        stx     $36                             ; 81ED 86 36                    .6
        asl     a                               ; 81EF 0A                       .
        adc     $36                             ; 81F0 65 36                    e6
        asl     a                               ; 81F2 0A                       .
        tay                                     ; 81F3 A8                       .
        lda     menuGameMode                    ; 81F4 AD F0 04                 ...
        cmp     #$03                            ; 81F7 C9 03                    ..
        bcc     L81FF                           ; 81F9 90 04                    ..
        tya                                     ; 81FB 98                       .
        beq     L81FF                           ; 81FC F0 01                    ..
        rts                                     ; 81FE 60                       `

; ----------------------------------------------------------------------------
L81FF:
        ldx     #$54                            ; 81FF A2 54                    .T
L8201:
        lda     player1ScoreOnes,y              ; 8201 B9 1D 04                 ...
        cmp     highScoreOnes,x                 ; 8204 DD 41 04                 .A.
        lda     player1ScoreTens,y              ; 8207 B9 1C 04                 ...
        sbc     highScoreTens,x                 ; 820A FD 40 04                 .@.
        lda     player1ScoreHundreds,y          ; 820D B9 1B 04                 ...
        sbc     highScoreHundreds,x             ; 8210 FD 3F 04                 .?.
        lda     player1ScoreThousands,y         ; 8213 B9 1A 04                 ...
        sbc     highScoreThousands,x            ; 8216 FD 3E 04                 .>.
        lda     player1ScoreTenThousands,y      ; 8219 B9 19 04                 ...
        sbc     highScoreTenThousands,x         ; 821C FD 3D 04                 .=.
        lda     player1ScoreHundredThousands,y  ; 821F B9 18 04                 ...
        sbc     highScoreHundredThousands,x     ; 8222 FD 3C 04                 .<.
        bcc     L822D                           ; 8225 90 06                    ..
        txa                                     ; 8227 8A                       .
        sbc     #$06                            ; 8228 E9 06                    ..
        tax                                     ; 822A AA                       .
        bcs     L8201                           ; 822B B0 D4                    ..
L822D:
        txa                                     ; 822D 8A                       .
        clc                                     ; 822E 18                       .
        adc     #$06                            ; 822F 69 06                    i.
        cmp     #$5A                            ; 8231 C9 5A                    .Z
        beq     L8297                           ; 8233 F0 62                    .b
        jsr     L829A                           ; 8235 20 9A 82                  ..
        lda     player1ScoreOnes,y              ; 8238 B9 1D 04                 ...
        sta     highScoreOnes,x                 ; 823B 9D 41 04                 .A.
        lda     player1ScoreTens,y              ; 823E B9 1C 04                 ...
        sta     highScoreTens,x                 ; 8241 9D 40 04                 .@.
        lda     player1ScoreHundreds,y          ; 8244 B9 1B 04                 ...
        sta     highScoreHundreds,x             ; 8247 9D 3F 04                 .?.
        lda     player1ScoreThousands,y         ; 824A B9 1A 04                 ...
        sta     highScoreThousands,x            ; 824D 9D 3E 04                 .>.
        lda     player1ScoreTenThousands,y      ; 8250 B9 19 04                 ...
        sta     highScoreTenThousands,x         ; 8253 9D 3D 04                 .=.
        lda     player1ScoreHundredThousands,y  ; 8256 B9 18 04                 ...
        sta     highScoreHundredThousands,x     ; 8259 9D 3C 04                 .<.
        lda     $36                             ; 825C A5 36                    .6
        asl     a                               ; 825E 0A                       .
        asl     a                               ; 825F 0A                       .
        tay                                     ; 8260 A8                       .
        txa                                     ; 8261 8A                       .
        lsr     a                               ; 8262 4A                       J
        tax                                     ; 8263 AA                       .
        lda     player1LinesThousands,y         ; 8264 B9 24 04                 .$.
        cmp     #$30                            ; 8267 C9 30                    .0
        beq     L8275                           ; 8269 F0 0A                    ..
        .byte   $A9,$39,$9D,$96,$04,$9D,$97,$04 ; 826B A9 39 9D 96 04 9D 97 04  .9......
        .byte   $D0,$0F                         ; 8273 D0 0F                    ..
; ----------------------------------------------------------------------------
L8275:
        lda     player1LinesHundreds,y          ; 8275 B9 25 04                 .%.
        sta     leaderboardLines,x              ; 8278 9D 96 04                 ...
        lda     player1LinesTens,y              ; 827B B9 26 04                 .&.
        sta     leaderboardLines+1,x            ; 827E 9D 97 04                 ...
        lda     player1LinesOnes,y              ; 8281 B9 27 04                 .'.
        sta     leaderboardLines+2,x            ; 8284 9D 98 04                 ...
        lda     #$01                            ; 8287 A9 01                    ..
        ldy     $36                             ; 8289 A4 36                    .6
        ora     L93DA,y                         ; 828B 19 DA 93                 ...
        sta     leaderboardInitials,x           ; 828E 9D C3 04                 ...
        sta     leaderboardInitials+1,x         ; 8291 9D C4 04                 ...
        sta     leaderboardInitials+2,x         ; 8294 9D C5 04                 ...
L8297:
        ldx     $36                             ; 8297 A6 36                    .6
        rts                                     ; 8299 60                       `

; ----------------------------------------------------------------------------
L829A:
        sta     $37                             ; 829A 85 37                    .7
        ldx     #$54                            ; 829C A2 54                    .T
        cpx     $37                             ; 829E E4 37                    .7
        beq     L82C6                           ; 82A0 F0 24                    .$
L82A2:
        dex                                     ; 82A2 CA                       .
        lda     highScoreHundredThousands,x     ; 82A3 BD 3C 04                 .<.
        sta     leaderboardScores:,x            ; 82A6 9D 42 04                 .B.
        cpx     $37                             ; 82A9 E4 37                    .7
        bne     L82A2                           ; 82AB D0 F5                    ..
        lsr     $37                             ; 82AD 46 37                    F7
        ldx     #$2A                            ; 82AF A2 2A                    .*
L82B1:
        dex                                     ; 82B1 CA                       .
        lda     leaderboardLines,x              ; 82B2 BD 96 04                 ...
        sta     leaderboardLines+3,x            ; 82B5 9D 99 04                 ...
        lda     leaderboardInitials,x           ; 82B8 BD C3 04                 ...
        sta     leaderboardInitials+3,x         ; 82BB 9D C6 04                 ...
        cpx     $37                             ; 82BE E4 37                    .7
        bne     L82B1                           ; 82C0 D0 EF                    ..
        lda     $37                             ; 82C2 A5 37                    .7
        asl     a                               ; 82C4 0A                       .
        tax                                     ; 82C5 AA                       .
L82C6:
        rts                                     ; 82C6 60                       `

; ----------------------------------------------------------------------------
L82C7:
        jsr     L819A                           ; 82C7 20 9A 81                  ..
        ldy     gameStatePossible               ; 82CA A4 29                    .)
        beq     L82D7                           ; 82CC F0 09                    ..
        cpy     #$FB                            ; 82CE C0 FB                    ..
        beq     L82D7                           ; 82D0 F0 05                    ..
        cpy     #$F9                            ; 82D2 C0 F9                    ..
        beq     L82F3                           ; 82D4 F0 1D                    ..
L82D6:
        rts                                     ; 82D6 60                       `

; ----------------------------------------------------------------------------
L82D7:
        lda     $01CE,x                         ; 82D7 BD CE 01                 ...
        bne     L82D6                           ; 82DA D0 FA                    ..
        ldy     playMode                        ; 82DC A4 2F                    ./
        bpl     L82E8                           ; 82DE 10 08                    ..
        lda     $01CE                           ; 82E0 AD CE 01                 ...
        ora     $01CF                           ; 82E3 0D CF 01                 ...
        bne     L82D6                           ; 82E6 D0 EE                    ..
L82E8:
        lda     $4A,x                           ; 82E8 B5 4A                    .J
        beq     L82F3                           ; 82EA F0 07                    ..
        lda     player1TetriminoCurrent,x       ; 82EC B5 64                    .d
        bne     L8320                           ; 82EE D0 30                    .0
        jmp     getNextTetrimino                ; 82F0 4C 29 99                 L).

; ----------------------------------------------------------------------------
L82F3:
        lda     player1ControllerHeld,x         ; 82F3 B5 42                    .B
        and     #$03                            ; 82F5 29 03                    ).
        cmp     #$03                            ; 82F7 C9 03                    ..
        bne     L82D6                           ; 82F9 D0 DB                    ..
        cpy     #$FB                            ; 82FB C0 FB                    ..
        beq     L82D6                           ; 82FD F0 D7                    ..
        lda     playMode                        ; 82FF A5 2F                    ./
        beq     L8312                           ; 8301 F0 0F                    ..
        bmi     L8315                           ; 8303 30 10                    0.
        lda     menuGameMode                    ; 8305 AD F0 04                 ...
        cmp     #$03                            ; 8308 C9 03                    ..
        bne     L830F                           ; 830A D0 03                    ..
        txa                                     ; 830C 8A                       .
        bne     L82D6                           ; 830D D0 C7                    ..
L830F:
        jmp     L9744                           ; 830F 4C 44 97                 LD.

; ----------------------------------------------------------------------------
L8312:
        txa                                     ; 8312 8A                       .
        bne     L82D6                           ; 8313 D0 C1                    ..
L8315:
        lda     savedRNGSeedForSomething        ; 8315 A5 5A                    .Z
        sta     rngSeed                         ; 8317 85 34                    .4
        lda     savedRNGSeedForSomething+1      ; 8319 A5 5B                    .[
        sta     rngSeed+1                       ; 831B 85 35                    .5
        jmp     L95E3                           ; 831D 4C E3 95                 L..

; ----------------------------------------------------------------------------
L8320:
        jsr     L8050                           ; 8320 20 50 80                  P.
        sta     $3B                             ; 8323 85 3B                    .;
        dec     player1FallTimer,x              ; 8325 D6 6A                    .j
        bne     L8330                           ; 8327 D0 07                    ..
        ora     #$20                            ; 8329 09 20                    . 
        sta     $3B                             ; 832B 85 3B                    .;
        jsr     L9AEE                           ; 832D 20 EE 9A                  ..
L8330:
        lda     $3B                             ; 8330 A5 3B                    .;
        and     #$E3                            ; 8332 29 E3                    ).
        beq     L82D6                           ; 8334 F0 A0                    ..
        jsr     L84D8                           ; 8336 20 D8 84                  ..
        lda     $3B                             ; 8339 A5 3B                    .;
        and     #$40                            ; 833B 29 40                    )@
        beq     L8352                           ; 833D F0 13                    ..
        dec     player1TetriminoX,x             ; 833F D6 62                    .b
        jsr     L8650                           ; 8341 20 50 86                  P.
        bcs     L8352                           ; 8344 B0 0C                    ..
        lda     #$09                            ; 8346 A9 09                    ..
        sta     $01AA,x                         ; 8348 9D AA 01                 ...
        inc     player1TetriminoX,x             ; 834B F6 62                    .b
        bvs     L8352                           ; 834D 70 03                    p.
        jsr     L862E                           ; 834F 20 2E 86                  ..
L8352:
        lda     $3B                             ; 8352 A5 3B                    .;
        and     #$80                            ; 8354 29 80                    ).
        beq     L836B                           ; 8356 F0 13                    ..
        inc     player1TetriminoX,x             ; 8358 F6 62                    .b
        jsr     L8650                           ; 835A 20 50 86                  P.
        bcs     L836B                           ; 835D B0 0C                    ..
        lda     #$09                            ; 835F A9 09                    ..
        sta     $01AC,x                         ; 8361 9D AC 01                 ...
        dec     player1TetriminoX,x             ; 8364 D6 62                    .b
        bvs     L836B                           ; 8366 70 03                    p.
        jsr     L862E                           ; 8368 20 2E 86                  ..
L836B:
        lda     $3B                             ; 836B A5 3B                    .;
        and     #$02                            ; 836D 29 02                    ).
        beq     L838E                           ; 836F F0 1D                    ..
        lda     player1TetriminoOrientation,x   ; 8371 B5 68                    .h
        sta     $3A                             ; 8373 85 3A                    .:
        clc                                     ; 8375 18                       .
        adc     #$01                            ; 8376 69 01                    i.
        and     #$03                            ; 8378 29 03                    ).
        sta     player1TetriminoOrientation,x   ; 837A 95 68                    .h
        jsr     L8650                           ; 837C 20 50 86                  P.
        bcs     L838E                           ; 837F B0 0D                    ..
        dec     player1TetriminoX,x             ; 8381 D6 62                    .b
        jsr     L8650                           ; 8383 20 50 86                  P.
        bcs     L838E                           ; 8386 B0 06                    ..
        inc     player1TetriminoX,x             ; 8388 F6 62                    .b
        lda     $3A                             ; 838A A5 3A                    .:
        sta     player1TetriminoOrientation,x   ; 838C 95 68                    .h
L838E:
        lda     $3B                             ; 838E A5 3B                    .;
        and     #$01                            ; 8390 29 01                    ).
        beq     L83B1                           ; 8392 F0 1D                    ..
        lda     player1TetriminoOrientation,x   ; 8394 B5 68                    .h
        sta     $3A                             ; 8396 85 3A                    .:
        sec                                     ; 8398 38                       8
        sbc     #$01                            ; 8399 E9 01                    ..
        and     #$03                            ; 839B 29 03                    ).
        sta     player1TetriminoOrientation,x   ; 839D 95 68                    .h
        jsr     L8650                           ; 839F 20 50 86                  P.
        bcs     L83B1                           ; 83A2 B0 0D                    ..
        dec     player1TetriminoX,x             ; 83A4 D6 62                    .b
        jsr     L8650                           ; 83A6 20 50 86                  P.
        bcs     L83B1                           ; 83A9 B0 06                    ..
        inc     player1TetriminoX,x             ; 83AB F6 62                    .b
        lda     $3A                             ; 83AD A5 3A                    .:
        sta     player1TetriminoOrientation,x   ; 83AF 95 68                    .h
L83B1:
        lda     $3B                             ; 83B1 A5 3B                    .;
        and     #$20                            ; 83B3 29 20                    ) 
        beq     L8416                           ; 83B5 F0 5F                    ._
        inc     player1TetriminoY,x             ; 83B7 F6 60                    .`
        jsr     L8C15                           ; 83B9 20 15 8C                  ..
        bcs     L840B                           ; 83BC B0 4D                    .M
        jsr     L8658                           ; 83BE 20 58 86                  X.
        bcs     L8416                           ; 83C1 B0 53                    .S
        dec     player1TetriminoY,x             ; 83C3 D6 60                    .`
        jsr     L85B3                           ; 83C5 20 B3 85                  ..
        jsr     L9A47                           ; 83C8 20 47 9A                  G.
        jsr     L8129                           ; 83CB 20 29 81                  ).
        lda     player1TetriminoY,x             ; 83CE B5 60                    .`
        cmp     #$06                            ; 83D0 C9 06                    ..
        bcs     L8417                           ; 83D2 B0 43                    .C
        lda     #$00                            ; 83D4 A9 00                    ..
        bit     playMode                        ; 83D6 24 2F                    $/
        bpl     L83DE                           ; 83D8 10 04                    ..
        sta     $4A                             ; 83DA 85 4A                    .J
        sta     $4B                             ; 83DC 85 4B                    .K
L83DE:
        sta     $4A,x                           ; 83DE 95 4A                    .J
        lda     gameStatePossible               ; 83E0 A5 29                    .)
        bne     L83E7                           ; 83E2 D0 03                    ..
        jsr     L81DD                           ; 83E4 20 DD 81                  ..
L83E7:
        lda     $4A                             ; 83E7 A5 4A                    .J
        ora     $4B                             ; 83E9 05 4B                    .K
        bne     L83F8                           ; 83EB D0 0B                    ..
        lda     #$F9                            ; 83ED A9 F9                    ..
        sta     gameStatePossible               ; 83EF 85 29                    .)
        sta     player1FallTimer                ; 83F1 85 6A                    .j
        lda     #$08                            ; 83F3 A9 08                    ..
        jsr     possibleSetSoundOrMusic         ; 83F5 20 B1 CF                  ..
L83F8:
        txa                                     ; 83F8 8A                       .
        lda     #$02                            ; 83F9 A9 02                    ..
        bit     playMode                        ; 83FB 24 2F                    $/
        bmi     L8403                           ; 83FD 30 04                    0.
        txa                                     ; 83FF 8A                       .
        clc                                     ; 8400 18                       .
        adc     #$03                            ; 8401 69 03                    i.
L8403:
        jsr     LB603                           ; 8403 20 03 B6                  ..
        lda     #$0A                            ; 8406 A9 0A                    ..
        jmp     possibleSetSoundOrMusic         ; 8408 4C B1 CF                 L..

; ----------------------------------------------------------------------------
L840B:
        dec     player1TetriminoY,x             ; 840B D6 60                    .`
        lda     #$01                            ; 840D A9 01                    ..
        sta     player1FallTimer,x              ; 840F 95 6A                    .j
        lda     #$05                            ; 8411 A9 05                    ..
        sta     $01B4,x                         ; 8413 9D B4 01                 ...
L8416:
        rts                                     ; 8416 60                       `

; ----------------------------------------------------------------------------
L8417:
        lda     #$00                            ; 8417 A9 00                    ..
        sta     player1TetriminoCurrent,x       ; 8419 95 64                    .d
        lda     #$0E                            ; 841B A9 0E                    ..
        jsr     possibleSetSoundOrMusic         ; 841D 20 B1 CF                  ..
        jsr     L8565                           ; 8420 20 65 85                  e.
        jsr     L8773                           ; 8423 20 73 87                  s.
L8426:
        ldy     #$00                            ; 8426 A0 00                    ..
        lda     #$07                            ; 8428 A9 07                    ..
        sta     $36                             ; 842A 85 36                    .6
L842C:
        ldx     #$08                            ; 842C A2 08                    ..
L842E:
        lda     $7A,y                           ; 842E B9 7A 00                 .z.
        cmp     $B2,y                           ; 8431 D9 B2 00                 ...
        bne     L844A                           ; 8434 D0 14                    ..
        iny                                     ; 8436 C8                       .
        dex                                     ; 8437 CA                       .
        bne     L842E                           ; 8438 D0 F4                    ..
L843A:
        lda     $ED                             ; 843A A5 ED                    ..
        clc                                     ; 843C 18                       .
        adc     #$20                            ; 843D 69 20                    i 
        sta     $ED                             ; 843F 85 ED                    ..
        bcc     L8445                           ; 8441 90 02                    ..
        inc     $EE                             ; 8443 E6 EE                    ..
L8445:
        dec     $36                             ; 8445 C6 36                    .6
        bne     L842C                           ; 8447 D0 E3                    ..
        rts                                     ; 8449 60                       `

; ----------------------------------------------------------------------------
L844A:
        sty     $38                             ; 844A 84 38                    .8
        stx     $37                             ; 844C 86 37                    .7
L844E:
        sty     $39                             ; 844E 84 39                    .9
L8450:
        iny                                     ; 8450 C8                       .
        dex                                     ; 8451 CA                       .
        beq     L845E                           ; 8452 F0 0A                    ..
        lda     $7A,y                           ; 8454 B9 7A 00                 .z.
        cmp     $B2,y                           ; 8457 D9 B2 00                 ...
        beq     L8450                           ; 845A F0 F4                    ..
        bne     L844E                           ; 845C D0 F0                    ..
L845E:
        jsr     LA3DB                           ; 845E 20 DB A3                  ..
        stx     $3A                             ; 8461 86 3A                    .:
        ldx     $38                             ; 8463 A6 38                    .8
        ldy     #$00                            ; 8465 A0 00                    ..
L8467:
        lda     $B2,x                           ; 8467 B5 B2                    ..
        sta     ($48),y                         ; 8469 91 48                    .H
        iny                                     ; 846B C8                       .
        inx                                     ; 846C E8                       .
        dec     $37                             ; 846D C6 37                    .7
        bne     L8467                           ; 846F D0 F6                    ..
        txa                                     ; 8471 8A                       .
        tay                                     ; 8472 A8                       .
        ldx     $3A                             ; 8473 A6 3A                    .:
        lda     $48                             ; 8475 A5 48                    .H
        sta     ppuDataAddress1,x               ; 8477 95 08                    ..
        lda     $49                             ; 8479 A5 49                    .I
        sta     ppuDataAddress1+1,x             ; 847B 95 09                    ..
        lda     $38                             ; 847D A5 38                    .8
        and     #$07                            ; 847F 29 07                    ).
        clc                                     ; 8481 18                       .
        adc     $ED                             ; 8482 65 ED                    e.
        sta     $16,x                           ; 8484 95 16                    ..
        lda     $EE                             ; 8486 A5 EE                    ..
        adc     #$00                            ; 8488 69 00                    i.
        sta     $17,x                           ; 848A 95 17                    ..
        lda     $39                             ; 848C A5 39                    .9
        sec                                     ; 848E 38                       8
        sbc     $38                             ; 848F E5 38                    .8
        adc     #$00                            ; 8491 69 00                    i.
        sta     $24,x                           ; 8493 95 24                    .$
        clc                                     ; 8495 18                       .
        adc     $48                             ; 8496 65 48                    eH
        sta     $48                             ; 8498 85 48                    .H
        jmp     L843A                           ; 849A 4C 3A 84                 L:.

; ----------------------------------------------------------------------------
L849D:
        lda     #$00                            ; 849D A9 00                    ..
        sta     $36                             ; 849F 85 36                    .6
        iny                                     ; 84A1 C8                       .
        sty     $37                             ; 84A2 84 37                    .7
        bit     playMode                        ; 84A4 24 2F                    $/
        bmi     L84AE                           ; 84A6 30 06                    0.
        lda     #$0A                            ; 84A8 A9 0A                    ..
        sta     $38                             ; 84AA 85 38                    .8
        bne     L84C4                           ; 84AC D0 16                    ..
L84AE:
        lda     #$0C                            ; 84AE A9 0C                    ..
        sta     $38                             ; 84B0 85 38                    .8
L84B2:
        lda     ($3A),y                         ; 84B2 B1 3A                    .:
        lsr     a                               ; 84B4 4A                       J
        lsr     a                               ; 84B5 4A                       J
        lsr     a                               ; 84B6 4A                       J
        lsr     a                               ; 84B7 4A                       J
        ldy     $36                             ; 84B8 A4 36                    .6
        sta     ($48),y                         ; 84BA 91 48                    .H
        inc     $36                             ; 84BC E6 36                    .6
        ldy     $37                             ; 84BE A4 37                    .7
        dec     $38                             ; 84C0 C6 38                    .8
        beq     L84D7                           ; 84C2 F0 13                    ..
L84C4:
        lda     ($3A),y                         ; 84C4 B1 3A                    .:
        iny                                     ; 84C6 C8                       .
        sty     $37                             ; 84C7 84 37                    .7
        and     #$0F                            ; 84C9 29 0F                    ).
        ldy     $36                             ; 84CB A4 36                    .6
        sta     ($48),y                         ; 84CD 91 48                    .H
        inc     $36                             ; 84CF E6 36                    .6
        ldy     $37                             ; 84D1 A4 37                    .7
        dec     $38                             ; 84D3 C6 38                    .8
        bne     L84B2                           ; 84D5 D0 DB                    ..
L84D7:
        rts                                     ; 84D7 60                       `

; ----------------------------------------------------------------------------
L84D8:
        lda     player1TetriminoY,x             ; 84D8 B5 60                    .`
        sec                                     ; 84DA 38                       8
        sbc     #$01                            ; 84DB E9 01                    ..
        sta     $EA                             ; 84DD 85 EA                    ..
        asl     a                               ; 84DF 0A                       .
        asl     a                               ; 84E0 0A                       .
        asl     a                               ; 84E1 0A                       .
        sta     $36                             ; 84E2 85 36                    .6
        lda     player1TetriminoX,x             ; 84E4 B5 62                    .b
        sec                                     ; 84E6 38                       8
        sbc     #$02                            ; 84E7 E9 02                    ..
        bpl     L84ED                           ; 84E9 10 02                    ..
        .byte   $A9,$00                         ; 84EB A9 00                    ..
; ----------------------------------------------------------------------------
L84ED:
        sta     $EB                             ; 84ED 85 EB                    ..
        lsr     a                               ; 84EF 4A                       J
        ora     $36                             ; 84F0 05 36                    .6
        sta     $EC                             ; 84F2 85 EC                    ..
        sta     $36                             ; 84F4 85 36                    .6
        stx     $39                             ; 84F6 86 39                    .9
        bit     playMode                        ; 84F8 24 2F                    $/
        bpl     L84FE                           ; 84FA 10 02                    ..
        ldx     #$02                            ; 84FC A2 02                    ..
L84FE:
        lda     playfieldIdPossible,x           ; 84FE BD 62 85                 .b.
        sta     $37                             ; 8501 85 37                    .7
        lda     L8559,x                         ; 8503 BD 59 85                 .Y.
        sta     $EE                             ; 8506 85 EE                    ..
        lda     $EA                             ; 8508 A5 EA                    ..
        asl     a                               ; 850A 0A                       .
        asl     a                               ; 850B 0A                       .
        asl     a                               ; 850C 0A                       .
        asl     a                               ; 850D 0A                       .
        rol     $EE                             ; 850E 26 EE                    &.
        asl     a                               ; 8510 0A                       .
        rol     $EE                             ; 8511 26 EE                    &.
        adc     L8556,x                         ; 8513 7D 56 85                 }V.
        bcc     L851A                           ; 8516 90 02                    ..
        inc     $EE                             ; 8518 E6 EE                    ..
L851A:
        clc                                     ; 851A 18                       .
        adc     $EB                             ; 851B 65 EB                    e.
        bcc     L8521                           ; 851D 90 02                    ..
        inc     $EE                             ; 851F E6 EE                    ..
L8521:
        sta     $ED                             ; 8521 85 ED                    ..
        ldx     #$00                            ; 8523 A2 00                    ..
        ldy     #$00                            ; 8525 A0 00                    ..
        lda     $EB                             ; 8527 A5 EB                    ..
        lsr     a                               ; 8529 4A                       J
        bcs     L8537                           ; 852A B0 0B                    ..
L852C:
        lda     ($36),y                         ; 852C B1 36                    .6
        lsr     a                               ; 852E 4A                       J
        lsr     a                               ; 852F 4A                       J
        lsr     a                               ; 8530 4A                       J
        lsr     a                               ; 8531 4A                       J
        jsr     L8544                           ; 8532 20 44 85                  D.
        bcs     L8541                           ; 8535 B0 0A                    ..
L8537:
        lda     ($36),y                         ; 8537 B1 36                    .6
        iny                                     ; 8539 C8                       .
        and     #$0F                            ; 853A 29 0F                    ).
        jsr     L8544                           ; 853C 20 44 85                  D.
        bcc     L852C                           ; 853F 90 EB                    ..
L8541:
        ldx     $39                             ; 8541 A6 39                    .9
        rts                                     ; 8543 60                       `

; ----------------------------------------------------------------------------
L8544:
        sta     $7A,x                           ; 8544 95 7A                    .z
        sta     $B2,x                           ; 8546 95 B2                    ..
        inx                                     ; 8548 E8                       .
        txa                                     ; 8549 8A                       .
        and     #$07                            ; 854A 29 07                    ).
        bne     L8553                           ; 854C D0 05                    ..
        tya                                     ; 854E 98                       .
        clc                                     ; 854F 18                       .
        adc     #$04                            ; 8550 69 04                    i.
        tay                                     ; 8552 A8                       .
L8553:
        cpx     #$38                            ; 8553 E0 38                    .8
        rts                                     ; 8555 60                       `

; ----------------------------------------------------------------------------
L8556:
        .byte   $3F,$51,$48                     ; 8556 3F 51 48                 ?QH
L8559:
        .byte   $08,$08,$08                     ; 8559 08 08 08                 ...
L855C:
        .byte   $02,$14,$0A                     ; 855C 02 14 0A                 ...
L855F:
        .byte   $21,$21,$21                     ; 855F 21 21 21                 !!!
playfieldIdPossible:
        .byte   $06,$07,$06                     ; 8562 06 07 06                 ...
; ----------------------------------------------------------------------------
L8565:
        lda     $EC                             ; 8565 A5 EC                    ..
        sta     $36                             ; 8567 85 36                    .6
        stx     $39                             ; 8569 86 39                    .9
        bit     playMode                        ; 856B 24 2F                    $/
        bpl     L8571                           ; 856D 10 02                    ..
        ldx     #$00                            ; 856F A2 00                    ..
L8571:
        lda     playfieldIdPossible,x           ; 8571 BD 62 85                 .b.
        sta     $37                             ; 8574 85 37                    .7
        ldx     #$00                            ; 8576 A2 00                    ..
        ldy     #$00                            ; 8578 A0 00                    ..
        lda     $EB                             ; 857A A5 EB                    ..
        lsr     a                               ; 857C 4A                       J
        bcs     L8590                           ; 857D B0 11                    ..
L857F:
        lda     ($36),y                         ; 857F B1 36                    .6
        and     #$0F                            ; 8581 29 0F                    ).
        sta     $38                             ; 8583 85 38                    .8
        lda     $B2,x                           ; 8585 B5 B2                    ..
        asl     a                               ; 8587 0A                       .
        asl     a                               ; 8588 0A                       .
        asl     a                               ; 8589 0A                       .
        asl     a                               ; 858A 0A                       .
        jsr     L85A1                           ; 858B 20 A1 85                  ..
        bcs     L859E                           ; 858E B0 0E                    ..
L8590:
        lda     ($36),y                         ; 8590 B1 36                    .6
        and     #$F0                            ; 8592 29 F0                    ).
        sta     $38                             ; 8594 85 38                    .8
        lda     $B2,x                           ; 8596 B5 B2                    ..
        jsr     L85A1                           ; 8598 20 A1 85                  ..
        iny                                     ; 859B C8                       .
        bcc     L857F                           ; 859C 90 E1                    ..
L859E:
        ldx     $39                             ; 859E A6 39                    .9
        rts                                     ; 85A0 60                       `

; ----------------------------------------------------------------------------
L85A1:
        ora     $38                             ; 85A1 05 38                    .8
        sta     ($36),y                         ; 85A3 91 36                    .6
        inx                                     ; 85A5 E8                       .
        txa                                     ; 85A6 8A                       .
        and     #$07                            ; 85A7 29 07                    ).
        bne     L85B0                           ; 85A9 D0 05                    ..
        tya                                     ; 85AB 98                       .
        clc                                     ; 85AC 18                       .
        adc     #$04                            ; 85AD 69 04                    i.
        tay                                     ; 85AF A8                       .
L85B0:
        cpx     #$38                            ; 85B0 E0 38                    .8
        rts                                     ; 85B2 60                       `

; ----------------------------------------------------------------------------
L85B3:
        lda     player1TetriminoCurrent,x       ; 85B3 B5 64                    .d
        sta     lastCurrentBlockP1,x            ; 85B5 9D BC 01                 ...
        lda     player1TetriminoY,x             ; 85B8 B5 60                    .`
        sta     lastTetriminoYP1,x              ; 85BA 9D C0 01                 ...
        lda     player1TetriminoX,x             ; 85BD B5 62                    .b
        sta     lastTetriminoXP1,x              ; 85BF 9D C2 01                 ...
        lda     player1TetriminoOrientation,x   ; 85C2 B5 68                    .h
        sta     lastOrientationP1,x             ; 85C4 9D BE 01                 ...
        txa                                     ; 85C7 8A                       .
        asl     a                               ; 85C8 0A                       .
        tay                                     ; 85C9 A8                       .
        lda     player1RNGSeed,y                ; 85CA B9 5C 00                 .\.
        sta     lastRNGSeedP1,y                 ; 85CD 99 C4 01                 ...
        lda     player1RNGSeed+1,y              ; 85D0 B9 5D 00                 .].
        sta     lastRNGSeedP1+1,y               ; 85D3 99 C5 01                 ...
        jsr     L869B                           ; 85D6 20 9B 86                  ..
L85D9:
        asl     $36                             ; 85D9 06 36                    .6
        bcc     L85EB                           ; 85DB 90 0E                    ..
        tya                                     ; 85DD 98                       .
        pha                                     ; 85DE 48                       H
        ldy     $39                             ; 85DF A4 39                    .9
        lda     L86F3,y                         ; 85E1 B9 F3 86                 ...
        sta     $B2,x                           ; 85E4 95 B2                    ..
        iny                                     ; 85E6 C8                       .
        sty     $39                             ; 85E7 84 39                    .9
        pla                                     ; 85E9 68                       h
        tay                                     ; 85EA A8                       .
L85EB:
        inx                                     ; 85EB E8                       .
        dey                                     ; 85EC 88                       .
        beq     L8604                           ; 85ED F0 15                    ..
        tya                                     ; 85EF 98                       .
        and     #$03                            ; 85F0 29 03                    ).
        bne     L85D9                           ; 85F2 D0 E5                    ..
        txa                                     ; 85F4 8A                       .
        clc                                     ; 85F5 18                       .
        adc     #$04                            ; 85F6 69 04                    i.
        tax                                     ; 85F8 AA                       .
        cpy     #$08                            ; 85F9 C0 08                    ..
        bne     L85D9                           ; 85FB D0 DC                    ..
        lda     $37                             ; 85FD A5 37                    .7
        sta     $36                             ; 85FF 85 36                    .6
        jmp     L85D9                           ; 8601 4C D9 85                 L..

; ----------------------------------------------------------------------------
L8604:
        ldx     $38                             ; 8604 A6 38                    .8
        rts                                     ; 8606 60                       `

; ----------------------------------------------------------------------------
L8607:
        .byte   $20,$9B,$86,$06,$36,$90,$04,$A9 ; 8607 20 9B 86 06 36 90 04 A9   ...6...
        .byte   $00,$95,$B2,$E8,$88,$F0,$15,$98 ; 860F 00 95 B2 E8 88 F0 15 98  ........
        .byte   $29,$03,$D0,$EF,$8A,$18,$69,$04 ; 8617 29 03 D0 EF 8A 18 69 04  ).....i.
        .byte   $AA,$C0,$08,$D0,$E6,$A5,$37,$85 ; 861F AA C0 08 D0 E6 A5 37 85  ......7.
        .byte   $36,$4C,$0A,$86,$A6,$38,$60     ; 8627 36 4C 0A 86 A6 38 60     6L...8`
; ----------------------------------------------------------------------------
L862E:
        inc     player1TetriminoY,x             ; 862E F6 60                    .`
        jsr     L8C15                           ; 8630 20 15 8C                  ..
        dec     player1TetriminoY,x             ; 8633 D6 60                    .`
        bcc     L863C                           ; 8635 90 05                    ..
L8637:
        inc     player1FallTimer,x              ; 8637 F6 6A                    .j
        inc     player1FallTimer,x              ; 8639 F6 6A                    .j
        rts                                     ; 863B 60                       `

; ----------------------------------------------------------------------------
L863C:
        txa                                     ; 863C 8A                       .
        eor     #$01                            ; 863D 49 01                    I.
        tay                                     ; 863F A8                       .
        lda     player1TetriminoY,x             ; 8640 B5 60                    .`
        cmp     player1TetriminoY,y             ; 8642 D9 60 00                 .`.
        bcc     L8637                           ; 8645 90 F0                    ..
        lda     player1FallTimer,y              ; 8647 B9 6A 00                 .j.
        adc     #$01                            ; 864A 69 01                    i.
        sta     player1FallTimer,y              ; 864C 99 6A 00                 .j.
        rts                                     ; 864F 60                       `

; ----------------------------------------------------------------------------
L8650:
        jsr     L8C15                           ; 8650 20 15 8C                  ..
        bcc     L8658                           ; 8653 90 03                    ..
        clv                                     ; 8655 B8                       .
        clc                                     ; 8656 18                       .
        rts                                     ; 8657 60                       `

; ----------------------------------------------------------------------------
L8658:
        jsr     L869B                           ; 8658 20 9B 86                  ..
        lda     #$FF                            ; 865B A9 FF                    ..
        sta     $2D                             ; 865D 85 2D                    .-
L865F:
        asl     $36                             ; 865F 06 36                    .6
        bcc     L8669                           ; 8661 90 06                    ..
        lda     $B2,x                           ; 8663 B5 B2                    ..
        beq     L8669                           ; 8665 F0 02                    ..
        stx     $2D                             ; 8667 86 2D                    .-
L8669:
        inx                                     ; 8669 E8                       .
        dey                                     ; 866A 88                       .
        beq     L8682                           ; 866B F0 15                    ..
        tya                                     ; 866D 98                       .
        and     #$03                            ; 866E 29 03                    ).
        bne     L865F                           ; 8670 D0 ED                    ..
        txa                                     ; 8672 8A                       .
        clc                                     ; 8673 18                       .
        adc     #$04                            ; 8674 69 04                    i.
        tax                                     ; 8676 AA                       .
        cpy     #$08                            ; 8677 C0 08                    ..
        bne     L865F                           ; 8679 D0 E4                    ..
        lda     $37                             ; 867B A5 37                    .7
        sta     $36                             ; 867D 85 36                    .6
        jmp     L865F                           ; 867F 4C 5F 86                 L_.

; ----------------------------------------------------------------------------
L8682:
        ldx     $38                             ; 8682 A6 38                    .8
        lda     $2D                             ; 8684 A5 2D                    .-
        bmi     L8699                           ; 8686 30 11                    0.
        lsr     a                               ; 8688 4A                       J
        lsr     a                               ; 8689 4A                       J
        lsr     a                               ; 868A 4A                       J
        clc                                     ; 868B 18                       .
        adc     $EA                             ; 868C 65 EA                    e.
        sbc     #$1A                            ; 868E E9 1A                    ..
        eor     #$FF                            ; 8690 49 FF                    I.
        sta     $2D                             ; 8692 85 2D                    .-
        bit     L8698                           ; 8694 2C 98 86                 ,..
        clc                                     ; 8697 18                       .
L8698:
        rts                                     ; 8698 60                       `

; ----------------------------------------------------------------------------
L8699:
        sec                                     ; 8699 38                       8
        rts                                     ; 869A 60                       `

; ----------------------------------------------------------------------------
L869B:
        lda     player1TetriminoCurrent,x       ; 869B B5 64                    .d
        asl     a                               ; 869D 0A                       .
        asl     a                               ; 869E 0A                       .
        ora     player1TetriminoOrientation,x   ; 869F 15 68                    .h
        asl     a                               ; 86A1 0A                       .
        tay                                     ; 86A2 A8                       .
        asl     a                               ; 86A3 0A                       .
        sta     $39                             ; 86A4 85 39                    .9
        lda     L86C3,y                         ; 86A6 B9 C3 86                 ...
        sta     $36                             ; 86A9 85 36                    .6
        lda     L86C4,y                         ; 86AB B9 C4 86                 ...
        sta     $37                             ; 86AE 85 37                    .7
        lda     player1TetriminoY,x             ; 86B0 B5 60                    .`
        sec                                     ; 86B2 38                       8
        sbc     $EA                             ; 86B3 E5 EA                    ..
        asl     a                               ; 86B5 0A                       .
        asl     a                               ; 86B6 0A                       .
        asl     a                               ; 86B7 0A                       .
        adc     player1TetriminoX,x             ; 86B8 75 62                    ub
        sec                                     ; 86BA 38                       8
        sbc     $EB                             ; 86BB E5 EB                    ..
        stx     $38                             ; 86BD 86 38                    .8
        tax                                     ; 86BF AA                       .
        ldy     #$10                            ; 86C0 A0 10                    ..
        rts                                     ; 86C2 60                       `

; ----------------------------------------------------------------------------
L86C3:
        .byte   $00                             ; 86C3 00                       .
L86C4:
        .byte   $00,$00,$00,$00,$00,$00,$00,$F0 ; 86C4 00 00 00 00 00 00 00 F0  ........
        .byte   $00,$44,$44,$F0,$00,$44,$44,$E4 ; 86CC 00 44 44 F0 00 44 44 E4  .DD..DD.
        .byte   $00,$8C,$80,$4E,$00,$4C,$40,$CC ; 86D4 00 8C 80 4E 00 4C 40 CC  ...N.L@.
        .byte   $00,$CC,$00,$CC,$00,$CC,$00,$E2 ; 86DC 00 CC 00 CC 00 CC 00 E2  ........
        .byte   $00,$C8,$80,$8E,$00,$44,$C0,$E8 ; 86E4 00 C8 80 8E 00 44 C0 E8  .....D..
        .byte   $00,$88,$C0,$2E,$00,$C4,$40     ; 86EC 00 88 C0 2E 00 C4 40     ......@
L86F3:
        .byte   $6C,$00,$8C,$40,$6C,$00,$8C,$40 ; 86F3 6C 00 8C 40 6C 00 8C 40  l..@l..@
        .byte   $C6,$00,$4C,$80,$C6,$00,$4C,$80 ; 86FB C6 00 4C 80 C6 00 4C 80  ..L...L.
        .byte   $01,$02,$02,$03,$04,$05,$05,$06 ; 8703 01 02 02 03 04 05 05 06  ........
        .byte   $01,$02,$02,$03,$04,$05,$05,$06 ; 870B 01 02 02 03 04 05 05 06  ........
        .byte   $01,$09,$03,$06,$04,$08,$03,$06 ; 8713 01 09 03 06 04 08 03 06  ........
        .byte   $04,$01,$07,$03,$04,$01,$0A,$06 ; 871B 04 01 07 03 04 01 0A 06  ........
        .byte   $0B,$0E,$0D,$0C,$0B,$0E,$0D,$0C ; 8723 0B 0E 0D 0C 0B 0E 0D 0C  ........
        .byte   $0B,$0E,$0D,$0C,$0B,$0E,$0D,$0C ; 872B 0B 0E 0D 0C 0B 0E 0D 0C  ........
        .byte   $01,$02,$0E,$06,$0B,$03,$05,$06 ; 8733 01 02 0E 06 0B 03 05 06  ........
        .byte   $04,$0D,$02,$03,$04,$05,$01,$0C ; 873B 04 0D 02 03 04 05 01 0C  ........
        .byte   $0B,$02,$03,$06,$04,$05,$0D,$03 ; 8743 0B 02 03 06 04 05 0D 03  ........
        .byte   $04,$01,$02,$0C,$01,$0E,$05,$06 ; 874B 04 01 02 0C 01 0E 05 06  ........
        .byte   $0B,$03,$01,$0C,$04,$0D,$0E,$06 ; 8753 0B 03 01 0C 04 0D 0E 06  ........
        .byte   $0B,$03,$01,$0C,$04,$0D,$0E,$06 ; 875B 0B 03 01 0C 04 0D 0E 06  ........
        .byte   $01,$0E,$0D,$03,$04,$0B,$0C,$06 ; 8763 01 0E 0D 03 04 0B 0C 06  ........
        .byte   $01,$0E,$0D,$03,$04,$0B,$0C,$06 ; 876B 01 0E 0D 03 04 0B 0C 06  ........
; ----------------------------------------------------------------------------
L8773:
        stx     $36                             ; 8773 86 36                    .6
        lda     #$00                            ; 8775 A9 00                    ..
        sta     $01CC,x                         ; 8777 9D CC 01                 ...
        lda     $EA                             ; 877A A5 EA                    ..
        clc                                     ; 877C 18                       .
        adc     #$01                            ; 877D 69 01                    i.
        asl     a                               ; 877F 0A                       .
        asl     a                               ; 8780 0A                       .
        asl     a                               ; 8781 0A                       .
        tay                                     ; 8782 A8                       .
        bit     playMode                        ; 8783 24 2F                    $/
        bpl     L8789                           ; 8785 10 02                    ..
        ldx     #$00                            ; 8787 A2 00                    ..
L8789:
        lda     playfieldIdPossible,x           ; 8789 BD 62 85                 .b.
        ldx     $36                             ; 878C A6 36                    .6
        sta     $37                             ; 878E 85 37                    .7
        lda     #$00                            ; 8790 A9 00                    ..
        sta     $36                             ; 8792 85 36                    .6
        lda     #$1A                            ; 8794 A9 1A                    ..
        clc                                     ; 8796 18                       .
        sbc     $EA                             ; 8797 E5 EA                    ..
        cmp     #$04                            ; 8799 C9 04                    ..
        bcc     L879F                           ; 879B 90 02                    ..
        lda     #$04                            ; 879D A9 04                    ..
L879F:
        sta     $39                             ; 879F 85 39                    .9
L87A1:
        lda     #$06                            ; 87A1 A9 06                    ..
        sta     $38                             ; 87A3 85 38                    .8
L87A5:
        iny                                     ; 87A5 C8                       .
        lda     ($36),y                         ; 87A6 B1 36                    .6
        cmp     #$10                            ; 87A8 C9 10                    ..
        bcc     L87D6                           ; 87AA 90 2A                    .*
        and     #$0F                            ; 87AC 29 0F                    ).
        beq     L87D6                           ; 87AE F0 26                    .&
        dec     $38                             ; 87B0 C6 38                    .8
        bne     L87A5                           ; 87B2 D0 F1                    ..
        tya                                     ; 87B4 98                       .
        and     #$F8                            ; 87B5 29 F8                    ).
        tay                                     ; 87B7 A8                       .
        lda     #$FE                            ; 87B8 A9 FE                    ..
        sta     ($36),y                         ; 87BA 91 36                    .6
        lda     #$1D                            ; 87BC A9 1D                    ..
        bit     playMode                        ; 87BE 24 2F                    $/
        bpl     L87C4                           ; 87C0 10 02                    ..
        lda     #$21                            ; 87C2 A9 21                    .!
L87C4:
        sta     $01CE,x                         ; 87C4 9D CE 01                 ...
        tya                                     ; 87C7 98                       .
        sta     $01D0,x                         ; 87C8 9D D0 01                 ...
        inc     $01CC,x                         ; 87CB FE CC 01                 ...
        lda     #$00                            ; 87CE A9 00                    ..
        sta     $01D2                           ; 87D0 8D D2 01                 ...
        jsr     L87FB                           ; 87D3 20 FB 87                  ..
L87D6:
        tya                                     ; 87D6 98                       .
        ora     #$07                            ; 87D7 09 07                    ..
        tay                                     ; 87D9 A8                       .
        iny                                     ; 87DA C8                       .
        dec     $39                             ; 87DB C6 39                    .9
        bne     L87A1                           ; 87DD D0 C2                    ..
        asl     $01CC,x                         ; 87DF 1E CC 01                 ...
        beq     L87FA                           ; 87E2 F0 16                    ..
        stx     $36                             ; 87E4 86 36                    .6
        txa                                     ; 87E6 8A                       .
        bit     playMode                        ; 87E7 24 2F                    $/
        bpl     L87ED                           ; 87E9 10 02                    ..
        lda     #$00                            ; 87EB A9 00                    ..
L87ED:
        ora     $01CC,x                         ; 87ED 1D CC 01                 ...
        tax                                     ; 87F0 AA                       .
        inc     player1FallTimer,x              ; 87F1 F6 6A                    .j
        ldx     $36                             ; 87F3 A6 36                    .6
        ldy     #$0A                            ; 87F5 A0 0A                    ..
        jsr     LA763                           ; 87F7 20 63 A7                  c.
L87FA:
        rts                                     ; 87FA 60                       `

; ----------------------------------------------------------------------------
L87FB:
        ldy     L8846,x                         ; 87FB BC 46 88                 .F.
L87FE:
        lda     oamStaging+16,y                 ; 87FE B9 10 05                 ...
        cmp     #$F7                            ; 8801 C9 F7                    ..
        beq     L880C                           ; 8803 F0 07                    ..
        tya                                     ; 8805 98                       .
        clc                                     ; 8806 18                       .
        adc     #$14                            ; 8807 69 14                    i.
        tay                                     ; 8809 A8                       .
        bne     L87FE                           ; 880A D0 F2                    ..
L880C:
        txa                                     ; 880C 8A                       .
        sta     oamStaging+18,y                 ; 880D 99 12 05                 ...
        sty     $38                             ; 8810 84 38                    .8
        ldy     playMode                        ; 8812 A4 2F                    ./
        iny                                     ; 8814 C8                       .
        tya                                     ; 8815 98                       .
        asl     a                               ; 8816 0A                       .
        cpx     #$01                            ; 8817 E0 01                    ..
        adc     #$00                            ; 8819 69 00                    i.
        tay                                     ; 881B A8                       .
        lda     L883A,y                         ; 881C B9 3A 88                 .:.
        ldy     $38                             ; 881F A4 38                    .8
        sta     oamStaging+19,y                 ; 8821 99 13 05                 ...
        lda     $01D0,x                         ; 8824 BD D0 01                 ...
        clc                                     ; 8827 18                       .
        adc     #$10                            ; 8828 69 10                    i.
        clc                                     ; 882A 18                       .
        sbc     ppuScrollYOffset                ; 882B ED F6 04                 ...
        sta     oamStaging+16,y                 ; 882E 99 10 05                 ...
        lda     #$5F                            ; 8831 A9 5F                    ._
        sta     oamStaging+17,y                 ; 8833 99 11 05                 ...
        ldy     $01D0,x                         ; 8836 BC D0 01                 ...
        rts                                     ; 8839 60                       `

; ----------------------------------------------------------------------------
L883A:
        .byte   $50,$50,$10,$00,$10,$A0         ; 883A 50 50 10 00 10 A0        PP....
L8840:
        .byte   $A8,$A8,$58,$00,$58,$E8         ; 8840 A8 A8 58 00 58 E8        ..X.X.
L8846:
        .byte   $40,$90                         ; 8846 40 90                    @.
; ----------------------------------------------------------------------------
L8848:
        lda     $01CE,x                         ; 8848 BD CE 01                 ...
        beq     L88C7                           ; 884B F0 7A                    .z
        stx     $3A                             ; 884D 86 3A                    .:
        ldy     L8846,x                         ; 884F BC 46 88                 .F.
        dec     $01CE,x                         ; 8852 DE CE 01                 ...
        lda     $01CE,x                         ; 8855 BD CE 01                 ...
        beq     L88C8                           ; 8858 F0 6E                    .n
        lsr     a                               ; 885A 4A                       J
        bcc     L88C7                           ; 885B 90 6A                    .j
        lda     #$14                            ; 885D A9 14                    ..
        sta     $3B                             ; 885F 85 3B                    .;
        lda     $01CC,x                         ; 8861 BD CC 01                 ...
        asl     a                               ; 8864 0A                       .
        adc     $01CC,x                         ; 8865 7D CC 01                 }..
        asl     a                               ; 8868 0A                       .
        sta     $37                             ; 8869 85 37                    .7
        lda     playMode                        ; 886B A5 2F                    ./
        clc                                     ; 886D 18                       .
        adc     #$01                            ; 886E 69 01                    i.
        asl     a                               ; 8870 0A                       .
        adc     $3A                             ; 8871 65 3A                    e:
        tax                                     ; 8873 AA                       .
L8874:
        lda     oamStaging,y                    ; 8874 B9 00 05                 ...
        cmp     #$F7                            ; 8877 C9 F7                    ..
        beq     L88BF                           ; 8879 F0 44                    .D
        lda     oamStaging+3,y                  ; 887B B9 03 05                 ...
        cmp     L883A,x                         ; 887E DD 3A 88                 .:.
        bne     L88A1                           ; 8881 D0 1E                    ..
        lda     oamStaging+1,y                  ; 8883 B9 01 05                 ...
        cmp     #$5C                            ; 8886 C9 5C                    .\
        bcc     L88A1                           ; 8888 90 17                    ..
        sbc     #$01                            ; 888A E9 01                    ..
        sta     $04FD,y                         ; 888C 99 FD 04                 ...
        lda     oamStaging,y                    ; 888F B9 00 05                 ...
        sta     $04FC,y                         ; 8892 99 FC 04                 ...
        lda     oamStaging+2,y                  ; 8895 B9 02 05                 ...
        sta     $04FE,y                         ; 8898 99 FE 04                 ...
        lda     oamStaging+3,y                  ; 889B B9 03 05                 ...
        sta     $04FF,y                         ; 889E 99 FF 04                 ...
L88A1:
        lda     oamStaging+1,y                  ; 88A1 B9 01 05                 ...
        cmp     #$5B                            ; 88A4 C9 5B                    .[
        bne     L88AB                           ; 88A6 D0 03                    ..
        jsr     L89E9                           ; 88A8 20 E9 89                  ..
L88AB:
        lda     oamStaging+3,y                  ; 88AB B9 03 05                 ...
        cmp     L8840,x                         ; 88AE DD 40 88                 .@.
        bcc     L88BA                           ; 88B1 90 07                    ..
        lda     #$F7                            ; 88B3 A9 F7                    ..
        sta     oamStaging,y                    ; 88B5 99 00 05                 ...
        bne     L88BF                           ; 88B8 D0 05                    ..
L88BA:
        adc     #$08                            ; 88BA 69 08                    i.
        sta     oamStaging+3,y                  ; 88BC 99 03 05                 ...
L88BF:
        iny                                     ; 88BF C8                       .
        iny                                     ; 88C0 C8                       .
        iny                                     ; 88C1 C8                       .
        iny                                     ; 88C2 C8                       .
        dec     $3B                             ; 88C3 C6 3B                    .;
        bne     L8874                           ; 88C5 D0 AD                    ..
L88C7:
        rts                                     ; 88C7 60                       `

; ----------------------------------------------------------------------------
L88C8:
        bit     playMode                        ; 88C8 24 2F                    $/
        bpl     L88CE                           ; 88CA 10 02                    ..
        ldx     #$00                            ; 88CC A2 00                    ..
L88CE:
        lda     playfieldIdPossible,x           ; 88CE BD 62 85                 .b.
        ldx     $3A                             ; 88D1 A6 3A                    .:
        sta     $3B                             ; 88D3 85 3B                    .;
        sta     $3D                             ; 88D5 85 3D                    .=
        jsr     L8A5B                           ; 88D7 20 5B 8A                  [.
        lda     $01D0,x                         ; 88DA BD D0 01                 ...
        sta     $3A                             ; 88DD 85 3A                    .:
        sta     $3C                             ; 88DF 85 3C                    .<
        bne     L88FC                           ; 88E1 D0 19                    ..
L88E3:
        lda     $3A                             ; 88E3 A5 3A                    .:
        sec                                     ; 88E5 38                       8
        sbc     #$08                            ; 88E6 E9 08                    ..
        cmp     #$30                            ; 88E8 C9 30                    .0
        bcs     L88F2                           ; 88EA B0 06                    ..
        jsr     L8ADB                           ; 88EC 20 DB 8A                  ..
        jmp     L8967                           ; 88EF 4C 67 89                 Lg.

; ----------------------------------------------------------------------------
L88F2:
        sta     $3A                             ; 88F2 85 3A                    .:
        ldy     #$00                            ; 88F4 A0 00                    ..
        lda     ($3A),y                         ; 88F6 B1 3A                    .:
        cmp     #$FE                            ; 88F8 C9 FE                    ..
        bne     L8905                           ; 88FA D0 09                    ..
L88FC:
        jsr     L89C3                           ; 88FC 20 C3 89                  ..
        jsr     L94E4                           ; 88FF 20 E4 94                  ..
        jmp     L88E3                           ; 8902 4C E3 88                 L..

; ----------------------------------------------------------------------------
L8905:
        iny                                     ; 8905 C8                       .
        lda     ($3A),y                         ; 8906 B1 3A                    .:
        iny                                     ; 8908 C8                       .
        bit     playMode                        ; 8909 24 2F                    $/
        bpl     L891F                           ; 890B 10 12                    ..
        ora     ($3A),y                         ; 890D 11 3A                    .:
        iny                                     ; 890F C8                       .
        ora     ($3A),y                         ; 8910 11 3A                    .:
        iny                                     ; 8912 C8                       .
        ora     ($3A),y                         ; 8913 11 3A                    .:
        iny                                     ; 8915 C8                       .
        ora     ($3A),y                         ; 8916 11 3A                    .:
        iny                                     ; 8918 C8                       .
        ora     ($3A),y                         ; 8919 11 3A                    .:
        beq     L88E3                           ; 891B F0 C6                    ..
        bne     L8935                           ; 891D D0 16                    ..
L891F:
        and     #$0F                            ; 891F 29 0F                    ).
        ora     ($3A),y                         ; 8921 11 3A                    .:
        iny                                     ; 8923 C8                       .
        ora     ($3A),y                         ; 8924 11 3A                    .:
        iny                                     ; 8926 C8                       .
        ora     ($3A),y                         ; 8927 11 3A                    .:
        iny                                     ; 8929 C8                       .
        ora     ($3A),y                         ; 892A 11 3A                    .:
        bne     L8935                           ; 892C D0 07                    ..
        iny                                     ; 892E C8                       .
        lda     ($3A),y                         ; 892F B1 3A                    .:
        and     #$F0                            ; 8931 29 F0                    ).
        beq     L88E3                           ; 8933 F0 AE                    ..
L8935:
        ldy     #$00                            ; 8935 A0 00                    ..
        lda     #$FE                            ; 8937 A9 FE                    ..
        sta     ($3A),y                         ; 8939 91 3A                    .:
        ldy     #$01                            ; 893B A0 01                    ..
        lda     ($3A),y                         ; 893D B1 3A                    .:
        sta     ($3C),y                         ; 893F 91 3C                    .<
        iny                                     ; 8941 C8                       .
        lda     ($3A),y                         ; 8942 B1 3A                    .:
        sta     ($3C),y                         ; 8944 91 3C                    .<
        iny                                     ; 8946 C8                       .
        lda     ($3A),y                         ; 8947 B1 3A                    .:
        sta     ($3C),y                         ; 8949 91 3C                    .<
        iny                                     ; 894B C8                       .
        lda     ($3A),y                         ; 894C B1 3A                    .:
        sta     ($3C),y                         ; 894E 91 3C                    .<
        iny                                     ; 8950 C8                       .
        lda     ($3A),y                         ; 8951 B1 3A                    .:
        sta     ($3C),y                         ; 8953 91 3C                    .<
        iny                                     ; 8955 C8                       .
        lda     ($3A),y                         ; 8956 B1 3A                    .:
        sta     ($3C),y                         ; 8958 91 3C                    .<
        jsr     L89C3                           ; 895A 20 C3 89                  ..
        lda     $3C                             ; 895D A5 3C                    .<
        sec                                     ; 895F 38                       8
        sbc     #$08                            ; 8960 E9 08                    ..
        sta     $3C                             ; 8962 85 3C                    .<
        jmp     L88E3                           ; 8964 4C E3 88                 L..

; ----------------------------------------------------------------------------
L8967:
        lda     gameStatePossible               ; 8967 A5 29                    .)
        bne     L8998                           ; 8969 D0 2D                    .-
        ldx     #$00                            ; 896B A2 00                    ..
        jsr     L897C                           ; 896D 20 7C 89                  |.
        beq     L8979                           ; 8970 F0 07                    ..
        ldx     #$01                            ; 8972 A2 01                    ..
        jsr     L897C                           ; 8974 20 7C 89                  |.
        bne     L8998                           ; 8977 D0 1F                    ..
L8979:
        jmp     L8CB5                           ; 8979 4C B5 8C                 L..

; ----------------------------------------------------------------------------
L897C:
        ldy     $78,x                           ; 897C B4 78                    .x
        cpy     #$2A                            ; 897E C0 2A                    .*
        bne     L8986                           ; 8980 D0 04                    ..
        .byte   $A0,$00,$94,$78                 ; 8982 A0 00 94 78              ...x
; ----------------------------------------------------------------------------
L8986:
        txa                                     ; 8986 8A                       .
        asl     a                               ; 8987 0A                       .
        asl     a                               ; 8988 0A                       .
        tax                                     ; 8989 AA                       .
        lda     player1LinesHundreds,x          ; 898A BD 25 04                 .%.
        cmp     L8999,y                         ; 898D D9 99 89                 ...
        bne     L8998                           ; 8990 D0 06                    ..
        lda     player1LinesTens,x              ; 8992 BD 26 04                 .&.
        cmp     L899A,y                         ; 8995 D9 9A 89                 ...
L8998:
        rts                                     ; 8998 60                       `

; ----------------------------------------------------------------------------
L8999:
        .byte   $30                             ; 8999 30                       0
L899A:
        .byte   $33,$30,$36,$30,$39,$31,$32,$31 ; 899A 33 30 36 30 39 31 32 31  30609121
        .byte   $35,$32,$30,$32,$35,$33,$30,$33 ; 89A2 35 32 30 32 35 33 30 33  52025303
        .byte   $35,$34,$30,$34,$35,$35,$30,$35 ; 89AA 35 34 30 34 35 35 30 35  54045505
        .byte   $35,$36,$30,$36,$35,$37,$30,$37 ; 89B2 35 36 30 36 35 37 30 37  56065707
        .byte   $35,$38,$30,$38,$35,$39,$30,$39 ; 89BA 35 38 30 38 35 39 30 39  58085909
        .byte   $35                             ; 89C2 35                       5
; ----------------------------------------------------------------------------
L89C3:
        ldy     #$01                            ; 89C3 A0 01                    ..
        lda     #$F0                            ; 89C5 A9 F0                    ..
        bit     playMode                        ; 89C7 24 2F                    $/
        bpl     L89CD                           ; 89C9 10 02                    ..
        lda     #$00                            ; 89CB A9 00                    ..
L89CD:
        sta     ($3A),y                         ; 89CD 91 3A                    .:
        iny                                     ; 89CF C8                       .
        lda     #$00                            ; 89D0 A9 00                    ..
        sta     ($3A),y                         ; 89D2 91 3A                    .:
        iny                                     ; 89D4 C8                       .
        sta     ($3A),y                         ; 89D5 91 3A                    .:
        iny                                     ; 89D7 C8                       .
        sta     ($3A),y                         ; 89D8 91 3A                    .:
        iny                                     ; 89DA C8                       .
        sta     ($3A),y                         ; 89DB 91 3A                    .:
        lda     #$0F                            ; 89DD A9 0F                    ..
        bit     playMode                        ; 89DF 24 2F                    $/
        bpl     L89E5                           ; 89E1 10 02                    ..
        lda     #$00                            ; 89E3 A9 00                    ..
L89E5:
        iny                                     ; 89E5 C8                       .
        sta     ($3A),y                         ; 89E6 91 3A                    .:
        rts                                     ; 89E8 60                       `

; ----------------------------------------------------------------------------
L89E9:
        lda     oamStaging+3,y                  ; 89E9 B9 03 05                 ...
        sec                                     ; 89EC 38                       8
        sbc     L883A,x                         ; 89ED FD 3A 88                 .:.
        stx     $36                             ; 89F0 86 36                    .6
        lsr     a                               ; 89F2 4A                       J
        lsr     a                               ; 89F3 4A                       J
        lsr     a                               ; 89F4 4A                       J
        adc     $37                             ; 89F5 65 37                    e7
        pha                                     ; 89F7 48                       H
        jsr     LA3DB                           ; 89F8 20 DB A3                  ..
        pla                                     ; 89FB 68                       h
        clc                                     ; 89FC 18                       .
        adc     #$1F                            ; 89FD 69 1F                    i.
        sta     ppuDataAddress1,x               ; 89FF 95 08                    ..
        lda     #$8A                            ; 8A01 A9 8A                    ..
        adc     #$00                            ; 8A03 69 00                    i.
        sta     ppuDataAddress1+1,x             ; 8A05 95 09                    ..
        lda     #$08                            ; 8A07 A9 08                    ..
        sta     $17,x                           ; 8A09 95 17                    ..
        lda     oamStaging,y                    ; 8A0B B9 00 05                 ...
        sec                                     ; 8A0E 38                       8
        adc     ppuScrollYOffset                ; 8A0F 6D F6 04                 m..
        asl     a                               ; 8A12 0A                       .
        rol     $17,x                           ; 8A13 36 17                    6.
        asl     a                               ; 8A15 0A                       .
        rol     $17,x                           ; 8A16 36 17                    6.
        sta     $16,x                           ; 8A18 95 16                    ..
        lda     oamStaging+3,y                  ; 8A1A B9 03 05                 ...
        lsr     a                               ; 8A1D 4A                       J
        lsr     a                               ; 8A1E 4A                       J
        lsr     a                               ; 8A1F 4A                       J
        ora     $16,x                           ; 8A20 15 16                    ..
        sta     $16,x                           ; 8A22 95 16                    ..
        lda     #$01                            ; 8A24 A9 01                    ..
        sta     $24,x                           ; 8A26 95 24                    .$
        ldx     $36                             ; 8A28 A6 36                    .6
        rts                                     ; 8A2A 60                       `

; ----------------------------------------------------------------------------
lineClearSingle:
        .byte   $20,$53,$49,$4E,$47,$4C,$45,$20 ; 8A2B 20 53 49 4E 47 4C 45 20   SINGLE 
        .byte   $20,$20                         ; 8A33 20 20                      
twoSpacesAfterSingle:
        .byte   $20,$20                         ; 8A35 20 20                      
lineClearDouble:
        .byte   $20,$44,$4F,$55,$42,$4C,$45,$20 ; 8A37 20 44 4F 55 42 4C 45 20   DOUBLE 
        .byte   $20,$20                         ; 8A3F 20 20                      
twoSpacesAfterDouble:
        .byte   $20,$20                         ; 8A41 20 20                      
lineClearTriple:
        .byte   $20,$54,$52,$49,$50,$4C,$45,$20 ; 8A43 20 54 52 49 50 4C 45 20   TRIPLE 
        .byte   $20,$20                         ; 8A4B 20 20                      
twoSpacesAfterTriple:
        .byte   $20,$20                         ; 8A4D 20 20                      
lineClearTetris:
        .byte   $20,$54,$45,$54,$52,$49,$53,$20 ; 8A4F 20 54 45 54 52 49 53 20   TETRIS 
        .byte   $20,$20                         ; 8A57 20 20                      
twoSpacesAfterTetris:
        .byte   $20,$20                         ; 8A59 20 20                      
; ----------------------------------------------------------------------------
L8A5B:
        lda     $01D0,x                         ; 8A5B BD D0 01                 ...
        sta     $3A                             ; 8A5E 85 3A                    .:
        stx     $36                             ; 8A60 86 36                    .6
L8A62:
        lda     $3A                             ; 8A62 A5 3A                    .:
        sec                                     ; 8A64 38                       8
        sbc     #$08                            ; 8A65 E9 08                    ..
        sta     $3A                             ; 8A67 85 3A                    .:
        cmp     #$28                            ; 8A69 C9 28                    .(
        bcs     L8A70                           ; 8A6B B0 03                    ..
        ldx     $36                             ; 8A6D A6 36                    .6
        rts                                     ; 8A6F 60                       `

; ----------------------------------------------------------------------------
L8A70:
        ldy     #$08                            ; 8A70 A0 08                    ..
        lda     ($3A),y                         ; 8A72 B1 3A                    .:
        cmp     #$FE                            ; 8A74 C9 FE                    ..
        bne     L8A62                           ; 8A76 D0 EA                    ..
        ldy     #$10                            ; 8A78 A0 10                    ..
        jsr     L8A85                           ; 8A7A 20 85 8A                  ..
        ldy     #$00                            ; 8A7D A0 00                    ..
        jsr     L8A85                           ; 8A7F 20 85 8A                  ..
        jmp     L8A62                           ; 8A82 4C 62 8A                 Lb.

; ----------------------------------------------------------------------------
L8A85:
        sty     $38                             ; 8A85 84 38                    .8
        lda     #$06                            ; 8A87 A9 06                    ..
        sta     $39                             ; 8A89 85 39                    .9
        lda     ($3A),y                         ; 8A8B B1 3A                    .:
        cmp     #$FE                            ; 8A8D C9 FE                    ..
        beq     L8ABA                           ; 8A8F F0 29                    .)
        lda     #$FD                            ; 8A91 A9 FD                    ..
        sta     ($3A),y                         ; 8A93 91 3A                    .:
L8A95:
        iny                                     ; 8A95 C8                       .
        lda     ($3A),y                         ; 8A96 B1 3A                    .:
        lsr     a                               ; 8A98 4A                       J
        lsr     a                               ; 8A99 4A                       J
        lsr     a                               ; 8A9A 4A                       J
        lsr     a                               ; 8A9B 4A                       J
        ora     $38                             ; 8A9C 05 38                    .8
        tax                                     ; 8A9E AA                       .
        lda     L8ABB,x                         ; 8A9F BD BB 8A                 ...
        asl     a                               ; 8AA2 0A                       .
        asl     a                               ; 8AA3 0A                       .
        asl     a                               ; 8AA4 0A                       .
        asl     a                               ; 8AA5 0A                       .
        sta     $37                             ; 8AA6 85 37                    .7
        lda     ($3A),y                         ; 8AA8 B1 3A                    .:
        and     #$0F                            ; 8AAA 29 0F                    ).
        ora     $38                             ; 8AAC 05 38                    .8
        tax                                     ; 8AAE AA                       .
        lda     L8ABB,x                         ; 8AAF BD BB 8A                 ...
        ora     $37                             ; 8AB2 05 37                    .7
        sta     ($3A),y                         ; 8AB4 91 3A                    .:
        dec     $39                             ; 8AB6 C6 39                    .9
        bne     L8A95                           ; 8AB8 D0 DB                    ..
L8ABA:
        rts                                     ; 8ABA 60                       `

; ----------------------------------------------------------------------------
L8ABB:
        .byte   $00,$01,$02,$03,$0F,$06,$06,$07 ; 8ABB 00 01 02 03 0F 06 06 07  ........
        .byte   $0D,$02,$0C,$01,$0C,$0D,$03,$0F ; 8AC3 0D 02 0C 01 0C 0D 03 0F  ........
        .byte   $00,$01,$02,$03,$04,$04,$0F,$02 ; 8ACB 00 01 02 03 04 04 0F 02  ........
        .byte   $0B,$09,$0E,$0B,$03,$01,$0E,$0F ; 8AD3 0B 09 0E 0B 03 01 0E 0F  ........
; ----------------------------------------------------------------------------
L8ADB:
        lda     #$00                            ; 8ADB A9 00                    ..
        sta     $3A                             ; 8ADD 85 3A                    .:
        bit     playMode                        ; 8ADF 24 2F                    $/
        bpl     L8AE5                           ; 8AE1 10 02                    ..
        ldx     #$02                            ; 8AE3 A2 02                    ..
L8AE5:
        lda     L855C,x                         ; 8AE5 BD 5C 85                 .\.
        sta     $ED                             ; 8AE8 85 ED                    ..
        lda     L855F,x                         ; 8AEA BD 5F 85                 ._.
        sta     $EE                             ; 8AED 85 EE                    ..
        ldy     #$30                            ; 8AEF A0 30                    .0
L8AF1:
        lda     ($3A),y                         ; 8AF1 B1 3A                    .:
        cmp     #$FF                            ; 8AF3 C9 FF                    ..
        bne     L8B0E                           ; 8AF5 D0 17                    ..
L8AF7:
        lda     $ED                             ; 8AF7 A5 ED                    ..
        clc                                     ; 8AF9 18                       .
        adc     #$20                            ; 8AFA 69 20                    i 
        sta     $ED                             ; 8AFC 85 ED                    ..
        lda     $EE                             ; 8AFE A5 EE                    ..
        adc     #$00                            ; 8B00 69 00                    i.
        sta     $EE                             ; 8B02 85 EE                    ..
        tya                                     ; 8B04 98                       .
        clc                                     ; 8B05 18                       .
        adc     #$08                            ; 8B06 69 08                    i.
        tay                                     ; 8B08 A8                       .
        cpy     #$D0                            ; 8B09 C0 D0                    ..
        bcc     L8AF1                           ; 8B0B 90 E4                    ..
        rts                                     ; 8B0D 60                       `

; ----------------------------------------------------------------------------
L8B0E:
        lda     #$FF                            ; 8B0E A9 FF                    ..
        sta     ($3A),y                         ; 8B10 91 3A                    .:
        jsr     LA3DB                           ; 8B12 20 DB A3                  ..
        sty     $39                             ; 8B15 84 39                    .9
        jsr     L849D                           ; 8B17 20 9D 84                  ..
        lda     $48                             ; 8B1A A5 48                    .H
        sta     ppuDataAddress1,x               ; 8B1C 95 08                    ..
        lda     $49                             ; 8B1E A5 49                    .I
        sta     ppuDataAddress1+1,x             ; 8B20 95 09                    ..
        lda     $ED                             ; 8B22 A5 ED                    ..
        sta     $16,x                           ; 8B24 95 16                    ..
        lda     $EE                             ; 8B26 A5 EE                    ..
        sta     $17,x                           ; 8B28 95 17                    ..
        lda     $36                             ; 8B2A A5 36                    .6
        sta     $24,x                           ; 8B2C 95 24                    .$
        clc                                     ; 8B2E 18                       .
        adc     $48                             ; 8B2F 65 48                    eH
        sta     $48                             ; 8B31 85 48                    .H
        ldy     $39                             ; 8B33 A4 39                    .9
        bne     L8AF7                           ; 8B35 D0 C0                    ..
L8B37:
        lda     gameStatePossible               ; 8B37 A5 29                    .)
        cmp     #$F9                            ; 8B39 C9 F9                    ..
        beq     L8B45                           ; 8B3B F0 08                    ..
        cmp     #$FB                            ; 8B3D C9 FB                    ..
        beq     L8B45                           ; 8B3F F0 04                    ..
        cmp     #$03                            ; 8B41 C9 03                    ..
        bcs     L8B83                           ; 8B43 B0 3E                    .>
L8B45:
        ldx     #$00                            ; 8B45 A2 00                    ..
        lda     #$00                            ; 8B47 A9 00                    ..
        sta     $3D                             ; 8B49 85 3D                    .=
L8B4B:
        lda     player1TetriminoCurrent,x       ; 8B4B B5 64                    .d
        asl     a                               ; 8B4D 0A                       .
        asl     a                               ; 8B4E 0A                       .
        cpx     #$02                            ; 8B4F E0 02                    ..
        bcs     L8B55                           ; 8B51 B0 02                    ..
        ora     player1TetriminoOrientation,x   ; 8B53 15 68                    .h
L8B55:
        asl     a                               ; 8B55 0A                       .
        tay                                     ; 8B56 A8                       .
        asl     a                               ; 8B57 0A                       .
        sta     $3B                             ; 8B58 85 3B                    .;
        lda     L86C3,y                         ; 8B5A B9 C3 86                 ...
        sta     $36                             ; 8B5D 85 36                    .6
        lda     L86C4,y                         ; 8B5F B9 C4 86                 ...
        sta     $37                             ; 8B62 85 37                    .7
        ora     $36                             ; 8B64 05 36                    .6
        bne     L8B84                           ; 8B66 D0 1C                    ..
        lda     #$F7                            ; 8B68 A9 F7                    ..
        ldy     $3D                             ; 8B6A A4 3D                    .=
        sta     oamStaging,y                    ; 8B6C 99 00 05                 ...
        sta     oamStaging+4,y                  ; 8B6F 99 04 05                 ...
        sta     oamStaging+8,y                  ; 8B72 99 08 05                 ...
        sta     oamStaging+12,y                 ; 8B75 99 0C 05                 ...
        tya                                     ; 8B78 98                       .
        clc                                     ; 8B79 18                       .
        adc     #$10                            ; 8B7A 69 10                    i.
        sta     $3D                             ; 8B7C 85 3D                    .=
L8B7E:
        inx                                     ; 8B7E E8                       .
        cpx     #$04                            ; 8B7F E0 04                    ..
        bcc     L8B4B                           ; 8B81 90 C8                    ..
L8B83:
        rts                                     ; 8B83 60                       `

; ----------------------------------------------------------------------------
L8B84:
        stx     $3C                             ; 8B84 86 3C                    .<
        lda     player1TetriminoY,x             ; 8B86 B5 60                    .`
        ldy     player1TetriminoX,x             ; 8B88 B4 62                    .b
        cpx     #$02                            ; 8B8A E0 02                    ..
        bcc     L8B93                           ; 8B8C 90 05                    ..
        ldy     L8C11,x                         ; 8B8E BC 11 8C                 ...
        lda     #$01                            ; 8B91 A9 01                    ..
L8B93:
        bit     playMode                        ; 8B93 24 2F                    $/
        bpl     L8BA1                           ; 8B95 10 0A                    ..
        pha                                     ; 8B97 48                       H
        tya                                     ; 8B98 98                       .
        clc                                     ; 8B99 18                       .
        adc     L8C0F,x                         ; 8B9A 7D 0F 8C                 }..
        tay                                     ; 8B9D A8                       .
        pla                                     ; 8B9E 68                       h
        ldx     #$04                            ; 8B9F A2 04                    ..
L8BA1:
        asl     a                               ; 8BA1 0A                       .
        asl     a                               ; 8BA2 0A                       .
        asl     a                               ; 8BA3 0A                       .
        adc     #$0F                            ; 8BA4 69 0F                    i.
        sec                                     ; 8BA6 38                       8
        sbc     ppuScrollYOffset                ; 8BA7 ED F6 04                 ...
        sta     $39                             ; 8BAA 85 39                    .9
        tya                                     ; 8BAC 98                       .
        asl     a                               ; 8BAD 0A                       .
        asl     a                               ; 8BAE 0A                       .
        asl     a                               ; 8BAF 0A                       .
        adc     L8C0A,x                         ; 8BB0 7D 0A 8C                 }..
        sta     $38                             ; 8BB3 85 38                    .8
L8BB5:
        ldx     #$08                            ; 8BB5 A2 08                    ..
L8BB7:
        asl     $36                             ; 8BB7 06 36                    .6
        bcc     L8BDF                           ; 8BB9 90 24                    .$
        ldy     $3B                             ; 8BBB A4 3B                    .;
        lda     L86F3,y                         ; 8BBD B9 F3 86                 ...
        iny                                     ; 8BC0 C8                       .
        sty     $3B                             ; 8BC1 84 3B                    .;
        ldy     $3D                             ; 8BC3 A4 3D                    .=
        sta     oamStaging+1,y                  ; 8BC5 99 01 05                 ...
        lda     $3C                             ; 8BC8 A5 3C                    .<
        ora     #$20                            ; 8BCA 09 20                    . 
        sta     oamStaging+2,y                  ; 8BCC 99 02 05                 ...
        lda     $38                             ; 8BCF A5 38                    .8
        sta     oamStaging+3,y                  ; 8BD1 99 03 05                 ...
        lda     $39                             ; 8BD4 A5 39                    .9
        sta     oamStaging,y                    ; 8BD6 99 00 05                 ...
        iny                                     ; 8BD9 C8                       .
        iny                                     ; 8BDA C8                       .
        iny                                     ; 8BDB C8                       .
        iny                                     ; 8BDC C8                       .
        sty     $3D                             ; 8BDD 84 3D                    .=
L8BDF:
        lda     $38                             ; 8BDF A5 38                    .8
        clc                                     ; 8BE1 18                       .
        adc     #$08                            ; 8BE2 69 08                    i.
        sta     $38                             ; 8BE4 85 38                    .8
        dex                                     ; 8BE6 CA                       .
        txa                                     ; 8BE7 8A                       .
        and     #$03                            ; 8BE8 29 03                    ).
        bne     L8BB7                           ; 8BEA D0 CB                    ..
        lda     $38                             ; 8BEC A5 38                    .8
        clc                                     ; 8BEE 18                       .
        adc     #$E0                            ; 8BEF 69 E0                    i.
        sta     $38                             ; 8BF1 85 38                    .8
        lda     $39                             ; 8BF3 A5 39                    .9
        clc                                     ; 8BF5 18                       .
        adc     #$08                            ; 8BF6 69 08                    i.
        sta     $39                             ; 8BF8 85 39                    .9
        txa                                     ; 8BFA 8A                       .
        bne     L8BB7                           ; 8BFB D0 BA                    ..
        lda     $37                             ; 8BFD A5 37                    .7
        stx     $37                             ; 8BFF 86 37                    .7
        sta     $36                             ; 8C01 85 36                    .6
        bne     L8BB5                           ; 8C03 D0 B0                    ..
        ldx     $3C                             ; 8C05 A6 3C                    .<
        jmp     L8B7E                           ; 8C07 4C 7E 8B                 L~.

; ----------------------------------------------------------------------------
L8C0A:
        .byte   $F8,$88,$F8,$88,$40             ; 8C0A F8 88 F8 88 40           ....@
L8C0F:
        .byte   $00,$00                         ; 8C0F 00 00                    ..
L8C11:
        .byte   $F7,$09,$03,$09                 ; 8C11 F7 09 03 09              ....
; ----------------------------------------------------------------------------
L8C15:
        stx     $3C                             ; 8C15 86 3C                    .<
        txa                                     ; 8C17 8A                       .
        eor     #$01                            ; 8C18 49 01                    I.
        tay                                     ; 8C1A A8                       .
        lda     player1TetriminoY,x             ; 8C1B B5 60                    .`
        sec                                     ; 8C1D 38                       8
        sbc     player1TetriminoY,y             ; 8C1E F9 60 00                 .`.
        clc                                     ; 8C21 18                       .
        adc     #$03                            ; 8C22 69 03                    i.
        bmi     L8C9F                           ; 8C24 30 79                    0y
        cmp     #$07                            ; 8C26 C9 07                    ..
        bcs     L8C9F                           ; 8C28 B0 75                    .u
        sta     $36                             ; 8C2A 85 36                    .6
        bit     playMode                        ; 8C2C 24 2F                    $/
        bpl     L8C9F                           ; 8C2E 10 6F                    .o
        lda     player1TetriminoX,x             ; 8C30 B5 62                    .b
        sec                                     ; 8C32 38                       8
        sbc     player1TetriminoX,y             ; 8C33 F9 62 00                 .b.
        clc                                     ; 8C36 18                       .
        adc     #$03                            ; 8C37 69 03                    i.
        bmi     L8C9F                           ; 8C39 30 64                    0d
        cmp     #$07                            ; 8C3B C9 07                    ..
        bcs     L8C9F                           ; 8C3D B0 60                    .`
        sta     $37                             ; 8C3F 85 37                    .7
        lda     player1TetriminoCurrent,x       ; 8C41 B5 64                    .d
        asl     a                               ; 8C43 0A                       .
        asl     a                               ; 8C44 0A                       .
        ora     player1TetriminoOrientation,x   ; 8C45 15 68                    .h
        asl     a                               ; 8C47 0A                       .
        tax                                     ; 8C48 AA                       .
        lda     player1TetriminoCurrent,y       ; 8C49 B9 64 00                 .d.
        beq     L8C9F                           ; 8C4C F0 51                    .Q
        asl     a                               ; 8C4E 0A                       .
        asl     a                               ; 8C4F 0A                       .
        ora     player1TetriminoOrientation,y   ; 8C50 19 68 00                 .h.
        asl     a                               ; 8C53 0A                       .
        tay                                     ; 8C54 A8                       .
        lda     L86C3,x                         ; 8C55 BD C3 86                 ...
        sta     $38                             ; 8C58 85 38                    .8
        lda     L86C4,x                         ; 8C5A BD C4 86                 ...
        sta     $39                             ; 8C5D 85 39                    .9
        ldx     $36                             ; 8C5F A6 36                    .6
        lda     L8CA7,x                         ; 8C61 BD A7 8C                 ...
        asl     a                               ; 8C64 0A                       .
        asl     a                               ; 8C65 0A                       .
        ldx     $37                             ; 8C66 A6 37                    .7
        clc                                     ; 8C68 18                       .
        adc     L8CA7,x                         ; 8C69 7D A7 8C                 }..
        tax                                     ; 8C6C AA                       .
        beq     L8C81                           ; 8C6D F0 12                    ..
        bmi     L8C7A                           ; 8C6F 30 09                    0.
L8C71:
        lsr     $38                             ; 8C71 46 38                    F8
        ror     $39                             ; 8C73 66 39                    f9
        dex                                     ; 8C75 CA                       .
        bne     L8C71                           ; 8C76 D0 F9                    ..
        beq     L8C81                           ; 8C78 F0 07                    ..
L8C7A:
        asl     $39                             ; 8C7A 06 39                    .9
        rol     $38                             ; 8C7C 26 38                    &8
        inx                                     ; 8C7E E8                       .
        bne     L8C7A                           ; 8C7F D0 F9                    ..
L8C81:
        ldx     $37                             ; 8C81 A6 37                    .7
        lda     $38                             ; 8C83 A5 38                    .8
        and     L8CAE,x                         ; 8C85 3D AE 8C                 =..
        sta     $38                             ; 8C88 85 38                    .8
        lda     $39                             ; 8C8A A5 39                    .9
        and     L8CAE,x                         ; 8C8C 3D AE 8C                 =..
        sta     $39                             ; 8C8F 85 39                    .9
        lda     L86C3,y                         ; 8C91 B9 C3 86                 ...
        and     $38                             ; 8C94 25 38                    %8
        bne     L8CA3                           ; 8C96 D0 0B                    ..
        lda     L86C4,y                         ; 8C98 B9 C4 86                 ...
        and     $39                             ; 8C9B 25 39                    %9
        bne     L8CA3                           ; 8C9D D0 04                    ..
L8C9F:
        ldx     $3C                             ; 8C9F A6 3C                    .<
        clc                                     ; 8CA1 18                       .
        rts                                     ; 8CA2 60                       `

; ----------------------------------------------------------------------------
L8CA3:
        ldx     $3C                             ; 8CA3 A6 3C                    .<
        sec                                     ; 8CA5 38                       8
        rts                                     ; 8CA6 60                       `

; ----------------------------------------------------------------------------
L8CA7:
        .byte   $FD,$FE,$FF,$00,$01,$02,$03     ; 8CA7 FD FE FF 00 01 02 03     .......
L8CAE:
        .byte   $88,$CC,$EE,$FF,$77,$33,$11     ; 8CAE 88 CC EE FF 77 33 11     ....w3.
; ----------------------------------------------------------------------------
L8CB5:
        lda     #$03                            ; 8CB5 A9 03                    ..
        sta     gameStatePossible               ; 8CB7 85 29                    .)
        inc     $78                             ; 8CB9 E6 78                    .x
        inc     $78                             ; 8CBB E6 78                    .x
        inc     $79                             ; 8CBD E6 79                    .y
        inc     $79                             ; 8CBF E6 79                    .y
        ldx     #$01                            ; 8CC1 A2 01                    ..
        lda     $4A,x                           ; 8CC3 B5 4A                    .J
        beq     L8CCB                           ; 8CC5 F0 04                    ..
        lda     player1TetriminoCurrent,x       ; 8CC7 B5 64                    .d
        beq     L8CCC                           ; 8CC9 F0 01                    ..
L8CCB:
        dex                                     ; 8CCB CA                       .
L8CCC:
        jsr     getNextTetrimino                ; 8CCC 20 29 99                  ).
        lda     #$00                            ; 8CCF A9 00                    ..
        sta     player1FallTimer                ; 8CD1 85 6A                    .j
        lda     #$F7                            ; 8CD3 A9 F7                    ..
        ldx     #$3C                            ; 8CD5 A2 3C                    .<
L8CD7:
        sta     oamStaging,x                    ; 8CD7 9D 00 05                 ...
        dex                                     ; 8CDA CA                       .
        dex                                     ; 8CDB CA                       .
        dex                                     ; 8CDC CA                       .
        dex                                     ; 8CDD CA                       .
        bpl     L8CD7                           ; 8CDE 10 F7                    ..
        lda     #$08                            ; 8CE0 A9 08                    ..
        jmp     possibleSetSoundOrMusic         ; 8CE2 4C B1 CF                 L..

; ----------------------------------------------------------------------------
L8CE5:
        lda     gameStatePossible               ; 8CE5 A5 29                    .)
        cmp     #$03                            ; 8CE7 C9 03                    ..
        bne     L8D0D                           ; 8CE9 D0 22                    ."
        lda     player1FallTimer                ; 8CEB A5 6A                    .j
        cmp     #$04                            ; 8CED C9 04                    ..
        beq     L8D0E                           ; 8CEF F0 1D                    ..
        cmp     #$0D                            ; 8CF1 C9 0D                    ..
        bcc     L8D00                           ; 8CF3 90 0B                    ..
        bne     L8CFA                           ; 8CF5 D0 03                    ..
        jsr     L8D6B                           ; 8CF7 20 6B 8D                  k.
L8CFA:
        jsr     L8EA2                           ; 8CFA 20 A2 8E                  ..
        jsr     L9035                           ; 8CFD 20 35 90                  5.
L8D00:
        lda     frameCounterLow                 ; 8D00 A5 32                    .2
        and     #$0F                            ; 8D02 29 0F                    ).
        bne     L8D0D                           ; 8D04 D0 07                    ..
        inc     player1FallTimer                ; 8D06 E6 6A                    .j
        bne     L8D0D                           ; 8D08 D0 03                    ..
        jsr     L90B0                           ; 8D0A 20 B0 90                  ..
L8D0D:
        rts                                     ; 8D0D 60                       `

; ----------------------------------------------------------------------------
L8D0E:
        inc     player1FallTimer                ; 8D0E E6 6A                    .j
        lda     $01D2                           ; 8D10 AD D2 01                 ...
        bne     L8D19                           ; 8D13 D0 04                    ..
        .byte   $A9,$0B,$85,$6A                 ; 8D15 A9 0B 85 6A              ...j
; ----------------------------------------------------------------------------
L8D19:
        lda     #$0B                            ; 8D19 A9 0B                    ..
        ldy     playMode                        ; 8D1B A4 2F                    ./
        bmi     L8D3C                           ; 8D1D 30 1D                    0.
        beq     L8D3A                           ; 8D1F F0 19                    ..
        ldy     $4B                             ; 8D21 A4 4B                    .K
        beq     L8D36                           ; 8D23 F0 11                    ..
        lda     #$0A                            ; 8D25 A9 0A                    ..
        jsr     LB603                           ; 8D27 20 03 B6                  ..
        ldy     #$01                            ; 8D2A A0 01                    ..
        jsr     L9177                           ; 8D2C 20 77 91                  w.
        lda     #$04                            ; 8D2F A9 04                    ..
        ldy     #$0B                            ; 8D31 A0 0B                    ..
        jsr     LA75E                           ; 8D33 20 5E A7                  ^.
L8D36:
        ldy     $4A                             ; 8D36 A4 4A                    .J
        beq     L8D50                           ; 8D38 F0 16                    ..
L8D3A:
        lda     #$09                            ; 8D3A A9 09                    ..
L8D3C:
        jsr     LB603                           ; 8D3C 20 03 B6                  ..
        ldy     playMode                        ; 8D3F A4 2F                    ./
        cpy     #$01                            ; 8D41 C0 01                    ..
        bne     L8D46                           ; 8D43 D0 01                    ..
        .byte   $88                             ; 8D45 88                       .
; ----------------------------------------------------------------------------
L8D46:
        jsr     L9177                           ; 8D46 20 77 91                  w.
        lda     #$00                            ; 8D49 A9 00                    ..
        ldy     #$0B                            ; 8D4B A0 0B                    ..
        jsr     LA75E                           ; 8D4D 20 5E A7                  ^.
L8D50:
        lda     #$00                            ; 8D50 A9 00                    ..
        ldx     #$17                            ; 8D52 A2 17                    ..
L8D54:
        sta     $0180,x                         ; 8D54 9D 80 01                 ...
        dex                                     ; 8D57 CA                       .
        bpl     L8D54                           ; 8D58 10 FA                    ..
        lda     #$05                            ; 8D5A A9 05                    ..
        sta     $0198                           ; 8D5C 8D 98 01                 ...
        sta     $0199                           ; 8D5F 8D 99 01                 ...
        lda     #$30                            ; 8D62 A9 30                    .0
        sta     $018B                           ; 8D64 8D 8B 01                 ...
        sta     $018F                           ; 8D67 8D 8F 01                 ...
        rts                                     ; 8D6A 60                       `

; ----------------------------------------------------------------------------
L8D6B:
        lda     #$7C                            ; 8D6B A9 7C                    .|
        sta     player1FallTimer                ; 8D6D 85 6A                    .j
        lda     #$0D                            ; 8D6F A9 0D                    ..
        jsr     possibleSetSoundOrMusic         ; 8D71 20 B1 CF                  ..
        lda     $00                             ; 8D74 A5 00                    ..
        ora     #$08                            ; 8D76 09 08                    ..
        sta     $00                             ; 8D78 85 00                    ..
        jsr     L972E                           ; 8D7A 20 2E 97                  ..
        lda     #$05                            ; 8D7D A9 05                    ..
        jsr     LA6BE                           ; 8D7F 20 BE A6                  ..
        bit     playMode                        ; 8D82 24 2F                    $/
        bmi     L8D8B                           ; 8D84 30 05                    0.
        lda     #$0C                            ; 8D86 A9 0C                    ..
        jsr     LB603                           ; 8D88 20 03 B6                  ..
L8D8B:
        lda     $4A                             ; 8D8B A5 4A                    .J
        beq     L8D94                           ; 8D8D F0 05                    ..
        lda     $72                             ; 8D8F A5 72                    .r
        asl     a                               ; 8D91 0A                       .
        adc     $70                             ; 8D92 65 70                    ep
L8D94:
        sta     $36                             ; 8D94 85 36                    .6
        lda     $4B                             ; 8D96 A5 4B                    .K
        beq     L8D9F                           ; 8D98 F0 05                    ..
        lda     $73                             ; 8D9A A5 73                    .s
        asl     a                               ; 8D9C 0A                       .
        adc     $71                             ; 8D9D 65 71                    eq
L8D9F:
        sec                                     ; 8D9F 38                       8
        adc     $36                             ; 8DA0 65 36                    e6
        cmp     #$08                            ; 8DA2 C9 08                    ..
        bcc     L8DA8                           ; 8DA4 90 02                    ..
        .byte   $A9,$08                         ; 8DA6 A9 08                    ..
; ----------------------------------------------------------------------------
L8DA8:
        sta     $36                             ; 8DA8 85 36                    .6
        clc                                     ; 8DAA 18                       .
        adc     #$06                            ; 8DAB 69 06                    i.
        ldy     #$06                            ; 8DAD A0 06                    ..
        bit     playMode                        ; 8DAF 24 2F                    $/
        bmi     L8DBD                           ; 8DB1 30 0A                    0.
        ldy     #$00                            ; 8DB3 A0 00                    ..
        lda     $36                             ; 8DB5 A5 36                    .6
        cmp     #$06                            ; 8DB7 C9 06                    ..
        bcc     L8DBD                           ; 8DB9 90 02                    ..
        .byte   $A9,$06                         ; 8DBB A9 06                    ..
; ----------------------------------------------------------------------------
L8DBD:
        sta     $36                             ; 8DBD 85 36                    .6
        sty     $37                             ; 8DBF 84 37                    .7
        ldx     #$07                            ; 8DC1 A2 07                    ..
L8DC3:
        lda     L8E54,x                         ; 8DC3 BD 54 8E                 .T.
        sta     $38                             ; 8DC6 85 38                    .8
        lda     #$00                            ; 8DC8 A9 00                    ..
L8DCA:
        lsr     $38                             ; 8DCA 46 38                    F8
        bcc     L8DD1                           ; 8DCC 90 03                    ..
        clc                                     ; 8DCE 18                       .
        adc     $6C,x                           ; 8DCF 75 6C                    ul
L8DD1:
        asl     $6C,x                           ; 8DD1 16 6C                    .l
        ldy     $38                             ; 8DD3 A4 38                    .8
        bne     L8DCA                           ; 8DD5 D0 F3                    ..
        sta     $6C,x                           ; 8DD7 95 6C                    .l
        dex                                     ; 8DD9 CA                       .
        bpl     L8DC3                           ; 8DDA 10 E7                    ..
        ldy     $37                             ; 8DDC A4 37                    .7
        lda     #$00                            ; 8DDE A9 00                    ..
        sta     $37                             ; 8DE0 85 37                    .7
        ldx     #$40                            ; 8DE2 A2 40                    .@
L8DE4:
        lda     L8E6A,y                         ; 8DE4 B9 6A 8E                 .j.
        sec                                     ; 8DE7 38                       8
        sbc     ppuScrollYOffset                ; 8DE8 ED F6 04                 ...
        sta     oamStaging,x                    ; 8DEB 9D 00 05                 ...
        sta     oamStaging+4,x                  ; 8DEE 9D 04 05                 ...
        clc                                     ; 8DF1 18                       .
        adc     #$08                            ; 8DF2 69 08                    i.
        sta     oamStaging+8,x                  ; 8DF4 9D 08 05                 ...
        sta     oamStaging+12,x                 ; 8DF7 9D 0C 05                 ...
        lda     L8E5C,y                         ; 8DFA B9 5C 8E                 .\.
        sta     oamStaging+3,x                  ; 8DFD 9D 03 05                 ...
        sta     oamStaging+11,x                 ; 8E00 9D 0B 05                 ...
        clc                                     ; 8E03 18                       .
        adc     #$08                            ; 8E04 69 08                    i.
        sta     oamStaging+7,x                  ; 8E06 9D 07 05                 ...
        sta     oamStaging+15,x                 ; 8E09 9D 0F 05                 ...
        lda     L8E78,y                         ; 8E0C B9 78 8E                 .x.
        ora     #$20                            ; 8E0F 09 20                    . 
        sta     oamStaging+2,x                  ; 8E11 9D 02 05                 ...
        sta     oamStaging+6,x                  ; 8E14 9D 06 05                 ...
        sta     oamStaging+10,x                 ; 8E17 9D 0A 05                 ...
        sta     oamStaging+14,x                 ; 8E1A 9D 0E 05                 ...
        stx     $38                             ; 8E1D 86 38                    .8
        sty     $39                             ; 8E1F 84 39                    .9
        tya                                     ; 8E21 98                       .
        asl     a                               ; 8E22 0A                       .
        tax                                     ; 8E23 AA                       .
        ldy     $37                             ; 8E24 A4 37                    .7
        lda     L8E86,x                         ; 8E26 BD 86 8E                 ...
        sta     $019A,y                         ; 8E29 99 9A 01                 ...
        lda     L8E87,x                         ; 8E2C BD 87 8E                 ...
        sta     $01A2,y                         ; 8E2F 99 A2 01                 ...
        iny                                     ; 8E32 C8                       .
        sty     $37                             ; 8E33 84 37                    .7
        lda     $38                             ; 8E35 A5 38                    .8
        clc                                     ; 8E37 18                       .
        adc     #$10                            ; 8E38 69 10                    i.
        tax                                     ; 8E3A AA                       .
        ldy     $39                             ; 8E3B A4 39                    .9
        iny                                     ; 8E3D C8                       .
        cpy     $36                             ; 8E3E C4 36                    .6
        bcc     L8DE4                           ; 8E40 90 A2                    ..
        lda     #$00                            ; 8E42 A9 00                    ..
        ldy     $37                             ; 8E44 A4 37                    .7
L8E46:
        cpy     #$08                            ; 8E46 C0 08                    ..
        beq     L8E53                           ; 8E48 F0 09                    ..
        sta     $019A,y                         ; 8E4A 99 9A 01                 ...
        sta     $01A2,y                         ; 8E4D 99 A2 01                 ...
        iny                                     ; 8E50 C8                       .
        bne     L8E46                           ; 8E51 D0 F3                    ..
L8E53:
        rts                                     ; 8E53 60                       `

; ----------------------------------------------------------------------------
L8E54:
        .byte   $01,$01,$04,$04,$09,$09,$19,$19 ; 8E54 01 01 04 04 09 09 19 19  ........
L8E5C:
        .byte   $61,$61,$61,$61,$61,$61,$40,$B1 ; 8E5C 61 61 61 61 61 61 40 B1  aaaaaa@.
        .byte   $40,$B1,$40,$B1,$40,$B1         ; 8E64 40 B1 40 B1 40 B1        @.@.@.
L8E6A:
        .byte   $D0,$B8,$A0,$88,$70,$58,$D0,$D0 ; 8E6A D0 B8 A0 88 70 58 D0 D0  ....pX..
        .byte   $B8,$B8,$A0,$A0,$88,$88         ; 8E72 B8 B8 A0 A0 88 88        ......
L8E78:
        .byte   $00,$02,$03,$00,$02,$03,$40,$02 ; 8E78 00 02 03 00 02 03 40 02  ......@.
        .byte   $43,$00,$42,$03,$40,$02         ; 8E80 43 00 42 03 40 02        C.B.@.
L8E86:
        .byte   $4D                             ; 8E86 4D                       M
L8E87:
        .byte   $B1,$4D,$B1,$4D,$B1,$4D,$B1,$67 ; 8E87 B1 4D B1 4D B1 4D B1 67  .M.M.M.g
        .byte   $B1,$67,$B1,$4D,$B1,$4D,$B1,$4D ; 8E8F B1 67 B1 4D B1 4D B1 4D  .g.M.M.M
        .byte   $B1,$4D,$B1,$4D,$B1,$4D,$B1,$67 ; 8E97 B1 4D B1 4D B1 4D B1 67  .M.M.M.g
        .byte   $B1,$67,$B1                     ; 8E9F B1 67 B1                 .g.
; ----------------------------------------------------------------------------
L8EA2:
        ldx     #$00                            ; 8EA2 A2 00                    ..
        stx     $3A                             ; 8EA4 86 3A                    .:
        ldy     #$00                            ; 8EA6 A0 00                    ..
L8EA8:
        stx     $3B                             ; 8EA8 86 3B                    .;
        sty     $3C                             ; 8EAA 84 3C                    .<
        lda     $4A,x                           ; 8EAC B5 4A                    .J
        beq     L8EBD                           ; 8EAE F0 0D                    ..
L8EB0:
        lda     $0180,x                         ; 8EB0 BD 80 01                 ...
        cmp     $6C,x                           ; 8EB3 D5 6C                    .l
        bne     L8ED9                           ; 8EB5 D0 22                    ."
        inx                                     ; 8EB7 E8                       .
        inx                                     ; 8EB8 E8                       .
        cpx     #$08                            ; 8EB9 E0 08                    ..
        bcc     L8EB0                           ; 8EBB 90 F3                    ..
L8EBD:
        ldx     $3B                             ; 8EBD A6 3B                    .;
        bne     L8EC6                           ; 8EBF D0 05                    ..
        ldy     #$04                            ; 8EC1 A0 04                    ..
        inx                                     ; 8EC3 E8                       .
        bne     L8EA8                           ; 8EC4 D0 E2                    ..
L8EC6:
        lda     player1ControllerNew            ; 8EC6 A5 46                    .F
        ora     player2ControllerNew            ; 8EC8 05 47                    .G
        beq     L8ED8                           ; 8ECA F0 0C                    ..
        lda     $3A                             ; 8ECC A5 3A                    .:
        beq     L8ED8                           ; 8ECE F0 08                    ..
L8ED0:
        lda     $25                             ; 8ED0 A5 25                    .%
        cmp     $27                             ; 8ED2 C5 27                    .'
        bne     L8ED0                           ; 8ED4 D0 FA                    ..
        beq     L8EA2                           ; 8ED6 F0 CA                    ..
L8ED8:
        rts                                     ; 8ED8 60                       `

; ----------------------------------------------------------------------------
L8ED9:
        stx     $3D                             ; 8ED9 86 3D                    .=
        ldx     $3B                             ; 8EDB A6 3B                    .;
        cmp     #$00                            ; 8EDD C9 00                    ..
        bne     L8EFA                           ; 8EDF D0 19                    ..
        lda     $0198,x                         ; 8EE1 BD 98 01                 ...
        cmp     #$05                            ; 8EE4 C9 05                    ..
        bne     L8EFA                           ; 8EE6 D0 12                    ..
        ldy     $3C                             ; 8EE8 A4 3C                    .<
        lda     #$00                            ; 8EEA A9 00                    ..
        sta     $0190,y                         ; 8EEC 99 90 01                 ...
        sta     $0191,y                         ; 8EEF 99 91 01                 ...
        sta     $0192,y                         ; 8EF2 99 92 01                 ...
        lda     #$30                            ; 8EF5 A9 30                    .0
        sta     $0193,y                         ; 8EF7 99 93 01                 ...
L8EFA:
        dec     $0198,x                         ; 8EFA DE 98 01                 ...
        bne     L8F0B                           ; 8EFD D0 0C                    ..
        ldx     $3D                             ; 8EFF A6 3D                    .=
        inc     $0180,x                         ; 8F01 FE 80 01                 ...
        ldx     $3B                             ; 8F04 A6 3B                    .;
        lda     #$05                            ; 8F06 A9 05                    ..
        sta     $0198,x                         ; 8F08 9D 98 01                 ...
L8F0B:
        lda     #$00                            ; 8F0B A9 00                    ..
        sta     $36                             ; 8F0D 85 36                    .6
        sta     $38                             ; 8F0F 85 38                    .8
        sta     $39                             ; 8F11 85 39                    .9
        lda     #$02                            ; 8F13 A9 02                    ..
        sta     $37                             ; 8F15 85 37                    .7
        jsr     L9A6A                           ; 8F17 20 6A 9A                  j.
        bit     playMode                        ; 8F1A 24 2F                    $/
        bpl     L8F23                           ; 8F1C 10 05                    ..
        .byte   $A2,$01,$20,$6A,$9A             ; 8F1E A2 01 20 6A 9A           .. j.
; ----------------------------------------------------------------------------
L8F23:
        lda     #$01                            ; 8F23 A9 01                    ..
        sta     $3A                             ; 8F25 85 3A                    .:
        ldx     $3C                             ; 8F27 A6 3C                    .<
        lda     $0193,x                         ; 8F29 BD 93 01                 ...
        clc                                     ; 8F2C 18                       .
        adc     #$02                            ; 8F2D 69 02                    i.
        sta     $0193,x                         ; 8F2F 9D 93 01                 ...
        cmp     #$3A                            ; 8F32 C9 3A                    .:
        bcc     L8F65                           ; 8F34 90 2F                    ./
        lda     #$30                            ; 8F36 A9 30                    .0
        sta     $0193,x                         ; 8F38 9D 93 01                 ...
        ora     $0192,x                         ; 8F3B 1D 92 01                 ...
        adc     #$00                            ; 8F3E 69 00                    i.
        sta     $0192,x                         ; 8F40 9D 92 01                 ...
        cmp     #$3A                            ; 8F43 C9 3A                    .:
        bcc     L8F65                           ; 8F45 90 1E                    ..
        lda     #$30                            ; 8F47 A9 30                    .0
        sta     $0192,x                         ; 8F49 9D 92 01                 ...
        ora     $0191,x                         ; 8F4C 1D 91 01                 ...
        adc     #$00                            ; 8F4F 69 00                    i.
        sta     $0191,x                         ; 8F51 9D 91 01                 ...
        cmp     #$3A                            ; 8F54 C9 3A                    .:
        bcc     L8F65                           ; 8F56 90 0D                    ..
        .byte   $A9,$30,$9D,$91,$01,$1D,$90,$01 ; 8F58 A9 30 9D 91 01 1D 90 01  .0......
        .byte   $69,$00,$9D,$90,$01             ; 8F60 69 00 9D 90 01           i....
; ----------------------------------------------------------------------------
L8F65:
        lda     $018B,x                         ; 8F65 BD 8B 01                 ...
        clc                                     ; 8F68 18                       .
        adc     #$02                            ; 8F69 69 02                    i.
        sta     $018B,x                         ; 8F6B 9D 8B 01                 ...
        cmp     #$3A                            ; 8F6E C9 3A                    .:
        bcc     L8FA1                           ; 8F70 90 2F                    ./
        lda     #$30                            ; 8F72 A9 30                    .0
        sta     $018B,x                         ; 8F74 9D 8B 01                 ...
        ora     $018A,x                         ; 8F77 1D 8A 01                 ...
        adc     #$00                            ; 8F7A 69 00                    i.
        sta     $018A,x                         ; 8F7C 9D 8A 01                 ...
        cmp     #$3A                            ; 8F7F C9 3A                    .:
        bcc     L8FA1                           ; 8F81 90 1E                    ..
        lda     #$30                            ; 8F83 A9 30                    .0
        sta     $018A,x                         ; 8F85 9D 8A 01                 ...
        ora     $0189,x                         ; 8F88 1D 89 01                 ...
        adc     #$00                            ; 8F8B 69 00                    i.
        sta     $0189,x                         ; 8F8D 9D 89 01                 ...
        cmp     #$3A                            ; 8F90 C9 3A                    .:
        bcc     L8FA1                           ; 8F92 90 0D                    ..
        .byte   $A9,$30,$9D,$89,$01,$1D,$88,$01 ; 8F94 A9 30 9D 89 01 1D 88 01  .0......
        .byte   $69,$00,$9D,$88,$01             ; 8F9C 69 00 9D 88 01           i....
; ----------------------------------------------------------------------------
L8FA1:
        ldx     $3B                             ; 8FA1 A6 3B                    .;
        lda     player1ControllerNew            ; 8FA3 A5 46                    .F
        ora     player2ControllerNew            ; 8FA5 05 47                    .G
        beq     L8FB6                           ; 8FA7 F0 0D                    ..
        ldy     $3D                             ; 8FA9 A4 3D                    .=
        lda     $0180,y                         ; 8FAB B9 80 01                 ...
        cmp     $6C,y                           ; 8FAE D9 6C 00                 .l.
        beq     L8FB6                           ; 8FB1 F0 03                    ..
        jmp     L8EFA                           ; 8FB3 4C FA 8E                 L..

; ----------------------------------------------------------------------------
L8FB6:
        lda     $3D                             ; 8FB6 A5 3D                    .=
        asl     a                               ; 8FB8 0A                       .
        bit     playMode                        ; 8FB9 24 2F                    $/
        bpl     L8FC3                           ; 8FBB 10 06                    ..
        .byte   $4A,$29,$FE,$18,$69,$10         ; 8FBD 4A 29 FE 18 69 10        J)..i.
; ----------------------------------------------------------------------------
L8FC3:
        tay                                     ; 8FC3 A8                       .
        jsr     LA3DB                           ; 8FC4 20 DB A3                  ..
        lda     L9018,y                         ; 8FC7 B9 18 90                 ...
        sta     $17,x                           ; 8FCA 95 17                    ..
        lda     L9017,y                         ; 8FCC B9 17 90                 ...
        sta     $16,x                           ; 8FCF 95 16                    ..
        lda     $3C                             ; 8FD1 A5 3C                    .<
        clc                                     ; 8FD3 18                       .
        adc     #$90                            ; 8FD4 69 90                    i.
        sta     ppuDataAddress1,x               ; 8FD6 95 08                    ..
        lda     #$01                            ; 8FD8 A9 01                    ..
        adc     #$00                            ; 8FDA 69 00                    i.
        sta     ppuDataAddress1+1,x             ; 8FDC 95 09                    ..
        lda     #$04                            ; 8FDE A9 04                    ..
        sta     $24,x                           ; 8FE0 95 24                    .$
        ldx     $3D                             ; 8FE2 A6 3D                    .=
        lda     $0180,x                         ; 8FE4 BD 80 01                 ...
        cmp     $6C,x                           ; 8FE7 D5 6C                    .l
        bne     L9014                           ; 8FE9 D0 29                    .)
        lda     $3B                             ; 8FEB A5 3B                    .;
        asl     a                               ; 8FED 0A                       .
        bit     playMode                        ; 8FEE 24 2F                    $/
        bpl     L8FF4                           ; 8FF0 10 02                    ..
        .byte   $A9,$04                         ; 8FF2 A9 04                    ..
; ----------------------------------------------------------------------------
L8FF4:
        tay                                     ; 8FF4 A8                       .
        jsr     LA3DB                           ; 8FF5 20 DB A3                  ..
        lda     L9030,y                         ; 8FF8 B9 30 90                 .0.
        sta     $17,x                           ; 8FFB 95 17                    ..
        lda     L902F,y                         ; 8FFD B9 2F 90                 ./.
        sta     $16,x                           ; 9000 95 16                    ..
        lda     $3B                             ; 9002 A5 3B                    .;
        asl     a                               ; 9004 0A                       .
        asl     a                               ; 9005 0A                       .
        adc     #$88                            ; 9006 69 88                    i.
        sta     ppuDataAddress1,x               ; 9008 95 08                    ..
        lda     #$01                            ; 900A A9 01                    ..
        adc     #$00                            ; 900C 69 00                    i.
        sta     ppuDataAddress1+1,x             ; 900E 95 09                    ..
        lda     #$04                            ; 9010 A9 04                    ..
        sta     $24,x                           ; 9012 95 24                    .$
L9014:
        jmp     L8EBD                           ; 9014 4C BD 8E                 L..

; ----------------------------------------------------------------------------
L9017:
        .byte   $87                             ; 9017 87                       .
L9018:
        .byte   $21,$99,$21,$07,$22,$19,$22,$87 ; 9018 21 99 21 07 22 19 22 87  !.!.".".
        .byte   $22,$99,$22,$07,$23,$19,$23,$90 ; 9020 22 99 22 07 23 19 23 90  ".".#.#.
        .byte   $21,$10,$22,$90,$22,$10,$23     ; 9028 21 10 22 90 22 10 23     !.".".#
L902F:
        .byte   $67                             ; 902F 67                       g
L9030:
        .byte   $23,$79,$23,$70,$23             ; 9030 23 79 23 70 23           #y#p#
; ----------------------------------------------------------------------------
L9035:
        ldy     player1FallTimer                ; 9035 A4 6A                    .j
        cpy     #$F4                            ; 9037 C0 F4                    ..
        beq     L9053                           ; 9039 F0 18                    ..
        bcs     L9091                           ; 903B B0 54                    .T
        lda     player1ControllerNew            ; 903D A5 46                    .F
        ora     player2ControllerNew            ; 903F 05 47                    .G
        beq     L9091                           ; 9041 F0 4E                    .N
        lda     #$08                            ; 9043 A9 08                    ..
        jsr     possibleSetSoundOrMusic         ; 9045 20 B1 CF                  ..
        lda     #$7C                            ; 9048 A9 7C                    .|
        sec                                     ; 904A 38                       8
        sbc     player1FallTimer                ; 904B E5 6A                    .j
        sbc     #$05                            ; 904D E9 05                    ..
        cmp     #$F5                            ; 904F C9 F5                    ..
        bcs     L9055                           ; 9051 B0 02                    ..
L9053:
        lda     #$F5                            ; 9053 A9 F5                    ..
L9055:
        sta     player1FallTimer                ; 9055 85 6A                    .j
        lda     frameCounterLow                 ; 9057 A5 32                    .2
        and     #$F0                            ; 9059 29 F0                    ).
        sta     frameCounterLow                 ; 905B 85 32                    .2
        ldy     #$00                            ; 905D A0 00                    ..
        ldx     #$00                            ; 905F A2 00                    ..
        bit     playMode                        ; 9061 24 2F                    $/
        bpl     L9079                           ; 9063 10 14                    ..
        .byte   $A2,$40,$BD,$02,$05,$49,$40,$9D ; 9065 A2 40 BD 02 05 49 40 9D  .@...I@.
        .byte   $02,$05,$E8,$E8,$E8,$E8,$E0,$C0 ; 906D 02 05 E8 E8 E8 E8 E0 C0  ........
        .byte   $90,$F0,$A2,$0C                 ; 9075 90 F0 A2 0C              ....
; ----------------------------------------------------------------------------
L9079:
        lda     $01A2,y                         ; 9079 B9 A2 01                 ...
        beq     L908A                           ; 907C F0 0C                    ..
        lda     L9094,x                         ; 907E BD 94 90                 ...
        sta     $019A,y                         ; 9081 99 9A 01                 ...
        lda     L9095,x                         ; 9084 BD 95 90                 ...
        sta     $01A2,y                         ; 9087 99 A2 01                 ...
L908A:
        inx                                     ; 908A E8                       .
        inx                                     ; 908B E8                       .
        iny                                     ; 908C C8                       .
        cpy     #$08                            ; 908D C0 08                    ..
        bcc     L9079                           ; 908F 90 E8                    ..
L9091:
        jmp     LB015                           ; 9091 4C 15 B0                 L..

; ----------------------------------------------------------------------------
L9094:
        .byte   $81                             ; 9094 81                       .
L9095:
        .byte   $B1,$81,$B1,$81,$B1,$81,$B1,$97 ; 9095 B1 81 B1 81 B1 81 B1 97  ........
        .byte   $B1,$97,$B1,$81,$B1,$81,$B1,$81 ; 909D B1 97 B1 81 B1 81 B1 81  ........
        .byte   $B1,$81,$B1,$81,$B1,$81,$B1,$97 ; 90A5 B1 81 B1 81 B1 81 B1 97  ........
        .byte   $B1,$97,$B1                     ; 90AD B1 97 B1                 ...
; ----------------------------------------------------------------------------
L90B0:
        lda     #$F7                            ; 90B0 A9 F7                    ..
        ldx     #$40                            ; 90B2 A2 40                    .@
L90B4:
        sta     oamStaging,x                    ; 90B4 9D 00 05                 ...
        inx                                     ; 90B7 E8                       .
        inx                                     ; 90B8 E8                       .
        inx                                     ; 90B9 E8                       .
        inx                                     ; 90BA E8                       .
        cpx     #$C0                            ; 90BB E0 C0                    ..
        bne     L90B4                           ; 90BD D0 F5                    ..
        ldx     #$07                            ; 90BF A2 07                    ..
        lda     #$00                            ; 90C1 A9 00                    ..
        sta     gameStatePossible               ; 90C3 85 29                    .)
L90C5:
        sta     $6C,x                           ; 90C5 95 6C                    .l
        dex                                     ; 90C7 CA                       .
        bpl     L90C5                           ; 90C8 10 FB                    ..
        lda     $00                             ; 90CA A5 00                    ..
        and     #$F7                            ; 90CC 29 F7                    ).
        sta     $00                             ; 90CE 85 00                    ..
        jsr     L970F                           ; 90D0 20 0F 97                  ..
        bit     playMode                        ; 90D3 24 2F                    $/
        bmi     L90DC                           ; 90D5 30 05                    0.
        lda     #$0D                            ; 90D7 A9 0D                    ..
        jsr     LB603                           ; 90D9 20 03 B6                  ..
L90DC:
        lda     #$5A                            ; 90DC A9 5A                    .Z
        sta     player1FallTimer                ; 90DE 85 6A                    .j
        sta     player2FallTimer                ; 90E0 85 6B                    .k
        jsr     LA035                           ; 90E2 20 35 A0                  5.
        ldy     #$04                            ; 90E5 A0 04                    ..
        lda     playMode                        ; 90E7 A5 2F                    ./
        beq     L90F4                           ; 90E9 F0 09                    ..
        ldx     #$01                            ; 90EB A2 01                    ..
        ldy     player2TetriminoCurrent         ; 90ED A4 65                    .e
        jsr     LA763                           ; 90EF 20 63 A7                  c.
        ldy     player2TetriminoNext            ; 90F2 A4 67                    .g
L90F4:
        ldx     #$03                            ; 90F4 A2 03                    ..
        jsr     LA763                           ; 90F6 20 63 A7                  c.
        lda     $4B                             ; 90F9 A5 4B                    .K
        beq     L9133                           ; 90FB F0 36                    .6
        ldx     playMode                        ; 90FD A6 2F                    ./
        dex                                     ; 90FF CA                       .
        bne     L9133                           ; 9100 D0 31                    .1
        lda     #$04                            ; 9102 A9 04                    ..
        sta     player2TetriminoY               ; 9104 85 61                    .a
        lda     L99ED                           ; 9106 AD ED 99                 ...
        bit     playMode                        ; 9109 24 2F                    $/
        bpl     L9110                           ; 910B 10 03                    ..
        .byte   $AD,$EC,$99                     ; 910D AD EC 99                 ...
; ----------------------------------------------------------------------------
L9110:
        sta     player2TetriminoX               ; 9110 85 63                    .c
        lda     #$07                            ; 9112 A9 07                    ..
        sta     $3B                             ; 9114 85 3B                    .;
        lda     #$00                            ; 9116 A9 00                    ..
        sta     $3A                             ; 9118 85 3A                    .:
        ldy     #$30                            ; 911A A0 30                    .0
L911C:
        lda     #$FE                            ; 911C A9 FE                    ..
        sta     ($3A),y                         ; 911E 91 3A                    .:
        tya                                     ; 9120 98                       .
        clc                                     ; 9121 18                       .
        adc     #$08                            ; 9122 69 08                    i.
        tay                                     ; 9124 A8                       .
        cpy     #$D0                            ; 9125 C0 D0                    ..
        bcc     L911C                           ; 9127 90 F3                    ..
        ldx     #$02                            ; 9129 A2 02                    ..
        jsr     LA756                           ; 912B 20 56 A7                  V.
        ldx     #$01                            ; 912E A2 01                    ..
        jsr     L8ADB                           ; 9130 20 DB 8A                  ..
L9133:
        ldx     #$00                            ; 9133 A2 00                    ..
        ldy     player1TetriminoCurrent         ; 9135 A4 64                    .d
        jsr     LA763                           ; 9137 20 63 A7                  c.
        ldx     #$02                            ; 913A A2 02                    ..
        ldy     player1TetriminoNext            ; 913C A4 66                    .f
        jsr     LA763                           ; 913E 20 63 A7                  c.
        lda     $4A                             ; 9141 A5 4A                    .J
        beq     L9176                           ; 9143 F0 31                    .1
        lda     #$04                            ; 9145 A9 04                    ..
        sta     player1TetriminoY               ; 9147 85 60                    .`
        lda     L99ED                           ; 9149 AD ED 99                 ...
        bit     playMode                        ; 914C 24 2F                    $/
        bpl     L9153                           ; 914E 10 03                    ..
        .byte   $AD,$EB,$99                     ; 9150 AD EB 99                 ...
; ----------------------------------------------------------------------------
L9153:
        sta     player1TetriminoX               ; 9153 85 62                    .b
        lda     #$06                            ; 9155 A9 06                    ..
        sta     $3B                             ; 9157 85 3B                    .;
        lda     #$00                            ; 9159 A9 00                    ..
        sta     $3A                             ; 915B 85 3A                    .:
        ldy     #$30                            ; 915D A0 30                    .0
L915F:
        lda     #$FE                            ; 915F A9 FE                    ..
        sta     ($3A),y                         ; 9161 91 3A                    .:
        tya                                     ; 9163 98                       .
        clc                                     ; 9164 18                       .
        adc     #$08                            ; 9165 69 08                    i.
        tay                                     ; 9167 A8                       .
        cpy     #$D0                            ; 9168 C0 D0                    ..
        bcc     L915F                           ; 916A 90 F3                    ..
        ldx     #$00                            ; 916C A2 00                    ..
        jsr     LA756                           ; 916E 20 56 A7                  V.
        ldx     #$00                            ; 9171 A2 00                    ..
        jsr     L8ADB                           ; 9173 20 DB 8A                  ..
L9176:
        rts                                     ; 9176 60                       `

; ----------------------------------------------------------------------------
L9177:
        iny                                     ; 9177 C8                       .
        ldx     L91DA,y                         ; 9178 BE DA 91                 ...
        tya                                     ; 917B 98                       .
        asl     a                               ; 917C 0A                       .
        tay                                     ; 917D A8                       .
        lda     L91DD,y                         ; 917E B9 DD 91                 ...
        sta     $36                             ; 9181 85 36                    .6
        lda     L91DE,y                         ; 9183 B9 DE 91                 ...
        sta     $37                             ; 9186 85 37                    .7
L9188:
        stx     $38                             ; 9188 86 38                    .8
        jsr     LA3DB                           ; 918A 20 DB A3                  ..
        lda     $37                             ; 918D A5 37                    .7
        sta     $17,x                           ; 918F 95 17                    ..
        lda     $36                             ; 9191 A5 36                    .6
        sta     $16,x                           ; 9193 95 16                    ..
        clc                                     ; 9195 18                       .
        adc     #$80                            ; 9196 69 80                    i.
        sta     $36                             ; 9198 85 36                    .6
        bcc     L919E                           ; 919A 90 02                    ..
        inc     $37                             ; 919C E6 37                    .7
L919E:
        lda     $49                             ; 919E A5 49                    .I
        sta     ppuDataAddress1+1,x             ; 91A0 95 09                    ..
        lda     $48                             ; 91A2 A5 48                    .H
        sta     ppuDataAddress1,x               ; 91A4 95 08                    ..
        ldy     $38                             ; 91A6 A4 38                    .8
        lda     $6C,y                           ; 91A8 B9 6C 00                 .l.
        ldy     #$00                            ; 91AB A0 00                    ..
        sty     $39                             ; 91AD 84 39                    .9
L91AF:
        cmp     #$0A                            ; 91AF C9 0A                    ..
        bcc     L91B9                           ; 91B1 90 06                    ..
        sbc     #$0A                            ; 91B3 E9 0A                    ..
        inc     $39                             ; 91B5 E6 39                    .9
        bne     L91AF                           ; 91B7 D0 F6                    ..
L91B9:
        pha                                     ; 91B9 48                       H
        lda     $39                             ; 91BA A5 39                    .9
        beq     L91C0                           ; 91BC F0 02                    ..
        ora     #$30                            ; 91BE 09 30                    .0
L91C0:
        sta     ($48),y                         ; 91C0 91 48                    .H
        pla                                     ; 91C2 68                       h
        ora     #$30                            ; 91C3 09 30                    .0
        iny                                     ; 91C5 C8                       .
        sta     ($48),y                         ; 91C6 91 48                    .H
        lda     #$02                            ; 91C8 A9 02                    ..
        sta     $24,x                           ; 91CA 95 24                    .$
        clc                                     ; 91CC 18                       .
        adc     $48                             ; 91CD 65 48                    eH
        sta     $48                             ; 91CF 85 48                    .H
        ldx     $38                             ; 91D1 A6 38                    .8
        inx                                     ; 91D3 E8                       .
        inx                                     ; 91D4 E8                       .
        cpx     #$08                            ; 91D5 E0 08                    ..
        bcc     L9188                           ; 91D7 90 AF                    ..
        rts                                     ; 91D9 60                       `

; ----------------------------------------------------------------------------
L91DA:
        .byte   $00,$00,$01                     ; 91DA 00 00 01                 ...
L91DD:
        .byte   $6B                             ; 91DD 6B                       k
L91DE:
        .byte   $21,$62,$21,$74,$21             ; 91DE 21 62 21 74 21           !b!t!
; ----------------------------------------------------------------------------
L91E3:
        ldy     gameStatePossible               ; 91E3 A4 29                    .)
        cpy     #$F8                            ; 91E5 C0 F8                    ..
        bne     L9205                           ; 91E7 D0 1C                    ..
        jsr     LA9CE                           ; 91E9 20 CE A9                  ..
        lda     $74                             ; 91EC A5 74                    .t
        ora     $75                             ; 91EE 05 75                    .u
        beq     L91F8                           ; 91F0 F0 06                    ..
        jsr     L922A                           ; 91F2 20 2A 92                  *.
        jmp     L932A                           ; 91F5 4C 2A 93                 L*.

; ----------------------------------------------------------------------------
L91F8:
        lda     frameCounterLow                 ; 91F8 A5 32                    .2
        and     #$03                            ; 91FA 29 03                    ).
        bne     L9215                           ; 91FC D0 17                    ..
        dec     player1FallTimer                ; 91FE C6 6A                    .j
        bne     L9215                           ; 9200 D0 13                    ..
        jmp     L9E61                           ; 9202 4C 61 9E                 La.

; ----------------------------------------------------------------------------
L9205:
        cpy     #$F9                            ; 9205 C0 F9                    ..
        bne     L9215                           ; 9207 D0 0C                    ..
        lda     frameCounterLow                 ; 9209 A5 32                    .2
        lsr     a                               ; 920B 4A                       J
        bcs     L9215                           ; 920C B0 07                    ..
        dec     player1FallTimer                ; 920E C6 6A                    .j
        bne     L9215                           ; 9210 D0 03                    ..
        jmp     L93F7                           ; 9212 4C F7 93                 L..

; ----------------------------------------------------------------------------
L9215:
        rts                                     ; 9215 60                       `

; ----------------------------------------------------------------------------
L9216:
        ldy     #$2C                            ; 9216 A0 2C                    .,
L9218:
        lda     leaderboardInitials,y           ; 9218 B9 C3 04                 ...
        and     #$C0                            ; 921B 29 C0                    ).
        beq     L9226                           ; 921D F0 07                    ..
        asl     a                               ; 921F 0A                       .
        rol     a                               ; 9220 2A                       *
        tax                                     ; 9221 AA                       .
        lda     #$01                            ; 9222 A9 01                    ..
        sta     $74,x                           ; 9224 95 74                    .t
L9226:
        dey                                     ; 9226 88                       .
        bpl     L9218                           ; 9227 10 EF                    ..
        rts                                     ; 9229 60                       `

; ----------------------------------------------------------------------------
L922A:
        ldx     #$01                            ; 922A A2 01                    ..
L922C:
        ldy     $74,x                           ; 922C B4 74                    .t
        bne     L9234                           ; 922E D0 04                    ..
L9230:
        dex                                     ; 9230 CA                       .
        bpl     L922C                           ; 9231 10 F9                    ..
        rts                                     ; 9233 60                       `

; ----------------------------------------------------------------------------
L9234:
        lda     player1ControllerHeld,x         ; 9234 B5 42                    .B
        sta     $3A                             ; 9236 85 3A                    .:
        lda     player1ControllerNew,x          ; 9238 B5 46                    .F
        and     #$40                            ; 923A 29 40                    )@
        bne     L9257                           ; 923C D0 19                    ..
        lda     player1ControllerNew,x          ; 923E B5 46                    .F
        and     #$80                            ; 9240 29 80                    ).
        bne     L9274                           ; 9242 D0 30                    .0
        lda     $3A                             ; 9244 A5 3A                    .:
        and     #$40                            ; 9246 29 40                    )@
        beq     L925C                           ; 9248 F0 12                    ..
        lda     $01AA,x                         ; 924A BD AA 01                 ...
        clc                                     ; 924D 18                       .
        adc     #$01                            ; 924E 69 01                    i.
        sta     $01AA,x                         ; 9250 9D AA 01                 ...
        cmp     #$0A                            ; 9253 C9 0A                    ..
        bcc     L9261                           ; 9255 90 0A                    ..
L9257:
        lda     #$FF                            ; 9257 A9 FF                    ..
        jsr     L929C                           ; 9259 20 9C 92                  ..
L925C:
        lda     #$00                            ; 925C A9 00                    ..
        sta     $01AA,x                         ; 925E 9D AA 01                 ...
L9261:
        lda     $3A                             ; 9261 A5 3A                    .:
        and     #$80                            ; 9263 29 80                    ).
        beq     L9279                           ; 9265 F0 12                    ..
        lda     $01AC,x                         ; 9267 BD AC 01                 ...
        clc                                     ; 926A 18                       .
        adc     #$01                            ; 926B 69 01                    i.
        sta     $01AC,x                         ; 926D 9D AC 01                 ...
        cmp     #$0A                            ; 9270 C9 0A                    ..
        bcc     L927E                           ; 9272 90 0A                    ..
L9274:
        lda     #$01                            ; 9274 A9 01                    ..
        jsr     L929C                           ; 9276 20 9C 92                  ..
L9279:
        lda     #$00                            ; 9279 A9 00                    ..
        sta     $01AC,x                         ; 927B 9D AC 01                 ...
L927E:
        lda     player1ControllerNew,x          ; 927E B5 46                    .F
        and     #$03                            ; 9280 29 03                    ).
        beq     L928D                           ; 9282 F0 09                    ..
        lda     $74,x                           ; 9284 B5 74                    .t
        clc                                     ; 9286 18                       .
        adc     #$01                            ; 9287 69 01                    i.
        and     #$03                            ; 9289 29 03                    ).
        sta     $74,x                           ; 928B 95 74                    .t
L928D:
        lda     player1ControllerNew            ; 928D A5 46                    .F
        ora     player2ControllerNew            ; 928F 05 47                    .G
        and     #$04                            ; 9291 29 04                    ).
        beq     L9299                           ; 9293 F0 04                    ..
        .byte   $A9,$01,$95,$74                 ; 9295 A9 01 95 74              ...t
; ----------------------------------------------------------------------------
L9299:
        jmp     L9230                           ; 9299 4C 30 92                 L0.

; ----------------------------------------------------------------------------
L929C:
        ldy     #$2C                            ; 929C A0 2C                    .,
        sta     $39                             ; 929E 85 39                    .9
        lda     #$0E                            ; 92A0 A9 0E                    ..
        sta     $36                             ; 92A2 85 36                    .6
L92A4:
        lda     #$02                            ; 92A4 A9 02                    ..
        sta     $37                             ; 92A6 85 37                    .7
L92A8:
        lda     leaderboardInitials,y           ; 92A8 B9 C3 04                 ...
        and     L93DA,x                         ; 92AB 3D DA 93                 =..
        bne     L92BA                           ; 92AE D0 0A                    ..
        dey                                     ; 92B0 88                       .
        dec     $37                             ; 92B1 C6 37                    .7
        bpl     L92A8                           ; 92B3 10 F3                    ..
        dec     $36                             ; 92B5 C6 36                    .6
        bpl     L92A4                           ; 92B7 10 EB                    ..
        .byte   $60                             ; 92B9 60                       `
; ----------------------------------------------------------------------------
L92BA:
        lda     leaderboardInitials,y           ; 92BA B9 C3 04                 ...
        and     #$3F                            ; 92BD 29 3F                    )?
        clc                                     ; 92BF 18                       .
        adc     $39                             ; 92C0 65 39                    e9
        cmp     #$FF                            ; 92C2 C9 FF                    ..
        bne     L92C8                           ; 92C4 D0 02                    ..
        lda     #$1A                            ; 92C6 A9 1A                    ..
L92C8:
        cmp     #$1B                            ; 92C8 C9 1B                    ..
        bcc     L92CE                           ; 92CA 90 02                    ..
        lda     #$00                            ; 92CC A9 00                    ..
L92CE:
        ora     L93DA,x                         ; 92CE 1D DA 93                 ...
        sta     $39                             ; 92D1 85 39                    .9
        bne     L92E3                           ; 92D3 D0 0E                    ..
L92D5:
        .byte   $A9,$02,$85,$37                 ; 92D5 A9 02 85 37              ...7
L92D9:
        .byte   $B9,$C3,$04,$3D,$DA,$93,$F0,$3F ; 92D9 B9 C3 04 3D DA 93 F0 3F  ...=...?
        .byte   $A5,$39                         ; 92E1 A5 39                    .9
; ----------------------------------------------------------------------------
L92E3:
        sta     leaderboardInitials,y           ; 92E3 99 C3 04                 ...
        stx     $38                             ; 92E6 86 38                    .8
        jsr     LA3DB                           ; 92E8 20 DB A3                  ..
        lda     $36                             ; 92EB A5 36                    .6
        asl     a                               ; 92ED 0A                       .
        asl     a                               ; 92EE 0A                       .
        asl     a                               ; 92EF 0A                       .
        asl     a                               ; 92F0 0A                       .
        rol     $17,x                           ; 92F1 36 17                    6.
        asl     a                               ; 92F3 0A                       .
        rol     $17,x                           ; 92F4 36 17                    6.
        clc                                     ; 92F6 18                       .
        adc     #$8B                            ; 92F7 69 8B                    i.
        bcc     L92FD                           ; 92F9 90 02                    ..
        .byte   $F6,$17                         ; 92FB F6 17                    ..
; ----------------------------------------------------------------------------
L92FD:
        clc                                     ; 92FD 18                       .
        adc     $37                             ; 92FE 65 37                    e7
        sta     $16,x                           ; 9300 95 16                    ..
        lda     $17,x                           ; 9302 B5 17                    ..
        and     #$03                            ; 9304 29 03                    ).
        adc     #$21                            ; 9306 69 21                    i!
        sta     $17,x                           ; 9308 95 17                    ..
        lda     leaderboardInitials,y           ; 930A B9 C3 04                 ...
        and     #$3F                            ; 930D 29 3F                    )?
        clc                                     ; 930F 18                       .
        adc     #$DC                            ; 9310 69 DC                    i.
        sta     ppuDataAddress1,x               ; 9312 95 08                    ..
        lda     #$93                            ; 9314 A9 93                    ..
        adc     #$00                            ; 9316 69 00                    i.
        sta     ppuDataAddress1+1,x             ; 9318 95 09                    ..
        lda     #$01                            ; 931A A9 01                    ..
        sta     $24,x                           ; 931C 95 24                    .$
        ldx     $38                             ; 931E A6 38                    .8
        dey                                     ; 9320 88                       .
        dec     $37                             ; 9321 C6 37                    .7
        bpl     L92D9                           ; 9323 10 B4                    ..
        dec     $36                             ; 9325 C6 36                    .6
        bpl     L92D5                           ; 9327 10 AC                    ..
        rts                                     ; 9329 60                       `

; ----------------------------------------------------------------------------
L932A:
        ldy     #$2A                            ; 932A A0 2A                    .*
        ldx     #$00                            ; 932C A2 00                    ..
        lda     #$0E                            ; 932E A9 0E                    ..
        sta     $3A                             ; 9330 85 3A                    .:
L9332:
        lda     leaderboardInitials,y           ; 9332 B9 C3 04                 ...
        ora     leaderboardInitials+1,y         ; 9335 19 C4 04                 ...
        ora     leaderboardInitials+2,y         ; 9338 19 C5 04                 ...
        and     #$C0                            ; 933B 29 C0                    ).
        beq     L93B0                           ; 933D F0 71                    .q
        asl     a                               ; 933F 0A                       .
        rol     a                               ; 9340 2A                       *
        sta     $38                             ; 9341 85 38                    .8
        lda     leaderboardInitials,y           ; 9343 B9 C3 04                 ...
        and     #$3F                            ; 9346 29 3F                    )?
        sta     leaderboardInitials,y           ; 9348 99 C3 04                 ...
        lda     leaderboardInitials+1,y         ; 934B B9 C4 04                 ...
        and     #$3F                            ; 934E 29 3F                    )?
        sta     leaderboardInitials+1,y         ; 9350 99 C4 04                 ...
        lda     leaderboardInitials+2,y         ; 9353 B9 C5 04                 ...
        and     #$3F                            ; 9356 29 3F                    )?
        sta     leaderboardInitials+2,y         ; 9358 99 C5 04                 ...
        sty     $37                             ; 935B 84 37                    .7
        ldy     $38                             ; 935D A4 38                    .8
        lda     $74,y                           ; 935F B9 74 00                 .t.
        beq     L93AE                           ; 9362 F0 4A                    .J
        clc                                     ; 9364 18                       .
        adc     $37                             ; 9365 65 37                    e7
        stx     $36                             ; 9367 86 36                    .6
        tax                                     ; 9369 AA                       .
        lda     leaderboardLines+44,x           ; 936A BD C2 04                 ...
        ora     L93DA,y                         ; 936D 19 DA 93                 ...
        sta     leaderboardLines+44,x           ; 9370 9D C2 04                 ...
        and     #$3F                            ; 9373 29 3F                    )?
        beq     L937B                           ; 9375 F0 04                    ..
        ora     #$40                            ; 9377 09 40                    .@
        bne     L937D                           ; 9379 D0 02                    ..
L937B:
        lda     #$01                            ; 937B A9 01                    ..
L937D:
        pha                                     ; 937D 48                       H
        ldx     $36                             ; 937E A6 36                    .6
        lda     $74,y                           ; 9380 B9 74 00                 .t.
        asl     a                               ; 9383 0A                       .
        asl     a                               ; 9384 0A                       .
        asl     a                               ; 9385 0A                       .
        adc     #$50                            ; 9386 69 50                    iP
        sta     oamStaging+3,x                  ; 9388 9D 03 05                 ...
        tya                                     ; 938B 98                       .
        sta     oamStaging+2,x                  ; 938C 9D 02 05                 ...
        asl     a                               ; 938F 0A                       .
        asl     a                               ; 9390 0A                       .
        eor     frameCounterLow                 ; 9391 45 32                    E2
        lsr     a                               ; 9393 4A                       J
        lsr     a                               ; 9394 4A                       J
        lsr     a                               ; 9395 4A                       J
        pla                                     ; 9396 68                       h
        bcs     L939B                           ; 9397 B0 02                    ..
        lda     #$00                            ; 9399 A9 00                    ..
L939B:
        sta     oamStaging+1,x                  ; 939B 9D 01 05                 ...
        ldy     $3A                             ; 939E A4 3A                    .:
        lda     L93CB,y                         ; 93A0 B9 CB 93                 ...
        sec                                     ; 93A3 38                       8
        sbc     ppuScrollYOffset                ; 93A4 ED F6 04                 ...
        sta     oamStaging,x                    ; 93A7 9D 00 05                 ...
        inx                                     ; 93AA E8                       .
        inx                                     ; 93AB E8                       .
        inx                                     ; 93AC E8                       .
        inx                                     ; 93AD E8                       .
L93AE:
        ldy     $37                             ; 93AE A4 37                    .7
L93B0:
        dey                                     ; 93B0 88                       .
        dey                                     ; 93B1 88                       .
        dey                                     ; 93B2 88                       .
        dec     $3A                             ; 93B3 C6 3A                    .:
        bmi     L93BA                           ; 93B5 30 03                    0.
        jmp     L9332                           ; 93B7 4C 32 93                 L2.

; ----------------------------------------------------------------------------
L93BA:
        lda     #$F7                            ; 93BA A9 F7                    ..
L93BC:
        cmp     oamStaging,x                    ; 93BC DD 00 05                 ...
        beq     L93CA                           ; 93BF F0 09                    ..
        sta     oamStaging,x                    ; 93C1 9D 00 05                 ...
        inx                                     ; 93C4 E8                       .
        inx                                     ; 93C5 E8                       .
        inx                                     ; 93C6 E8                       .
        inx                                     ; 93C7 E8                       .
        bne     L93BC                           ; 93C8 D0 F2                    ..
L93CA:
        rts                                     ; 93CA 60                       `

; ----------------------------------------------------------------------------
L93CB:
        .byte   $5F,$67,$6F,$77,$7F,$87,$8F,$97 ; 93CB 5F 67 6F 77 7F 87 8F 97  _gow....
        .byte   $9F,$A7,$AF,$B7,$BF,$C7,$CF     ; 93D3 9F A7 AF B7 BF C7 CF     .......
L93DA:
        .byte   $40,$80                         ; 93DA 40 80                    @.
L93DC:
        .byte   $20,$41,$42,$43,$44,$45,$46,$47 ; 93DC 20 41 42 43 44 45 46 47   ABCDEFG
        .byte   $48,$49,$4A,$4B,$4C,$4D,$4E,$4F ; 93E4 48 49 4A 4B 4C 4D 4E 4F  HIJKLMNO
        .byte   $50,$51,$52,$53,$54,$55,$56,$57 ; 93EC 50 51 52 53 54 55 56 57  PQRSTUVW
        .byte   $58,$59,$5A                     ; 93F4 58 59 5A                 XYZ
; ----------------------------------------------------------------------------
L93F7:
        jsr     LA44A                           ; 93F7 20 4A A4                  J.
        jsr     LA3C2                           ; 93FA 20 C2 A3                  ..
        lda     #$08                            ; 93FD A9 08                    ..
        jsr     LB3E9                           ; 93FF 20 E9 B3                  ..
        ldx     #$05                            ; 9402 A2 05                    ..
L9404:
        lda     player1ScoreMirrorPossible,x    ; 9404 BD 30 04                 .0.
        sta     player1ScoreHundredThousands,x  ; 9407 9D 18 04                 ...
        lda     unknownScoreSlot,x              ; 940A BD 36 04                 .6.
        sta     player1LinesThousands,x         ; 940D 9D 24 04                 .$.
        dex                                     ; 9410 CA                       .
        bpl     L9404                           ; 9411 10 F1                    ..
        lda     #$F8                            ; 9413 A9 F8                    ..
        sta     gameStatePossible               ; 9415 85 29                    .)
        sta     $4C                             ; 9417 85 4C                    .L
        sta     $4D                             ; 9419 85 4D                    .M
        sta     $4E                             ; 941B 85 4E                    .N
        sta     $4F                             ; 941D 85 4F                    .O
        sta     $50                             ; 941F 85 50                    .P
        sta     $51                             ; 9421 85 51                    .Q
        jsr     L9216                           ; 9423 20 16 92                  ..
        lda     #$0A                            ; 9426 A9 0A                    ..
        sta     player2FallTimer                ; 9428 85 6B                    .k
        lda     #$8B                            ; 942A A9 8B                    ..
        sta     $36                             ; 942C 85 36                    .6
        lda     #$21                            ; 942E A9 21                    .!
        sta     $37                             ; 9430 85 37                    .7
        ldy     #$00                            ; 9432 A0 00                    ..
        sty     player1TetriminoCurrent         ; 9434 84 64                    .d
        sty     player2TetriminoCurrent         ; 9436 84 65                    .e
        sty     player1TetriminoNext            ; 9438 84 66                    .f
        sty     player2TetriminoNext            ; 943A 84 67                    .g
L943C:
        bit     PPUSTATUS                       ; 943C 2C 02 20                 ,. 
        lda     $37                             ; 943F A5 37                    .7
        sta     PPUADDR                         ; 9441 8D 06 20                 .. 
        lda     $36                             ; 9444 A5 36                    .6
        sta     PPUADDR                         ; 9446 8D 06 20                 .. 
        jsr     L94BF                           ; 9449 20 BF 94                  ..
        lda     #$00                            ; 944C A9 00                    ..
        sta     PPUDATA                         ; 944E 8D 07 20                 .. 
        sta     $38                             ; 9451 85 38                    .8
        ldx     #$06                            ; 9453 A2 06                    ..
        tya                                     ; 9455 98                       .
        asl     a                               ; 9456 0A                       .
        tay                                     ; 9457 A8                       .
L9458:
        lda     highScoreHundredThousands,y     ; 9458 B9 3C 04                 .<.
        cmp     #$30                            ; 945B C9 30                    .0
        bne     L9467                           ; 945D D0 08                    ..
        bit     $38                             ; 945F 24 38                    $8
        bmi     L9469                           ; 9461 30 06                    0.
        lda     #$00                            ; 9463 A9 00                    ..
        beq     L9469                           ; 9465 F0 02                    ..
L9467:
        dec     $38                             ; 9467 C6 38                    .8
L9469:
        sta     PPUDATA                         ; 9469 8D 07 20                 .. 
        iny                                     ; 946C C8                       .
        dex                                     ; 946D CA                       .
        bne     L9458                           ; 946E D0 E8                    ..
        lda     #$00                            ; 9470 A9 00                    ..
        sta     PPUDATA                         ; 9472 8D 07 20                 .. 
        sta     $38                             ; 9475 85 38                    .8
        tya                                     ; 9477 98                       .
        lsr     a                               ; 9478 4A                       J
        sbc     #$02                            ; 9479 E9 02                    ..
        tay                                     ; 947B A8                       .
        ldx     #$03                            ; 947C A2 03                    ..
L947E:
        lda     leaderboardLines,y              ; 947E B9 96 04                 ...
        cmp     #$30                            ; 9481 C9 30                    .0
        bne     L9491                           ; 9483 D0 0C                    ..
        cpx     #$01                            ; 9485 E0 01                    ..
        beq     L9493                           ; 9487 F0 0A                    ..
        bit     $38                             ; 9489 24 38                    $8
        bmi     L9493                           ; 948B 30 06                    0.
        lda     #$00                            ; 948D A9 00                    ..
        beq     L9493                           ; 948F F0 02                    ..
L9491:
        dec     $38                             ; 9491 C6 38                    .8
L9493:
        sta     PPUDATA                         ; 9493 8D 07 20                 .. 
        iny                                     ; 9496 C8                       .
        dex                                     ; 9497 CA                       .
        bne     L947E                           ; 9498 D0 E4                    ..
        lda     $36                             ; 949A A5 36                    .6
        clc                                     ; 949C 18                       .
        adc     #$20                            ; 949D 69 20                    i 
        sta     $36                             ; 949F 85 36                    .6
        lda     $37                             ; 94A1 A5 37                    .7
        adc     #$00                            ; 94A3 69 00                    i.
        sta     $37                             ; 94A5 85 37                    .7
        cpy     #$2D                            ; 94A7 C0 2D                    .-
        bcc     L943C                           ; 94A9 90 91                    ..
        lda     #$01                            ; 94AB A9 01                    ..
        jsr     LA6BE                           ; 94AD 20 BE A6                  ..
        lda     #$06                            ; 94B0 A9 06                    ..
        jsr     LA6BE                           ; 94B2 20 BE A6                  ..
        ldx     #$04                            ; 94B5 A2 04                    ..
        jsr     L9EB0                           ; 94B7 20 B0 9E                  ..
        lda     #$18                            ; 94BA A9 18                    ..
        jmp     LA465                           ; 94BC 4C 65 A4                 Le.

; ----------------------------------------------------------------------------
L94BF:
        lda     leaderboardInitials,y           ; 94BF B9 C3 04                 ...
        and     #$3F                            ; 94C2 29 3F                    )?
        tax                                     ; 94C4 AA                       .
        lda     L93DC,x                         ; 94C5 BD DC 93                 ...
        sta     PPUDATA                         ; 94C8 8D 07 20                 .. 
        lda     leaderboardInitials+1,y         ; 94CB B9 C4 04                 ...
        and     #$3F                            ; 94CE 29 3F                    )?
        tax                                     ; 94D0 AA                       .
        lda     L93DC,x                         ; 94D1 BD DC 93                 ...
        sta     PPUDATA                         ; 94D4 8D 07 20                 .. 
        lda     leaderboardInitials+2,y         ; 94D7 B9 C5 04                 ...
        and     #$3F                            ; 94DA 29 3F                    )?
        tax                                     ; 94DC AA                       .
        lda     L93DC,x                         ; 94DD BD DC 93                 ...
        sta     PPUDATA                         ; 94E0 8D 07 20                 .. 
        rts                                     ; 94E3 60                       `

; ----------------------------------------------------------------------------
L94E4:
        lda     #$00                            ; 94E4 A9 00                    ..
        sta     lastCurrentBlockP1,x            ; 94E6 9D BC 01                 ...
        bit     playMode                        ; 94E9 24 2F                    $/
        bpl     L94F3                           ; 94EB 10 06                    ..
        sta     lastCurrentBlockP1              ; 94ED 8D BC 01                 ...
        sta     lastCurrentBlockP2              ; 94F0 8D BD 01                 ...
L94F3:
        lda     #$30                            ; 94F3 A9 30                    .0
        sta     $36                             ; 94F5 85 36                    .6
        lda     #$01                            ; 94F7 A9 01                    ..
        sta     $4E,x                           ; 94F9 95 4E                    .N
        txa                                     ; 94FB 8A                       .
        asl     a                               ; 94FC 0A                       .
        asl     a                               ; 94FD 0A                       .
        tay                                     ; 94FE A8                       .
        lda     player1LinesOnes,y              ; 94FF B9 27 04                 .'.
        clc                                     ; 9502 18                       .
        adc     #$01                            ; 9503 69 01                    i.
        cmp     #$3A                            ; 9505 C9 3A                    .:
        bcc     L950C                           ; 9507 90 03                    ..
        sbc     #$0A                            ; 9509 E9 0A                    ..
        sec                                     ; 950B 38                       8
L950C:
        sta     player1LinesOnes,y              ; 950C 99 27 04                 .'.
        lda     player1LinesTens,y              ; 950F B9 26 04                 .&.
        adc     #$00                            ; 9512 69 00                    i.
        cmp     #$3A                            ; 9514 C9 3A                    .:
        bcc     L951B                           ; 9516 90 03                    ..
        .byte   $E9,$0A,$38                     ; 9518 E9 0A 38                 ..8
; ----------------------------------------------------------------------------
L951B:
        sta     player1LinesTens,y              ; 951B 99 26 04                 .&.
        lda     player1LinesHundreds,y          ; 951E B9 25 04                 .%.
        adc     #$00                            ; 9521 69 00                    i.
        cmp     #$3A                            ; 9523 C9 3A                    .:
        bcc     L952A                           ; 9525 90 03                    ..
        .byte   $E9,$0A,$38                     ; 9527 E9 0A 38                 ..8
; ----------------------------------------------------------------------------
L952A:
        sta     player1LinesHundreds,y          ; 952A 99 25 04                 .%.
        lda     player1LinesThousands,y         ; 952D B9 24 04                 .$.
        adc     #$00                            ; 9530 69 00                    i.
        cmp     #$3A                            ; 9532 C9 3A                    .:
        bcc     L9538                           ; 9534 90 02                    ..
        .byte   $A9,$31                         ; 9536 A9 31                    .1
; ----------------------------------------------------------------------------
L9538:
        sta     player1LinesThousands,y         ; 9538 99 24 04                 .$.
        cmp     #$30                            ; 953B C9 30                    .0
        beq     L9543                           ; 953D F0 04                    ..
        .byte   $A9,$37,$D0,$35                 ; 953F A9 37 D0 35              .7.5
; ----------------------------------------------------------------------------
L9543:
        stx     $37                             ; 9543 86 37                    .7
        ldx     #$00                            ; 9545 A2 00                    ..
L9547:
        lda     player1LinesTens,y              ; 9547 B9 26 04                 .&.
        cmp     L899A,x                         ; 954A DD 9A 89                 ...
        lda     player1LinesHundreds,y          ; 954D B9 25 04                 .%.
        sbc     L8999,x                         ; 9550 FD 99 89                 ...
        bcc     L955B                           ; 9553 90 06                    ..
        inx                                     ; 9555 E8                       .
        inx                                     ; 9556 E8                       .
        cpx     #$2A                            ; 9557 E0 2A                    .*
        bcc     L9547                           ; 9559 90 EC                    ..
L955B:
        txa                                     ; 955B 8A                       .
        lsr     a                               ; 955C 4A                       J
        ldx     $37                             ; 955D A6 37                    .7
        bit     gameStatePossible               ; 955F 24 29                    $)
        bpl     L9567                           ; 9561 10 04                    ..
        adc     #$09                            ; 9563 69 09                    i.
        bne     L956A                           ; 9565 D0 03                    ..
L9567:
        adc     menuPlayer1StartLevel,x         ; 9567 7D F1 04                 }..
L956A:
        adc     #$30                            ; 956A 69 30                    i0
        cmp     #$3A                            ; 956C C9 3A                    .:
        bcc     L957A                           ; 956E 90 0A                    ..
        .byte   $E9,$0A,$C9,$37,$90,$02,$A9,$37 ; 9570 E9 0A C9 37 90 02 A9 37  ...7...7
        .byte   $E6,$36                         ; 9578 E6 36                    .6
; ----------------------------------------------------------------------------
L957A:
        sta     $37                             ; 957A 85 37                    .7
        txa                                     ; 957C 8A                       .
        asl     a                               ; 957D 0A                       .
        tay                                     ; 957E A8                       .
        lda     player1LevelOnes,y              ; 957F B9 2D 04                 .-.
        cmp     $37                             ; 9582 C5 37                    .7
        lda     player1LevelTens,y              ; 9584 B9 2C 04                 .,.
        sbc     $36                             ; 9587 E5 36                    .6
        bcs     L95C1                           ; 9589 B0 36                    .6
        lda     $36                             ; 958B A5 36                    .6
        sta     player1LevelTens,y              ; 958D 99 2C 04                 .,.
        lda     $37                             ; 9590 A5 37                    .7
        sta     player1LevelOnes,y              ; 9592 99 2D 04                 .-.
        inc     $50,x                           ; 9595 F6 50                    .P
        inc     $01D2                           ; 9597 EE D2 01                 ...
        lda     #$00                            ; 959A A9 00                    ..
        sta     longBarCodeUsedP1,x             ; 959C 9D B8 01                 ...
        bit     playMode                        ; 959F 24 2F                    $/
        bpl     L95B3                           ; 95A1 10 10                    ..
        .byte   $98,$49,$02,$A8,$A5,$36,$99,$2C ; 95A3 98 49 02 A8 A5 36 99 2C  .I...6.,
        .byte   $04,$A5,$37,$99,$2D,$04,$A0,$00 ; 95AB 04 A5 37 99 2D 04 A0 00  ..7.-...
; ----------------------------------------------------------------------------
L95B3:
        stx     $37                             ; 95B3 86 37                    .7
        tya                                     ; 95B5 98                       .
        tax                                     ; 95B6 AA                       .
        jsr     LA756                           ; 95B7 20 56 A7                  V.
        ldx     $37                             ; 95BA A6 37                    .7
        lda     #$0B                            ; 95BC A9 0B                    ..
        jmp     possibleSetSoundOrMusic         ; 95BE 4C B1 CF                 L..

; ----------------------------------------------------------------------------
L95C1:
        lda     #$13                            ; 95C1 A9 13                    ..
        jmp     possibleSetSoundOrMusic         ; 95C3 4C B1 CF                 L..

; ----------------------------------------------------------------------------
L95C6:
        lda     #$FB                            ; 95C6 A9 FB                    ..
        sta     gameStatePossible               ; 95C8 85 29                    .)
        lda     #$00                            ; 95CA A9 00                    ..
        sta     playMode                        ; 95CC 85 2F                    ./
        lda     #$01                            ; 95CE A9 01                    ..
        jsr     possibleSetSoundOrMusic         ; 95D0 20 B1 CF                  ..
        ldx     #$05                            ; 95D3 A2 05                    ..
        lda     #$30                            ; 95D5 A9 30                    .0
L95D7:
        sta     player1ScoreHundredThousands,x  ; 95D7 9D 18 04                 ...
        sta     player1LinesThousands,x         ; 95DA 9D 24 04                 .$.
        dex                                     ; 95DD CA                       .
        bpl     L95D7                           ; 95DE 10 F7                    ..
        jmp     L95FA                           ; 95E0 4C FA 95                 L..

; ----------------------------------------------------------------------------
L95E3:
        lda     #$00                            ; 95E3 A9 00                    ..
        sta     gameStatePossible               ; 95E5 85 29                    .)
        ldx     #$05                            ; 95E7 A2 05                    ..
        lda     #$30                            ; 95E9 A9 30                    .0
L95EB:
        sta     player1ScoreHundredThousands,x  ; 95EB 9D 18 04                 ...
        sta     player2ScoreHundredThousands,x  ; 95EE 9D 1E 04                 ...
        sta     player1LinesThousands,x         ; 95F1 9D 24 04                 .$.
        sta     player2LinesTens,x              ; 95F4 9D 2A 04                 .*.
        dex                                     ; 95F7 CA                       .
        bpl     L95EB                           ; 95F8 10 F1                    ..
L95FA:
        jsr     LA44A                           ; 95FA 20 4A A4                  J.
        jsr     LA3C2                           ; 95FD 20 C2 A3                  ..
        lda     #$06                            ; 9600 A9 06                    ..
        clc                                     ; 9602 18                       .
        adc     playMode                        ; 9603 65 2F                    e/
        jsr     LB3E9                           ; 9605 20 E9 B3                  ..
        lda     #$00                            ; 9608 A9 00                    ..
        ldx     #$4B                            ; 960A A2 4B                    .K
L960C:
        sta     $00,x                           ; 960C 95 00                    ..
        inx                                     ; 960E E8                       .
        cpx     #$EF                            ; 960F E0 EF                    ..
        bne     L960C                           ; 9611 D0 F9                    ..
        sta     longBarCodeUsedP1               ; 9613 8D B8 01                 ...
        sta     longBarCodeUsedP2               ; 9616 8D B9 01                 ...
        sta     removeBlockCodeUsedP1           ; 9619 8D BA 01                 ...
        sta     removeBlockCodeUsedP2           ; 961C 8D BB 01                 ...
        sta     lastCurrentBlockP1              ; 961F 8D BC 01                 ...
        sta     lastCurrentBlockP2              ; 9622 8D BD 01                 ...
        lda     #$01                            ; 9625 A9 01                    ..
        sta     $4A                             ; 9627 85 4A                    .J
        sta     $4C                             ; 9629 85 4C                    .L
        sta     $4E                             ; 962B 85 4E                    .N
        sta     $50                             ; 962D 85 50                    .P
        ldx     playMode                        ; 962F A6 2F                    ./
        beq     L963E                           ; 9631 F0 0B                    ..
        sta     $4B                             ; 9633 85 4B                    .K
        sta     $4D                             ; 9635 85 4D                    .M
        sta     $4F                             ; 9637 85 4F                    .O
        sta     $51                             ; 9639 85 51                    .Q
        inx                                     ; 963B E8                       .
        bne     L9640                           ; 963C D0 02                    ..
L963E:
        sta     $52                             ; 963E 85 52                    .R
L9640:
        lda     menuPlayer1StartLevel           ; 9640 AD F1 04                 ...
        clc                                     ; 9643 18                       .
        adc     #$30                            ; 9644 69 30                    i0
        sta     player1LevelOnes                ; 9646 8D 2D 04                 .-.
        lda     menuPlayer2StartLevel           ; 9649 AD F2 04                 ...
        adc     #$30                            ; 964C 69 30                    i0
        sta     player2LevelOnes                ; 964E 8D 2F 04                 ./.
        lda     #$30                            ; 9651 A9 30                    .0
        sta     player1LevelTens                ; 9653 8D 2C 04                 .,.
        sta     player2LevelTens                ; 9656 8D 2E 04                 ...
        bit     gameStatePossible               ; 9659 24 29                    $)
        bpl     L9662                           ; 965B 10 05                    ..
        lda     #$39                            ; 965D A9 39                    .9
        sta     player1LevelOnes                ; 965F 8D 2D 04                 .-.
L9662:
        lda     menuGameMode                    ; 9662 AD F0 04                 ...
        cmp     #$02                            ; 9665 C9 02                    ..
        bcc     L967B                           ; 9667 90 12                    ..
        lda     player1LevelTens                ; 9669 AD 2C 04                 .,.
        sta     player2LevelTens                ; 966C 8D 2E 04                 ...
        lda     player1LevelOnes                ; 966F AD 2D 04                 .-.
        sta     player2LevelOnes                ; 9672 8D 2F 04                 ./.
        lda     menuPlayer1StartLevel           ; 9675 AD F1 04                 ...
        sta     menuPlayer2StartLevel           ; 9678 8D F2 04                 ...
L967B:
        jsr     L9B62                           ; 967B 20 62 9B                  b.
        lda     #$02                            ; 967E A9 02                    ..
        jsr     LA6BE                           ; 9680 20 BE A6                  ..
        lda     #$03                            ; 9683 A9 03                    ..
        jsr     LA6BE                           ; 9685 20 BE A6                  ..
        ldx     #$00                            ; 9688 A2 00                    ..
        jsr     LA756                           ; 968A 20 56 A7                  V.
        ldy     playMode                        ; 968D A4 2F                    ./
        dey                                     ; 968F 88                       .
        bne     L9697                           ; 9690 D0 05                    ..
        ldx     #$02                            ; 9692 A2 02                    ..
        jsr     LA756                           ; 9694 20 56 A7                  V.
L9697:
        lda     rngSeed                         ; 9697 A5 34                    .4
        sta     player1RNGSeed                  ; 9699 85 5C                    .\
        sta     player2RNGSeed                  ; 969B 85 5E                    .^
        sta     savedRNGSeedForSomething        ; 969D 85 5A                    .Z
        lda     rngSeed+1                       ; 969F A5 35                    .5
        sta     player1RNGSeed+1                ; 96A1 85 5D                    .]
        sta     player2RNGSeed+1                ; 96A3 85 5F                    ._
        sta     savedRNGSeedForSomething+1      ; 96A5 85 5B                    .[
        jsr     initializePlayfields            ; 96A7 20 C1 97                  ..
        lda     gameStatePossible               ; 96AA A5 29                    .)
        bne     L96B7                           ; 96AC D0 09                    ..
        lda     playMode                        ; 96AE A5 2F                    ./
        cmp     #$01                            ; 96B0 C9 01                    ..
        bne     L96B7                           ; 96B2 D0 03                    ..
        jsr     L9804                           ; 96B4 20 04 98                  ..
L96B7:
        ldx     #$00                            ; 96B7 A2 00                    ..
        stx     player1ControllerNew            ; 96B9 86 46                    .F
        stx     player2ControllerNew            ; 96BB 86 47                    .G
        jsr     LA035                           ; 96BD 20 35 A0                  5.
        lda     playMode                        ; 96C0 A5 2F                    ./
        bne     L9705                           ; 96C2 D0 41                    .A
        jsr     L970F                           ; 96C4 20 0F 97                  ..
        lda     #$CF                            ; 96C7 A9 CF                    ..
        sec                                     ; 96C9 38                       8
        sbc     ppuScrollYOffset                ; 96CA ED F6 04                 ...
        sta     oamStaging+204                  ; 96CD 8D CC 05                 ...
        sta     oamStaging+208                  ; 96D0 8D D0 05                 ...
        sta     oamStaging+212                  ; 96D3 8D D4 05                 ...
        clc                                     ; 96D6 18                       .
        adc     #$08                            ; 96D7 69 08                    i.
        sta     oamStaging+216                  ; 96D9 8D D8 05                 ...
        sta     oamStaging+220                  ; 96DC 8D DC 05                 ...
        lda     #$B8                            ; 96DF A9 B8                    ..
        sta     oamStaging+207                  ; 96E1 8D CF 05                 ...
        lda     #$C8                            ; 96E4 A9 C8                    ..
        sta     oamStaging+211                  ; 96E6 8D D3 05                 ...
        sta     oamStaging+219                  ; 96E9 8D DB 05                 ...
        lda     #$D0                            ; 96EC A9 D0                    ..
        sta     oamStaging+215                  ; 96EE 8D D7 05                 ...
        sta     oamStaging+223                  ; 96F1 8D DF 05                 ...
        lda     #$01                            ; 96F4 A9 01                    ..
        sta     oamStaging+206                  ; 96F6 8D CE 05                 ...
        sta     oamStaging+210                  ; 96F9 8D D2 05                 ...
        sta     oamStaging+214                  ; 96FC 8D D6 05                 ...
        sta     oamStaging+218                  ; 96FF 8D DA 05                 ...
        sta     oamStaging+222                  ; 9702 8D DE 05                 ...
L9705:
        ldx     #$00                            ; 9705 A2 00                    ..
        jsr     L9EB0                           ; 9707 20 B0 9E                  ..
        lda     #$00                            ; 970A A9 00                    ..
        jmp     LA465                           ; 970C 4C 65 A4                 Le.

; ----------------------------------------------------------------------------
L970F:
        lda     possibleGameNametable+855       ; 970F AD 7F C3                 ...
        sta     oamStaging+205                  ; 9712 8D CD 05                 ...
        lda     possibleGameNametable+857       ; 9715 AD 81 C3                 ...
        sta     oamStaging+209                  ; 9718 8D D1 05                 ...
        lda     possibleGameNametable+889       ; 971B AD A1 C3                 ...
        sta     oamStaging+217                  ; 971E 8D D9 05                 ...
        lda     possibleGameNametable+858       ; 9721 AD 82 C3                 ...
        sta     oamStaging+213                  ; 9724 8D D5 05                 ...
        lda     possibleGameNametable+890       ; 9727 AD A2 C3                 ...
        sta     oamStaging+221                  ; 972A 8D DD 05                 ...
        rts                                     ; 972D 60                       `

; ----------------------------------------------------------------------------
L972E:
        ldy     #$00                            ; 972E A0 00                    ..
        sty     oamStaging+205                  ; 9730 8C CD 05                 ...
        iny                                     ; 9733 C8                       .
        sty     oamStaging+209                  ; 9734 8C D1 05                 ...
        iny                                     ; 9737 C8                       .
        sty     oamStaging+217                  ; 9738 8C D9 05                 ...
        iny                                     ; 973B C8                       .
        sty     oamStaging+213                  ; 973C 8C D5 05                 ...
        iny                                     ; 973F C8                       .
        sty     oamStaging+221                  ; 9740 8C DD 05                 ...
        rts                                     ; 9743 60                       `

; ----------------------------------------------------------------------------
L9744:
        .byte   $86,$37,$8A,$0A,$85,$36,$0A,$85 ; 9744 86 37 8A 0A 85 36 0A 85  .7...6..
        .byte   $38,$65,$36,$AA,$A9,$30,$A0,$05 ; 974C 38 65 36 AA A9 30 A0 05  8e6..0..
        .byte   $9D,$18,$04,$E8,$88,$10,$F9,$A6 ; 9754 9D 18 04 E8 88 10 F9 A6  ........
        .byte   $38,$A0,$03,$9D,$24,$04,$E8,$88 ; 975C 38 A0 03 9D 24 04 E8 88  8...$...
        .byte   $10,$F9,$A5,$4A,$05,$4B,$D0,$03 ; 9764 10 F9 A5 4A 05 4B D0 03  ...J.K..
        .byte   $20,$35,$A0,$A6,$37,$A4,$36,$A5 ; 976C 20 35 A0 A6 37 A4 36 A5   5..7.6.
        .byte   $5A,$99,$5C,$00,$A5,$5B,$99,$5D ; 9774 5A 99 5C 00 A5 5B 99 5D  Z.\..[.]
        .byte   $00,$BD,$F1,$04,$18,$69,$30,$99 ; 977C 00 BD F1 04 18 69 30 99  .....i0.
        .byte   $2D,$04,$A9,$30,$99,$2C,$04,$95 ; 9784 2D 04 A9 30 99 2C 04 95  -..0.,..
        .byte   $4A,$95,$4C,$95,$4E,$95,$50,$A9 ; 978C 4A 95 4C 95 4E 95 50 A9  J.L.N.P.
        .byte   $00,$85,$29,$95,$66,$95,$64,$95 ; 9794 00 85 29 95 66 95 64 95  ..).f.d.
        .byte   $46,$95,$78,$9D,$B8,$01,$9D,$BA ; 979C 46 95 78 9D B8 01 9D BA  F.x.....
        .byte   $01,$9D,$BC,$01,$95,$6C,$95,$6E ; 97A4 01 9D BC 01 95 6C 95 6E  .....l.n
        .byte   $95,$70,$95,$72,$A6,$36,$20,$56 ; 97AC 95 70 95 72 A6 36 20 56  .p.r.6 V
        .byte   $A7,$A5,$37,$48,$18,$69,$05,$20 ; 97B4 A7 A5 37 48 18 69 05 20  ..7H.i. 
        .byte   $03,$B6,$68,$D0,$43             ; 97BC 03 B6 68 D0 43           ..h.C
; ----------------------------------------------------------------------------
initializePlayfields:
        ldx     #$00                            ; 97C1 A2 00                    ..
L97C3:
        lda     #$FF                            ; 97C3 A9 FF                    ..
        sta     player1Playfield,x              ; 97C5 9D 00 06                 ...
        sta     player1Playfield+7,x            ; 97C8 9D 07 06                 ...
        lda     #$00                            ; 97CB A9 00                    ..
        sta     player1Playfield+2,x            ; 97CD 9D 02 06                 ...
        sta     player1Playfield+3,x            ; 97D0 9D 03 06                 ...
        sta     player1Playfield+4,x            ; 97D3 9D 04 06                 ...
        sta     player1Playfield+5,x            ; 97D6 9D 05 06                 ...
        ldy     playMode                        ; 97D9 A4 2F                    ./
        bpl     L97E2                           ; 97DB 10 05                    ..
        sta     player1Playfield+1,x            ; 97DD 9D 01 06                 ...
        bmi     L97E9                           ; 97E0 30 07                    0.
L97E2:
        lda     #$F0                            ; 97E2 A9 F0                    ..
        sta     player1Playfield+1,x            ; 97E4 9D 01 06                 ...
        lda     #$0F                            ; 97E7 A9 0F                    ..
L97E9:
        sta     player1Playfield+6,x            ; 97E9 9D 06 06                 ...
        txa                                     ; 97EC 8A                       .
        clc                                     ; 97ED 18                       .
        adc     #$08                            ; 97EE 69 08                    i.
        tax                                     ; 97F0 AA                       .
        cpx     #$D0                            ; 97F1 E0 D0                    ..
        bne     L97C3                           ; 97F3 D0 CE                    ..
        lda     #$FF                            ; 97F5 A9 FF                    ..
        ldy     #$10                            ; 97F7 A0 10                    ..
L97F9:
        sta     player1Playfield,x              ; 97F9 9D 00 06                 ...
        inx                                     ; 97FC E8                       .
        dey                                     ; 97FD 88                       .
        bne     L97F9                           ; 97FE D0 F9                    ..
        ldx     #$00                            ; 9800 A2 00                    ..
        beq     L983C                           ; 9802 F0 38                    .8
L9804:
        ldx     #$00                            ; 9804 A2 00                    ..
L9806:
        lda     #$FF                            ; 9806 A9 FF                    ..
        sta     player2Playfield,x              ; 9808 9D 00 07                 ...
        sta     player2Playfield+7,x            ; 980B 9D 07 07                 ...
        lda     #$F0                            ; 980E A9 F0                    ..
        sta     player2Playfield+1,x            ; 9810 9D 01 07                 ...
        lda     #$00                            ; 9813 A9 00                    ..
        sta     player2Playfield+2,x            ; 9815 9D 02 07                 ...
        sta     player2Playfield+3,x            ; 9818 9D 03 07                 ...
        sta     player2Playfield+4,x            ; 981B 9D 04 07                 ...
        sta     player2Playfield+5,x            ; 981E 9D 05 07                 ...
        lda     #$0F                            ; 9821 A9 0F                    ..
        sta     player2Playfield+6,x            ; 9823 9D 06 07                 ...
        txa                                     ; 9826 8A                       .
        clc                                     ; 9827 18                       .
        adc     #$08                            ; 9828 69 08                    i.
        tax                                     ; 982A AA                       .
        cpx     #$D0                            ; 982B E0 D0                    ..
        bne     L9806                           ; 982D D0 D7                    ..
        lda     #$FF                            ; 982F A9 FF                    ..
        ldy     #$10                            ; 9831 A0 10                    ..
L9833:
        sta     player2Playfield,x              ; 9833 9D 00 07                 ...
        inx                                     ; 9836 E8                       .
        dey                                     ; 9837 88                       .
        bne     L9833                           ; 9838 D0 F9                    ..
        ldx     #$01                            ; 983A A2 01                    ..
L983C:
        lda     menuGameMode                    ; 983C AD F0 04                 ...
        cmp     #$03                            ; 983F C9 03                    ..
        lda     menuPlayer1Handicap             ; 9841 AD F3 04                 ...
        bcs     L9849                           ; 9844 B0 03                    ..
        lda     menuPlayer1Handicap,x           ; 9846 BD F3 04                 ...
L9849:
        bne     initHandicapGarbage             ; 9849 D0 01                    ..
        rts                                     ; 984B 60                       `

; ----------------------------------------------------------------------------
initHandicapGarbage:
        tay                                     ; 984C A8                       .
        stx     $38                             ; 984D 86 38                    .8
        lda     L98A6,y                         ; 984F B9 A6 98                 ...
        tay                                     ; 9852 A8                       .
        lda     playfieldIdPossible,x           ; 9853 BD 62 85                 .b.
        sta     $3B                             ; 9856 85 3B                    .;
        lda     #$00                            ; 9858 A9 00                    ..
        sta     $3A                             ; 985A 85 3A                    .:
        lda     savedRNGSeedForSomething        ; 985C A5 5A                    .Z
        sta     rngSeed                         ; 985E 85 34                    .4
        lda     savedRNGSeedForSomething+1      ; 9860 A5 5B                    .[
        sta     rngSeed+1                       ; 9862 85 35                    .5
L9864:
        lda     #$00                            ; 9864 A9 00                    ..
        sta     $37                             ; 9866 85 37                    .7
        lda     #$FE                            ; 9868 A9 FE                    ..
        sta     ($3A),y                         ; 986A 91 3A                    .:
        iny                                     ; 986C C8                       .
        ldx     #$34                            ; 986D A2 34                    .4
L986F:
        lda     ($3A),y                         ; 986F B1 3A                    .:
        jsr     L98AD                           ; 9871 20 AD 98                  ..
        sta     ($3A),y                         ; 9874 91 3A                    .:
        iny                                     ; 9876 C8                       .
        tya                                     ; 9877 98                       .
        and     #$07                            ; 9878 29 07                    ).
        bne     L986F                           ; 987A D0 F3                    ..
        lda     $37                             ; 987C A5 37                    .7
        cmp     #$07                            ; 987E C9 07                    ..
        bcc     L989E                           ; 9880 90 1C                    ..
        sty     $37                             ; 9882 84 37                    .7
        jsr     genNextPseudoRandom2x           ; 9884 20 F7 99                  ..
        and     #$03                            ; 9887 29 03                    ).
        sec                                     ; 9889 38                       8
        sbc     #$06                            ; 988A E9 06                    ..
        adc     $37                             ; 988C 65 37                    e7
        tay                                     ; 988E A8                       .
        jsr     genNextPseudoRandom             ; 988F 20 FA 99                  ..
        and     #$01                            ; 9892 29 01                    ).
        tax                                     ; 9894 AA                       .
        lda     ($3A),y                         ; 9895 B1 3A                    .:
        and     L98AB,x                         ; 9897 3D AB 98                 =..
        sta     ($3A),y                         ; 989A 91 3A                    .:
        ldy     $37                             ; 989C A4 37                    .7
L989E:
        cpy     #$D0                            ; 989E C0 D0                    ..
        bne     L9864                           ; 98A0 D0 C2                    ..
        ldx     $38                             ; 98A2 A6 38                    .8
L98A6           := * + 2
        jmp     L8ADB                           ; 98A4 4C DB 8A                 L..

; ----------------------------------------------------------------------------
        .byte   $B8,$A0,$88,$70                 ; 98A7 B8 A0 88 70              ...p
L98AB:
        .byte   $F0,$0F                         ; 98AB F0 0F                    ..
; ----------------------------------------------------------------------------
L98AD:
        cmp     #$10                            ; 98AD C9 10                    ..
        bcs     L98C0                           ; 98AF B0 0F                    ..
        sta     $36                             ; 98B1 85 36                    .6
        jsr     genNextPseudoRandom3x           ; 98B3 20 F4 99                  ..
        and     #$07                            ; 98B6 29 07                    ).
        beq     L98BE                           ; 98B8 F0 04                    ..
        inc     $37                             ; 98BA E6 37                    .7
        lda     #$F0                            ; 98BC A9 F0                    ..
L98BE:
        ora     $36                             ; 98BE 05 36                    .6
L98C0:
        sta     $36                             ; 98C0 85 36                    .6
        and     #$0F                            ; 98C2 29 0F                    ).
        bne     L98D4                           ; 98C4 D0 0E                    ..
        jsr     genNextPseudoRandom3x           ; 98C6 20 F4 99                  ..
        and     #$07                            ; 98C9 29 07                    ).
        beq     L98D4                           ; 98CB F0 07                    ..
        inc     $37                             ; 98CD E6 37                    .7
        lda     #$0F                            ; 98CF A9 0F                    ..
        ora     $36                             ; 98D1 05 36                    .6
        rts                                     ; 98D3 60                       `

; ----------------------------------------------------------------------------
L98D4:
        lda     $36                             ; 98D4 A5 36                    .6
        rts                                     ; 98D6 60                       `

; ----------------------------------------------------------------------------
L98D7:
        sta     $38                             ; 98D7 85 38                    .8
        ldy     #$00                            ; 98D9 A0 00                    ..
        sty     $39                             ; 98DB 84 39                    .9
        sty     $37                             ; 98DD 84 37                    .7
L98DF:
        lsr     $38                             ; 98DF 46 38                    F8
        bcc     L98EE                           ; 98E1 90 0B                    ..
        tya                                     ; 98E3 98                       .
        clc                                     ; 98E4 18                       .
        adc     $36                             ; 98E5 65 36                    e6
        tay                                     ; 98E7 A8                       .
        lda     $39                             ; 98E8 A5 39                    .9
        adc     $37                             ; 98EA 65 37                    e7
        sta     $39                             ; 98EC 85 39                    .9
L98EE:
        lda     $38                             ; 98EE A5 38                    .8
        beq     L98F8                           ; 98F0 F0 06                    ..
        asl     $36                             ; 98F2 06 36                    .6
        rol     $37                             ; 98F4 26 37                    &7
        bcc     L98DF                           ; 98F6 90 E7                    ..
L98F8:
        lda     #$00                            ; 98F8 A9 00                    ..
        sta     $36                             ; 98FA 85 36                    .6
        sta     $37                             ; 98FC 85 37                    .7
L98FE:
        lda     $39                             ; 98FE A5 39                    .9
        beq     L9911                           ; 9900 F0 0F                    ..
        tya                                     ; 9902 98                       .
        sec                                     ; 9903 38                       8
        sbc     #$64                            ; 9904 E9 64                    .d
        tay                                     ; 9906 A8                       .
        lda     $39                             ; 9907 A5 39                    .9
        sbc     #$00                            ; 9909 E9 00                    ..
        sta     $39                             ; 990B 85 39                    .9
        inc     $36                             ; 990D E6 36                    .6
        bne     L98FE                           ; 990F D0 ED                    ..
L9911:
        tya                                     ; 9911 98                       .
L9912:
        cmp     #$64                            ; 9912 C9 64                    .d
        bcc     L991C                           ; 9914 90 06                    ..
        sbc     #$64                            ; 9916 E9 64                    .d
        inc     $36                             ; 9918 E6 36                    .6
        bne     L9912                           ; 991A D0 F6                    ..
L991C:
        cmp     #$0A                            ; 991C C9 0A                    ..
        bcc     L9926                           ; 991E 90 06                    ..
        sbc     #$0A                            ; 9920 E9 0A                    ..
        inc     $37                             ; 9922 E6 37                    .7
        bne     L991C                           ; 9924 D0 F6                    ..
L9926:
        sta     $38                             ; 9926 85 38                    .8
        rts                                     ; 9928 60                       `

; ----------------------------------------------------------------------------
getNextTetrimino:
        lda     #$14                            ; 9929 A9 14                    ..
        sta     player1FallTimer,x              ; 992B 95 6A                    .j
        sta     $01B4,x                         ; 992D 9D B4 01                 ...
L9930:
        lda     player1TetriminoNext,x          ; 9930 B5 66                    .f
        sta     player1TetriminoCurrent,x       ; 9932 95 64                    .d
        stx     $3B                             ; 9934 86 3B                    .;
        txa                                     ; 9936 8A                       .
        asl     a                               ; 9937 0A                       .
        adc     #$5C                            ; 9938 69 5C                    i\
        tax                                     ; 993A AA                       .
L993B:
        jsr     genNextPseudoRandom5x           ; 993B 20 EE 99                  ..
        and     #$07                            ; 993E 29 07                    ).
        beq     L993B                           ; 9940 F0 F9                    ..
        ldx     $3B                             ; 9942 A6 3B                    .;
        sta     player1TetriminoNext,x          ; 9944 95 66                    .f
        lda     player1TetriminoCurrent,x       ; 9946 B5 64                    .d
        bne     L9950                           ; 9948 D0 06                    ..
        lda     #$30                            ; 994A A9 30                    .0
        sta     player1FallTimer,x              ; 994C 95 6A                    .j
        bne     L9930                           ; 994E D0 E0                    ..
L9950:
        lda     #$00                            ; 9950 A9 00                    ..
        sta     player1TetriminoOrientation,x   ; 9952 95 68                    .h
        lda     #$04                            ; 9954 A9 04                    ..
        sta     player1TetriminoY,x             ; 9956 95 60                    .`
        lda     L99ED                           ; 9958 AD ED 99                 ...
        ldy     playMode                        ; 995B A4 2F                    ./
        bpl     L9962                           ; 995D 10 03                    ..
        lda     L99EB,x                         ; 995F BD EB 99                 ...
L9962:
        sta     player1TetriminoX,x             ; 9962 95 62                    .b
        ldy     player1TetriminoCurrent,x       ; 9964 B4 64                    .d
        jsr     LA763                           ; 9966 20 63 A7                  c.
        ldx     $3B                             ; 9969 A6 3B                    .;
        inx                                     ; 996B E8                       .
        inx                                     ; 996C E8                       .
        ldy     player1TetriminoCurrent,x       ; 996D B4 64                    .d
        jsr     LA763                           ; 996F 20 63 A7                  c.
        ldx     $3B                             ; 9972 A6 3B                    .;
        lda     player1TetriminoCurrent,x       ; 9974 B5 64                    .d
        beq     L99EA                           ; 9976 F0 72                    .r
        lda     gameStatePossible               ; 9978 A5 29                    .)
        cmp     #$FB                            ; 997A C9 FB                    ..
        bne     L9984                           ; 997C D0 06                    ..
        jsr     L9C8D                           ; 997E 20 8D 9C                  ..
        jmp     L9997                           ; 9981 4C 97 99                 L..

; ----------------------------------------------------------------------------
L9984:
        lda     menuGameMode                    ; 9984 AD F0 04                 ...
        beq     L9997                           ; 9987 F0 0E                    ..
        cmp     #$03                            ; 9989 C9 03                    ..
        bcc     L99EA                           ; 998B 90 5D                    .]
        bne     L9992                           ; 998D D0 03                    ..
        txa                                     ; 998F 8A                       .
        beq     L99EA                           ; 9990 F0 58                    .X
L9992:
        ldx     #$01                            ; 9992 A2 01                    ..
        jmp     L9C8D                           ; 9994 4C 8D 9C                 L..

; ----------------------------------------------------------------------------
L9997:
        ldx     player1TetriminoCurrent         ; 9997 A6 64                    .d
        lda     $52,x                           ; 9999 B5 52                    .R
        cmp     #$90                            ; 999B C9 90                    ..
        bcs     L99EA                           ; 999D B0 4B                    .K
        and     #$07                            ; 999F 29 07                    ).
        ldy     #$00                            ; 99A1 A0 00                    ..
        clc                                     ; 99A3 18                       .
        adc     #$21                            ; 99A4 69 21                    i!
        sta     $36                             ; 99A6 85 36                    .6
        jsr     LA3DB                           ; 99A8 20 DB A3                  ..
        lda     $48                             ; 99AB A5 48                    .H
        sta     ppuDataAddress1,x               ; 99AD 95 08                    ..
        lda     $49                             ; 99AF A5 49                    .I
        sta     ppuDataAddress1+1,x             ; 99B1 95 09                    ..
        lda     $36                             ; 99B3 A5 36                    .6
        sta     ($48),y                         ; 99B5 91 48                    .H
        inc     $48                             ; 99B7 E6 48                    .H
        lda     #$23                            ; 99B9 A9 23                    .#
        sta     $17,x                           ; 99BB 95 17                    ..
        ldy     player1TetriminoCurrent         ; 99BD A4 64                    .d
        lda     $52,y                           ; 99BF B9 52 00                 .R.
        and     #$F8                            ; 99C2 29 F8                    ).
        asl     a                               ; 99C4 0A                       .
        bcc     L99CB                           ; 99C5 90 04                    ..
        .byte   $D6,$17,$D6,$17                 ; 99C7 D6 17 D6 17              ....
; ----------------------------------------------------------------------------
L99CB:
        asl     a                               ; 99CB 0A                       .
        bcc     L99D0                           ; 99CC 90 02                    ..
        .byte   $D6,$17                         ; 99CE D6 17                    ..
; ----------------------------------------------------------------------------
L99D0:
        sta     $36                             ; 99D0 85 36                    .6
        lda     player1TetriminoCurrent         ; 99D2 A5 64                    .d
        clc                                     ; 99D4 18                       .
        adc     #$34                            ; 99D5 69 34                    i4
        sec                                     ; 99D7 38                       8
        sbc     $36                             ; 99D8 E5 36                    .6
        sta     $16,x                           ; 99DA 95 16                    ..
        lda     $17,x                           ; 99DC B5 17                    ..
        sbc     #$00                            ; 99DE E9 00                    ..
        sta     $17,x                           ; 99E0 95 17                    ..
        lda     #$01                            ; 99E2 A9 01                    ..
        sta     $24,x                           ; 99E4 95 24                    .$
        ldx     player1TetriminoCurrent         ; 99E6 A6 64                    .d
        inc     $52,x                           ; 99E8 F6 52                    .R
L99EA:
        rts                                     ; 99EA 60                       `

; ----------------------------------------------------------------------------
L99EB:
        .byte   $03,$09                         ; 99EB 03 09                    ..
L99ED:
        .byte   $07                             ; 99ED 07                       .
; ----------------------------------------------------------------------------
genNextPseudoRandom5x:
        jsr     genNextPseudoRandom             ; 99EE 20 FA 99                  ..
        jsr     genNextPseudoRandom             ; 99F1 20 FA 99                  ..
genNextPseudoRandom3x:
        jsr     genNextPseudoRandom             ; 99F4 20 FA 99                  ..
genNextPseudoRandom2x:
        jsr     genNextPseudoRandom             ; 99F7 20 FA 99                  ..
genNextPseudoRandom:
        lda     $00,x                           ; 99FA B5 00                    ..
        eor     $01,x                           ; 99FC 55 01                    U.
        bne     L9A04                           ; 99FE D0 04                    ..
        cmp     $01,x                           ; 9A00 D5 01                    ..
        beq     L9A06                           ; 9A02 F0 02                    ..
L9A04:
        asl     a                               ; 9A04 0A                       .
        asl     a                               ; 9A05 0A                       .
L9A06:
        rol     $00,x                           ; 9A06 36 00                    6.
        rol     $01,x                           ; 9A08 36 01                    6.
        lda     $00,x                           ; 9A0A B5 00                    ..
        rts                                     ; 9A0C 60                       `

; ----------------------------------------------------------------------------
L9A0D:
        stx     $3B                             ; 9A0D 86 3B                    .;
        ldx     #$34                            ; 9A0F A2 34                    .4
        jsr     genNextPseudoRandom5x           ; 9A11 20 EE 99                  ..
        ldx     $3B                             ; 9A14 A6 3B                    .;
        rts                                     ; 9A16 60                       `

; ----------------------------------------------------------------------------
L9A17:
        lda     $01B4,x                         ; 9A17 BD B4 01                 ...
        cmp     #$02                            ; 9A1A C9 02                    ..
        bcs     L9A46                           ; 9A1C B0 28                    .(
        lda     $38                             ; 9A1E A5 38                    .8
        adc     $38                             ; 9A20 65 38                    e8
        cmp     #$0A                            ; 9A22 C9 0A                    ..
        bcc     L9A28                           ; 9A24 90 02                    ..
        sbc     #$0A                            ; 9A26 E9 0A                    ..
L9A28:
        sta     $38                             ; 9A28 85 38                    .8
        lda     $37                             ; 9A2A A5 37                    .7
        adc     $37                             ; 9A2C 65 37                    e7
        cmp     #$0A                            ; 9A2E C9 0A                    ..
        bcc     L9A34                           ; 9A30 90 02                    ..
        sbc     #$0A                            ; 9A32 E9 0A                    ..
L9A34:
        sta     $37                             ; 9A34 85 37                    .7
        lda     $36                             ; 9A36 A5 36                    .6
        adc     $36                             ; 9A38 65 36                    e6
        cmp     #$0A                            ; 9A3A C9 0A                    ..
        bcc     L9A44                           ; 9A3C 90 06                    ..
        .byte   $A9,$09,$85,$38,$85,$37         ; 9A3E A9 09 85 38 85 37        ...8.7
; ----------------------------------------------------------------------------
L9A44:
        sta     $36                             ; 9A44 85 36                    .6
L9A46:
        rts                                     ; 9A46 60                       `

; ----------------------------------------------------------------------------
L9A47:
        txa                                     ; 9A47 8A                       .
        asl     a                               ; 9A48 0A                       .
        tay                                     ; 9A49 A8                       .
        lda     player1LevelOnes,y              ; 9A4A B9 2D 04                 .-.
        sec                                     ; 9A4D 38                       8
        sbc     #$2F                            ; 9A4E E9 2F                    ./
        sta     $36                             ; 9A50 85 36                    .6
        lda     player1LevelTens,y              ; 9A52 B9 2C 04                 .,.
        cmp     #$31                            ; 9A55 C9 31                    .1
        bcc     L9A5F                           ; 9A57 90 06                    ..
        .byte   $A5,$36,$69,$09,$85,$36         ; 9A59 A5 36 69 09 85 36        .6i..6
; ----------------------------------------------------------------------------
L9A5F:
        lda     $36                             ; 9A5F A5 36                    .6
        clc                                     ; 9A61 18                       .
        adc     $2D                             ; 9A62 65 2D                    e-
        jsr     L98D7                           ; 9A64 20 D7 98                  ..
        jsr     L9A17                           ; 9A67 20 17 9A                  ..
L9A6A:
        txa                                     ; 9A6A 8A                       .
        sta     $39                             ; 9A6B 85 39                    .9
        asl     a                               ; 9A6D 0A                       .
        adc     $39                             ; 9A6E 65 39                    e9
        asl     a                               ; 9A70 0A                       .
        tay                                     ; 9A71 A8                       .
        lda     $38                             ; 9A72 A5 38                    .8
        clc                                     ; 9A74 18                       .
        adc     player1ScoreOnes,y              ; 9A75 79 1D 04                 y..
        cmp     #$3A                            ; 9A78 C9 3A                    .:
        bcc     L9A7F                           ; 9A7A 90 03                    ..
        sbc     #$0A                            ; 9A7C E9 0A                    ..
        sec                                     ; 9A7E 38                       8
L9A7F:
        sta     player1ScoreOnes,y              ; 9A7F 99 1D 04                 ...
        lda     player1ScoreTens,y              ; 9A82 B9 1C 04                 ...
        adc     $37                             ; 9A85 65 37                    e7
        cmp     #$3A                            ; 9A87 C9 3A                    .:
        bcc     L9A8E                           ; 9A89 90 03                    ..
        sbc     #$0A                            ; 9A8B E9 0A                    ..
        sec                                     ; 9A8D 38                       8
L9A8E:
        sta     player1ScoreTens,y              ; 9A8E 99 1C 04                 ...
        lda     player1ScoreHundreds,y          ; 9A91 B9 1B 04                 ...
        adc     $36                             ; 9A94 65 36                    e6
        cmp     #$3A                            ; 9A96 C9 3A                    .:
        bcc     L9A9D                           ; 9A98 90 03                    ..
        sbc     #$0A                            ; 9A9A E9 0A                    ..
        sec                                     ; 9A9C 38                       8
L9A9D:
        sta     player1ScoreHundreds,y          ; 9A9D 99 1B 04                 ...
        lda     player1ScoreThousands,y         ; 9AA0 B9 1A 04                 ...
        adc     #$00                            ; 9AA3 69 00                    i.
        cmp     #$3A                            ; 9AA5 C9 3A                    .:
        bcc     L9AAC                           ; 9AA7 90 03                    ..
        sbc     #$0A                            ; 9AA9 E9 0A                    ..
        sec                                     ; 9AAB 38                       8
L9AAC:
        sta     player1ScoreThousands,y         ; 9AAC 99 1A 04                 ...
        lda     player1ScoreTenThousands,y      ; 9AAF B9 19 04                 ...
        adc     #$00                            ; 9AB2 69 00                    i.
        cmp     #$3A                            ; 9AB4 C9 3A                    .:
        bcc     L9ABB                           ; 9AB6 90 03                    ..
        .byte   $E9,$0A,$38                     ; 9AB8 E9 0A 38                 ..8
; ----------------------------------------------------------------------------
L9ABB:
        sta     player1ScoreTenThousands,y      ; 9ABB 99 19 04                 ...
        lda     player1ScoreHundredThousands,y  ; 9ABE B9 18 04                 ...
        adc     #$00                            ; 9AC1 69 00                    i.
        cmp     #$3A                            ; 9AC3 C9 3A                    .:
        bcc     L9AC9                           ; 9AC5 90 02                    ..
        .byte   $A9,$31                         ; 9AC7 A9 31                    .1
; ----------------------------------------------------------------------------
L9AC9:
        sta     player1ScoreHundredThousands,y  ; 9AC9 99 18 04                 ...
        inc     $4C,x                           ; 9ACC F6 4C                    .L
        lda     gameStatePossible               ; 9ACE A5 29                    .)
        bne     L9AED                           ; 9AD0 D0 1B                    ..
        lda     menuGameMode                    ; 9AD2 AD F0 04                 ...
        cmp     #$03                            ; 9AD5 C9 03                    ..
        bcc     L9ADC                           ; 9AD7 90 03                    ..
        tya                                     ; 9AD9 98                       .
        bne     L9AED                           ; 9ADA D0 11                    ..
L9ADC:
        ldy     #$05                            ; 9ADC A0 05                    ..
L9ADE:
        lda     player1ScoreHundredThousands,y  ; 9ADE B9 18 04                 ...
        sta     player1ScoreMirrorPossible,y    ; 9AE1 99 30 04                 .0.
        lda     player1LinesThousands,y         ; 9AE4 B9 24 04                 .$.
        sta     unknownScoreSlot,y              ; 9AE7 99 36 04                 .6.
        dey                                     ; 9AEA 88                       .
        bpl     L9ADE                           ; 9AEB 10 F1                    ..
L9AED:
        rts                                     ; 9AED 60                       `

; ----------------------------------------------------------------------------
L9AEE:
        txa                                     ; 9AEE 8A                       .
        asl     a                               ; 9AEF 0A                       .
        tay                                     ; 9AF0 A8                       .
        lda     player1LevelTens,y              ; 9AF1 B9 2C 04                 .,.
        sec                                     ; 9AF4 38                       8
        sbc     #$30                            ; 9AF5 E9 30                    .0
        beq     L9AFB                           ; 9AF7 F0 02                    ..
        .byte   $A9,$0A                         ; 9AF9 A9 0A                    ..
; ----------------------------------------------------------------------------
L9AFB:
        clc                                     ; 9AFB 18                       .
        adc     player1LevelOnes,y              ; 9AFC 79 2D 04                 y-.
        sec                                     ; 9AFF 38                       8
        sbc     #$30                            ; 9B00 E9 30                    .0
        tay                                     ; 9B02 A8                       .
        cpy     #$0A                            ; 9B03 C0 0A                    ..
        bcc     L9B21                           ; 9B05 90 1A                    ..
        .byte   $24,$2F,$30,$1D,$C0,$10,$90,$0A ; 9B07 24 2F 30 1D C0 10 90 0A  $/0.....
        .byte   $B5,$60,$39,$50,$9B,$D0,$0B,$88 ; 9B0F B5 60 39 50 9B D0 0B 88  .`9P....
        .byte   $D0,$08,$B5,$60,$39,$50,$9B,$F0 ; 9B17 D0 08 B5 60 39 50 9B F0  ...`9P..
        .byte   $01,$88                         ; 9B1F 01 88                    ..
; ----------------------------------------------------------------------------
L9B21:
        lda     possibleFallTimerTable,y        ; 9B21 B9 36 9B                 .6.
        bit     playMode                        ; 9B24 24 2F                    $/
        bpl     L9B2B                           ; 9B26 10 03                    ..
        lda     L9B48,y                         ; 9B28 B9 48 9B                 .H.
L9B2B:
        sta     player1FallTimer,x              ; 9B2B 95 6A                    .j
        cmp     $01B4,x                         ; 9B2D DD B4 01                 ...
        bcs     L9B35                           ; 9B30 B0 03                    ..
        sta     $01B4,x                         ; 9B32 9D B4 01                 ...
L9B35:
        rts                                     ; 9B35 60                       `

; ----------------------------------------------------------------------------
possibleFallTimerTable:
        .byte   $21,$1C,$18,$14,$11,$0E,$0B,$09 ; 9B36 21 1C 18 14 11 0E 0B 09  !.......
        .byte   $07,$06,$05,$05,$04,$04,$03,$04 ; 9B3E 07 06 05 05 04 04 03 04  ........
        .byte   $03,$03                         ; 9B46 03 03                    ..
L9B48:
        .byte   $21,$1C,$18,$14,$12,$11,$10,$0F ; 9B48 21 1C 18 14 12 11 10 0F  !.......
        .byte   $0E,$0D,$0C,$0B,$0A,$09,$08,$07 ; 9B50 0E 0D 0C 0B 0A 09 08 07  ........
        .byte   $06,$05,$01,$00,$01,$00,$03,$01 ; 9B58 06 05 01 00 01 00 03 01  ........
        .byte   $03,$00                         ; 9B60 03 00                    ..
; ----------------------------------------------------------------------------
L9B62:
        ldx     #$06                            ; 9B62 A2 06                    ..
L9B64:
        lda     $4C,x                           ; 9B64 B5 4C                    .L
        beq     L9BD1                           ; 9B66 F0 69                    .i
        lda     #$00                            ; 9B68 A9 00                    ..
        sta     $4C,x                           ; 9B6A 95 4C                    .L
        stx     $38                             ; 9B6C 86 38                    .8
        txa                                     ; 9B6E 8A                       .
        asl     a                               ; 9B6F 0A                       .
        tay                                     ; 9B70 A8                       .
        jsr     LA3DB                           ; 9B71 20 DB A3                  ..
        lda     L9BDC,y                         ; 9B74 B9 DC 9B                 ...
        sta     ppuDataAddress1,x               ; 9B77 95 08                    ..
        sta     $36                             ; 9B79 85 36                    .6
        lda     L9BDD,y                         ; 9B7B B9 DD 9B                 ...
        sta     ppuDataAddress1+1,x             ; 9B7E 95 09                    ..
        sta     $37                             ; 9B80 85 37                    .7
        bit     playMode                        ; 9B82 24 2F                    $/
        bpl     L9B96                           ; 9B84 10 10                    ..
        lda     gameStatePossible               ; 9B86 A5 29                    .)
        bmi     L9B96                           ; 9B88 30 0C                    0.
        cpy     #$08                            ; 9B8A C0 08                    ..
        bcc     L9B96                           ; 9B8C 90 08                    ..
        cpy     #$0C                            ; 9B8E C0 0C                    ..
        ldy     #$10                            ; 9B90 A0 10                    ..
        bcs     L9B96                           ; 9B92 B0 02                    ..
        ldy     #$0E                            ; 9B94 A0 0E                    ..
L9B96:
        lda     L9BEA,y                         ; 9B96 B9 EA 9B                 ...
        sta     $16,x                           ; 9B99 95 16                    ..
        lda     L9BEB,y                         ; 9B9B B9 EB 9B                 ...
        sta     $17,x                           ; 9B9E 95 17                    ..
        sty     $3A                             ; 9BA0 84 3A                    .:
        ldy     $38                             ; 9BA2 A4 38                    .8
        lda     L9BD5,y                         ; 9BA4 B9 D5 9B                 ...
        sta     $39                             ; 9BA7 85 39                    .9
        ldy     #$00                            ; 9BA9 A0 00                    ..
L9BAB:
        lda     ($36),y                         ; 9BAB B1 36                    .6
        cmp     #$30                            ; 9BAD C9 30                    .0
        bne     L9BCB                           ; 9BAF D0 1A                    ..
        inc     ppuDataAddress1,x               ; 9BB1 F6 08                    ..
        lda     $3A                             ; 9BB3 A5 3A                    .:
        cmp     #$0E                            ; 9BB5 C9 0E                    ..
        beq     L9BC2                           ; 9BB7 F0 09                    ..
        bcs     L9BC0                           ; 9BB9 B0 05                    ..
        lda     $38                             ; 9BBB A5 38                    .8
        lsr     a                               ; 9BBD 4A                       J
        bcs     L9BC2                           ; 9BBE B0 02                    ..
L9BC0:
        inc     $16,x                           ; 9BC0 F6 16                    ..
L9BC2:
        dec     $39                             ; 9BC2 C6 39                    .9
        iny                                     ; 9BC4 C8                       .
        lda     $39                             ; 9BC5 A5 39                    .9
        cmp     #$02                            ; 9BC7 C9 02                    ..
        bcs     L9BAB                           ; 9BC9 B0 E0                    ..
L9BCB:
        lda     $39                             ; 9BCB A5 39                    .9
        sta     $24,x                           ; 9BCD 95 24                    .$
        ldx     $38                             ; 9BCF A6 38                    .8
L9BD1:
        dex                                     ; 9BD1 CA                       .
        bpl     L9B64                           ; 9BD2 10 90                    ..
        rts                                     ; 9BD4 60                       `

; ----------------------------------------------------------------------------
L9BD5:
        .byte   $06,$06,$04,$04,$02,$02,$06     ; 9BD5 06 06 04 04 02 02 06     .......
L9BDC:
        .byte   $18                             ; 9BDC 18                       .
L9BDD:
        .byte   $04,$1E,$04,$24,$04,$28,$04,$2C ; 9BDD 04 1E 04 24 04 28 04 2C  ...$.(.,
        .byte   $04,$2E,$04,$3C,$04             ; 9BE5 04 2E 04 3C 04           ...<.
L9BEA:
        .byte   $47                             ; 9BEA 47                       G
L9BEB:
        .byte   $20,$53,$20,$89,$20,$93,$20,$CB ; 9BEB 20 53 20 89 20 93 20 CB   S . . .
        .byte   $20,$D3,$20,$96,$20,$84,$21,$B8 ; 9BF3 20 D3 20 96 20 84 21 B8   . . .!.
        .byte   $21                             ; 9BFB 21                       !
; ----------------------------------------------------------------------------
L9BFC:
        ldx     #$00                            ; 9BFC A2 00                    ..
        lda     gameStatePossible               ; 9BFE A5 29                    .)
        beq     L9C4C                           ; 9C00 F0 4A                    .J
        cmp     #$FB                            ; 9C02 C9 FB                    ..
        beq     L9C58                           ; 9C04 F0 52                    .R
        cmp     #$FA                            ; 9C06 C9 FA                    ..
        beq     moveScreenUpOrDown              ; 9C08 F0 01                    ..
L9C0A:
        rts                                     ; 9C0A 60                       `

; ----------------------------------------------------------------------------
moveScreenUpOrDown:
        jsr     LA9CE                           ; 9C0B 20 CE A9                  ..
        lda     frameCounterLow                 ; 9C0E A5 32                    .2
        and     #$0F                            ; 9C10 29 0F                    ).
        bne     L9C3D                           ; 9C12 D0 29                    .)
        lda     player1ControllerHeld           ; 9C14 A5 42                    .B
        sta     $36                             ; 9C16 85 36                    .6
        lda     player2ControllerHeld           ; 9C18 A5 43                    .C
        and     $36                             ; 9C1A 25 36                    %6
        sta     $36                             ; 9C1C 85 36                    .6
        ldy     ppuScrollYOffset                ; 9C1E AC F6 04                 ...
        and     #$10                            ; 9C21 29 10                    ).
        beq     @bothUpsNotPressed              ; 9C23 F0 05                    ..
        iny                                     ; 9C25 C8                       .
        cpy     #$09                            ; 9C26 C0 09                    ..
        beq     L9C3D                           ; 9C28 F0 13                    ..
@bothUpsNotPressed:
        lda     $36                             ; 9C2A A5 36                    .6
        and     #$20                            ; 9C2C 29 20                    ) 
        beq     @bothDownsNotPressed            ; 9C2E F0 05                    ..
        dey                                     ; 9C30 88                       .
        cpy     #$F7                            ; 9C31 C0 F7                    ..
        beq     L9C3D                           ; 9C33 F0 08                    ..
@bothDownsNotPressed:
        sty     ppuScrollYOffset                ; 9C35 8C F6 04                 ...
        sty     ppuScrollY                      ; 9C38 84 03                    ..
        jsr     drawCathedralSprites            ; 9C3A 20 69 B3                  i.
L9C3D:
        lda     frameCounterHigh                ; 9C3D A5 33                    .3
        cmp     #$05                            ; 9C3F C9 05                    ..
        bne     L9C0A                           ; 9C41 D0 C7                    ..
        lda     frameCounterLow                 ; 9C43 A5 32                    .2
        cmp     #$20                            ; 9C45 C9 20                    . 
        bne     L9C0A                           ; 9C47 D0 C1                    ..
        jmp     L95C6                           ; 9C49 4C C6 95                 L..

; ----------------------------------------------------------------------------
L9C4C:
        lda     menuGameMode                    ; 9C4C AD F0 04                 ...
        cmp     #$03                            ; 9C4F C9 03                    ..
        bcc     L9C0A                           ; 9C51 90 B7                    ..
        inx                                     ; 9C53 E8                       .
        lda     $4A,x                           ; 9C54 B5 4A                    .J
        beq     L9C0A                           ; 9C56 F0 B2                    ..
L9C58:
        ldy     #$00                            ; 9C58 A0 00                    ..
        lda     frameCounterLow                 ; 9C5A A5 32                    .2
        and     #$07                            ; 9C5C 29 07                    ).
        bne     L9C6E                           ; 9C5E D0 0E                    ..
        lda     $01CA                           ; 9C60 AD CA 01                 ...
        sec                                     ; 9C63 38                       8
        sbc     player1TetriminoX,x             ; 9C64 F5 62                    .b
        beq     L9C6E                           ; 9C66 F0 06                    ..
        ldy     #$80                            ; 9C68 A0 80                    ..
        bcs     L9C6E                           ; 9C6A B0 02                    ..
        ldy     #$40                            ; 9C6C A0 40                    .@
L9C6E:
        lda     frameCounterLow                 ; 9C6E A5 32                    .2
        and     #$0F                            ; 9C70 29 0F                    ).
        bne     L9C8A                           ; 9C72 D0 16                    ..
        lda     $01CB                           ; 9C74 AD CB 01                 ...
        sec                                     ; 9C77 38                       8
        sbc     player1TetriminoOrientation,x   ; 9C78 F5 68                    .h
        beq     L9C8A                           ; 9C7A F0 0E                    ..
        and     #$03                            ; 9C7C 29 03                    ).
        cmp     #$03                            ; 9C7E C9 03                    ..
        tya                                     ; 9C80 98                       .
        bcc     L9C87                           ; 9C81 90 04                    ..
        ora     #$01                            ; 9C83 09 01                    ..
        bne     L9C89                           ; 9C85 D0 02                    ..
L9C87:
        ora     #$02                            ; 9C87 09 02                    ..
L9C89:
        tay                                     ; 9C89 A8                       .
L9C8A:
        sty     player1ControllerNew,x          ; 9C8A 94 46                    .F
        rts                                     ; 9C8C 60                       `

; ----------------------------------------------------------------------------
L9C8D:
        lda     player1TetriminoCurrent,x       ; 9C8D B5 64                    .d
        asl     a                               ; 9C8F 0A                       .
        asl     a                               ; 9C90 0A                       .
        asl     a                               ; 9C91 0A                       .
        asl     a                               ; 9C92 0A                       .
        sta     $36                             ; 9C93 85 36                    .6
        lda     #$00                            ; 9C95 A9 00                    ..
        sta     $38                             ; 9C97 85 38                    .8
        ldx     playMode                        ; 9C99 A6 2F                    ./
        bpl     L9C9F                           ; 9C9B 10 02                    ..
        ldx     #$02                            ; 9C9D A2 02                    ..
L9C9F:
        lda     playfieldIdPossible,x           ; 9C9F BD 62 85                 .b.
        sta     $39                             ; 9CA2 85 39                    .9
        ldx     #$00                            ; 9CA4 A2 00                    ..
        ldy     #$28                            ; 9CA6 A0 28                    .(
L9CA8:
        tya                                     ; 9CA8 98                       .
        clc                                     ; 9CA9 18                       .
        adc     #$08                            ; 9CAA 69 08                    i.
        tay                                     ; 9CAC A8                       .
        lda     ($38),y                         ; 9CAD B1 38                    .8
        and     #$F0                            ; 9CAF 29 F0                    ).
        beq     L9CA8                           ; 9CB1 F0 F5                    ..
        tya                                     ; 9CB3 98                       .
        and     #$F8                            ; 9CB4 29 F8                    ).
        sta     $07E0,x                         ; 9CB6 9D E0 07                 ...
        tya                                     ; 9CB9 98                       .
        and     #$07                            ; 9CBA 29 07                    ).
        clc                                     ; 9CBC 18                       .
        adc     #$28                            ; 9CBD 69 28                    i(
        tay                                     ; 9CBF A8                       .
        inx                                     ; 9CC0 E8                       .
L9CC1:
        tya                                     ; 9CC1 98                       .
        clc                                     ; 9CC2 18                       .
        adc     #$08                            ; 9CC3 69 08                    i.
        tay                                     ; 9CC5 A8                       .
        lda     ($38),y                         ; 9CC6 B1 38                    .8
        and     #$0F                            ; 9CC8 29 0F                    ).
        beq     L9CC1                           ; 9CCA F0 F5                    ..
        tya                                     ; 9CCC 98                       .
        and     #$F8                            ; 9CCD 29 F8                    ).
        sta     $07E0,x                         ; 9CCF 9D E0 07                 ...
        tya                                     ; 9CD2 98                       .
        and     #$07                            ; 9CD3 29 07                    ).
        sec                                     ; 9CD5 38                       8
        adc     #$28                            ; 9CD6 69 28                    i(
        tay                                     ; 9CD8 A8                       .
        inx                                     ; 9CD9 E8                       .
        cpx     #$10                            ; 9CDA E0 10                    ..
        bcc     L9CA8                           ; 9CDC 90 CA                    ..
        lda     #$00                            ; 9CDE A9 00                    ..
        sta     $07FC                           ; 9CE0 8D FC 07                 ...
        sta     $07FD                           ; 9CE3 8D FD 07                 ...
        ldx     #$02                            ; 9CE6 A2 02                    ..
L9CE8:
        ldy     $36                             ; 9CE8 A4 36                    .6
        jsr     L9D3A                           ; 9CEA 20 3A 9D                  :.
        lda     $36                             ; 9CED A5 36                    .6
        clc                                     ; 9CEF 18                       .
        adc     #$04                            ; 9CF0 69 04                    i.
        tay                                     ; 9CF2 A8                       .
        jsr     L9D3A                           ; 9CF3 20 3A 9D                  :.
        lda     $36                             ; 9CF6 A5 36                    .6
        clc                                     ; 9CF8 18                       .
        adc     #$08                            ; 9CF9 69 08                    i.
        tay                                     ; 9CFB A8                       .
        jsr     L9D3A                           ; 9CFC 20 3A 9D                  :.
        lda     $36                             ; 9CFF A5 36                    .6
        clc                                     ; 9D01 18                       .
        adc     #$0C                            ; 9D02 69 0C                    i.
        tay                                     ; 9D04 A8                       .
        jsr     L9D3A                           ; 9D05 20 3A 9D                  :.
        inx                                     ; 9D08 E8                       .
        cpx     #$0E                            ; 9D09 E0 0E                    ..
        bcc     L9CE8                           ; 9D0B 90 DB                    ..
        ldx     $07FA                           ; 9D0D AE FA 07                 ...
        ldy     $07F8                           ; 9D10 AC F8 07                 ...
        lda     $07FC                           ; 9D13 AD FC 07                 ...
        clc                                     ; 9D16 18                       .
        adc     #$0B                            ; 9D17 69 0B                    i.
        cmp     $07FD                           ; 9D19 CD FD 07                 ...
        bcs     L9D24                           ; 9D1C B0 06                    ..
        ldx     $07FB                           ; 9D1E AE FB 07                 ...
        ldy     $07F9                           ; 9D21 AC F9 07                 ...
L9D24:
        stx     $01CB                           ; 9D24 8E CB 01                 ...
        lda     $36                             ; 9D27 A5 36                    .6
        cmp     #$10                            ; 9D29 C9 10                    ..
        bne     L9D36                           ; 9D2B D0 09                    ..
        cpx     #$01                            ; 9D2D E0 01                    ..
        beq     L9D35                           ; 9D2F F0 04                    ..
        cpx     #$03                            ; 9D31 E0 03                    ..
        bne     L9D36                           ; 9D33 D0 01                    ..
L9D35:
        dey                                     ; 9D35 88                       .
L9D36:
        sty     $01CA                           ; 9D36 8C CA 01                 ...
        rts                                     ; 9D39 60                       `

; ----------------------------------------------------------------------------
L9D3A:
        stx     $07F0                           ; 9D3A 8E F0 07                 ...
        lda     LA0DA,y                         ; 9D3D B9 DA A0                 ...
        cmp     #$80                            ; 9D40 C9 80                    ..
        beq     L9D76                           ; 9D42 F0 32                    .2
        inc     $07F0                           ; 9D44 EE F0 07                 ...
        clc                                     ; 9D47 18                       .
        adc     $07E0,x                         ; 9D48 7D E0 07                 }..
        cmp     $07E1,x                         ; 9D4B DD E1 07                 ...
        bne     L9DA3                           ; 9D4E D0 53                    .S
        lda     LA0DB,y                         ; 9D50 B9 DB A0                 ...
        cmp     #$80                            ; 9D53 C9 80                    ..
        beq     L9D76                           ; 9D55 F0 1F                    ..
        inc     $07F0                           ; 9D57 EE F0 07                 ...
        clc                                     ; 9D5A 18                       .
        adc     $07E0,x                         ; 9D5B 7D E0 07                 }..
        cmp     $07E2,x                         ; 9D5E DD E2 07                 ...
        bne     L9DA3                           ; 9D61 D0 40                    .@
        lda     LA0DC,y                         ; 9D63 B9 DC A0                 ...
        cmp     #$80                            ; 9D66 C9 80                    ..
        beq     L9D76                           ; 9D68 F0 0C                    ..
        inc     $07F0                           ; 9D6A EE F0 07                 ...
        clc                                     ; 9D6D 18                       .
        adc     $07E0,x                         ; 9D6E 7D E0 07                 }..
        cmp     $07E3,x                         ; 9D71 DD E3 07                 ...
        bne     L9DA3                           ; 9D74 D0 2D                    .-
L9D76:
        sty     $07F1                           ; 9D76 8C F1 07                 ...
        ldy     $07F0                           ; 9D79 AC F0 07                 ...
        lda     #$0C                            ; 9D7C A9 0C                    ..
        jsr     L9E31                           ; 9D7E 20 31 9E                  1.
        ldy     $07F1                           ; 9D81 AC F1 07                 ...
        lda     $07E0,x                         ; 9D84 BD E0 07                 ...
        sec                                     ; 9D87 38                       8
        sbc     $07F0                           ; 9D88 ED F0 07                 ...
        clc                                     ; 9D8B 18                       .
        adc     LA0D9,y                         ; 9D8C 79 D9 A0                 y..
        cmp     $07FC                           ; 9D8F CD FC 07                 ...
        bcc     L9DA2                           ; 9D92 90 0E                    ..
        sta     $07FC                           ; 9D94 8D FC 07                 ...
        stx     $07F8                           ; 9D97 8E F8 07                 ...
        tya                                     ; 9D9A 98                       .
        lsr     a                               ; 9D9B 4A                       J
        lsr     a                               ; 9D9C 4A                       J
        and     #$03                            ; 9D9D 29 03                    ).
        sta     $07FA                           ; 9D9F 8D FA 07                 ...
L9DA2:
        rts                                     ; 9DA2 60                       `

; ----------------------------------------------------------------------------
L9DA3:
        stx     $07F0                           ; 9DA3 8E F0 07                 ...
        lda     $07E0,x                         ; 9DA6 BD E0 07                 ...
        sta     $37                             ; 9DA9 85 37                    .7
        lda     LA0DA,y                         ; 9DAB B9 DA A0                 ...
        cmp     #$80                            ; 9DAE C9 80                    ..
        beq     L9DFF                           ; 9DB0 F0 4D                    .M
        cpx     #$0C                            ; 9DB2 E0 0C                    ..
        bcs     L9E30                           ; 9DB4 B0 7A                    .z
        inc     $07F0                           ; 9DB6 EE F0 07                 ...
        adc     $37                             ; 9DB9 65 37                    e7
        sec                                     ; 9DBB 38                       8
        sbc     $07E1,x                         ; 9DBC FD E1 07                 ...
        bcc     L9DC7                           ; 9DBF 90 06                    ..
        eor     #$FF                            ; 9DC1 49 FF                    I.
        adc     $37                             ; 9DC3 65 37                    e7
        sta     $37                             ; 9DC5 85 37                    .7
L9DC7:
        lda     LA0DB,y                         ; 9DC7 B9 DB A0                 ...
        cmp     #$80                            ; 9DCA C9 80                    ..
        beq     L9DFF                           ; 9DCC F0 31                    .1
        cpx     #$0C                            ; 9DCE E0 0C                    ..
        bcs     L9E30                           ; 9DD0 B0 5E                    .^
        inc     $07F0                           ; 9DD2 EE F0 07                 ...
        adc     $37                             ; 9DD5 65 37                    e7
        sec                                     ; 9DD7 38                       8
        sbc     $07E2,x                         ; 9DD8 FD E2 07                 ...
        bcc     L9DE3                           ; 9DDB 90 06                    ..
        eor     #$FF                            ; 9DDD 49 FF                    I.
        adc     $37                             ; 9DDF 65 37                    e7
        sta     $37                             ; 9DE1 85 37                    .7
L9DE3:
        lda     LA0DC,y                         ; 9DE3 B9 DC A0                 ...
        cmp     #$80                            ; 9DE6 C9 80                    ..
        beq     L9DFF                           ; 9DE8 F0 15                    ..
        cpx     #$0C                            ; 9DEA E0 0C                    ..
        bcs     L9E30                           ; 9DEC B0 42                    .B
        inc     $07F0                           ; 9DEE EE F0 07                 ...
        adc     $37                             ; 9DF1 65 37                    e7
        sec                                     ; 9DF3 38                       8
        sbc     $07E3,x                         ; 9DF4 FD E3 07                 ...
        bcc     L9DFF                           ; 9DF7 90 06                    ..
        eor     #$FF                            ; 9DF9 49 FF                    I.
        adc     $37                             ; 9DFB 65 37                    e7
        sta     $37                             ; 9DFD 85 37                    .7
L9DFF:
        sty     $07F1                           ; 9DFF 8C F1 07                 ...
        ldy     $07F0                           ; 9E02 AC F0 07                 ...
        lda     #$00                            ; 9E05 A9 00                    ..
        jsr     L9E31                           ; 9E07 20 31 9E                  1.
        ldy     $07F1                           ; 9E0A AC F1 07                 ...
        lda     $37                             ; 9E0D A5 37                    .7
        sec                                     ; 9E0F 38                       8
        sbc     $07F0                           ; 9E10 ED F0 07                 ...
        bcc     L9E30                           ; 9E13 90 1B                    ..
        cmp     #$20                            ; 9E15 C9 20                    . 
        bcc     L9E30                           ; 9E17 90 17                    ..
        clc                                     ; 9E19 18                       .
        adc     LA0D9,y                         ; 9E1A 79 D9 A0                 y..
        cmp     $07FD                           ; 9E1D CD FD 07                 ...
        bcc     L9E30                           ; 9E20 90 0E                    ..
        sta     $07FD                           ; 9E22 8D FD 07                 ...
        stx     $07F9                           ; 9E25 8E F9 07                 ...
        tya                                     ; 9E28 98                       .
        lsr     a                               ; 9E29 4A                       J
        lsr     a                               ; 9E2A 4A                       J
        and     #$03                            ; 9E2B 29 03                    ).
        sta     $07FB                           ; 9E2D 8D FB 07                 ...
L9E30:
        rts                                     ; 9E30 60                       `

; ----------------------------------------------------------------------------
L9E31:
        sta     $07F2                           ; 9E31 8D F2 07                 ...
        lda     $07E1,y                         ; 9E34 B9 E1 07                 ...
        cmp     #$30                            ; 9E37 C9 30                    .0
        bne     L9E40                           ; 9E39 D0 05                    ..
        lda     $07DF,x                         ; 9E3B BD DF 07                 ...
        bne     L9E4A                           ; 9E3E D0 0A                    ..
L9E40:
        lda     $07DF,x                         ; 9E40 BD DF 07                 ...
        cmp     #$30                            ; 9E43 C9 30                    .0
        bne     L9E56                           ; 9E45 D0 0F                    ..
        lda     $07E1,y                         ; 9E47 B9 E1 07                 ...
L9E4A:
        clc                                     ; 9E4A 18                       .
        adc     $07E0,x                         ; 9E4B 7D E0 07                 }..
        ror     a                               ; 9E4E 6A                       j
        sec                                     ; 9E4F 38                       8
        sbc     $07F2                           ; 9E50 ED F2 07                 ...
        jmp     L9E5B                           ; 9E53 4C 5B 9E                 L[.

; ----------------------------------------------------------------------------
L9E56:
        clc                                     ; 9E56 18                       .
        adc     $07E1,y                         ; 9E57 79 E1 07                 y..
        ror     a                               ; 9E5A 6A                       j
L9E5B:
        lsr     a                               ; 9E5B 4A                       J
        lsr     a                               ; 9E5C 4A                       J
        sta     $07F0                           ; 9E5D 8D F0 07                 ...
        rts                                     ; 9E60 60                       `

; ----------------------------------------------------------------------------
L9E61:
        jsr     LA44A                           ; 9E61 20 4A A4                  J.
        jsr     LA3C2                           ; 9E64 20 C2 A3                  ..
        jsr     drawCathedralSprites            ; 9E67 20 69 B3                  i.
        lda     #$3C                            ; 9E6A A9 3C                    .<
        sta     player2FallTimer                ; 9E6C 85 6B                    .k
        lda     #$00                            ; 9E6E A9 00                    ..
        sta     player1TetriminoCurrent         ; 9E70 85 64                    .d
        sta     player2TetriminoCurrent         ; 9E72 85 65                    .e
        sta     player1TetriminoNext            ; 9E74 85 66                    .f
        sta     player2TetriminoNext            ; 9E76 85 67                    .g
        sta     $01CE                           ; 9E78 8D CE 01                 ...
        sta     $01CF                           ; 9E7B 8D CF 01                 ...
        jsr     LB3E9                           ; 9E7E 20 E9 B3                  ..
        lda     #$FA                            ; 9E81 A9 FA                    ..
        sta     gameStatePossible               ; 9E83 85 29                    .)
        lda     #$00                            ; 9E85 A9 00                    ..
        sta     frameCounterLow                 ; 9E87 85 32                    .2
        sta     frameCounterHigh                ; 9E89 85 33                    .3
        sta     frameCounterLowLastFrame        ; 9E8B 85 2B                    .+
        sta     ppuScrollX                      ; 9E8D 85 02                    ..
        lda     ppuScrollYOffset                ; 9E8F AD F6 04                 ...
        sta     ppuScrollY                      ; 9E92 85 03                    ..
        jsr     LCF79                           ; 9E94 20 79 CF                  y.
        lda     #$09                            ; 9E97 A9 09                    ..
        jsr     possibleSetSoundOrMusic         ; 9E99 20 B1 CF                  ..
        lda     #$00                            ; 9E9C A9 00                    ..
        jsr     LA6BE                           ; 9E9E 20 BE A6                  ..
        lda     #$04                            ; 9EA1 A9 04                    ..
        jsr     LA6BE                           ; 9EA3 20 BE A6                  ..
        ldx     #$04                            ; 9EA6 A2 04                    ..
        jsr     L9EB0                           ; 9EA8 20 B0 9E                  ..
        lda     #$08                            ; 9EAB A9 08                    ..
        jmp     LA465                           ; 9EAD 4C 65 A4                 Le.

; ----------------------------------------------------------------------------
L9EB0:
        stx     $04                             ; 9EB0 86 04                    ..
        inx                                     ; 9EB2 E8                       .
        stx     $05                             ; 9EB3 86 05                    ..
        inx                                     ; 9EB5 E8                       .
        stx     $06                             ; 9EB6 86 06                    ..
        inx                                     ; 9EB8 E8                       .
        stx     $07                             ; 9EB9 86 07                    ..
        rts                                     ; 9EBB 60                       `

; ----------------------------------------------------------------------------
L9EBC:
        jsr     LA44A                           ; 9EBC 20 4A A4                  J.
        jsr     LA3C2                           ; 9EBF 20 C2 A3                  ..
        lda     #$01                            ; 9EC2 A9 01                    ..
        jsr     LB3E9                           ; 9EC4 20 E9 B3                  ..
        lda     #$3E                            ; 9EC7 A9 3E                    .>
        ldy     #$00                            ; 9EC9 A0 00                    ..
        sty     player1TetriminoCurrent         ; 9ECB 84 64                    .d
        sty     player2TetriminoCurrent         ; 9ECD 84 65                    .e
        sty     player1TetriminoNext            ; 9ECF 84 66                    .f
        sty     player2TetriminoNext            ; 9ED1 84 67                    .g
        sty     $01CE                           ; 9ED3 8C CE 01                 ...
        sty     $01CF                           ; 9ED6 8C CF 01                 ...
        jsr     LA06F                           ; 9ED9 20 6F A0                  o.
        ldx     #$05                            ; 9EDC A2 05                    ..
L9EDE:
        lda     player1ScoreMirrorPossible,x    ; 9EDE BD 30 04                 .0.
        sta     player1ScoreHundredThousands,x  ; 9EE1 9D 18 04                 ...
        lda     unknownScoreSlot,x              ; 9EE4 BD 36 04                 .6.
        sta     player1LinesThousands,x         ; 9EE7 9D 24 04                 .$.
        dex                                     ; 9EEA CA                       .
        bpl     L9EDE                           ; 9EEB 10 F1                    ..
        lda     #$FC                            ; 9EED A9 FC                    ..
        sta     player1FallTimer                ; 9EEF 85 6A                    .j
        sta     gameStatePossible               ; 9EF1 85 29                    .)
        sta     $4C                             ; 9EF3 85 4C                    .L
        sta     $4D                             ; 9EF5 85 4D                    .M
        sta     $4E                             ; 9EF7 85 4E                    .N
        sta     $4F                             ; 9EF9 85 4F                    .O
        sta     $50                             ; 9EFB 85 50                    .P
        sta     $51                             ; 9EFD 85 51                    .Q
        jsr     LCF79                           ; 9EFF 20 79 CF                  y.
        lda     #$15                            ; 9F02 A9 15                    ..
        jsr     possibleSetSoundOrMusic         ; 9F04 20 B1 CF                  ..
        lda     #$01                            ; 9F07 A9 01                    ..
        jsr     LA6BE                           ; 9F09 20 BE A6                  ..
        lda     #$03                            ; 9F0C A9 03                    ..
        jsr     LA6BE                           ; 9F0E 20 BE A6                  ..
        ldx     #$00                            ; 9F11 A2 00                    ..
        jsr     L9EB0                           ; 9F13 20 B0 9E                  ..
        lda     #$00                            ; 9F16 A9 00                    ..
        jmp     LA465                           ; 9F18 4C 65 A4                 Le.

; ----------------------------------------------------------------------------
L9F1B:
        jsr     LA44A                           ; 9F1B 20 4A A4                  J.
        lda     #$02                            ; 9F1E A9 02                    ..
        jsr     LB3E9                           ; 9F20 20 E9 B3                  ..
        lda     #$3E                            ; 9F23 A9 3E                    .>
        ldy     #$01                            ; 9F25 A0 01                    ..
        jsr     LA06F                           ; 9F27 20 6F A0                  o.
        ldy     menuGameMode                    ; 9F2A AC F0 04                 ...
        lda     playModeTable,y                 ; 9F2D B9 51 9F                 .Q.
        sta     playMode                        ; 9F30 85 2F                    ./
        dey                                     ; 9F32 88                       .
        bne     L9F3A                           ; 9F33 D0 05                    ..
        ldy     #$02                            ; 9F35 A0 02                    ..
        jsr     LA06F                           ; 9F37 20 6F A0                  o.
L9F3A:
        lda     #$FD                            ; 9F3A A9 FD                    ..
L9F3C:
        sta     gameStatePossible               ; 9F3C 85 29                    .)
        sta     player1FallTimer                ; 9F3E 85 6A                    .j
        sta     $4C                             ; 9F40 85 4C                    .L
        sta     $4D                             ; 9F42 85 4D                    .M
        sta     $4E                             ; 9F44 85 4E                    .N
        sta     $4F                             ; 9F46 85 4F                    .O
        sta     $50                             ; 9F48 85 50                    .P
        sta     $51                             ; 9F4A 85 51                    .Q
        lda     #$00                            ; 9F4C A9 00                    ..
        jmp     LA465                           ; 9F4E 4C 65 A4                 Le.

; ----------------------------------------------------------------------------
; 1p, 2p, coop, vs comp, with comp
playModeTable:
        .byte   $00,$01,$FF,$01,$FF             ; 9F51 00 01 FF 01 FF           .....
; ----------------------------------------------------------------------------
L9F56:
        jsr     LA44A                           ; 9F56 20 4A A4                  J.
        lda     #$03                            ; 9F59 A9 03                    ..
        jsr     LB3E9                           ; 9F5B 20 E9 B3                  ..
        lda     #$3E                            ; 9F5E A9 3E                    .>
        ldy     #$03                            ; 9F60 A0 03                    ..
        jsr     LA06F                           ; 9F62 20 6F A0                  o.
        ldy     menuGameMode                    ; 9F65 AC F0 04                 ...
        dey                                     ; 9F68 88                       .
        bne     L9F70                           ; 9F69 D0 05                    ..
        ldy     #$04                            ; 9F6B A0 04                    ..
        jsr     LA06F                           ; 9F6D 20 6F A0                  o.
L9F70:
        lda     #$FE                            ; 9F70 A9 FE                    ..
        bne     L9F3C                           ; 9F72 D0 C8                    ..
L9F74:
        jsr     LA44A                           ; 9F74 20 4A A4                  J.
        lda     #$04                            ; 9F77 A9 04                    ..
        jsr     LB3E9                           ; 9F79 20 E9 B3                  ..
        lda     #$3E                            ; 9F7C A9 3E                    .>
        ldy     #$05                            ; 9F7E A0 05                    ..
        jsr     LA06F                           ; 9F80 20 6F A0                  o.
        lda     #$FF                            ; 9F83 A9 FF                    ..
        bne     L9F3C                           ; 9F85 D0 B5                    ..
L9F87:
        lda     gameStatePossible               ; 9F87 A5 29                    .)
        bmi     L9F8C                           ; 9F89 30 01                    0.
L9F8B:
        rts                                     ; 9F8B 60                       `

; ----------------------------------------------------------------------------
L9F8C:
        cmp     #$FC                            ; 9F8C C9 FC                    ..
        bcs     L9FAB                           ; 9F8E B0 1B                    ..
        cmp     #$F9                            ; 9F90 C9 F9                    ..
        bne     L9F9A                           ; 9F92 D0 06                    ..
        lda     player1FallTimer                ; 9F94 A5 6A                    .j
        cmp     #$C0                            ; 9F96 C9 C0                    ..
        bcs     L9F8B                           ; 9F98 B0 F1                    ..
L9F9A:
        lda     $74                             ; 9F9A A5 74                    .t
        ora     $75                             ; 9F9C 05 75                    .u
        bne     L9F8B                           ; 9F9E D0 EB                    ..
        lda     player1ControllerNew            ; 9FA0 A5 46                    .F
        ora     player2ControllerNew            ; 9FA2 05 47                    .G
        and     #$0C                            ; 9FA4 29 0C                    ).
        beq     L9F8B                           ; 9FA6 F0 E3                    ..
        jmp     L9EBC                           ; 9FA8 4C BC 9E                 L..

; ----------------------------------------------------------------------------
L9FAB:
        lda     frameCounterLow                 ; 9FAB A5 32                    .2
        and     #$03                            ; 9FAD 29 03                    ).
        bne     L9FB8                           ; 9FAF D0 07                    ..
        dec     player1FallTimer                ; 9FB1 C6 6A                    .j
        bne     L9FB8                           ; 9FB3 D0 03                    ..
        jmp     L9E61                           ; 9FB5 4C 61 9E                 La.

; ----------------------------------------------------------------------------
L9FB8:
        lda     player1ControllerNew            ; 9FB8 A5 46                    .F
        ora     player2ControllerNew            ; 9FBA 05 47                    .G
        and     #$34                            ; 9FBC 29 34                    )4
        beq     LA00D                           ; 9FBE F0 4D                    .M
        lda     #$FF                            ; 9FC0 A9 FF                    ..
        sta     player1FallTimer                ; 9FC2 85 6A                    .j
        lda     #$14                            ; 9FC4 A9 14                    ..
        jsr     possibleSetSoundOrMusic         ; 9FC6 20 B1 CF                  ..
        lda     gameStatePossible               ; 9FC9 A5 29                    .)
        cmp     #$FF                            ; 9FCB C9 FF                    ..
        beq     L9FDB                           ; 9FCD F0 0C                    ..
        cmp     #$FC                            ; 9FCF C9 FC                    ..
        bne     L9FE3                           ; 9FD1 D0 10                    ..
        lda     player1ControllerNew            ; 9FD3 A5 46                    .F
        ora     player2ControllerNew            ; 9FD5 05 47                    .G
        ldy     #$00                            ; 9FD7 A0 00                    ..
        beq     LA001                           ; 9FD9 F0 26                    .&
L9FDB:
        lda     player1ControllerNew            ; 9FDB A5 46                    .F
        ora     player2ControllerNew            ; 9FDD 05 47                    .G
        ldy     #$05                            ; 9FDF A0 05                    ..
        bne     LA001                           ; 9FE1 D0 1E                    ..
L9FE3:
        ldy     #$01                            ; 9FE3 A0 01                    ..
        cmp     #$FD                            ; 9FE5 C9 FD                    ..
        beq     L9FEB                           ; 9FE7 F0 02                    ..
        ldy     #$03                            ; 9FE9 A0 03                    ..
L9FEB:
        lda     player1ControllerNew            ; 9FEB A5 46                    .F
        and     #$34                            ; 9FED 29 34                    )4
        beq     L9FF4                           ; 9FEF F0 03                    ..
        jsr     LA048                           ; 9FF1 20 48 A0                  H.
L9FF4:
        lda     player2ControllerNew            ; 9FF4 A5 47                    .G
        and     #$34                            ; 9FF6 29 34                    )4
        beq     LA004                           ; 9FF8 F0 0A                    ..
        .byte   $AE,$F0,$04,$CA,$D0,$01,$C8     ; 9FFA AE F0 04 CA D0 01 C8     .......
; ----------------------------------------------------------------------------
LA001:
        jsr     LA048                           ; A001 20 48 A0                  H.
LA004:
        lda     gameStatePossible               ; A004 A5 29                    .)
        cmp     #$FF                            ; A006 C9 FF                    ..
        bne     LA00D                           ; A008 D0 03                    ..
        jsr     LA035                           ; A00A 20 35 A0                  5.
LA00D:
        lda     player1ControllerNew            ; A00D A5 46                    .F
        ora     player2ControllerNew            ; A00F 05 47                    .G
        and     #$08                            ; A011 29 08                    ).
        bne     LA016                           ; A013 D0 01                    ..
        rts                                     ; A015 60                       `

; ----------------------------------------------------------------------------
LA016:
        lda     #$15                            ; A016 A9 15                    ..
        jsr     possibleSetSoundOrMusic         ; A018 20 B1 CF                  ..
        lda     gameStatePossible               ; A01B A5 29                    .)
        cmp     #$FC                            ; A01D C9 FC                    ..
        beq     @branchOnModeGameTypeMenu       ; A01F F0 0B                    ..
        cmp     #$FD                            ; A021 C9 FD                    ..
        beq     @branchOnModeLevelMenu          ; A023 F0 0A                    ..
        cmp     #$FE                            ; A025 C9 FE                    ..
        beq     @branchOnModeHandicapMenu       ; A027 F0 09                    ..
        jmp     L95E3                           ; A029 4C E3 95                 L..

; ----------------------------------------------------------------------------
@branchOnModeGameTypeMenu:
        jmp     L9F1B                           ; A02C 4C 1B 9F                 L..

; ----------------------------------------------------------------------------
@branchOnModeLevelMenu:
        jmp     L9F56                           ; A02F 4C 56 9F                 LV.

; ----------------------------------------------------------------------------
@branchOnModeHandicapMenu:
        jmp     L9F74                           ; A032 4C 74 9F                 Lt.

; ----------------------------------------------------------------------------
LA035:
        lda     #$08                            ; A035 A9 08                    ..
        jsr     possibleSetSoundOrMusic         ; A037 20 B1 CF                  ..
        ldy     menuMusic                       ; A03A AC F5 04                 ...
        lda     musicSelectTable,y              ; A03D B9 43 A0                 .C.
        jmp     possibleSetSoundOrMusic         ; A040 4C B1 CF                 L..

; ----------------------------------------------------------------------------
musicSelectTable:
        .byte   $08,$04,$05,$06,$07             ; A043 08 04 05 06 07           .....
; ----------------------------------------------------------------------------
LA048:
        pha                                     ; A048 48                       H
        lda     #$00                            ; A049 A9 00                    ..
        jsr     LA06F                           ; A04B 20 6F A0                  o.
        pla                                     ; A04E 68                       h
        and     #$10                            ; A04F 29 10                    ).
        beq     LA055                           ; A051 F0 02                    ..
        lda     #$FE                            ; A053 A9 FE                    ..
LA055:
        sec                                     ; A055 38                       8
        adc     menuGameMode,y                  ; A056 79 F0 04                 y..
        cmp     #$FF                            ; A059 C9 FF                    ..
        bne     LA063                           ; A05B D0 06                    ..
        lda     LA0E3,y                         ; A05D B9 E3 A0                 ...
        sec                                     ; A060 38                       8
        sbc     #$01                            ; A061 E9 01                    ..
LA063:
        cmp     LA0E3,y                         ; A063 D9 E3 A0                 ...
        bcc     LA06A                           ; A066 90 02                    ..
        lda     #$00                            ; A068 A9 00                    ..
LA06A:
        sta     menuGameMode,y                  ; A06A 99 F0 04                 ...
        lda     #$3E                            ; A06D A9 3E                    .>
LA06F:
        pha                                     ; A06F 48                       H
        jsr     LA3DB                           ; A070 20 DB A3                  ..
        sty     $36                             ; A073 84 36                    .6
        lda     menuGameMode,y                  ; A075 B9 F0 04                 ...
        clc                                     ; A078 18                       .
        adc     LA0DD,y                         ; A079 79 DD A0                 y..
        asl     a                               ; A07C 0A                       .
        tay                                     ; A07D A8                       .
        lda     LA0AB,y                         ; A07E B9 AB A0                 ...
        sta     $16,x                           ; A081 95 16                    ..
        lda     LA0AC,y                         ; A083 B9 AC A0                 ...
        sta     $17,x                           ; A086 95 17                    ..
        pla                                     ; A088 68                       h
        beq     LA090                           ; A089 F0 05                    ..
        ldy     $36                             ; A08B A4 36                    .6
        lda     LA0A5,y                         ; A08D B9 A5 A0                 ...
LA090:
        ldy     #$00                            ; A090 A0 00                    ..
        sta     ($48),y                         ; A092 91 48                    .H
        lda     $48                             ; A094 A5 48                    .H
        sta     ppuDataAddress1,x               ; A096 95 08                    ..
        lda     $49                             ; A098 A5 49                    .I
        sta     ppuDataAddress1+1,x             ; A09A 95 09                    ..
        inc     $48                             ; A09C E6 48                    .H
        lda     #$01                            ; A09E A9 01                    ..
        sta     $24,x                           ; A0A0 95 24                    .$
        ldy     $36                             ; A0A2 A4 36                    .6
        rts                                     ; A0A4 60                       `

; ----------------------------------------------------------------------------
LA0A5:
        .byte   $3E,$3E,$3F,$3E,$3F,$3E         ; A0A5 3E 3E 3F 3E 3F 3E        >>?>?>
LA0AB:
        .byte   $0A                             ; A0AB 0A                       .
LA0AC:
        .byte   $22,$2A,$22,$4A,$22,$6A,$22,$8A ; A0AC 22 2A 22 4A 22 6A 22 8A  "*"J"j".
        .byte   $22,$8D,$21,$AD,$21,$CD,$21,$ED ; A0B4 22 8D 21 AD 21 CD 21 ED  ".!.!.!.
        .byte   $21,$0D,$22,$2D,$22,$4D,$22,$6D ; A0BC 21 0D 22 2D 22 4D 22 6D  !."-"M"m
        .byte   $22,$8D,$22,$AD,$22,$91,$21,$B1 ; A0C4 22 8D 22 AD 22 91 21 B1  ".".".!.
        .byte   $21,$D1,$21,$F1,$21,$11,$22,$31 ; A0CC 21 D1 21 F1 21 11 22 31  !.!.!."1
        .byte   $22,$51,$22,$71,$22             ; A0D4 22 51 22 71 22           "Q"q"
LA0D9:
        .byte   $91                             ; A0D9 91                       .
LA0DA:
        .byte   $22                             ; A0DA 22                       "
LA0DB:
        .byte   $B1                             ; A0DB B1                       .
LA0DC:
        .byte   $22                             ; A0DC 22                       "
LA0DD:
        .byte   $00,$05,$0F,$05,$0F,$05         ; A0DD 00 05 0F 05 0F 05        ......
LA0E3:
        .byte   $05,$0A,$0A,$05,$05,$05,$00,$00 ; A0E3 05 0A 0A 05 05 05 00 00  ........
        .byte   $00,$00,$F8,$80,$80,$80,$FE,$00 ; A0EB 00 00 F8 80 80 80 FE 00  ........
        .byte   $00,$00,$F6,$80,$80,$80,$09,$08 ; A0F3 00 00 F6 80 80 80 09 08  ........
        .byte   $00,$80,$00,$F8,$80,$80,$02,$00 ; A0FB 00 80 00 F8 80 80 02 00  ........
        .byte   $00,$80,$08,$08,$80,$80,$00,$00 ; A103 00 80 08 08 80 80 00 00  ........
        .byte   $80,$80,$00,$00,$80,$80,$00,$00 ; A10B 80 80 00 00 80 80 00 00  ........
        .byte   $80,$80,$00,$00,$80,$80,$08,$00 ; A113 80 80 00 00 80 80 08 00  ........
        .byte   $08,$80,$FF,$F0,$80,$80,$01,$00 ; A11B 08 80 FF F0 80 80 01 00  ........
        .byte   $00,$80,$00,$00,$80,$80,$00,$F8 ; A123 00 80 00 00 80 80 00 F8  ........
        .byte   $F8,$80,$00,$00,$80,$80,$01,$00 ; A12B F8 80 00 00 80 80 01 00  ........
        .byte   $00,$80,$0F,$10,$80,$80,$01,$00 ; A133 00 80 0F 10 80 80 01 00  ........
        .byte   $F8,$80,$08,$08,$80,$80,$FF,$00 ; A13B F8 80 08 08 80 80 FF 00  ........
        .byte   $F8,$80,$06,$08,$80,$80,$09,$08 ; A143 F8 80 06 08 80 80 09 08  ........
        .byte   $08,$80,$00,$F8,$80,$80,$07,$08 ; A14B 08 80 00 F8 80 80 07 08  ........
        .byte   $08,$80,$FE,$F8,$80,$80         ; A153 08 80 FE F8 80 80        ......
; ----------------------------------------------------------------------------
LA159:
        asl     a                               ; A159 0A                       .
        tay                                     ; A15A A8                       .
        lda     LA189,y                         ; A15B B9 89 A1                 ...
        sta     $3C                             ; A15E 85 3C                    .<
        lda     LA189+1,y                       ; A160 B9 8A A1                 ...
        sta     $3D                             ; A163 85 3D                    .=
        ldy     #$00                            ; A165 A0 00                    ..
LA167:
        lda     ($3C),y                         ; A167 B1 3C                    .<
        beq     LA188                           ; A169 F0 1D                    ..
        bit     PPUSTATUS                       ; A16B 2C 02 20                 ,. 
        tax                                     ; A16E AA                       .
        iny                                     ; A16F C8                       .
        lda     ($3C),y                         ; A170 B1 3C                    .<
        sta     PPUADDR                         ; A172 8D 06 20                 .. 
        stx     PPUADDR                         ; A175 8E 06 20                 .. 
        iny                                     ; A178 C8                       .
        lda     ($3C),y                         ; A179 B1 3C                    .<
LA17B:
        sta     PPUDATA                         ; A17B 8D 07 20                 .. 
        iny                                     ; A17E C8                       .
        lda     ($3C),y                         ; A17F B1 3C                    .<
        cmp     #$FF                            ; A181 C9 FF                    ..
        bne     LA17B                           ; A183 D0 F6                    ..
        iny                                     ; A185 C8                       .
        bne     LA167                           ; A186 D0 DF                    ..
LA188:
        rts                                     ; A188 60                       `

; ----------------------------------------------------------------------------
LA189:
        .addr   ppuPatchLevelSelectZero         ; A189 0D A2                    ..
        .addr   ppuPatchGameSelect              ; A18B 9B A1                    ..
        .addr   ppuPatchLevelSelect             ; A18D 0E A2                    ..
        .addr   ppuPatchHandicap                ; A18F 80 A2                    ..
        .addr   ppuPatchMusicSelect             ; A191 DF A2                    ..
        .addr   ppuPatchHighScoresZero          ; A193 39 A3                    9.
        .addr   ppuPatchHighScoresZero          ; A195 39 A3                    9.
        .addr   ppuPatchHighScoresZero          ; A197 39 A3                    9.
        .addr   ppuPatchHighScores              ; A199 3A A3                    :.
; ----------------------------------------------------------------------------
ppuPatchGameSelect:
        .byte   $CA,$21,$47,$41,$4D,$45,$20,$53 ; A19B CA 21 47 41 4D 45 20 53  .!GAME S
        .byte   $45,$4C,$45,$43,$54,$FF         ; A1A3 45 4C 45 43 54 FF        ELECT.
ppuPatch1Player:
        .byte   $0C,$22,$31,$20,$50,$4C,$41,$59 ; A1A9 0C 22 31 20 50 4C 41 59  ."1 PLAY
        .byte   $45,$52,$FF                     ; A1B1 45 52 FF                 ER.
ppuPatch2Player:
        .byte   $2C,$22,$32,$20,$50,$4C,$41,$59 ; A1B4 2C 22 32 20 50 4C 41 59  ,"2 PLAY
        .byte   $45,$52,$FF                     ; A1BC 45 52 FF                 ER.
ppuPatchCooperative:
        .byte   $4C,$22,$43,$4F,$4F,$50,$45,$52 ; A1BF 4C 22 43 4F 4F 50 45 52  L"COOPER
        .byte   $41,$54,$49,$56,$45,$FF         ; A1C7 41 54 49 56 45 FF        ATIVE.
ppuPatchVsComputer:
        .byte   $6C,$22,$56,$45,$52,$53,$55,$53 ; A1CD 6C 22 56 45 52 53 55 53  l"VERSUS
        .byte   $20,$43,$4F,$4D,$50,$55,$54,$45 ; A1D5 20 43 4F 4D 50 55 54 45   COMPUTE
        .byte   $52,$FF                         ; A1DD 52 FF                    R.
ppuPatchWithComputer:
        .byte   $8C,$22,$57,$49,$54,$48,$20,$43 ; A1DF 8C 22 57 49 54 48 20 43  ."WITH C
        .byte   $4F,$4D,$50,$55,$54,$45,$52,$FF ; A1E7 4F 4D 50 55 54 45 52 FF  OMPUTER.
ppuPatchLicensedBy:
        .byte   $03,$23,$4C,$49,$43,$45,$4E,$53 ; A1EF 03 23 4C 49 43 45 4E 53  .#LICENS
        .byte   $45,$44,$20,$42,$59,$20,$4D,$49 ; A1F7 45 44 20 42 59 20 4D 49  ED BY MI
        .byte   $52,$52,$4F,$52,$53,$4F,$46,$54 ; A1FF 52 52 4F 52 53 4F 46 54  RRORSOFT
        .byte   $20,$4C,$54,$44,$2E,$FF         ; A207 20 4C 54 44 2E FF         LTD..
ppuPatchLevelSelectZero:
        .byte   $00                             ; A20D 00                       .
ppuPatchLevelSelect:
        .byte   $4A,$21,$4C,$45,$56,$45,$4C,$20 ; A20E 4A 21 4C 45 56 45 4C 20  J!LEVEL 
        .byte   $53,$45,$4C,$45,$43,$54,$FF     ; A216 53 45 4C 45 43 54 FF     SELECT.
ppuPatchLevel0:
        .byte   $8F,$21,$30,$FF                 ; A21D 8F 21 30 FF              .!0.
ppuPatchLevel1:
        .byte   $AF,$21,$31,$FF                 ; A221 AF 21 31 FF              .!1.
ppuPatchLevel2:
        .byte   $CF,$21,$32,$FF                 ; A225 CF 21 32 FF              .!2.
ppuPatchLevel3:
        .byte   $EF,$21,$33,$FF                 ; A229 EF 21 33 FF              .!3.
ppuPatchLevel4:
        .byte   $0F,$22,$34,$FF                 ; A22D 0F 22 34 FF              ."4.
ppuPatchLevel5:
        .byte   $2F,$22,$35,$FF                 ; A231 2F 22 35 FF              /"5.
ppuPatchLevel6:
        .byte   $4F,$22,$36,$FF                 ; A235 4F 22 36 FF              O"6.
ppuPatchLevel7:
        .byte   $6F,$22,$37,$FF                 ; A239 6F 22 37 FF              o"7.
ppuPatchLevel8:
        .byte   $8F,$22,$38,$FF                 ; A23D 8F 22 38 FF              ."8.
ppuPatchLevel9:
        .byte   $AF,$22,$39,$FF                 ; A241 AF 22 39 FF              ."9.
ppuPatchConceptBy:
        .byte   $02,$23,$43,$4F,$4E,$43,$45,$50 ; A245 02 23 43 4F 4E 43 45 50  .#CONCEP
        .byte   $54,$20,$42,$59,$20,$41,$4C,$45 ; A24D 54 20 42 59 20 41 4C 45  T BY ALE
        .byte   $58,$45,$59,$20,$50,$41,$5A,$48 ; A255 58 45 59 20 50 41 5A 48  XEY PAZH
        .byte   $49,$54,$4E,$4F,$56,$FF         ; A25D 49 54 4E 4F 56 FF        ITNOV.
ppuPatchDesignBy:
        .byte   $43,$23,$44,$45,$53,$49,$47,$4E ; A263 43 23 44 45 53 49 47 4E  C#DESIGN
        .byte   $20,$42,$59,$20,$56,$41,$44,$49 ; A26B 20 42 59 20 56 41 44 49   BY VADI
        .byte   $4D,$20,$47,$45,$52,$41,$53,$49 ; A273 4D 20 47 45 52 41 53 49  M GERASI
        .byte   $4D,$4F,$56,$FF                 ; A27B 4D 4F 56 FF              MOV.
ppuPatchHandicapZero:
        .byte   $00                             ; A27F 00                       .
ppuPatchHandicap:
        .byte   $49,$21,$48,$41,$4E,$44,$49,$43 ; A280 49 21 48 41 4E 44 49 43  I!HANDIC
        .byte   $41,$50,$20,$53,$45,$4C,$45,$43 ; A288 41 50 20 53 45 4C 45 43  AP SELEC
        .byte   $54,$FF                         ; A290 54 FF                    T.
ppuPatchHandicap0:
        .byte   $8F,$21,$30,$FF                 ; A292 8F 21 30 FF              .!0.
ppuPatchHandicap3:
        .byte   $AF,$21,$33,$FF                 ; A296 AF 21 33 FF              .!3.
ppuPatchHandicap6:
        .byte   $CF,$21,$36,$FF                 ; A29A CF 21 36 FF              .!6.
ppuPatchHandicap9:
        .byte   $EF,$21,$39,$FF                 ; A29E EF 21 39 FF              .!9.
ppuPatchHandicap12:
        .byte   $0E,$22,$31,$32,$FF             ; A2A2 0E 22 31 32 FF           ."12.
ppuPatchProgrammedBy:
        .byte   $05,$23,$50,$52,$4F,$47,$52,$41 ; A2A7 05 23 50 52 4F 47 52 41  .#PROGRA
        .byte   $4D,$4D,$45,$44,$20,$42,$59,$20 ; A2AF 4D 4D 45 44 20 42 59 20  MMED BY 
        .byte   $45,$44,$20,$4C,$4F,$47,$47,$FF ; A2B7 45 44 20 4C 4F 47 47 FF  ED LOGG.
ppuPatchVideoBy:
        .byte   $42,$23,$56,$49,$44,$45,$4F,$20 ; A2BF 42 23 56 49 44 45 4F 20  B#VIDEO 
        .byte   $47,$52,$41,$50,$48,$49,$43,$53 ; A2C7 47 52 41 50 48 49 43 53  GRAPHICS
        .byte   $20,$42,$59,$20,$4B,$52,$49,$53 ; A2CF 20 42 59 20 4B 52 49 53   BY KRIS
        .byte   $20,$4D,$4F,$53,$45,$52,$FF     ; A2D7 20 4D 4F 53 45 52 FF      MOSER.
ppuPatchMusicSelectZero:
        .byte   $00                             ; A2DE 00                       .
ppuPatchMusicSelect:
        .byte   $4B,$21,$4D,$55,$53,$49,$43,$20 ; A2DF 4B 21 4D 55 53 49 43 20  K!MUSIC 
        .byte   $53,$45,$4C,$45,$43,$54,$FF     ; A2E7 53 45 4C 45 43 54 FF     SELECT.
ppuPatchSilence:
        .byte   $8F,$21,$53,$49,$4C,$45,$4E,$43 ; A2EE 8F 21 53 49 4C 45 4E 43  .!SILENC
        .byte   $45,$FF                         ; A2F6 45 FF                    E.
ppuPatchLoginska:
        .byte   $AF,$21,$4C,$4F,$47,$49,$4E,$53 ; A2F8 AF 21 4C 4F 47 49 4E 53  .!LOGINS
        .byte   $4B,$41                         ; A300 4B 41                    KA
ppuPatchBradinksy:
        .byte   $FF,$CF,$21,$42,$52,$41,$44,$49 ; A302 FF CF 21 42 52 41 44 49  ..!BRADI
        .byte   $4E,$53,$4B,$59,$FF             ; A30A 4E 53 4B 59 FF           NSKY.
ppuPatchKarinka:
        .byte   $EF,$21,$4B,$41,$52,$49,$4E,$4B ; A30F EF 21 4B 41 52 49 4E 4B  .!KARINK
        .byte   $41,$FF                         ; A317 41 FF                    A.
ppuPatchTroika:
        .byte   $0F,$22,$54,$52,$4F,$49,$4B,$41 ; A319 0F 22 54 52 4F 49 4B 41  ."TROIKA
        .byte   $FF                             ; A321 FF                       .
ppuPatchAudioBy:
        .byte   $26,$23,$41,$55,$44,$49,$4F,$20 ; A322 26 23 41 55 44 49 4F 20  &#AUDIO 
        .byte   $42,$59,$20,$42,$52,$41,$44,$20 ; A32A 42 59 20 42 52 41 44 20  BY BRAD 
        .byte   $46,$55,$4C,$4C,$45,$52,$FF     ; A332 46 55 4C 4C 45 52 FF     FULLER.
ppuPatchHighScoresZero:
        .byte   $00                             ; A339 00                       .
ppuPatchHighScores:
        .byte   $48,$21,$48,$49,$47,$48,$20,$53 ; A33A 48 21 48 49 47 48 20 53  H!HIGH S
        .byte   $43,$4F,$52,$45,$53,$2D,$4C,$49 ; A342 43 4F 52 45 53 2D 4C 49  CORES-LI
        .byte   $4E,$45,$53,$FF                 ; A34A 4E 45 53 FF              NES.
ppuPatchLeaderboard1:
        .byte   $88,$21,$31,$2E,$FF             ; A34E 88 21 31 2E FF           .!1..
ppuPatchLeaderboard2:
        .byte   $A8,$21,$32,$2E,$FF             ; A353 A8 21 32 2E FF           .!2..
ppuPatchLeaderboard3:
        .byte   $C8,$21,$33,$2E,$FF             ; A358 C8 21 33 2E FF           .!3..
ppuPatchLeaderboard4:
        .byte   $E8,$21,$34,$2E,$FF             ; A35D E8 21 34 2E FF           .!4..
ppuPatchLeaderboard5:
        .byte   $08,$22,$35,$2E,$FF             ; A362 08 22 35 2E FF           ."5..
ppuPatchLeaderboard6:
        .byte   $28,$22,$36,$2E,$FF             ; A367 28 22 36 2E FF           ("6..
ppuPatchLeaderboard7:
        .byte   $48,$22,$37,$2E,$FF             ; A36C 48 22 37 2E FF           H"7..
ppuPatchLeaderboard8:
        .byte   $68,$22,$38,$2E,$FF             ; A371 68 22 38 2E FF           h"8..
ppuPatchLeaderboard9:
        .byte   $88,$22,$39,$2E,$FF             ; A376 88 22 39 2E FF           ."9..
ppuPatchLeaderboard10:
        .byte   $A7,$22,$31,$30,$2E,$FF         ; A37B A7 22 31 30 2E FF        ."10..
ppuPatchLeaderboard11:
        .byte   $C7,$22,$31,$31,$2E,$FF         ; A381 C7 22 31 31 2E FF        ."11..
ppuPatchLeaderboard12:
        .byte   $E7,$22,$31,$32,$2E,$FF         ; A387 E7 22 31 32 2E FF        ."12..
ppuPatchLeaderboard13:
        .byte   $07,$23,$31,$33,$2E,$FF         ; A38D 07 23 31 33 2E FF        .#13..
ppuPatchLeaderboard14:
        .byte   $27,$23,$31,$34,$2E,$FF         ; A393 27 23 31 34 2E FF        '#14..
ppuPatchLeaderboard15:
        .byte   $47,$23,$31,$35,$2E,$FF         ; A399 47 23 31 35 2E FF        G#15..
unknownData01:
        .byte   $00,$10,$05,$49,$FF,$18,$69,$01 ; A39F 00 10 05 49 FF 18 69 01  ...I..i.
        .byte   $60,$A9,$20,$AE,$02,$20,$8D,$06 ; A3A7 60 A9 20 AE 02 20 8D 06  `. .. ..
        .byte   $20,$A9,$00,$8D,$06,$20,$A0,$04 ; A3AF 20 A9 00 8D 06 20 A0 04   .... ..
        .byte   $AA,$8D,$07,$20,$E8,$D0,$FA,$88 ; A3B7 AA 8D 07 20 E8 D0 FA 88  ... ....
        .byte   $D0,$F7,$60                     ; A3BF D0 F7 60                 ..`
; ----------------------------------------------------------------------------
LA3C2:
        ldx     #$00                            ; A3C2 A2 00                    ..
LA3C4:
        lda     #$F7                            ; A3C4 A9 F7                    ..
        sta     oamStaging,x                    ; A3C6 9D 00 05                 ...
        lda     #$00                            ; A3C9 A9 00                    ..
        sta     oamStaging+1,x                  ; A3CB 9D 01 05                 ...
        sta     oamStaging+2,x                  ; A3CE 9D 02 05                 ...
        sta     oamStaging+3,x                  ; A3D1 9D 03 05                 ...
        inx                                     ; A3D4 E8                       .
        inx                                     ; A3D5 E8                       .
        inx                                     ; A3D6 E8                       .
        inx                                     ; A3D7 E8                       .
        bne     LA3C4                           ; A3D8 D0 EA                    ..
        rts                                     ; A3DA 60                       `

; ----------------------------------------------------------------------------
LA3DB:
        ldx     $25                             ; A3DB A6 25                    .%
        lda     $24,x                           ; A3DD B5 24                    .$
        beq     LA3F2                           ; A3DF F0 11                    ..
        lda     $00                             ; A3E1 A5 00                    ..
        bmi     LA3EA                           ; A3E3 30 05                    0.
        ora     #$80                            ; A3E5 09 80                    ..
        sta     PPUCTRL                         ; A3E7 8D 00 20                 .. 
LA3EA:
        lda     #$00                            ; A3EA A9 00                    ..
        sta     $48                             ; A3EC 85 48                    .H
LA3EE:
        lda     $24,x                           ; A3EE B5 24                    .$
        bne     LA3EE                           ; A3F0 D0 FC                    ..
LA3F2:
        lda     $25                             ; A3F2 A5 25                    .%
        clc                                     ; A3F4 18                       .
        adc     #$02                            ; A3F5 69 02                    i.
        cmp     #$0E                            ; A3F7 C9 0E                    ..
        bcc     LA3FD                           ; A3F9 90 02                    ..
        lda     #$00                            ; A3FB A9 00                    ..
LA3FD:
        sta     $25                             ; A3FD 85 25                    .%
        rts                                     ; A3FF 60                       `

; ----------------------------------------------------------------------------
pollController:
        lda     #$03                            ; A400 A9 03                    ..
        sta     player1controllerPort           ; A402 8D 16 40                 ..@
        and     #$FE                            ; A405 29 FE                    ).
        sta     player1controllerPort           ; A407 8D 16 40                 ..@
        lda     player1ControllerHeld           ; A40A A5 42                    .B
        sta     player1ControllerLastFrame      ; A40C 85 3E                    .>
        lda     player2ControllerHeld           ; A40E A5 43                    .C
        sta     player2ControllerLastFrame      ; A410 85 3F                    .?
        lda     player1ExpansionHeld            ; A412 A5 44                    .D
        sta     player1ExpansionLastFrame       ; A414 85 40                    .@
        lda     player2ExpansionHeld            ; A416 A5 45                    .E
        sta     player2ExpansionLastFrame       ; A418 85 41                    .A
        ldx     #$08                            ; A41A A2 08                    ..
LA41C:
        lda     player1controllerPort           ; A41C AD 16 40                 ..@
        lsr     a                               ; A41F 4A                       J
        ror     player1ControllerHeld           ; A420 66 42                    fB
        lsr     a                               ; A422 4A                       J
        ror     player1ExpansionHeld            ; A423 66 44                    fD
        lda     player2controllerPort           ; A425 AD 17 40                 ..@
        lsr     a                               ; A428 4A                       J
        ror     player2ControllerHeld           ; A429 66 43                    fC
        lsr     a                               ; A42B 4A                       J
        ror     player2ExpansionHeld            ; A42C 66 45                    fE
        dex                                     ; A42E CA                       .
        bne     LA41C                           ; A42F D0 EB                    ..
        lda     player1ControllerLastFrame      ; A431 A5 3E                    .>
        eor     #$FF                            ; A433 49 FF                    I.
        sta     player1ControllerNew            ; A435 85 46                    .F
        lda     player1ControllerHeld           ; A437 A5 42                    .B
        and     player1ControllerNew            ; A439 25 46                    %F
        sta     player1ControllerNew            ; A43B 85 46                    .F
        lda     player2ControllerLastFrame      ; A43D A5 3F                    .?
        eor     #$FF                            ; A43F 49 FF                    I.
        sta     player2ControllerNew            ; A441 85 47                    .G
        lda     player2ControllerHeld           ; A443 A5 43                    .C
        and     player2ControllerNew            ; A445 25 47                    %G
        sta     player2ControllerNew            ; A447 85 47                    .G
        rts                                     ; A449 60                       `

; ----------------------------------------------------------------------------
LA44A:
        lda     $00                             ; A44A A5 00                    ..
        bpl     LA458                           ; A44C 10 0A                    ..
LA44E:
        ldx     $25                             ; A44E A6 25                    .%
        cpx     $27                             ; A450 E4 27                    .'
        bne     LA44E                           ; A452 D0 FA                    ..
        lda     $24,x                           ; A454 B5 24                    .$
        bne     LA44E                           ; A456 D0 F6                    ..
LA458:
        lda     #$00                            ; A458 A9 00                    ..
        sta     PPUCTRL                         ; A45A 8D 00 20                 .. 
        sta     $00                             ; A45D 85 00                    ..
        sta     PPUMASK                         ; A45F 8D 01 20                 .. 
        sta     $01                             ; A462 85 01                    ..
        rts                                     ; A464 60                       `

; ----------------------------------------------------------------------------
LA465:
        ldy     #$1A                            ; A465 A0 1A                    ..
        sty     $01                             ; A467 84 01                    ..
LA469:
        bit     PPUSTATUS                       ; A469 2C 02 20                 ,. 
        bmi     LA469                           ; A46C 30 FB                    0.
LA46E:
        bit     PPUSTATUS                       ; A46E 2C 02 20                 ,. 
        bpl     LA46E                           ; A471 10 FB                    ..
        ora     #$80                            ; A473 09 80                    ..
        sta     $00                             ; A475 85 00                    ..
        sta     PPUCTRL                         ; A477 8D 00 20                 .. 
        rts                                     ; A47A 60                       `

; ----------------------------------------------------------------------------
LA47B:
        asl     a                               ; A47B 0A                       .
        tax                                     ; A47C AA                       .
        bit     PPUSTATUS                       ; A47D 2C 02 20                 ,. 
        lda     #$23                            ; A480 A9 23                    .#
        sta     PPUADDR                         ; A482 8D 06 20                 .. 
        lda     #$C0                            ; A485 A9 C0                    ..
        sta     PPUADDR                         ; A487 8D 06 20                 .. 
        lda     LA4A8,x                         ; A48A BD A8 A4                 ...
        sta     $3C                             ; A48D 85 3C                    .<
        lda     LA4A9,x                         ; A48F BD A9 A4                 ...
        sta     $3D                             ; A492 85 3D                    .=
        ldy     #$00                            ; A494 A0 00                    ..
LA496:
        lda     ($3C),y                         ; A496 B1 3C                    .<
        beq     LA4A7                           ; A498 F0 0D                    ..
        tax                                     ; A49A AA                       .
        iny                                     ; A49B C8                       .
        lda     ($3C),y                         ; A49C B1 3C                    .<
LA49E:
        sta     PPUDATA                         ; A49E 8D 07 20                 .. 
        dex                                     ; A4A1 CA                       .
        bne     LA49E                           ; A4A2 D0 FA                    ..
        iny                                     ; A4A4 C8                       .
        bne     LA496                           ; A4A5 D0 EF                    ..
LA4A7:
        rts                                     ; A4A7 60                       `

; ----------------------------------------------------------------------------
LA4A8:
        .byte   $BA                             ; A4A8 BA                       .
LA4A9:
        .byte   $A4,$09,$A5,$3E,$A5,$3E,$A5,$77 ; A4A9 A4 09 A5 3E A5 3E A5 77  ...>.>.w
        .byte   $A5,$A8,$A5,$ED,$A5,$3E,$A6,$91 ; A4B1 A5 A8 A5 ED A5 3E A6 91  .....>..
        .byte   $A6,$01,$29,$02,$0A,$01,$0B,$01 ; A4B9 A6 01 29 02 0A 01 0B 01  ..).....
        .byte   $0E,$02,$0A,$01,$86,$01,$22,$06 ; A4C1 0E 02 0A 01 86 01 22 06  ......".
        .byte   $A5,$01,$88,$01,$32,$06,$55,$01 ; A4C9 A5 01 88 01 32 06 55 01  ....2.U.
        .byte   $C8,$01,$12,$03,$AA,$01,$9A,$02 ; A4D1 C8 01 12 03 AA 01 9A 02  ........
        .byte   $AA,$01,$48,$01,$32,$03,$AA,$01 ; A4D9 AA 01 48 01 32 03 AA 01  ..H.2...
        .byte   $A9,$02,$AA,$01,$C8,$01,$22,$01 ; A4E1 A9 02 AA 01 C8 01 22 01  ......".
        .byte   $AA,$01,$5A,$01,$00,$01,$C8,$01 ; A4E9 AA 01 5A 01 00 01 C8 01  ..Z.....
        .byte   $55,$01,$AA,$01,$88,$01,$22,$06 ; A4F1 55 01 AA 01 88 01 22 06  U.....".
        .byte   $0A,$01,$88,$01,$09,$02,$0A,$01 ; A4F9 0A 01 88 01 09 02 0A 01  ........
        .byte   $0B,$01,$0E,$02,$0A,$01,$06,$00 ; A501 0B 01 0E 02 0A 01 06 00  ........
        .byte   $01,$AA,$06,$FA,$01,$AA,$01,$AA ; A509 01 AA 06 FA 01 AA 01 AA  ........
        .byte   $06,$FF,$01,$AA,$01,$AA,$06,$FF ; A511 06 FF 01 AA 01 AA 06 FF  ........
        .byte   $01,$AA,$01,$AA,$06,$0F,$01,$AA ; A519 01 AA 01 AA 06 0F 01 AA  ........
        .byte   $01,$22,$01,$00,$01,$CC,$04,$00 ; A521 01 22 01 00 01 CC 04 00  ."......
        .byte   $01,$88,$01,$22,$01,$00,$01,$0C ; A529 01 88 01 22 01 00 01 0C  ..."....
        .byte   $04,$00,$01,$88,$01,$66,$06,$55 ; A531 04 00 01 88 01 66 06 55  .....f.U
        .byte   $01,$99,$08,$AA,$00,$01,$AA,$06 ; A539 01 99 08 AA 00 01 AA 06  ........
        .byte   $FA,$01,$AA,$01,$AA,$06,$FF,$01 ; A541 FA 01 AA 01 AA 06 FF 01  ........
        .byte   $AA,$01,$22,$06,$00,$01,$88,$01 ; A549 AA 01 22 06 00 01 88 01  ..".....
        .byte   $22,$02,$00,$02,$33,$02,$00,$01 ; A551 22 02 00 02 33 02 00 01  "...3...
        .byte   $88,$01,$22,$02,$00,$02,$33,$02 ; A559 88 01 22 02 00 02 33 02  .."...3.
        .byte   $00,$01,$88,$01,$22,$02,$00,$02 ; A561 00 01 88 01 22 02 00 02  ...."...
        .byte   $33,$02,$00,$01,$88,$01,$66,$06 ; A569 33 02 00 01 88 01 66 06  3.....f.
        .byte   $55,$01,$99,$08,$AA,$00,$01,$AA ; A571 55 01 99 08 AA 00 01 AA  U.......
        .byte   $06,$FA,$01,$AA,$01,$AA,$06,$FF ; A579 06 FA 01 AA 01 AA 06 FF  ........
        .byte   $01,$AA,$01,$22,$06,$00,$01,$88 ; A581 01 AA 01 22 06 00 01 88  ..."....
        .byte   $01,$22,$02,$00,$01,$33,$03,$00 ; A589 01 22 02 00 01 33 03 00  ."...3..
        .byte   $01,$88,$01,$22,$02,$00,$01,$33 ; A591 01 88 01 22 02 00 01 33  ..."...3
        .byte   $03,$00,$01,$88,$08,$AA,$01,$66 ; A599 03 00 01 88 08 AA 01 66  .......f
        .byte   $06,$55,$01,$99,$08,$AA,$00,$01 ; A5A1 06 55 01 99 08 AA 00 01  .U......
        .byte   $EA,$06,$FA,$01,$BA,$01,$22,$01 ; A5A9 EA 06 FA 01 BA 01 22 01  ......".
        .byte   $00,$04,$0F,$01,$00,$01,$88,$02 ; A5B1 00 04 0F 01 00 01 88 02  ........
        .byte   $FA,$01,$22,$02,$00,$01,$88,$02 ; A5B9 FA 01 22 02 00 01 88 02  ..".....
        .byte   $FA,$02,$FF,$01,$22,$02,$00,$01 ; A5C1 FA 02 FF 01 22 02 00 01  ...."...
        .byte   $88,$02,$FF,$02,$AA,$01,$22,$02 ; A5C9 88 02 FF 02 AA 01 22 02  ......".
        .byte   $00,$01,$88,$02,$AA,$02,$AA,$01 ; A5D1 00 01 88 02 AA 02 AA 01  ........
        .byte   $22,$02,$00,$01,$88,$02,$AA,$02 ; A5D9 22 02 00 01 88 02 AA 02  ".......
        .byte   $AA,$01,$22,$02,$00,$01,$88,$02 ; A5E1 AA 01 22 02 00 01 88 02  ..".....
        .byte   $AA,$08,$AA,$00,$01,$EA,$06,$FA ; A5E9 AA 08 AA 00 01 EA 06 FA  ........
        .byte   $01,$BA,$01,$22,$01,$00,$01,$CF ; A5F1 01 BA 01 22 01 00 01 CF  ..."....
        .byte   $04,$FF,$01,$BB,$01,$22,$02,$00 ; A5F9 04 FF 01 BB 01 22 02 00  ....."..
        .byte   $01,$EA,$01,$BA,$02,$55,$01,$99 ; A601 01 EA 01 BA 02 55 01 99  .....U..
        .byte   $01,$22,$02,$00,$01,$EE,$01,$BB ; A609 01 22 02 00 01 EE 01 BB  ."......
        .byte   $02,$55,$01,$99,$01,$22,$02,$00 ; A611 02 55 01 99 01 22 02 00  .U..."..
        .byte   $01,$EE,$01,$BB,$02,$55,$01,$99 ; A619 01 EE 01 BB 02 55 01 99  .....U..
        .byte   $01,$22,$02,$00,$01,$EE,$01,$BB ; A621 01 22 02 00 01 EE 01 BB  ."......
        .byte   $02,$55,$01,$99,$01,$22,$02,$00 ; A629 02 55 01 99 01 22 02 00  .U..."..
        .byte   $01,$EE,$01,$BB,$01,$75,$01,$95 ; A631 01 EE 01 BB 01 75 01 95  .....u..
        .byte   $01,$A9,$08,$AA,$00,$01,$EA,$06 ; A639 01 A9 08 AA 00 01 EA 06  ........
        .byte   $FA,$01,$BA,$01,$22,$01,$00,$01 ; A641 FA 01 BA 01 22 01 00 01  ...."...
        .byte   $CF,$02,$FF,$01,$7F,$01,$55,$01 ; A649 CF 02 FF 01 7F 01 55 01  ......U.
        .byte   $99,$01,$22,$02,$00,$01,$EA,$01 ; A651 99 01 22 02 00 01 EA 01  ..".....
        .byte   $BA,$02,$55,$01,$99,$01,$22,$02 ; A659 BA 02 55 01 99 01 22 02  ..U...".
        .byte   $00,$01,$EE,$01,$BB,$02,$55,$01 ; A661 00 01 EE 01 BB 02 55 01  ......U.
        .byte   $99,$01,$22,$02,$00,$01,$EE,$01 ; A669 99 01 22 02 00 01 EE 01  ..".....
        .byte   $BB,$02,$55,$01,$99,$01,$22,$02 ; A671 BB 02 55 01 99 01 22 02  ..U...".
        .byte   $00,$01,$EE,$01,$BB,$02,$55,$01 ; A679 00 01 EE 01 BB 02 55 01  ......U.
        .byte   $99,$01,$22,$02,$00,$01,$EE,$01 ; A681 99 01 22 02 00 01 EE 01  ..".....
        .byte   $BB,$02,$55,$01,$99,$08,$AA,$00 ; A689 BB 02 55 01 99 08 AA 00  ..U.....
        .byte   $01,$AA,$06,$FA,$01,$AA,$01,$22 ; A691 01 AA 06 FA 01 AA 01 22  ......."
        .byte   $06,$FF,$01,$88,$01,$22,$06,$55 ; A699 06 FF 01 88 01 22 06 55  .....".U
        .byte   $01,$88,$01,$22,$06,$00,$01,$88 ; A6A1 01 88 01 22 06 00 01 88  ..."....
        .byte   $01,$22,$06,$00,$01,$88,$01,$22 ; A6A9 01 22 06 00 01 88 01 22  ."....."
        .byte   $06,$00,$01,$88,$01,$22,$06,$00 ; A6B1 06 00 01 88 01 22 06 00  ....."..
        .byte   $01,$88,$08,$AA,$00             ; A6B9 01 88 08 AA 00           .....
; ----------------------------------------------------------------------------
LA6BE:
        tay                                     ; A6BE A8                       .
        jsr     LA3DB                           ; A6BF 20 DB A3                  ..
        lda     #$3F                            ; A6C2 A9 3F                    .?
        sta     $17,x                           ; A6C4 95 17                    ..
        lda     LA6DF,y                         ; A6C6 B9 DF A6                 ...
        sta     $16,x                           ; A6C9 95 16                    ..
        tya                                     ; A6CB 98                       .
        asl     a                               ; A6CC 0A                       .
        asl     a                               ; A6CD 0A                       .
        asl     a                               ; A6CE 0A                       .
        asl     a                               ; A6CF 0A                       .
        adc     #$E6                            ; A6D0 69 E6                    i.
        sta     ppuDataAddress1,x               ; A6D2 95 08                    ..
        lda     #$00                            ; A6D4 A9 00                    ..
        adc     #$A6                            ; A6D6 69 A6                    i.
        sta     ppuDataAddress1+1,x             ; A6D8 95 09                    ..
        lda     #$10                            ; A6DA A9 10                    ..
        sta     $24,x                           ; A6DC 95 24                    .$
        rts                                     ; A6DE 60                       `

; ----------------------------------------------------------------------------
LA6DF:
        .byte   $00,$00,$00,$10,$10,$10,$10,$0F ; A6DF 00 00 00 10 10 10 10 0F  ........
        .byte   $31,$21,$11,$0F,$26,$16,$06,$0F ; A6E7 31 21 11 0F 26 16 06 0F  1!..&...
        .byte   $37,$27,$17,$0F,$2A,$1A,$0A,$0F ; A6EF 37 27 17 0F 2A 1A 0A 0F  7'..*...
        .byte   $12,$0F,$0F,$0F,$27,$0F,$0F,$0F ; A6F7 12 0F 0F 0F 27 0F 0F 0F  ....'...
        .byte   $31,$21,$01,$0F,$30,$16,$00,$0F ; A6FF 31 21 01 0F 30 16 00 0F  1!..0...
        .byte   $20,$10,$00,$0F,$27,$18,$08,$0F ; A707 20 10 00 0F 27 18 08 0F   ...'...
        .byte   $31,$21,$01,$0F,$30,$16,$00,$0F ; A70F 31 21 01 0F 30 16 00 0F  1!..0...
        .byte   $16,$0F,$00,$0F,$12,$24,$1B,$0F ; A717 16 0F 00 0F 12 24 1B 0F  .....$..
        .byte   $0F,$0F,$0F,$0F,$37,$0F,$0F,$0F ; A71F 0F 0F 0F 0F 37 0F 0F 0F  ....7...
        .byte   $37,$27,$06,$0F,$31,$06,$11,$0F ; A727 37 27 06 0F 31 06 11 0F  7'..1...
        .byte   $17,$21,$26,$0F,$26,$16,$06,$0F ; A72F 17 21 26 0F 26 16 06 0F  .!&.&...
        .byte   $35,$16,$12,$0F,$12,$24,$1B,$0F ; A737 35 16 12 0F 12 24 1B 0F  5....$..
        .byte   $35,$1A,$37,$0F,$35,$18,$24,$0F ; A73F 35 1A 37 0F 35 18 24 0F  5.7.5.$.
        .byte   $37,$39,$3B,$0F,$2A,$2B,$30,$0F ; A747 37 39 3B 0F 2A 2B 30 0F  79;.*+0.
        .byte   $26,$21,$37,$0F,$35,$24,$13     ; A74F 26 21 37 0F 35 24 13     &!7.5$.
; ----------------------------------------------------------------------------
LA756:
        lda     player1LevelOnes,x              ; A756 BD 2D 04                 .-.
        and     #$0F                            ; A759 29 0F                    ).
        tay                                     ; A75B A8                       .
        txa                                     ; A75C 8A                       .
        asl     a                               ; A75D 0A                       .
LA75E:
        clc                                     ; A75E 18                       .
        adc     #$01                            ; A75F 69 01                    i.
        bne     LA768                           ; A761 D0 05                    ..
LA763:
        txa                                     ; A763 8A                       .
        asl     a                               ; A764 0A                       .
        asl     a                               ; A765 0A                       .
        adc     #$11                            ; A766 69 11                    i.
LA768:
        pha                                     ; A768 48                       H
        jsr     LA3DB                           ; A769 20 DB A3                  ..
        pla                                     ; A76C 68                       h
        sta     $16,x                           ; A76D 95 16                    ..
        lda     #$3F                            ; A76F A9 3F                    .?
        sta     $17,x                           ; A771 95 17                    ..
        sty     $36                             ; A773 84 36                    .6
        tya                                     ; A775 98                       .
        asl     a                               ; A776 0A                       .
        adc     $36                             ; A777 65 36                    e6
        adc     #$88                            ; A779 69 88                    i.
        sta     ppuDataAddress1,x               ; A77B 95 08                    ..
        lda     #$A7                            ; A77D A9 A7                    ..
        adc     #$00                            ; A77F 69 00                    i.
        sta     ppuDataAddress1+1,x             ; A781 95 09                    ..
        lda     #$03                            ; A783 A9 03                    ..
        sta     $24,x                           ; A785 95 24                    .$
        rts                                     ; A787 60                       `

; ----------------------------------------------------------------------------
        .byte   $20,$10,$00,$26,$16,$06,$27,$18 ; A788 20 10 00 26 16 06 27 18   ..&..'.
        .byte   $08,$21,$12,$01,$37,$27,$17,$34 ; A790 08 21 12 01 37 27 17 34  .!..7'.4
        .byte   $24,$14,$2A,$1A,$0A,$2C,$1C,$0C ; A798 24 14 2A 1A 0A 2C 1C 0C  $.*..,..
        .byte   $23,$13,$03,$2B,$1B,$0B,$0F,$0F ; A7A0 23 13 03 2B 1B 0B 0F 0F  #..+....
        .byte   $0F,$30,$16,$0F                 ; A7A8 0F 30 16 0F              .0..
; ----------------------------------------------------------------------------
nmi:
        pha                                     ; A7AC 48                       H
        txa                                     ; A7AD 8A                       .
        pha                                     ; A7AE 48                       H
        tya                                     ; A7AF 98                       .
        pha                                     ; A7B0 48                       H
        lda     #$00                            ; A7B1 A9 00                    ..
        sta     PPUMASK                         ; A7B3 8D 01 20                 .. 
        sta     OAMADDR                         ; A7B6 8D 03 20                 .. 
        lda     #$05                            ; A7B9 A9 05                    ..
        sta     OAMDMA                          ; A7BB 8D 14 40                 ..@
        lda     $00                             ; A7BE A5 00                    ..
        and     #$FB                            ; A7C0 29 FB                    ).
        sta     PPUCTRL                         ; A7C2 8D 00 20                 .. 
        jsr     renderJumpRoutine               ; A7C5 20 0E A8                  ..
        stx     $27                             ; A7C8 86 27                    .'
        inc     frameCounterLow                 ; A7CA E6 32                    .2
        bne     LA7D0                           ; A7CC D0 02                    ..
        inc     frameCounterHigh                ; A7CE E6 33                    .3
LA7D0:
        ldx     $04                             ; A7D0 A6 04                    ..
        sta     $6000,x                         ; A7D2 9D 00 60                 ..`
        ldx     $05                             ; A7D5 A6 05                    ..
        sta     $6010,x                         ; A7D7 9D 10 60                 ..`
        ldx     $06                             ; A7DA A6 06                    ..
        sta     $6020,x                         ; A7DC 9D 20 60                 . `
        ldx     $07                             ; A7DF A6 07                    ..
        sta     $6030,x                         ; A7E1 9D 30 60                 .0`
        lda     $04                             ; A7E4 A5 04                    ..
        lsr     a                               ; A7E6 4A                       J
        lsr     a                               ; A7E7 4A                       J
        tax                                     ; A7E8 AA                       .
        ora     #$02                            ; A7E9 09 02                    ..
        sta     cnromBank2or3,x                 ; A7EB 9D F6 FF                 ...
        ldx     PPUSTATUS                       ; A7EE AE 02 20                 .. 
        lda     ppuScrollX                      ; A7F1 A5 02                    ..
        sta     PPUSCROLL                       ; A7F3 8D 05 20                 .. 
        lda     ppuScrollY                      ; A7F6 A5 03                    ..
        sta     PPUSCROLL                       ; A7F8 8D 05 20                 .. 
        lda     $00                             ; A7FB A5 00                    ..
        sta     PPUCTRL                         ; A7FD 8D 00 20                 .. 
        lda     $01                             ; A800 A5 01                    ..
        sta     PPUMASK                         ; A802 8D 01 20                 .. 
        jsr     LCFCA                           ; A805 20 CA CF                  ..
        pla                                     ; A808 68                       h
        tay                                     ; A809 A8                       .
        pla                                     ; A80A 68                       h
        tax                                     ; A80B AA                       .
        pla                                     ; A80C 68                       h
        rti                                     ; A80D 40                       @

; ----------------------------------------------------------------------------
renderJumpRoutine:
        ldx     $27                             ; A80E A6 27                    .'
        lda     renderJumpTable+1,x             ; A810 BD 04 A9                 ...
        pha                                     ; A813 48                       H
        lda     renderJumpTable,x               ; A814 BD 03 A9                 ...
        pha                                     ; A817 48                       H
renderFakeReturnXIs0:
        rts                                     ; A818 60                       `

; ----------------------------------------------------------------------------
LA819:
        ldx     $24                             ; A819 A6 24                    .$
        bne     LA820                           ; A81B D0 03                    ..
        ldx     #$00                            ; A81D A2 00                    ..
        rts                                     ; A81F 60                       `

; ----------------------------------------------------------------------------
LA820:
        ldy     #$00                            ; A820 A0 00                    ..
        bit     PPUSTATUS                       ; A822 2C 02 20                 ,. 
        lda     $17                             ; A825 A5 17                    ..
        sta     PPUADDR                         ; A827 8D 06 20                 .. 
        lda     $16                             ; A82A A5 16                    ..
        sta     PPUADDR                         ; A82C 8D 06 20                 .. 
LA82F:
        lda     (ppuDataAddress1),y             ; A82F B1 08                    ..
        sta     PPUDATA                         ; A831 8D 07 20                 .. 
        iny                                     ; A834 C8                       .
        dex                                     ; A835 CA                       .
        bne     LA82F                           ; A836 D0 F7                    ..
renderFakeReturnXIs2:= * + 1
        stx     $24                             ; A838 86 24                    .$
        ldx     $26                             ; A83A A6 26                    .&
        bne     LA841                           ; A83C D0 03                    ..
        ldx     #$02                            ; A83E A2 02                    ..
        rts                                     ; A840 60                       `

; ----------------------------------------------------------------------------
LA841:
        ldy     #$00                            ; A841 A0 00                    ..
        bit     PPUSTATUS                       ; A843 2C 02 20                 ,. 
        lda     $19                             ; A846 A5 19                    ..
        sta     PPUADDR                         ; A848 8D 06 20                 .. 
        lda     $18                             ; A84B A5 18                    ..
        sta     PPUADDR                         ; A84D 8D 06 20                 .. 
LA850:
        lda     (ppuDataAddress2),y             ; A850 B1 0A                    ..
        sta     PPUDATA                         ; A852 8D 07 20                 .. 
        iny                                     ; A855 C8                       .
        dex                                     ; A856 CA                       .
        bne     LA850                           ; A857 D0 F7                    ..
renderFakeReturnXIs4:= * + 1
        stx     $26                             ; A859 86 26                    .&
        ldx     $28                             ; A85B A6 28                    .(
        bne     LA862                           ; A85D D0 03                    ..
        ldx     #$04                            ; A85F A2 04                    ..
        rts                                     ; A861 60                       `

; ----------------------------------------------------------------------------
LA862:
        ldy     #$00                            ; A862 A0 00                    ..
        bit     PPUSTATUS                       ; A864 2C 02 20                 ,. 
        lda     $1B                             ; A867 A5 1B                    ..
        sta     PPUADDR                         ; A869 8D 06 20                 .. 
        lda     $1A                             ; A86C A5 1A                    ..
        sta     PPUADDR                         ; A86E 8D 06 20                 .. 
LA871:
        lda     (ppuDataAddress3),y             ; A871 B1 0C                    ..
        sta     PPUDATA                         ; A873 8D 07 20                 .. 
        iny                                     ; A876 C8                       .
        dex                                     ; A877 CA                       .
        bne     LA871                           ; A878 D0 F7                    ..
renderFakeReturnXIs6:= * + 1
        stx     $28                             ; A87A 86 28                    .(
        ldx     $2A                             ; A87C A6 2A                    .*
        bne     LA883                           ; A87E D0 03                    ..
        ldx     #$06                            ; A880 A2 06                    ..
        rts                                     ; A882 60                       `

; ----------------------------------------------------------------------------
LA883:
        ldy     #$00                            ; A883 A0 00                    ..
        bit     PPUSTATUS                       ; A885 2C 02 20                 ,. 
        lda     $1D                             ; A888 A5 1D                    ..
        sta     PPUADDR                         ; A88A 8D 06 20                 .. 
        lda     $1C                             ; A88D A5 1C                    ..
        sta     PPUADDR                         ; A88F 8D 06 20                 .. 
LA892:
        lda     (ppuDataAddress4),y             ; A892 B1 0E                    ..
        sta     PPUDATA                         ; A894 8D 07 20                 .. 
        iny                                     ; A897 C8                       .
        dex                                     ; A898 CA                       .
        bne     LA892                           ; A899 D0 F7                    ..
renderFakeReturnXIs8:= * + 1
        stx     $2A                             ; A89B 86 2A                    .*
        ldx     $2C                             ; A89D A6 2C                    .,
        bne     LA8A4                           ; A89F D0 03                    ..
        ldx     #$08                            ; A8A1 A2 08                    ..
        rts                                     ; A8A3 60                       `

; ----------------------------------------------------------------------------
LA8A4:
        ldy     #$00                            ; A8A4 A0 00                    ..
        bit     PPUSTATUS                       ; A8A6 2C 02 20                 ,. 
        lda     $1F                             ; A8A9 A5 1F                    ..
        sta     PPUADDR                         ; A8AB 8D 06 20                 .. 
        lda     $1E                             ; A8AE A5 1E                    ..
        sta     PPUADDR                         ; A8B0 8D 06 20                 .. 
LA8B3:
        lda     (ppuDataAddress5),y             ; A8B3 B1 10                    ..
        sta     PPUDATA                         ; A8B5 8D 07 20                 .. 
        iny                                     ; A8B8 C8                       .
        dex                                     ; A8B9 CA                       .
        bne     LA8B3                           ; A8BA D0 F7                    ..
renderFakeReturnXIsA:= * + 1
        stx     $2C                             ; A8BC 86 2C                    .,
        ldx     $2E                             ; A8BE A6 2E                    ..
        bne     LA8C5                           ; A8C0 D0 03                    ..
        ldx     #$0A                            ; A8C2 A2 0A                    ..
        rts                                     ; A8C4 60                       `

; ----------------------------------------------------------------------------
LA8C5:
        ldy     #$00                            ; A8C5 A0 00                    ..
        bit     PPUSTATUS                       ; A8C7 2C 02 20                 ,. 
        lda     $21                             ; A8CA A5 21                    .!
        sta     PPUADDR                         ; A8CC 8D 06 20                 .. 
        lda     $20                             ; A8CF A5 20                    . 
        sta     PPUADDR                         ; A8D1 8D 06 20                 .. 
LA8D4:
        lda     (ppuDataAddress6),y             ; A8D4 B1 12                    ..
        sta     PPUDATA                         ; A8D6 8D 07 20                 .. 
        iny                                     ; A8D9 C8                       .
        dex                                     ; A8DA CA                       .
        bne     LA8D4                           ; A8DB D0 F7                    ..
renderFakeReturnXIsC:= * + 1
        stx     $2E                             ; A8DD 86 2E                    ..
        ldx     $30                             ; A8DF A6 30                    .0
        bne     LA8E6                           ; A8E1 D0 03                    ..
        ldx     #$0C                            ; A8E3 A2 0C                    ..
        rts                                     ; A8E5 60                       `

; ----------------------------------------------------------------------------
LA8E6:
        ldy     #$00                            ; A8E6 A0 00                    ..
        bit     PPUSTATUS                       ; A8E8 2C 02 20                 ,. 
        lda     $23                             ; A8EB A5 23                    .#
        sta     PPUADDR                         ; A8ED 8D 06 20                 .. 
        lda     $22                             ; A8F0 A5 22                    ."
        sta     PPUADDR                         ; A8F2 8D 06 20                 .. 
LA8F5:
        lda     (ppuDataAddress7),y             ; A8F5 B1 14                    ..
        sta     PPUDATA                         ; A8F7 8D 07 20                 .. 
        iny                                     ; A8FA C8                       .
        dex                                     ; A8FB CA                       .
        bne     LA8F5                           ; A8FC D0 F7                    ..
        stx     $30                             ; A8FE 86 30                    .0
        jmp     LA819                           ; A900 4C 19 A8                 L..

; ----------------------------------------------------------------------------
renderJumpTable:
        .addr   renderFakeReturnXIs0            ; A903 18 A8                    ..
        .addr   renderFakeReturnXIs2            ; A905 39 A8                    9.
        .addr   renderFakeReturnXIs4            ; A907 5A A8                    Z.
        .addr   renderFakeReturnXIs6            ; A909 7B A8                    {.
        .addr   renderFakeReturnXIs8            ; A90B 9C A8                    ..
        .addr   renderFakeReturnXIsA            ; A90D BD A8                    ..
        .addr   renderFakeReturnXIsC            ; A90F DE A8                    ..
; ----------------------------------------------------------------------------
reset:
        sei                                     ; A911 78                       x
        cld                                     ; A912 D8                       .
        ldx     #$00                            ; A913 A2 00                    ..
        stx     PPUCTRL                         ; A915 8E 00 20                 .. 
        stx     PPUMASK                         ; A918 8E 01 20                 .. 
LA91B:
        lda     PPUSTATUS                       ; A91B AD 02 20                 .. 
        bpl     LA91B                           ; A91E 10 FB                    ..
LA920:
        lda     PPUSTATUS                       ; A920 AD 02 20                 .. 
        bpl     LA920                           ; A923 10 FB                    ..
        dex                                     ; A925 CA                       .
        txs                                     ; A926 9A                       .
        inx                                     ; A927 E8                       .
        lda     $04F7                           ; A928 AD F7 04                 ...
        cmp     #$4C                            ; A92B C9 4C                    .L
        bne     LA966                           ; A92D D0 37                    .7
        lda     $04F8                           ; A92F AD F8 04                 ...
        cmp     #$4F                            ; A932 C9 4F                    .O
        bne     LA966                           ; A934 D0 30                    .0
        lda     $04F9                           ; A936 AD F9 04                 ...
        cmp     #$47                            ; A939 C9 47                    .G
        bne     LA966                           ; A93B D0 29                    .)
        lda     $04FA                           ; A93D AD FA 04                 ...
        cmp     #$47                            ; A940 C9 47                    .G
        bne     LA966                           ; A942 D0 22                    ."
        ldy     #$00                            ; A944 A0 00                    ..
LA946:
        lda     player1ScoreHundredThousands,y  ; A946 B9 18 04                 ...
        cmp     #$30                            ; A949 C9 30                    .0
        bcc     LA966                           ; A94B 90 19                    ..
        cmp     #$3A                            ; A94D C9 3A                    .:
        bcs     LA966                           ; A94F B0 15                    ..
        iny                                     ; A951 C8                       .
        cpy     #$AB                            ; A952 C0 AB                    ..
        bcc     LA946                           ; A954 90 F0                    ..
LA956:
        lda     player1ScoreHundredThousands,y  ; A956 B9 18 04                 ...
        and     #$3F                            ; A959 29 3F                    )?
        cmp     #$1B                            ; A95B C9 1B                    ..
        bcs     LA966                           ; A95D B0 07                    ..
        iny                                     ; A95F C8                       .
        cpy     #$D8                            ; A960 C0 D8                    ..
        bcc     LA956                           ; A962 90 F2                    ..
        bcs     LA9A1                           ; A964 B0 3B                    .;
LA966:
        txa                                     ; A966 8A                       .
LA967:
        sta     player1ScoreHundredThousands,x  ; A967 9D 18 04                 ...
        inx                                     ; A96A E8                       .
        bne     LA967                           ; A96B D0 FA                    ..
        ldy     #$00                            ; A96D A0 00                    ..
        lda     #$30                            ; A96F A9 30                    .0
LA971:
        sta     player1ScoreHundredThousands,y  ; A971 99 18 04                 ...
        iny                                     ; A974 C8                       .
        cpy     #$AB                            ; A975 C0 AB                    ..
        bcc     LA971                           ; A977 90 F8                    ..
        lda     #$01                            ; A979 A9 01                    ..
LA97B:
        sta     player1ScoreHundredThousands,y  ; A97B 99 18 04                 ...
        iny                                     ; A97E C8                       .
        cpy     #$D8                            ; A97F C0 D8                    ..
        bcc     LA97B                           ; A981 90 F8                    ..
        ldy     #$0E                            ; A983 A0 0E                    ..
        ldx     #$00                            ; A985 A2 00                    ..
LA987:
        tya                                     ; A987 98                       .
        clc                                     ; A988 18                       .
        adc     #$33                            ; A989 69 33                    i3
        cmp     #$3A                            ; A98B C9 3A                    .:
        bcc     LA994                           ; A98D 90 05                    ..
        inc     highScoreTenThousands,x         ; A98F FE 3D 04                 .=.
        sbc     #$0A                            ; A992 E9 0A                    ..
LA994:
        sta     highScoreThousands,x            ; A994 9D 3E 04                 .>.
        txa                                     ; A997 8A                       .
        clc                                     ; A998 18                       .
        adc     #$06                            ; A999 69 06                    i.
        tax                                     ; A99B AA                       .
        dey                                     ; A99C 88                       .
        bpl     LA987                           ; A99D 10 E8                    ..
        ldx     #$00                            ; A99F A2 00                    ..
LA9A1:
        txa                                     ; A9A1 8A                       .
LA9A2:
        sta     $00,x                           ; A9A2 95 00                    ..
        sta     $0100,x                         ; A9A4 9D 00 01                 ...
        sta     oamStaging,x                    ; A9A7 9D 00 05                 ...
        sta     player1Playfield,x              ; A9AA 9D 00 06                 ...
        sta     player2Playfield,x              ; A9AD 9D 00 07                 ...
        inx                                     ; A9B0 E8                       .
        bne     LA9A2                           ; A9B1 D0 EF                    ..
        lda     #$4C                            ; A9B3 A9 4C                    .L
        sta     $04F7                           ; A9B5 8D F7 04                 ...
        lda     #$4F                            ; A9B8 A9 4F                    .O
        sta     $04F8                           ; A9BA 8D F8 04                 ...
        lda     #$47                            ; A9BD A9 47                    .G
        sta     $04F9                           ; A9BF 8D F9 04                 ...
        lda     #$47                            ; A9C2 A9 47                    .G
        sta     $04FA                           ; A9C4 8D FA 04                 ...
        lda     #$5A                            ; A9C7 A9 5A                    .Z
        sta     rngSeed                         ; A9C9 85 34                    .4
        jmp     L8003                           ; A9CB 4C 03 80                 L..

; ----------------------------------------------------------------------------
LA9CE:
        lda     player2FallTimer                ; A9CE A5 6B                    .k
        beq     LA9E9                           ; A9D0 F0 17                    ..
        lda     gameStatePossible               ; A9D2 A5 29                    .)
        cmp     #$FA                            ; A9D4 C9 FA                    ..
        beq     LA9DE                           ; A9D6 F0 06                    ..
        lda     $74                             ; A9D8 A5 74                    .t
        ora     $75                             ; A9DA 05 75                    .u
        beq     LA9E2                           ; A9DC F0 04                    ..
LA9DE:
        dec     player2FallTimer                ; A9DE C6 6B                    .k
        beq     LA9E3                           ; A9E0 F0 01                    ..
LA9E2:
        rts                                     ; A9E2 60                       `

; ----------------------------------------------------------------------------
LA9E3:
        jsr     LAA70                           ; A9E3 20 70 AA                  p.
        jmp     LA9EF                           ; A9E6 4C EF A9                 L..

; ----------------------------------------------------------------------------
LA9E9:
        lda     frameCounterLow                 ; A9E9 A5 32                    .2
        and     #$03                            ; A9EB 29 03                    ).
        bne     LA9E2                           ; A9ED D0 F3                    ..
LA9EF:
        ldy     #$00                            ; A9EF A0 00                    ..
        lda     ($76),y                         ; A9F1 B1 76                    .v
        sta     $39                             ; A9F3 85 39                    .9
        bne     LAA1D                           ; A9F5 D0 26                    .&
        ldx     #$4C                            ; A9F7 A2 4C                    .L
        ldy     #$2D                            ; A9F9 A0 2D                    .-
        lda     #$F7                            ; A9FB A9 F7                    ..
LA9FD:
        sta     oamStaging,x                    ; A9FD 9D 00 05                 ...
        inx                                     ; AA00 E8                       .
        inx                                     ; AA01 E8                       .
        inx                                     ; AA02 E8                       .
        inx                                     ; AA03 E8                       .
        dey                                     ; AA04 88                       .
        bne     LA9FD                           ; AA05 D0 F6                    ..
        lda     gameStatePossible               ; AA07 A5 29                    .)
        cmp     #$FA                            ; AA09 C9 FA                    ..
        bne     LAA13                           ; AA0B D0 06                    ..
        lda     frameCounterHigh                ; AA0D A5 33                    .3
        cmp     #$04                            ; AA0F C9 04                    ..
        bcs     LA9E2                           ; AA11 B0 CF                    ..
LAA13:
        jsr     L9A0D                           ; AA13 20 0D 9A                  ..
        and     #$3F                            ; AA16 29 3F                    )?
        adc     #$08                            ; AA18 69 08                    i.
        sta     player2FallTimer                ; AA1A 85 6B                    .k
        rts                                     ; AA1C 60                       `

; ----------------------------------------------------------------------------
LAA1D:
        cmp     #$80                            ; AA1D C9 80                    ..
        bcs     LAA2C                           ; AA1F B0 0B                    ..
        jsr     LACA0                           ; AA21 20 A0 AC                  ..
        inc     $76                             ; AA24 E6 76                    .v
        bne     LA9EF                           ; AA26 D0 C7                    ..
        inc     $77                             ; AA28 E6 77                    .w
        bne     LA9EF                           ; AA2A D0 C3                    ..
LAA2C:
        iny                                     ; AA2C C8                       .
        lda     ($76),y                         ; AA2D B1 76                    .v
        sta     $38                             ; AA2F 85 38                    .8
        iny                                     ; AA31 C8                       .
        lda     ($76),y                         ; AA32 B1 76                    .v
        sta     $36                             ; AA34 85 36                    .6
        lda     $76                             ; AA36 A5 76                    .v
        clc                                     ; AA38 18                       .
        adc     #$03                            ; AA39 69 03                    i.
        sta     $76                             ; AA3B 85 76                    .v
        bcc     LAA41                           ; AA3D 90 02                    ..
        inc     $77                             ; AA3F E6 77                    .w
LAA41:
        ldx     #$4C                            ; AA41 A2 4C                    .L
        ldy     #$01                            ; AA43 A0 01                    ..
LAA45:
        lda     oamStaging,x                    ; AA45 BD 00 05                 ...
        clc                                     ; AA48 18                       .
        adc     $36                             ; AA49 65 36                    e6
        sta     oamStaging,x                    ; AA4B 9D 00 05                 ...
        lda     oamStaging+2,x                  ; AA4E BD 02 05                 ...
        and     #$04                            ; AA51 29 04                    ).
        beq     LAA57                           ; AA53 F0 02                    ..
        lda     ($38),y                         ; AA55 B1 38                    .8
LAA57:
        sta     oamStaging+1,x                  ; AA57 9D 01 05                 ...
        inx                                     ; AA5A E8                       .
        inx                                     ; AA5B E8                       .
        inx                                     ; AA5C E8                       .
        inx                                     ; AA5D E8                       .
LAA5E:
        iny                                     ; AA5E C8                       .
        cpy     #$06                            ; AA5F C0 06                    ..
        beq     LAA5E                           ; AA61 F0 FB                    ..
        cpy     #$2A                            ; AA63 C0 2A                    .*
        beq     LAA5E                           ; AA65 F0 F7                    ..
        cpy     #$30                            ; AA67 C0 30                    .0
        bcc     LAA45                           ; AA69 90 DA                    ..
        rts                                     ; AA6B 60                       `

; ----------------------------------------------------------------------------
differentMusicSelectTable:
        .byte   $16,$17,$18,$19                 ; AA6C 16 17 18 19              ....
; ----------------------------------------------------------------------------
LAA70:
        ldy     gameStatePossible               ; AA70 A4 29                    .)
        lda     #$00                            ; AA72 A9 00                    ..
        cpy     #$FA                            ; AA74 C0 FA                    ..
        beq     LAA89                           ; AA76 F0 11                    ..
        jsr     L9A0D                           ; AA78 20 0D 9A                  ..
        and     #$03                            ; AA7B 29 03                    ).
        tay                                     ; AA7D A8                       .
        lda     differentMusicSelectTable,y     ; AA7E B9 6C AA                 .l.
        jsr     possibleSetSoundOrMusic         ; AA81 20 B1 CF                  ..
        jsr     L9A0D                           ; AA84 20 0D 9A                  ..
        and     #$06                            ; AA87 29 06                    ).
LAA89:
        tay                                     ; AA89 A8                       .
        lda     LAB25,y                         ; AA8A B9 25 AB                 .%.
        sta     $76                             ; AA8D 85 76                    .v
        lda     LAB26,y                         ; AA8F B9 26 AB                 .&.
        sta     $77                             ; AA92 85 77                    .w
        sta     $37                             ; AA94 85 37                    .7
        ldy     gameStatePossible               ; AA96 A4 29                    .)
        lda     #$50                            ; AA98 A9 50                    .P
        cpy     #$FA                            ; AA9A C0 FA                    ..
        beq     LAAA0                           ; AA9C F0 02                    ..
        lda     #$10                            ; AA9E A9 10                    ..
LAAA0:
        ldx     #$4C                            ; AAA0 A2 4C                    .L
        ldy     #$07                            ; AAA2 A0 07                    ..
LAAA4:
        sta     oamStaging,x                    ; AAA4 9D 00 05                 ...
        sta     oamStaging+4,x                  ; AAA7 9D 04 05                 ...
        sta     oamStaging+8,x                  ; AAAA 9D 08 05                 ...
        sta     oamStaging+12,x                 ; AAAD 9D 0C 05                 ...
        sta     oamStaging+16,x                 ; AAB0 9D 10 05                 ...
        cpy     #$01                            ; AAB3 C0 01                    ..
        beq     LAABD                           ; AAB5 F0 06                    ..
        sta     oamStaging+20,x                 ; AAB7 9D 14 05                 ...
        sta     oamStaging+24,x                 ; AABA 9D 18 05                 ...
LAABD:
        clc                                     ; AABD 18                       .
        adc     #$08                            ; AABE 69 08                    i.
        pha                                     ; AAC0 48                       H
        txa                                     ; AAC1 8A                       .
        clc                                     ; AAC2 18                       .
        adc     LAB1D,y                         ; AAC3 79 1D AB                 y..
        tax                                     ; AAC6 AA                       .
        pla                                     ; AAC7 68                       h
        dey                                     ; AAC8 88                       .
        bne     LAAA4                           ; AAC9 D0 D9                    ..
        jsr     L9A0D                           ; AACB 20 0D 9A                  ..
        cmp     #$2C                            ; AACE C9 2C                    .,
        bcs     LAAD4                           ; AAD0 B0 02                    ..
        lda     #$2C                            ; AAD2 A9 2C                    .,
LAAD4:
        cmp     #$D4                            ; AAD4 C9 D4                    ..
        bcc     LAADA                           ; AAD6 90 02                    ..
        lda     #$D4                            ; AAD8 A9 D4                    ..
LAADA:
        sec                                     ; AADA 38                       8
        sbc     #$1C                            ; AADB E9 1C                    ..
        ldx     #$4C                            ; AADD A2 4C                    .L
        ldy     #$07                            ; AADF A0 07                    ..
LAAE1:
        sta     oamStaging+23,x                 ; AAE1 9D 17 05                 ...
        sta     oamStaging+51,x                 ; AAE4 9D 33 05                 .3.
        sta     oamStaging+79,x                 ; AAE7 9D 4F 05                 .O.
        sta     oamStaging+107,x                ; AAEA 9D 6B 05                 .k.
        sta     oamStaging+135,x                ; AAED 9D 87 05                 ...
        cpy     #$07                            ; AAF0 C0 07                    ..
        beq     LAAFE                           ; AAF2 F0 0A                    ..
        cpy     #$01                            ; AAF4 C0 01                    ..
        beq     LAAFE                           ; AAF6 F0 06                    ..
        sta     $04FF,x                         ; AAF8 9D FF 04                 ...
        sta     oamStaging+159,x                ; AAFB 9D 9F 05                 ...
LAAFE:
        clc                                     ; AAFE 18                       .
        adc     #$08                            ; AAFF 69 08                    i.
        inx                                     ; AB01 E8                       .
        inx                                     ; AB02 E8                       .
        inx                                     ; AB03 E8                       .
        inx                                     ; AB04 E8                       .
        dey                                     ; AB05 88                       .
        bne     LAAE1                           ; AB06 D0 D9                    ..
        jsr     L9A0D                           ; AB08 20 0D 9A                  ..
        and     #$03                            ; AB0B 29 03                    ).
        ora     #$24                            ; AB0D 09 24                    .$
        ldx     #$4C                            ; AB0F A2 4C                    .L
        ldy     #$2D                            ; AB11 A0 2D                    .-
LAB13:
        sta     oamStaging+2,x                  ; AB13 9D 02 05                 ...
        inx                                     ; AB16 E8                       .
        inx                                     ; AB17 E8                       .
        inx                                     ; AB18 E8                       .
        inx                                     ; AB19 E8                       .
        dey                                     ; AB1A 88                       .
        bne     LAB13                           ; AB1B D0 F6                    ..
LAB1D:
        rts                                     ; AB1D 60                       `

; ----------------------------------------------------------------------------
        .byte   $14,$1C,$1C,$1C,$1C,$1C,$14     ; AB1E 14 1C 1C 1C 1C 1C 14     .......
LAB25:
        .byte   $2D                             ; AB25 2D                       -
LAB26:
        .byte   $AB,$52,$AB,$C9,$AB,$5A,$AC,$CD ; AB26 AB 52 AB C9 AB 5A AC CD  .R...Z..
        .byte   $C0,$00,$CD,$C0,$00,$CD,$F1,$00 ; AB2E C0 00 CD C0 00 CD F1 00  ........
        .byte   $CD,$F1,$00,$CE,$22,$00,$CE,$22 ; AB36 CD F1 00 CE 22 00 CE 22  ....".."
        .byte   $00,$CE,$53,$00,$CE,$53,$00,$CE ; AB3E 00 CE 53 00 CE 53 00 CE  ..S..S..
        .byte   $53,$00,$CE,$84,$01,$CE,$84,$00 ; AB46 53 00 CE 84 01 CE 84 00  S.......
        .byte   $CE,$84,$01,$00,$CD,$C0,$00,$CD ; AB4E CE 84 01 00 CD C0 00 CD  ........
        .byte   $C0,$00,$CD,$F1,$00,$CD,$F1,$00 ; AB56 C0 00 CD F1 00 CD F1 00  ........
        .byte   $CE,$22,$00,$CE,$22,$00,$CE,$53 ; AB5E CE 22 00 CE 22 00 CE 53  .".."..S
        .byte   $00,$CE,$53,$00,$CE,$53,$00,$01 ; AB66 00 CE 53 00 CE 53 00 01  ..S..S..
        .byte   $CE,$B5,$01,$CE,$E6,$01,$CF,$17 ; AB6E CE B5 01 CE E6 01 CF 17  ........
        .byte   $01,$CF,$48,$01,$02,$CE,$B5,$01 ; AB76 01 CF 48 01 02 CE B5 01  ..H.....
        .byte   $CE,$E6,$01,$CF,$17,$01,$CF,$48 ; AB7E CE E6 01 CF 17 01 CF 48  .......H
        .byte   $01,$03,$CE,$B5,$01,$CE,$E6,$01 ; AB86 01 03 CE B5 01 CE E6 01  ........
        .byte   $CF,$17,$01,$CF,$48,$01,$04,$CE ; AB8E CF 17 01 CF 48 01 04 CE  ....H...
        .byte   $B5,$01,$CE,$E6,$01,$CF,$17,$01 ; AB96 B5 01 CE E6 01 CF 17 01  ........
        .byte   $CF,$48,$01,$05,$CE,$B5,$01,$CE ; AB9E CF 48 01 05 CE B5 01 CE  .H......
        .byte   $E6,$01,$CF,$17,$01,$CF,$48,$01 ; ABA6 E6 01 CF 17 01 CF 48 01  ......H.
        .byte   $06,$CE,$B5,$01,$CE,$E6,$01,$CF ; ABAE 06 CE B5 01 CE E6 01 CF  ........
        .byte   $17,$01,$CF,$48,$01,$07,$CE,$B5 ; ABB6 17 01 CF 48 01 07 CE B5  ...H....
        .byte   $01,$CE,$E6,$01,$CF,$17,$01,$CF ; ABBE 01 CE E6 01 CF 17 01 CF  ........
        .byte   $48,$01,$00,$CD,$C0,$00,$CD,$C0 ; ABC6 48 01 00 CD C0 00 CD C0  H.......
        .byte   $00,$CD,$F1,$00,$CD,$F1,$00,$CE ; ABCE 00 CD F1 00 CD F1 00 CE  ........
        .byte   $22,$00,$CE,$22,$00,$CE,$53,$00 ; ABD6 22 00 CE 22 00 CE 53 00  ".."..S.
        .byte   $CE,$53,$00,$CE,$53,$00,$08,$CE ; ABDE CE 53 00 CE 53 00 08 CE  .S..S...
        .byte   $B5,$01,$CE,$E6,$01,$CF,$17,$01 ; ABE6 B5 01 CE E6 01 CF 17 01  ........
        .byte   $CF,$48,$01,$09,$CE,$B5,$01,$CE ; ABEE CF 48 01 09 CE B5 01 CE  .H......
        .byte   $E6,$01,$CF,$17,$01,$CF,$48,$01 ; ABF6 E6 01 CF 17 01 CF 48 01  ......H.
        .byte   $0A,$CE,$B5,$01,$CE,$E6,$01,$CF ; ABFE 0A CE B5 01 CE E6 01 CF  ........
        .byte   $17,$01,$CF,$48,$01,$0B,$CE,$B5 ; AC06 17 01 CF 48 01 0B CE B5  ...H....
        .byte   $01,$CE,$E6,$01,$CF,$17,$01,$CF ; AC0E 01 CE E6 01 CF 17 01 CF  ........
        .byte   $48,$01,$0C,$CE,$B5,$01,$CE,$E6 ; AC16 48 01 0C CE B5 01 CE E6  H.......
        .byte   $01,$CF,$17,$01,$CF,$48,$01,$0D ; AC1E 01 CF 17 01 CF 48 01 0D  .....H..
        .byte   $CE,$B5,$01,$CE,$E6,$01,$CF,$17 ; AC26 CE B5 01 CE E6 01 CF 17  ........
        .byte   $01,$CF,$48,$01,$0E,$CE,$B5,$01 ; AC2E 01 CF 48 01 0E CE B5 01  ..H.....
        .byte   $CE,$E6,$01,$CF,$17,$01,$CF,$48 ; AC36 CE E6 01 CF 17 01 CF 48  .......H
        .byte   $01,$0F,$CE,$B5,$01,$CE,$E6,$01 ; AC3E 01 0F CE B5 01 CE E6 01  ........
        .byte   $CF,$17,$01,$CF,$48,$01,$10,$CE ; AC46 CF 17 01 CF 48 01 10 CE  ....H...
        .byte   $B5,$01,$CE,$E6,$01,$CF,$17,$01 ; AC4E B5 01 CE E6 01 CF 17 01  ........
        .byte   $CF,$48,$01,$00,$14,$CD,$C0,$00 ; AC56 CF 48 01 00 14 CD C0 00  .H......
        .byte   $CD,$F1,$00,$CD,$F1,$00,$14,$CD ; AC5E CD F1 00 CD F1 00 14 CD  ........
        .byte   $C0,$00,$CD,$F1,$00,$CD,$F1,$00 ; AC66 C0 00 CD F1 00 CD F1 00  ........
        .byte   $14,$CD,$C0,$00,$CD,$F1,$00,$CD ; AC6E 14 CD C0 00 CD F1 00 CD  ........
        .byte   $F1,$00,$14,$CD,$C0,$00,$CD,$C0 ; AC76 F1 00 14 CD C0 00 CD C0  ........
        .byte   $00,$CD,$F1,$00,$CD,$F1,$00,$14 ; AC7E 00 CD F1 00 CD F1 00 14  ........
        .byte   $CD,$C0,$00,$CD,$C0,$00,$CD,$F1 ; AC86 CD C0 00 CD C0 00 CD F1  ........
        .byte   $00,$CD,$F1,$00,$14,$CD,$C0,$00 ; AC8E 00 CD F1 00 14 CD C0 00  ........
        .byte   $CD,$C0,$00,$CD,$F1,$00,$CD,$F1 ; AC96 CD C0 00 CD F1 00 CD F1  ........
        .byte   $00,$00                         ; AC9E 00 00                    ..
; ----------------------------------------------------------------------------
LACA0:
        asl     a                               ; ACA0 0A                       .
        tay                                     ; ACA1 A8                       .
        cpy     #$10                            ; ACA2 C0 10                    ..
        beq     LACF1                           ; ACA4 F0 4B                    .K
        cpy     #$22                            ; ACA6 C0 22                    ."
        bcc     LAD03                           ; ACA8 90 59                    .Y
        jsr     L9A0D                           ; ACAA 20 0D 9A                  ..
        and     #$03                            ; ACAD 29 03                    ).
        tax                                     ; ACAF AA                       .
        lda     differentMusicSelectTable,x     ; ACB0 BD 6C AA                 .l.
        jsr     possibleSetSoundOrMusic         ; ACB3 20 B1 CF                  ..
        jsr     L9A0D                           ; ACB6 20 0D 9A                  ..
        and     #$8F                            ; ACB9 29 8F                    ).
        bpl     LACBF                           ; ACBB 10 02                    ..
        ora     #$F0                            ; ACBD 09 F0                    ..
LACBF:
        sta     $36                             ; ACBF 85 36                    .6
        jsr     L9A0D                           ; ACC1 20 0D 9A                  ..
        and     #$07                            ; ACC4 29 07                    ).
        sta     $37                             ; ACC6 85 37                    .7
        jsr     L9A0D                           ; ACC8 20 0D 9A                  ..
        and     #$03                            ; ACCB 29 03                    ).
        ora     #$24                            ; ACCD 09 24                    .$
        sta     $38                             ; ACCF 85 38                    .8
        ldx     #$4C                            ; ACD1 A2 4C                    .L
LACD3:
        lda     $38                             ; ACD3 A5 38                    .8
        sta     oamStaging+2,x                  ; ACD5 9D 02 05                 ...
        lda     $36                             ; ACD8 A5 36                    .6
        clc                                     ; ACDA 18                       .
        adc     oamStaging+3,x                  ; ACDB 7D 03 05                 }..
        sta     oamStaging+3,x                  ; ACDE 9D 03 05                 ...
        lda     $37                             ; ACE1 A5 37                    .7
        clc                                     ; ACE3 18                       .
        adc     oamStaging,x                    ; ACE4 7D 00 05                 }..
        sta     oamStaging,x                    ; ACE7 9D 00 05                 ...
        inx                                     ; ACEA E8                       .
        inx                                     ; ACEB E8                       .
        inx                                     ; ACEC E8                       .
        inx                                     ; ACED E8                       .
        bne     LACD3                           ; ACEE D0 E3                    ..
        rts                                     ; ACF0 60                       `

; ----------------------------------------------------------------------------
LACF1:
        ldx     #$4C                            ; ACF1 A2 4C                    .L
LACF3:
        jsr     L9A0D                           ; ACF3 20 0D 9A                  ..
        and     #$03                            ; ACF6 29 03                    ).
        ora     #$24                            ; ACF8 09 24                    .$
        sta     oamStaging+2,x                  ; ACFA 9D 02 05                 ...
        inx                                     ; ACFD E8                       .
        inx                                     ; ACFE E8                       .
        inx                                     ; ACFF E8                       .
        inx                                     ; AD00 E8                       .
        bne     LACF3                           ; AD01 D0 F0                    ..
LAD03:
        lda     LAD23,y                         ; AD03 B9 23 AD                 .#.
        sta     $36                             ; AD06 85 36                    .6
        lda     LAD24,y                         ; AD08 B9 24 AD                 .$.
        sta     $37                             ; AD0B 85 37                    .7
        ldx     #$4C                            ; AD0D A2 4C                    .L
        ldy     #$00                            ; AD0F A0 00                    ..
LAD11:
        lda     oamStaging+2,x                  ; AD11 BD 02 05                 ...
        and     #$FB                            ; AD14 29 FB                    ).
        ora     ($36),y                         ; AD16 11 36                    .6
        sta     oamStaging+2,x                  ; AD18 9D 02 05                 ...
        inx                                     ; AD1B E8                       .
        inx                                     ; AD1C E8                       .
        inx                                     ; AD1D E8                       .
        inx                                     ; AD1E E8                       .
        iny                                     ; AD1F C8                       .
        cpy     #$2D                            ; AD20 C0 2D                    .-
LAD23           := * + 1
        bcc     LAD11                           ; AD22 90 ED                    ..
LAD24:
        rts                                     ; AD24 60                       `

; ----------------------------------------------------------------------------
        .byte   $45,$AD,$72,$AD,$9F,$AD,$CC,$AD ; AD25 45 AD 72 AD 9F AD CC AD  E.r.....
        .byte   $F9,$AD,$26,$AE,$53,$AE,$80,$AE ; AD2D F9 AD 26 AE 53 AE 80 AE  ..&.S...
        .byte   $AD,$AE,$DA,$AE,$07,$AF,$34,$AF ; AD35 AD AE DA AE 07 AF 34 AF  ......4.
        .byte   $61,$AF,$8E,$AF,$BB,$AF,$E8,$AF ; AD3D 61 AF 8E AF BB AF E8 AF  a.......
        .byte   $00,$04,$00,$04,$00,$04,$00,$04 ; AD45 00 04 00 04 00 04 00 04  ........
        .byte   $04,$00,$04,$00,$00,$04,$00,$04 ; AD4D 04 00 04 00 00 04 00 04  ........
        .byte   $00,$04,$04,$04,$04,$04,$00,$04 ; AD55 00 04 04 04 04 04 00 04  ........
        .byte   $00,$00,$04,$00,$04,$04,$00,$04 ; AD5D 00 00 04 00 04 04 00 04  ........
        .byte   $04,$00,$04,$00,$04,$04,$04,$00 ; AD65 04 00 04 00 04 04 04 00  ........
        .byte   $00,$04,$04,$00,$04,$00,$04,$00 ; AD6D 00 04 04 00 04 00 04 00  ........
        .byte   $04,$00,$04,$00,$00,$04,$00,$04 ; AD75 04 00 04 00 00 04 00 04  ........
        .byte   $00,$00,$04,$00,$04,$00,$04,$04 ; AD7D 00 00 04 00 04 00 04 04  ........
        .byte   $04,$00,$04,$00,$04,$00,$00,$04 ; AD85 04 00 04 00 04 00 00 04  ........
        .byte   $00,$00,$04,$00,$04,$04,$00,$04 ; AD8D 00 00 04 00 04 04 00 04  ........
        .byte   $00,$00,$04,$00,$00,$00,$04,$04 ; AD95 00 00 04 00 00 00 04 04  ........
        .byte   $00,$04,$00,$04,$00,$04,$00,$04 ; AD9D 00 04 00 04 00 04 00 04  ........
        .byte   $00,$00,$04,$00,$04,$00,$00,$04 ; ADA5 00 00 04 00 04 00 00 04  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$04 ; ADAD 00 04 00 00 04 00 00 04  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$04 ; ADB5 00 04 00 00 04 00 00 04  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$04 ; ADBD 00 04 00 00 04 00 00 04  ........
        .byte   $00,$00,$00,$04,$00,$00,$04,$00 ; ADC5 00 00 00 04 00 00 04 00  ........
        .byte   $04,$00,$04,$00,$00,$00,$00,$04 ; ADCD 04 00 04 00 00 00 00 04  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$00 ; ADD5 00 04 00 00 04 00 00 00  ........
        .byte   $00,$04,$00,$00,$04,$00,$04,$00 ; ADDD 00 04 00 00 04 00 04 00  ........
        .byte   $00,$04,$00,$00,$04,$00,$04,$00 ; ADE5 00 04 00 00 04 00 04 00  ........
        .byte   $00,$00,$00,$00,$04,$00,$00,$00 ; ADED 00 00 00 00 04 00 00 00  ........
        .byte   $04,$00,$00,$00,$00,$04,$00,$00 ; ADF5 04 00 00 00 00 04 00 00  ........
        .byte   $00,$00,$00,$00,$04,$00,$04,$00 ; ADFD 00 00 00 00 04 00 04 00  ........
        .byte   $00,$04,$00,$00,$00,$00,$04,$00 ; AE05 00 04 00 00 00 00 04 00  ........
        .byte   $00,$00,$00,$04,$00,$00,$04,$00 ; AE0D 00 00 00 04 00 00 04 00  ........
        .byte   $00,$04,$00,$04,$00,$00,$00,$00 ; AE15 00 04 00 04 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$04,$00,$00 ; AE1D 00 00 00 00 00 04 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AE25 00 00 00 00 00 00 00 00  ........
        .byte   $00,$04,$00,$00,$00,$00,$04,$00 ; AE2D 00 04 00 00 00 00 04 00  ........
        .byte   $00,$00,$00,$04,$00,$00,$00,$00 ; AE35 00 00 00 04 00 00 00 00  ........
        .byte   $04,$00,$00,$04,$00,$00,$00,$00 ; AE3D 04 00 00 04 00 00 00 00  ........
        .byte   $04,$00,$00,$00,$00,$00,$00,$00 ; AE45 04 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AE4D 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$04,$00 ; AE55 00 00 00 00 00 00 04 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AE5D 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$04,$00,$00 ; AE65 00 00 00 00 00 04 00 00  ........
        .byte   $04,$00,$00,$00,$00,$00,$00,$00 ; AE6D 04 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AE75 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$04,$00,$04,$04 ; AE7D 00 00 00 00 04 00 04 04  ........
        .byte   $04,$00,$00,$04,$00,$00,$00,$04 ; AE85 04 00 00 04 00 00 00 04  ........
        .byte   $00,$04,$00,$00,$00,$04,$00,$00 ; AE8D 00 04 00 00 00 04 00 00  ........
        .byte   $00,$04,$00,$04,$00,$00,$04,$00 ; AE95 00 04 00 04 00 00 04 00  ........
        .byte   $00,$04,$00,$04,$04,$00,$04,$00 ; AE9D 00 04 00 04 04 00 04 00  ........
        .byte   $04,$00,$04,$00,$04,$04,$00,$00 ; AEA5 04 00 04 00 04 04 00 00  ........
        .byte   $00,$04,$00,$04,$00,$04,$00,$00 ; AEAD 00 04 00 04 00 04 00 00  ........
        .byte   $04,$00,$04,$00,$04,$00,$04,$04 ; AEB5 04 00 04 00 04 00 04 04  ........
        .byte   $00,$00,$04,$00,$00,$00,$04,$04 ; AEBD 00 00 04 00 00 00 04 04  ........
        .byte   $04,$00,$00,$04,$00,$00,$04,$00 ; AEC5 04 00 00 04 00 00 04 00  ........
        .byte   $04,$04,$00,$04,$00,$04,$00,$04 ; AECD 04 04 00 04 00 04 00 04  ........
        .byte   $00,$04,$04,$00,$04,$00,$04,$00 ; AED5 00 04 04 00 04 00 04 00  ........
        .byte   $04,$00,$00,$00,$00,$04,$00,$04 ; AEDD 04 00 00 00 00 04 00 04  ........
        .byte   $00,$04,$00,$04,$04,$04,$00,$04 ; AEE5 00 04 00 04 04 04 00 04  ........
        .byte   $00,$04,$00,$04,$00,$04,$00,$00 ; AEED 00 04 00 04 00 04 00 00  ........
        .byte   $04,$00,$00,$04,$00,$04,$04,$00 ; AEF5 04 00 00 04 00 04 04 00  ........
        .byte   $04,$00,$00,$04,$04,$04,$00,$04 ; AEFD 04 00 00 04 04 04 00 04  ........
        .byte   $00,$04,$00,$04,$00,$04,$00,$04 ; AF05 00 04 00 04 00 04 00 04  ........
        .byte   $00,$00,$04,$00,$00,$04,$04,$00 ; AF0D 00 00 04 00 00 04 04 00  ........
        .byte   $04,$00,$04,$00,$00,$00,$04,$00 ; AF15 04 00 04 00 00 00 04 00  ........
        .byte   $04,$00,$04,$00,$00,$00,$00,$00 ; AF1D 04 00 04 00 00 00 00 00  ........
        .byte   $04,$00,$04,$00,$04,$00,$04,$00 ; AF25 04 00 04 00 04 00 04 00  ........
        .byte   $04,$00,$00,$00,$04,$00,$04,$00 ; AF2D 04 00 00 00 04 00 04 00  ........
        .byte   $04,$04,$04,$00,$04,$00,$00,$04 ; AF35 04 04 04 00 04 00 00 04  ........
        .byte   $00,$00,$04,$00,$00,$04,$00,$04 ; AF3D 00 00 04 00 00 04 00 04  ........
        .byte   $00,$00,$00,$04,$00,$04,$00,$00 ; AF45 00 00 00 04 00 04 00 00  ........
        .byte   $04,$04,$00,$04,$00,$04,$00,$00 ; AF4D 04 04 00 04 00 04 00 00  ........
        .byte   $00,$04,$00,$04,$00,$00,$00,$04 ; AF55 00 04 00 04 00 00 00 04  ........
        .byte   $00,$04,$04,$00,$00,$00,$04,$00 ; AF5D 00 04 04 00 00 00 04 00  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$04 ; AF65 00 04 00 00 04 00 00 04  ........
        .byte   $00,$00,$04,$00,$04,$00,$00,$00 ; AF6D 00 00 04 00 04 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$04,$04,$00 ; AF75 00 00 00 00 00 04 04 00  ........
        .byte   $04,$00,$04,$00,$00,$00,$04,$00 ; AF7D 04 00 04 00 00 00 04 00  ........
        .byte   $04,$00,$00,$00,$00,$00,$00,$04 ; AF85 04 00 00 00 00 00 00 04  ........
        .byte   $00,$00,$00,$04,$00,$00,$00,$00 ; AF8D 00 00 00 04 00 00 00 00  ........
        .byte   $00,$04,$00,$00,$04,$00,$00,$00 ; AF95 00 04 00 00 04 00 00 00  ........
        .byte   $00,$04,$00,$00,$00,$00,$00,$00 ; AF9D 00 04 00 00 00 00 00 00  ........
        .byte   $00,$00,$04,$04,$00,$00,$00,$04 ; AFA5 00 00 04 04 00 00 00 04  ........
        .byte   $00,$00,$00,$04,$00,$00,$00,$00 ; AFAD 00 00 00 04 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$04,$00,$00,$00 ; AFB5 00 00 00 00 04 00 00 00  ........
        .byte   $04,$00,$00,$00,$00,$00,$00,$00 ; AFBD 04 00 00 00 00 00 00 00  ........
        .byte   $00,$04,$00,$00,$00,$00,$00,$00 ; AFC5 00 04 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$04 ; AFCD 00 00 00 00 00 00 00 04  ........
        .byte   $04,$00,$00,$00,$04,$00,$00,$00 ; AFD5 04 00 00 00 04 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AFDD 00 00 00 00 00 00 00 00  ........
        .byte   $00,$04,$00,$00,$00,$04,$00,$00 ; AFE5 00 04 00 00 00 04 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AFED 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; AFF5 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$04,$04,$00,$00 ; AFFD 00 00 00 00 04 04 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B005 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B00D 00 00 00 00 00 00 00 00  ........
; ----------------------------------------------------------------------------
LB015:
        ldx     #$40                            ; B015 A2 40                    .@
        ldy     #$00                            ; B017 A0 00                    ..
LB019:
        lda     $01A2,y                         ; B019 B9 A2 01                 ...
        bne     LB029                           ; B01C D0 0B                    ..
LB01E:
        txa                                     ; B01E 8A                       .
        clc                                     ; B01F 18                       .
        adc     #$10                            ; B020 69 10                    i.
        tax                                     ; B022 AA                       .
        iny                                     ; B023 C8                       .
        cpy     #$08                            ; B024 C0 08                    ..
        bcc     LB019                           ; B026 90 F1                    ..
        rts                                     ; B028 60                       `

; ----------------------------------------------------------------------------
LB029:
        sta     $37                             ; B029 85 37                    .7
        lda     $019A,y                         ; B02B B9 9A 01                 ...
        sta     $36                             ; B02E 85 36                    .6
        sty     $3A                             ; B030 84 3A                    .:
        lda     frameCounterLow                 ; B032 A5 32                    .2
        and     #$07                            ; B034 29 07                    ).
        bne     LB043                           ; B036 D0 0B                    ..
        lda     $36                             ; B038 A5 36                    .6
        clc                                     ; B03A 18                       .
        adc     #$02                            ; B03B 69 02                    i.
        sta     $36                             ; B03D 85 36                    .6
        bcc     LB043                           ; B03F 90 02                    ..
        inc     $37                             ; B041 E6 37                    .7
LB043:
        ldy     #$00                            ; B043 A0 00                    ..
        lda     ($36),y                         ; B045 B1 36                    .6
        sta     $38                             ; B047 85 38                    .8
        iny                                     ; B049 C8                       .
        cmp     #$4D                            ; B04A C9 4D                    .M
        lda     ($36),y                         ; B04C B1 36                    .6
        sta     $39                             ; B04E 85 39                    .9
        sbc     #$B1                            ; B050 E9 B1                    ..
        bcs     LB077                           ; B052 B0 23                    .#
        lda     player1FallTimer                ; B054 A5 6A                    .j
        cmp     #$70                            ; B056 C9 70                    .p
        bcs     LB064                           ; B058 B0 0A                    ..
        .byte   $A4,$3A,$C9,$16,$B0,$BE,$E6,$6A ; B05A A4 3A C9 16 B0 BE E6 6A  .:.....j
        .byte   $90,$67                         ; B062 90 67                    .g
; ----------------------------------------------------------------------------
LB064:
        jsr     L9A0D                           ; B064 20 0D 9A                  ..
        and     #$1E                            ; B067 29 1E                    ).
        tay                                     ; B069 A8                       .
        lda     ($38),y                         ; B06A B1 38                    .8
        sta     $36                             ; B06C 85 36                    .6
        iny                                     ; B06E C8                       .
        lda     ($38),y                         ; B06F B1 38                    .8
        sta     $37                             ; B071 85 37                    .7
        ldy     $3A                             ; B073 A4 3A                    .:
        bpl     LB043                           ; B075 10 CC                    ..
LB077:
        lda     $38                             ; B077 A5 38                    .8
        cmp     #$BC                            ; B079 C9 BC                    ..
        lda     $39                             ; B07B A5 39                    .9
        sbc     #$C8                            ; B07D E9 C8                    ..
        bcs     LB08D                           ; B07F B0 0C                    ..
        lda     $38                             ; B081 A5 38                    .8
        sta     $36                             ; B083 85 36                    .6
        lda     $39                             ; B085 A5 39                    .9
        sta     $37                             ; B087 85 37                    .7
        ldy     $3A                             ; B089 A4 3A                    .:
        bpl     LB043                           ; B08B 10 B6                    ..
LB08D:
        ldy     #$00                            ; B08D A0 00                    ..
        lda     oamStaging+2,x                  ; B08F BD 02 05                 ...
        and     #$40                            ; B092 29 40                    )@
        bne     LB0D8                           ; B094 D0 42                    .B
        lda     ($38),y                         ; B096 B1 38                    .8
        sta     oamStaging+1,x                  ; B098 9D 01 05                 ...
        iny                                     ; B09B C8                       .
        lda     ($38),y                         ; B09C B1 38                    .8
        sta     oamStaging+5,x                  ; B09E 9D 05 05                 ...
        iny                                     ; B0A1 C8                       .
        lda     ($38),y                         ; B0A2 B1 38                    .8
        sta     oamStaging+9,x                  ; B0A4 9D 09 05                 ...
        iny                                     ; B0A7 C8                       .
        lda     ($38),y                         ; B0A8 B1 38                    .8
        sta     oamStaging+13,x                 ; B0AA 9D 0D 05                 ...
        lda     $36                             ; B0AD A5 36                    .6
        cmp     #$81                            ; B0AF C9 81                    ..
        lda     $37                             ; B0B1 A5 37                    .7
        sbc     #$B1                            ; B0B3 E9 B1                    ..
        bcs     LB0C9                           ; B0B5 B0 12                    ..
        lda     frameCounterLow                 ; B0B7 A5 32                    .2
        and     #$03                            ; B0B9 29 03                    ).
        bne     LB0C9                           ; B0BB D0 0C                    ..
        inc     oamStaging+3,x                  ; B0BD FE 03 05                 ...
        inc     oamStaging+7,x                  ; B0C0 FE 07 05                 ...
        inc     oamStaging+11,x                 ; B0C3 FE 0B 05                 ...
        inc     oamStaging+15,x                 ; B0C6 FE 0F 05                 ...
LB0C9:
        ldy     $3A                             ; B0C9 A4 3A                    .:
        lda     $36                             ; B0CB A5 36                    .6
        sta     $019A,y                         ; B0CD 99 9A 01                 ...
        lda     $37                             ; B0D0 A5 37                    .7
        sta     $01A2,y                         ; B0D2 99 A2 01                 ...
        jmp     LB01E                           ; B0D5 4C 1E B0                 L..

; ----------------------------------------------------------------------------
LB0D8:
        .byte   $B1,$38,$9D,$05,$05,$C8,$B1,$38 ; B0D8 B1 38 9D 05 05 C8 B1 38  .8.....8
        .byte   $9D,$01,$05,$C8,$B1,$38,$9D,$0D ; B0E0 9D 01 05 C8 B1 38 9D 0D  .....8..
        .byte   $05,$C8,$B1,$38,$9D,$09,$05,$A5 ; B0E8 05 C8 B1 38 9D 09 05 A5  ...8....
        .byte   $36,$C9,$81,$A5,$37,$E9,$B1,$B0 ; B0F0 36 C9 81 A5 37 E9 B1 B0  6...7...
        .byte   $D0,$A5,$32,$29,$03,$D0,$CA,$DE ; B0F8 D0 A5 32 29 03 D0 CA DE  ..2)....
        .byte   $03,$05,$DE,$07,$05,$DE,$0B,$05 ; B100 03 05 DE 07 05 DE 0B 05  ........
        .byte   $DE,$0F,$05,$D0,$BC,$AD,$B1,$C7 ; B108 DE 0F 05 D0 BC AD B1 C7  ........
        .byte   $B1,$E1,$B1,$03,$B2,$25,$B2,$47 ; B110 B1 E1 B1 03 B2 25 B2 47  .....%.G
        .byte   $B2,$69,$B2,$93,$B2,$BD,$B2,$AD ; B118 B2 69 B2 93 B2 BD B2 AD  .i......
        .byte   $B1,$E1,$B1,$03,$B2,$47,$B2,$69 ; B120 B1 E1 B1 03 B2 47 B2 69  .....G.i
        .byte   $B2,$93,$B2,$BD,$B2,$DF,$B2,$F1 ; B128 B2 93 B2 BD B2 DF B2 F1  ........
        .byte   $B2,$03,$B3,$25,$B3,$47,$B3,$DF ; B130 B2 03 B3 25 B3 47 B3 DF  ...%.G..
        .byte   $B2,$F1,$B2,$03,$B3,$25,$B3,$47 ; B138 B2 F1 B2 03 B3 25 B3 47  .....%.G
        .byte   $B3,$DF,$B2,$F1,$B2,$03,$B3,$25 ; B140 B3 DF B2 F1 B2 03 B3 25  .......%
        .byte   $B3,$47,$B3,$DF,$B2,$10,$C9,$14 ; B148 B3 47 B3 DF B2 10 C9 14  .G......
        .byte   $C9,$18,$C9,$14,$C9,$10,$C9,$14 ; B150 C9 18 C9 14 C9 10 C9 14  ........
        .byte   $C9,$18,$C9,$14,$C9,$10,$C9,$14 ; B158 C9 18 C9 14 C9 10 C9 14  ........
        .byte   $C9,$18,$C9,$64,$C9,$0D,$B1,$94 ; B160 C9 18 C9 64 C9 0D B1 94  ...d....
        .byte   $C9,$98,$C9,$9C,$C9,$98,$C9,$94 ; B168 C9 98 C9 9C C9 98 C9 94  ........
        .byte   $C9,$98,$C9,$9C,$C9,$98,$C9,$94 ; B170 C9 98 C9 9C C9 98 C9 94  ........
        .byte   $C9,$98,$C9,$9C,$C9,$C0,$C8,$2D ; B178 C9 98 C9 9C C9 C0 C8 2D  .......-
        .byte   $B1,$20,$C9,$20,$C9,$20,$C9,$08 ; B180 B1 20 C9 20 C9 20 C9 08  . . . ..
        .byte   $C9,$0C,$C9,$28,$C9,$28,$C9,$28 ; B188 C9 0C C9 28 C9 28 C9 28  ...(.(.(
        .byte   $C9,$20,$C9,$14,$C9,$4D,$B1,$BC ; B190 C9 20 C9 14 C9 4D B1 BC  . ...M..
        .byte   $C8,$2C,$C9,$30,$C9,$34,$C9,$34 ; B198 C8 2C C9 30 C9 34 C9 34  .,.0.4.4
        .byte   $C9,$34,$C9,$34,$C9,$BC,$C8,$BC ; B1A0 C9 34 C9 34 C9 BC C8 BC  .4.4....
        .byte   $C8,$98,$C9,$67,$B1,$3C,$C9,$40 ; B1A8 C8 98 C9 67 B1 3C C9 40  ...g.<.@
        .byte   $C9,$40,$C9,$3C,$C9,$38,$C9,$38 ; B1B0 C9 40 C9 3C C9 38 C9 38  .@.<.8.8
        .byte   $C9,$3C,$C9,$40,$C9,$40,$C9,$38 ; B1B8 C9 3C C9 40 C9 40 C9 38  .<.@.@.8
        .byte   $C9,$38,$C9,$3C,$C9,$0D,$B1,$3C ; B1C0 C9 38 C9 3C C9 0D B1 3C  .8.<...<
        .byte   $C9,$40,$C9,$40,$C9,$3C,$C9,$38 ; B1C8 C9 40 C9 40 C9 3C C9 38  .@.@.<.8
        .byte   $C9,$38,$C9,$3C,$C9,$48,$C9,$48 ; B1D0 C9 38 C9 3C C9 48 C9 48  .8.<.H.H
        .byte   $C9,$44,$C9,$44,$C9,$3C,$C9,$0D ; B1D8 C9 44 C9 44 C9 3C C9 0D  .D.D.<..
        .byte   $B1,$68,$C9,$68,$C9,$68,$C9,$6C ; B1E0 B1 68 C9 68 C9 68 C9 6C  .h.h.h.l
        .byte   $C9,$60,$C9,$60,$C9,$60,$C9,$7C ; B1E8 C9 60 C9 60 C9 60 C9 7C  .`.`.`.|
        .byte   $C9,$68,$C9,$68,$C9,$68,$C9,$6C ; B1F0 C9 68 C9 68 C9 68 C9 6C  .h.h.h.l
        .byte   $C9,$60,$C9,$60,$C9,$60,$C9,$7C ; B1F8 C9 60 C9 60 C9 60 C9 7C  .`.`.`.|
        .byte   $C9,$0D,$B1,$68,$C9,$68,$C9,$68 ; B200 C9 0D B1 68 C9 68 C9 68  ...h.h.h
        .byte   $C9,$6C,$C9,$68,$C9,$68,$C9,$68 ; B208 C9 6C C9 68 C9 68 C9 68  .l.h.h.h
        .byte   $C9,$80,$C9,$60,$C9,$60,$C9,$60 ; B210 C9 80 C9 60 C9 60 C9 60  ...`.`.`
        .byte   $C9,$7C,$C9,$60,$C9,$60,$C9,$60 ; B218 C9 7C C9 60 C9 60 C9 60  .|.`.`.`
        .byte   $C9,$80,$C9,$0D,$B1,$78,$C9,$78 ; B220 C9 80 C9 0D B1 78 C9 78  .....x.x
        .byte   $C9,$70,$C9,$70,$C9,$74,$C9,$74 ; B228 C9 70 C9 70 C9 74 C9 74  .p.p.t.t
        .byte   $C9,$70,$C9,$70,$C9,$78,$C9,$78 ; B230 C9 70 C9 70 C9 78 C9 78  .p.p.x.x
        .byte   $C9,$70,$C9,$70,$C9,$74,$C9,$74 ; B238 C9 70 C9 70 C9 74 C9 74  .p.p.t.t
        .byte   $C9,$70,$C9,$70,$C9,$0D,$B1,$60 ; B240 C9 70 C9 70 C9 0D B1 60  .p.p...`
        .byte   $C9,$4C,$C9,$50,$C9,$50,$C9,$50 ; B248 C9 4C C9 50 C9 50 C9 50  .L.P.P.P
        .byte   $C9,$54,$C9,$58,$C9,$A0,$C9,$A4 ; B250 C9 54 C9 58 C9 A0 C9 A4  .T.X....
        .byte   $C9,$A8,$C9,$50,$C9,$50,$C9,$50 ; B258 C9 A8 C9 50 C9 50 C9 50  ...P.P.P
        .byte   $C9,$4C,$C9,$20,$C9,$20,$C9,$0D ; B260 C9 4C C9 20 C9 20 C9 0D  .L. . ..
        .byte   $B1,$64,$C9,$04,$C9,$F4,$C8,$5C ; B268 B1 64 C9 04 C9 F4 C8 5C  .d.....\
        .byte   $C9,$24,$C9,$64,$C9,$F8,$C8,$FC ; B270 C9 24 C9 64 C9 F8 C8 FC  .$.d....
        .byte   $C8,$00,$C9,$1C,$C9,$64,$C9,$04 ; B278 C8 00 C9 1C C9 64 C9 04  .....d..
        .byte   $C9,$F4,$C8,$5C,$C9,$24,$C9,$64 ; B280 C9 F4 C8 5C C9 24 C9 64  ...\.$.d
        .byte   $C9,$F8,$C8,$FC,$C8,$00,$C9,$1C ; B288 C9 F8 C8 FC C8 00 C9 1C  ........
        .byte   $C9,$0D,$B1,$E0,$C9,$C8,$C9,$CC ; B290 C9 0D B1 E0 C9 C8 C9 CC  ........
        .byte   $C9,$D0,$C9,$D0,$C9,$DC,$C9,$D8 ; B298 C9 D0 C9 D0 C9 DC C9 D8  ........
        .byte   $C9,$D4,$C9,$D0,$C9,$D0,$C9,$E0 ; B2A0 C9 D4 C9 D0 C9 D0 C9 E0  ........
        .byte   $C9,$C8,$C9,$CC,$C9,$D0,$C9,$D0 ; B2A8 C9 C8 C9 CC C9 D0 C9 D0  ........
        .byte   $C9,$DC,$C9,$D8,$C9,$D4,$C9,$D0 ; B2B0 C9 DC C9 D8 C9 D4 C9 D0  ........
        .byte   $C9,$D0,$C9,$0D,$B1,$E4,$C9,$E8 ; B2B8 C9 D0 C9 0D B1 E4 C9 E8  ........
        .byte   $C9,$EC,$C9,$F0,$C9,$F4,$C9,$F8 ; B2C0 C9 EC C9 F0 C9 F4 C9 F8  ........
        .byte   $C9,$FC,$C9,$64,$C9,$E4,$C9,$E8 ; B2C8 C9 FC C9 64 C9 E4 C9 E8  ...d....
        .byte   $C9,$EC,$C9,$F0,$C9,$F4,$C9,$F8 ; B2D0 C9 EC C9 F0 C9 F4 C9 F8  ........
        .byte   $C9,$FC,$C9,$64,$C9,$0D,$B1,$84 ; B2D8 C9 FC C9 64 C9 0D B1 84  ...d....
        .byte   $C9,$88,$C9,$8C,$C9,$90,$C9,$E4 ; B2E0 C9 88 C9 8C C9 90 C9 E4  ........
        .byte   $C8,$E8,$C8,$EC,$C8,$F0,$C8,$2D ; B2E8 C8 E8 C8 EC C8 F0 C8 2D  .......-
        .byte   $B1,$BC,$C8,$BC,$C8,$C0,$C8,$C0 ; B2F0 B1 BC C8 BC C8 C0 C8 C0  ........
        .byte   $C8,$BC,$C8,$BC,$C8,$C0,$C8,$C0 ; B2F8 C8 BC C8 BC C8 C0 C8 C0  ........
        .byte   $C8,$2D,$B1,$D0,$C8,$D0,$C8,$D4 ; B300 C8 2D B1 D0 C8 D0 C8 D4  .-......
        .byte   $C8,$D4,$C8,$C8,$C8,$C8,$C8,$C4 ; B308 C8 D4 C8 C8 C8 C8 C8 C4  ........
        .byte   $C8,$C4,$C8,$D0,$C8,$D0,$C8,$D4 ; B310 C8 C4 C8 D0 C8 D0 C8 D4  ........
        .byte   $C8,$D4,$C8,$C8,$C8,$C8,$C8,$C4 ; B318 C8 D4 C8 C8 C8 C8 C8 C4  ........
        .byte   $C8,$C4,$C8,$2D,$B1,$C4,$C8,$C4 ; B320 C8 C4 C8 2D B1 C4 C8 C4  ...-....
        .byte   $C8,$C8,$C8,$C8,$C8,$CC,$C8,$D0 ; B328 C8 C8 C8 C8 C8 CC C8 D0  ........
        .byte   $C8,$D0,$C8,$D4,$C8,$D4,$C8,$D8 ; B330 C8 D0 C8 D4 C8 D4 C8 D8  ........
        .byte   $C8,$D8,$C8,$DC,$C8,$DC,$C8,$E0 ; B338 C8 D8 C8 DC C8 DC C8 E0  ........
        .byte   $C8,$E0,$C8,$CC,$C8,$2D,$B1,$84 ; B340 C8 E0 C8 CC C8 2D B1 84  .....-..
        .byte   $C9,$AC,$C9,$B0,$C9,$B4,$C9,$B8 ; B348 C9 AC C9 B0 C9 B4 C9 B8  ........
        .byte   $C9,$BC,$C9,$C0,$C9,$C4,$C9,$84 ; B350 C9 BC C9 C0 C9 C4 C9 84  ........
        .byte   $C9,$AC,$C9,$B0,$C9,$B4,$C9,$B8 ; B358 C9 AC C9 B0 C9 B4 C9 B8  ........
        .byte   $C9,$BC,$C9,$C0,$C9,$C4,$C9,$2D ; B360 C9 BC C9 C0 C9 C4 C9 2D  .......-
        .byte   $B1                             ; B368 B1                       .
; ----------------------------------------------------------------------------
drawCathedralSprites:
        ldx     #$00                            ; B369 A2 00                    ..
cathedralCheckComplete:
        lda     cathedralSpriteTabel,x          ; B36B BD A0 B3                 ...
        bne     drawCathedralSpriteTile         ; B36E D0 01                    ..
        rts                                     ; B370 60                       `

; ----------------------------------------------------------------------------
drawCathedralSpriteTile:
        sta     oamStaging+1,x                  ; B371 9D 01 05                 ...
        lda     cathedralSpriteTabel+1,x        ; B374 BD A1 B3                 ...
        sta     oamStaging+2,x                  ; B377 9D 02 05                 ...
        lda     cathedralSpriteTabel+3,x        ; B37A BD A3 B3                 ...
        sta     $36                             ; B37D 85 36                    .6
        lda     cathedralSpriteTabel+2,x        ; B37F BD A2 B3                 ...
        asl     a                               ; B382 0A                       .
        asl     a                               ; B383 0A                       .
        asl     a                               ; B384 0A                       .
        sta     oamStaging+3,x                  ; B385 9D 03 05                 ...
        lda     cathedralSpriteTabel+2,x        ; B388 BD A2 B3                 ...
        lsr     $36                             ; B38B 46 36                    F6
        ror     a                               ; B38D 6A                       j
        lsr     $36                             ; B38E 46 36                    F6
        ror     a                               ; B390 6A                       j
        and     #$F8                            ; B391 29 F8                    ).
        clc                                     ; B393 18                       .
        sbc     ppuScrollYOffset                ; B394 ED F6 04                 ...
        sta     oamStaging,x                    ; B397 9D 00 05                 ...
        inx                                     ; B39A E8                       .
        inx                                     ; B39B E8                       .
        inx                                     ; B39C E8                       .
        inx                                     ; B39D E8                       .
        bne     cathedralCheckComplete          ; B39E D0 CB                    ..
cathedralSpriteTabel:
        .byte   $02,$03,$CF,$01,$03,$03,$EF,$01 ; B3A0 02 03 CF 01 03 03 EF 01  ........
        .byte   $04,$03,$0F,$02,$05,$03,$2F,$02 ; B3A8 04 03 0F 02 05 03 2F 02  ....../.
        .byte   $06,$01,$8F,$02,$07,$01,$AF,$02 ; B3B0 06 01 8F 02 07 01 AF 02  ........
        .byte   $08,$01,$CF,$02,$09,$01,$EF,$02 ; B3B8 08 01 CF 02 09 01 EF 02  ........
        .byte   $0A,$03,$90,$02,$0B,$03,$B0,$02 ; B3C0 0A 03 90 02 0B 03 B0 02  ........
        .byte   $0C,$03,$D0,$02,$0D,$03,$F0,$02 ; B3C8 0C 03 D0 02 0D 03 F0 02  ........
        .byte   $0E,$02,$91,$02,$0F,$02,$B1,$02 ; B3D0 0E 02 91 02 0F 02 B1 02  ........
        .byte   $10,$02,$D1,$02,$11,$02,$F1,$02 ; B3D8 10 02 D1 02 11 02 F1 02  ........
        .byte   $12,$00,$94,$02,$13,$00,$B4,$02 ; B3E0 12 00 94 02 13 00 B4 02  ........
        .byte   $00                             ; B3E8 00                       .
; ----------------------------------------------------------------------------
LB3E9:
        pha                                     ; B3E9 48                       H
        asl     a                               ; B3EA 0A                       .
        tax                                     ; B3EB AA                       .
        lda     #$04                            ; B3EC A9 04                    ..
        sta     $38                             ; B3EE 85 38                    .8
        bit     PPUSTATUS                       ; B3F0 2C 02 20                 ,. 
        lda     #$20                            ; B3F3 A9 20                    . 
        sta     PPUADDR                         ; B3F5 8D 06 20                 .. 
        lda     #$00                            ; B3F8 A9 00                    ..
        sta     PPUADDR                         ; B3FA 8D 06 20                 .. 
        ldy     #$00                            ; B3FD A0 00                    ..
        lda     LB47F,x                         ; B3FF BD 7F B4                 ...
        bne     LB410                           ; B402 D0 0C                    ..
        .byte   $8D,$07,$20,$C8,$D0,$FA,$C6,$38 ; B404 8D 07 20 C8 D0 FA C6 38  .. ....8
        .byte   $D0,$F6,$F0,$15                 ; B40C D0 F6 F0 15              ....
; ----------------------------------------------------------------------------
LB410:
        sta     $37                             ; B410 85 37                    .7
        lda     LB47E,x                         ; B412 BD 7E B4                 .~.
        sta     $36                             ; B415 85 36                    .6
LB417:
        lda     ($36),y                         ; B417 B1 36                    .6
        sta     PPUDATA                         ; B419 8D 07 20                 .. 
        iny                                     ; B41C C8                       .
        bne     LB417                           ; B41D D0 F8                    ..
        inc     $37                             ; B41F E6 37                    .7
        dec     $38                             ; B421 C6 38                    .8
        bne     LB417                           ; B423 D0 F2                    ..
        lda     LB490,x                         ; B425 BD 90 B4                 ...
        sta     $36                             ; B428 85 36                    .6
        lda     LB491,x                         ; B42A BD 91 B4                 ...
        sta     $37                             ; B42D 85 37                    .7
LB42F:
        ldy     #$00                            ; B42F A0 00                    ..
        ldx     #$00                            ; B431 A2 00                    ..
LB433:
        lda     ($36),y                         ; B433 B1 36                    .6
        sta     $38,x                           ; B435 95 38                    .8
        iny                                     ; B437 C8                       .
        inx                                     ; B438 E8                       .
        cpx     #$06                            ; B439 E0 06                    ..
        bne     LB433                           ; B43B D0 F6                    ..
        lda     $36                             ; B43D A5 36                    .6
        clc                                     ; B43F 18                       .
        adc     #$06                            ; B440 69 06                    i.
        sta     $36                             ; B442 85 36                    .6
        bcc     LB448                           ; B444 90 02                    ..
        .byte   $E6,$37                         ; B446 E6 37                    .7
; ----------------------------------------------------------------------------
LB448:
        ldy     #$00                            ; B448 A0 00                    ..
LB44A:
        ldx     $38                             ; B44A A6 38                    .8
        bne     LB457                           ; B44C D0 09                    ..
        pla                                     ; B44E 68                       h
        pha                                     ; B44F 48                       H
        jsr     LA159                           ; B450 20 59 A1                  Y.
        pla                                     ; B453 68                       h
        jmp     LA47B                           ; B454 4C 7B A4                 L{.

; ----------------------------------------------------------------------------
LB457:
        bit     PPUSTATUS                       ; B457 2C 02 20                 ,. 
        lda     $3B                             ; B45A A5 3B                    .;
        sta     PPUADDR                         ; B45C 8D 06 20                 .. 
        lda     $3A                             ; B45F A5 3A                    .:
        sta     PPUADDR                         ; B461 8D 06 20                 .. 
LB464:
        lda     ($3C),y                         ; B464 B1 3C                    .<
        sta     PPUDATA                         ; B466 8D 07 20                 .. 
        iny                                     ; B469 C8                       .
        dex                                     ; B46A CA                       .
        bne     LB464                           ; B46B D0 F7                    ..
        lda     $3A                             ; B46D A5 3A                    .:
        clc                                     ; B46F 18                       .
        adc     #$20                            ; B470 69 20                    i 
        sta     $3A                             ; B472 85 3A                    .:
        bcc     LB478                           ; B474 90 02                    ..
        .byte   $E6,$3B                         ; B476 E6 3B                    .;
; ----------------------------------------------------------------------------
LB478:
        dec     $39                             ; B478 C6 39                    .9
        bne     LB44A                           ; B47A D0 CE                    ..
        beq     LB42F                           ; B47C F0 B1                    ..
LB47E:
        .byte   $00                             ; B47E 00                       .
LB47F:
        .byte   $CA,$A8,$B8,$A8,$B8,$A8,$B8,$A8 ; B47F CA A8 B8 A8 B8 A8 B8 A8  ........
        .byte   $B8,$68,$BC,$28,$C0,$E8,$C3,$A8 ; B487 B8 68 BC 28 C0 E8 C3 A8  .h.(....
        .byte   $B8                             ; B48F B8                       .
LB490:
        .byte   $A8                             ; B490 A8                       .
LB491:
        .byte   $B4,$A2,$B4,$A8,$B4,$A8,$B4,$A8 ; B491 B4 A2 B4 A8 B4 A8 B4 A8  ........
        .byte   $B4,$A8,$B4,$A8,$B4,$A8,$B4,$A8 ; B499 B4 A8 B4 A8 B4 A8 B4 A8  ........
        .byte   $B4,$18,$03,$44,$21,$A8,$C7,$00 ; B4A1 B4 18 03 44 21 A8 C7 00  ...D!...
; ----------------------------------------------------------------------------
LB4A9:
        lda     $4A,x                           ; B4A9 B5 4A                    .J
        beq     LB52A                           ; B4AB F0 7D                    .}
        lda     player1ControllerNew,x          ; B4AD B5 46                    .F
        beq     LB52A                           ; B4AF F0 79                    .y
        ldy     codeInputPlayer1,x              ; B4B1 BC B6 01                 ...
        bne     LB4C8                           ; B4B4 D0 12                    ..
        cmp     removeBlockCode,y               ; B4B6 D9 BB B5                 ...
        bne     LB4BF                           ; B4B9 D0 04                    ..
        .byte   $A0,$14,$D0,$67                 ; B4BB A0 14 D0 67              ...g
; ----------------------------------------------------------------------------
LB4BF:
        cmp     getLongbarCode,y                ; B4BF D9 B2 B5                 ...
        bne     LB4C8                           ; B4C2 D0 04                    ..
        ldy     #$0B                            ; B4C4 A0 0B                    ..
        bne     LB526                           ; B4C6 D0 5E                    .^
LB4C8:
        cmp     levelUpCode,y                   ; B4C8 D9 A8 B5                 ...
        bne     LB524                           ; B4CB D0 57                    .W
        iny                                     ; B4CD C8                       .
        lda     levelUpCode,y                   ; B4CE B9 A8 B5                 ...
        bne     LB526                           ; B4D1 D0 53                    .S
        cpy     #$12                            ; B4D3 C0 12                    ..
        beq     LB52B                           ; B4D5 F0 54                    .T
        cpy     #$1C                            ; B4D7 C0 1C                    ..
        beq     LB559                           ; B4D9 F0 7E                    .~
        stx     $37                             ; B4DB 86 37                    .7
        txa                                     ; B4DD 8A                       .
        asl     a                               ; B4DE 0A                       .
        tax                                     ; B4DF AA                       .
        lda     player1LevelOnes,x              ; B4E0 BD 2D 04                 .-.
        clc                                     ; B4E3 18                       .
        adc     #$01                            ; B4E4 69 01                    i.
        cmp     #$3A                            ; B4E6 C9 3A                    .:
        bcc     LB4F4                           ; B4E8 90 0A                    ..
        lda     player1LevelTens,x              ; B4EA BD 2C 04                 .,.
        adc     #$00                            ; B4ED 69 00                    i.
        sta     player1LevelTens,x              ; B4EF 9D 2C 04                 .,.
        lda     #$30                            ; B4F2 A9 30                    .0
LB4F4:
        ldy     player1LevelTens,x              ; B4F4 BC 2C 04                 .,.
        cmp     #$38                            ; B4F7 C9 38                    .8
        bne     LB4FF                           ; B4F9 D0 04                    ..
        cpy     #$31                            ; B4FB C0 31                    .1
        beq     LB52A                           ; B4FD F0 2B                    .+
LB4FF:
        sta     player1LevelOnes,x              ; B4FF 9D 2D 04                 .-.
        bit     playMode                        ; B502 24 2F                    $/
        bpl     LB514                           ; B504 10 0E                    ..
        sty     player1LevelTens                ; B506 8C 2C 04                 .,.
        sta     player1LevelOnes                ; B509 8D 2D 04                 .-.
        sty     player2LevelTens                ; B50C 8C 2E 04                 ...
        sta     player2LevelOnes                ; B50F 8D 2F 04                 ./.
        ldx     #$00                            ; B512 A2 00                    ..
LB514:
        jsr     LA756                           ; B514 20 56 A7                  V.
        ldx     $37                             ; B517 A6 37                    .7
        inc     $50,x                           ; B519 F6 50                    .P
        lda     #$3C                            ; B51B A9 3C                    .<
        sta     player1FallTimer,x              ; B51D 95 6A                    .j
        lda     #$15                            ; B51F A9 15                    ..
        jmp     possibleSetSoundOrMusic         ; B521 4C B1 CF                 L..

; ----------------------------------------------------------------------------
LB524:
        ldy     #$00                            ; B524 A0 00                    ..
LB526:
        tya                                     ; B526 98                       .
        sta     codeInputPlayer1,x              ; B527 9D B6 01                 ...
LB52A:
        rts                                     ; B52A 60                       `

; ----------------------------------------------------------------------------
LB52B:
        lda     longBarCodeUsedP1,x             ; B52B BD B8 01                 ...
        bne     LB52A                           ; B52E D0 FA                    ..
        lda     #$01                            ; B530 A9 01                    ..
        sta     longBarCodeUsedP1,x             ; B532 9D B8 01                 ...
        sta     player1TetriminoCurrent,x       ; B535 95 64                    .d
LB537:
        lda     #$04                            ; B537 A9 04                    ..
        sta     player1TetriminoY,x             ; B539 95 60                    .`
        lda     L99ED                           ; B53B AD ED 99                 ...
        bit     playMode                        ; B53E 24 2F                    $/
        bpl     LB545                           ; B540 10 03                    ..
        lda     L99EB,x                         ; B542 BD EB 99                 ...
LB545:
        sta     player1TetriminoX,x             ; B545 95 62                    .b
        lda     #$00                            ; B547 A9 00                    ..
        sta     player1TetriminoOrientation,x   ; B549 95 68                    .h
        lda     #$3C                            ; B54B A9 3C                    .<
        sta     player1FallTimer,x              ; B54D 95 6A                    .j
        ldy     player1TetriminoCurrent,x       ; B54F B4 64                    .d
        jsr     LA763                           ; B551 20 63 A7                  c.
        lda     #$15                            ; B554 A9 15                    ..
        jmp     possibleSetSoundOrMusic         ; B556 4C B1 CF                 L..

; ----------------------------------------------------------------------------
LB559:
        lda     removeBlockCodeUsedP1,x         ; B559 BD BA 01                 ...
        bne     LB52A                           ; B55C D0 CC                    ..
        lda     lastCurrentBlockP1,x            ; B55E BD BC 01                 ...
        beq     LB52A                           ; B561 F0 C7                    ..
        inc     removeBlockCodeUsedP1,x         ; B563 FE BA 01                 ...
        lda     player1TetriminoCurrent,x       ; B566 B5 64                    .d
        beq     LB576                           ; B568 F0 0C                    ..
        sta     player1TetriminoNext,x          ; B56A 95 66                    .f
        tay                                     ; B56C A8                       .
        stx     $3A                             ; B56D 86 3A                    .:
        inx                                     ; B56F E8                       .
        inx                                     ; B570 E8                       .
        jsr     LA763                           ; B571 20 63 A7                  c.
        ldx     $3A                             ; B574 A6 3A                    .:
LB576:
        lda     lastOrientationP1,x             ; B576 BD BE 01                 ...
        sta     player1TetriminoOrientation,x   ; B579 95 68                    .h
        lda     lastTetriminoXP1,x              ; B57B BD C2 01                 ...
        sta     player1TetriminoX,x             ; B57E 95 62                    .b
        lda     lastTetriminoYP1,x              ; B580 BD C0 01                 ...
        sta     player1TetriminoY,x             ; B583 95 60                    .`
        lda     lastCurrentBlockP1,x            ; B585 BD BC 01                 ...
        sta     player1TetriminoCurrent,x       ; B588 95 64                    .d
        txa                                     ; B58A 8A                       .
        asl     a                               ; B58B 0A                       .
        tay                                     ; B58C A8                       .
        lda     lastRNGSeedP1,y                 ; B58D B9 C4 01                 ...
        sta     player1RNGSeed,y                ; B590 99 5C 00                 .\.
        lda     lastRNGSeedP1+1,y               ; B593 B9 C5 01                 ...
        sta     player1RNGSeed+1,y              ; B596 99 5D 00                 .].
        jsr     L84D8                           ; B599 20 D8 84                  ..
        jsr     L8607                           ; B59C 20 07 86                  ..
        jsr     L8565                           ; B59F 20 65 85                  e.
        jsr     L8426                           ; B5A2 20 26 84                  &.
        jmp     LB537                           ; B5A5 4C 37 B5                 L7.

; ----------------------------------------------------------------------------
levelUpCode:
        .byte   $10,$20,$10,$20,$40,$80,$02,$02 ; B5A8 10 20 10 20 40 80 02 02  . . @...
        .byte   $01,$00                         ; B5B0 01 00                    ..
getLongbarCode:
        .byte   $20,$20,$40,$80,$40,$80,$02,$01 ; B5B2 20 20 40 80 40 80 02 01    @.@...
        .byte   $00                             ; B5BA 00                       .
removeBlockCode:
        .byte   $40,$20,$80,$10,$40,$20,$80,$02 ; B5BB 40 20 80 10 40 20 80 02  @ ..@ ..
        .byte   $01,$00                         ; B5C3 01 00                    ..
; ----------------------------------------------------------------------------
LB5C5:
        ldy     gameStatePossible               ; B5C5 A4 29                    .)
        dey                                     ; B5C7 88                       .
        bne     LB5D4                           ; B5C8 D0 0A                    ..
        ldx     #$00                            ; B5CA A2 00                    ..
        jsr     LB4A9                           ; B5CC 20 A9 B4                  ..
        ldx     #$01                            ; B5CF A2 01                    ..
        jsr     LB4A9                           ; B5D1 20 A9 B4                  ..
LB5D4:
        lda     player1ControllerNew            ; B5D4 A5 46                    .F
        ora     player2ControllerNew            ; B5D6 05 47                    .G
        and     #$08                            ; B5D8 29 08                    ).
        bne     LB5DD                           ; B5DA D0 01                    ..
LB5DC:
        rts                                     ; B5DC 60                       `

; ----------------------------------------------------------------------------
LB5DD:
        ldy     gameStatePossible               ; B5DD A4 29                    .)
        cpy     #$01                            ; B5DF C0 01                    ..
        beq     LB5F0                           ; B5E1 F0 0D                    ..
        bcs     LB5DC                           ; B5E3 B0 F7                    ..
        inc     gameStatePossible               ; B5E5 E6 29                    .)
        lda     #$01                            ; B5E7 A9 01                    ..
        jsr     possibleSetSoundOrMusic         ; B5E9 20 B1 CF                  ..
        lda     #$00                            ; B5EC A9 00                    ..
        beq     LB5FC                           ; B5EE F0 0C                    ..
LB5F0:
        dec     gameStatePossible               ; B5F0 C6 29                    .)
        lda     #$02                            ; B5F2 A9 02                    ..
        jsr     possibleSetSoundOrMusic         ; B5F4 20 B1 CF                  ..
        jsr     L8967                           ; B5F7 20 67 89                  g.
        lda     #$01                            ; B5FA A9 01                    ..
LB5FC:
        bit     playMode                        ; B5FC 24 2F                    $/
        bpl     LB603                           ; B5FE 10 03                    ..
        .byte   $18,$69,$07                     ; B600 18 69 07                 .i.
; ----------------------------------------------------------------------------
LB603:
        asl     a                               ; B603 0A                       .
        tay                                     ; B604 A8                       .
        lda     LB65D,y                         ; B605 B9 5D B6                 .].
        sta     $3C                             ; B608 85 3C                    .<
        lda     LB65E,y                         ; B60A B9 5E B6                 .^.
        sta     $3D                             ; B60D 85 3D                    .=
        ldy     #$00                            ; B60F A0 00                    ..
LB611:
        ldx     #$00                            ; B611 A2 00                    ..
        lda     ($3C),y                         ; B613 B1 3C                    .<
        bne     LB61A                           ; B615 D0 03                    ..
        rts                                     ; B617 60                       `

; ----------------------------------------------------------------------------
LB618:
        lda     ($3C),y                         ; B618 B1 3C                    .<
LB61A:
        sta     $36,x                           ; B61A 95 36                    .6
        iny                                     ; B61C C8                       .
        inx                                     ; B61D E8                       .
        cpx     #$06                            ; B61E E0 06                    ..
        bne     LB618                           ; B620 D0 F6                    ..
LB622:
        jsr     LA3DB                           ; B622 20 DB A3                  ..
        lda     $38                             ; B625 A5 38                    .8
        sta     $16,x                           ; B627 95 16                    ..
        lda     $39                             ; B629 A5 39                    .9
        sta     $17,x                           ; B62B 95 17                    ..
        lda     $3A                             ; B62D A5 3A                    .:
        sta     ppuDataAddress1,x               ; B62F 95 08                    ..
        lda     $3B                             ; B631 A5 3B                    .;
        sta     ppuDataAddress1+1,x             ; B633 95 09                    ..
        lda     $36                             ; B635 A5 36                    .6
        and     #$7F                            ; B637 29 7F                    ).
        sta     $24,x                           ; B639 95 24                    .$
        dec     $37                             ; B63B C6 37                    .7
        beq     LB611                           ; B63D F0 D2                    ..
        lda     $38                             ; B63F A5 38                    .8
        clc                                     ; B641 18                       .
        adc     #$20                            ; B642 69 20                    i 
        sta     $38                             ; B644 85 38                    .8
        lda     $39                             ; B646 A5 39                    .9
        adc     #$00                            ; B648 69 00                    i.
        sta     $39                             ; B64A 85 39                    .9
        lda     $36                             ; B64C A5 36                    .6
        bpl     LB622                           ; B64E 10 D2                    ..
        and     #$7F                            ; B650 29 7F                    ).
        clc                                     ; B652 18                       .
        adc     $3A                             ; B653 65 3A                    e:
        sta     $3A                             ; B655 85 3A                    .:
        bcc     LB622                           ; B657 90 C9                    ..
        inc     $3B                             ; B659 E6 3B                    .;
        bne     LB622                           ; B65B D0 C5                    ..
LB65D:
        .byte   $79                             ; B65D 79                       y
LB65E:
        .byte   $B6,$86,$B6,$99,$B6,$A6,$B6,$B3 ; B65E B6 86 B6 99 B6 A6 B6 B3  ........
        .byte   $B6,$C0,$B6,$E5,$B6,$0A,$B7,$17 ; B666 B6 C0 B6 E5 B6 0A B7 17  ........
        .byte   $B7,$24,$B7,$6D,$B7,$B6,$B7,$FF ; B66E B7 24 B7 6D B7 B6 B7 FF  .$.m....
        .byte   $B7,$24,$B8,$88,$02,$0C,$21,$F0 ; B676 B7 24 B8 88 02 0C 21 F0  .$....!.
        .byte   $C7,$02,$01,$D3,$23,$98,$B8,$00 ; B67E C7 02 01 D3 23 98 B8 00  ....#...
        .byte   $08,$01,$0C,$21,$34,$C1,$08,$01 ; B686 08 01 0C 21 34 C1 08 01  ...!4...
        .byte   $2C,$21,$54,$C1,$02,$01,$D3,$23 ; B68E 2C 21 54 C1 02 01 D3 23  ,!T....#
        .byte   $9A,$B8,$00,$86,$04,$8C,$21,$00 ; B696 9A B8 00 86 04 8C 21 00  ......!.
        .byte   $C8,$02,$01,$DB,$23,$9C,$B8,$00 ; B69E C8 02 01 DB 23 9C B8 00  ....#...
        .byte   $86,$04,$84,$21,$00,$C8,$02,$01 ; B6A6 86 04 84 21 00 C8 02 01  ...!....
        .byte   $D9,$23,$9C,$B8,$00,$86,$04,$96 ; B6AE D9 23 9C B8 00 86 04 96  .#......
        .byte   $21,$00,$C8,$02,$01,$DD,$23,$9E ; B6B6 21 00 C8 02 01 DD 23 9E  !.....#.
        .byte   $B8,$00,$02,$01,$D9,$23,$A0,$B8 ; B6BE B8 00 02 01 D9 23 A0 B8  .....#..
        .byte   $06,$01,$47,$20,$2A,$BD,$04,$01 ; B6C6 06 01 47 20 2A BD 04 01  ..G *...
        .byte   $89,$20,$2A,$BD,$02,$01,$CB,$20 ; B6CE 89 20 2A BD 02 01 CB 20  . *.... 
        .byte   $2A,$BD,$08,$02,$C2,$20,$2A,$BD ; B6D6 2A BD 08 02 C2 20 2A BD  *.... *.
        .byte   $0A,$14,$02,$21,$2A,$BD,$00,$02 ; B6DE 0A 14 02 21 2A BD 00 02  ...!*...
        .byte   $01,$DD,$23,$A2,$B8,$06,$01,$53 ; B6E6 01 DD 23 A2 B8 06 01 53  ..#....S
        .byte   $20,$2A,$BD,$04,$01,$93,$20,$2A ; B6EE 20 2A BD 04 01 93 20 2A   *.... *
        .byte   $BD,$02,$01,$D3,$20,$2A,$BD,$08 ; B6F6 BD 02 01 D3 20 2A BD 08  .... *..
        .byte   $02,$D6,$20,$2A,$BD,$0A,$14,$14 ; B6FE 02 D6 20 2A BD 0A 14 14  .. *....
        .byte   $21,$2A,$BD,$00,$88,$02,$CC,$20 ; B706 21 2A BD 00 88 02 CC 20  !*..... 
        .byte   $F0,$C7,$02,$01,$CB,$23,$A4,$B8 ; B70E F0 C7 02 01 CB 23 A4 B8  .....#..
        .byte   $00,$08,$02,$CC,$20,$2A,$BD,$02 ; B716 00 08 02 CC 20 2A BD 02  .... *..
        .byte   $01,$CB,$23,$A6,$B8,$00,$0A,$14 ; B71E 01 CB 23 A6 B8 00 0A 14  ..#.....
        .byte   $02,$21,$2A,$BD,$8A,$02,$02,$21 ; B726 02 21 2A BD 8A 02 02 21  .!*....!
        .byte   $18,$C8,$07,$01,$65,$21,$4F,$B8 ; B72E 18 C8 07 01 65 21 4F B8  ....e!O.
        .byte   $0A,$01,$82,$21,$56,$B8,$07,$01 ; B736 0A 01 82 21 56 B8 07 01  ...!V...
        .byte   $E5,$21,$60,$B8,$0A,$01,$02,$22 ; B73E E5 21 60 B8 0A 01 02 22  .!`...."
        .byte   $67,$B8,$07,$01,$65,$22,$71,$B8 ; B746 67 B8 07 01 65 22 71 B8  g...e"q.
        .byte   $0A,$01,$82,$22,$78,$B8,$06,$01 ; B74E 0A 01 82 22 78 B8 06 01  ..."x...
        .byte   $E5,$22,$82,$B8,$0A,$01,$02,$23 ; B756 E5 22 82 B8 0A 01 02 23  .".....#
        .byte   $89,$B8,$05,$01,$42,$23,$93,$B8 ; B75E 89 B8 05 01 42 23 93 B8  ....B#..
        .byte   $02,$01,$6A,$23,$91,$B8,$00,$0A ; B766 02 01 6A 23 91 B8 00 0A  ..j#....
        .byte   $14,$14,$21,$2A,$BD,$8A,$02,$14 ; B76E 14 14 21 2A BD 8A 02 14  ..!*....
        .byte   $21,$18,$C8,$07,$01,$77,$21,$4F ; B776 21 18 C8 07 01 77 21 4F  !....w!O
        .byte   $B8,$0A,$01,$94,$21,$56,$B8,$07 ; B77E B8 0A 01 94 21 56 B8 07  ....!V..
        .byte   $01,$F7,$21,$60,$B8,$0A,$01,$14 ; B786 01 F7 21 60 B8 0A 01 14  ..!`....
        .byte   $22,$67,$B8,$07,$01,$77,$22,$71 ; B78E 22 67 B8 07 01 77 22 71  "g...w"q
        .byte   $B8,$0A,$01,$94,$22,$78,$B8,$06 ; B796 B8 0A 01 94 22 78 B8 06  ...."x..
        .byte   $01,$F7,$22,$82,$B8,$0A,$01,$14 ; B79E 01 F7 22 82 B8 0A 01 14  ..".....
        .byte   $23,$89,$B8,$05,$01,$54,$23,$93 ; B7A6 23 89 B8 05 01 54 23 93  #....T#.
        .byte   $B8,$02,$01,$7C,$23,$91,$B8,$00 ; B7AE B8 02 01 7C 23 91 B8 00  ...|#...
        .byte   $0C,$14,$0A,$21,$2A,$BD,$8A,$02 ; B7B6 0C 14 0A 21 2A BD 8A 02  ...!*...
        .byte   $0B,$21,$18,$C8,$07,$01,$6E,$21 ; B7BE 0B 21 18 C8 07 01 6E 21  .!....n!
        .byte   $4F,$B8,$0A,$01,$8B,$21,$56,$B8 ; B7C6 4F B8 0A 01 8B 21 56 B8  O....!V.
        .byte   $07,$01,$EE,$21,$60,$B8,$0A,$01 ; B7CE 07 01 EE 21 60 B8 0A 01  ...!`...
        .byte   $0B,$22,$67,$B8,$07,$01,$6E,$22 ; B7D6 0B 22 67 B8 07 01 6E 22  ."g...n"
        .byte   $71,$B8,$0A,$01,$8B,$22,$78,$B8 ; B7DE 71 B8 0A 01 8B 22 78 B8  q...."x.
        .byte   $06,$01,$EE,$22,$82,$B8,$0B,$01 ; B7E6 06 01 EE 22 82 B8 0B 01  ..."....
        .byte   $0A,$23,$88,$B8,$05,$01,$4B,$23 ; B7EE 0A 23 88 B8 05 01 4B 23  .#....K#
        .byte   $93,$B8,$02,$01,$73,$23,$91,$B8 ; B7F6 93 B8 02 01 73 23 91 B8  ....s#..
        .byte   $00,$84,$12,$4E,$21,$2C,$C8,$02 ; B7FE 00 84 12 4E 21 2C C8 02  ...N!,..
        .byte   $01,$D3,$23,$4D,$B8,$02,$01,$DB ; B806 01 D3 23 4D B8 02 01 DB  ..#M....
        .byte   $23,$4D,$B8,$02,$01,$E3,$23,$4D ; B80E 23 4D B8 02 01 E3 23 4D  #M....#M
        .byte   $B8,$02,$01,$EB,$23,$4D,$B8,$02 ; B816 B8 02 01 EB 23 4D B8 02  ....#M..
        .byte   $01,$F3,$23,$4D,$B8,$00,$84,$12 ; B81E 01 F3 23 4D B8 00 84 12  ..#M....
        .byte   $4E,$21,$74,$C8,$02,$01,$D3,$23 ; B826 4E 21 74 C8 02 01 D3 23  N!t....#
        .byte   $49,$B8,$02,$01,$DB,$23,$4B,$B8 ; B82E 49 B8 02 01 DB 23 4B B8  I....#K.
        .byte   $02,$01,$E3,$23,$4B,$B8,$02,$01 ; B836 02 01 E3 23 4B B8 02 01  ...#K...
        .byte   $EB,$23,$4B,$B8,$02,$01,$F3,$23 ; B83E EB 23 4B B8 02 01 F3 23  .#K....#
        .byte   $4B,$B8,$00,$EA,$BA,$EE,$BB,$AA ; B846 4B B8 00 EA BA EE BB AA  K.......
        .byte   $AA,$53,$49,$4E,$47,$4C,$45,$53 ; B84E AA 53 49 4E 47 4C 45 53  .SINGLES
        .byte   $58,$31,$30,$30,$3D,$20,$20,$20 ; B856 58 31 30 30 3D 20 20 20  X100=   
        .byte   $30,$30,$44,$4F,$55,$42,$4C,$45 ; B85E 30 30 44 4F 55 42 4C 45  00DOUBLE
        .byte   $53,$58,$34,$30,$30,$3D,$20,$20 ; B866 53 58 34 30 30 3D 20 20  SX400=  
        .byte   $20,$30,$30,$54,$52,$49,$50,$4C ; B86E 20 30 30 54 52 49 50 4C   00TRIPL
        .byte   $45,$53,$58,$39,$30,$30,$3D,$20 ; B876 45 53 58 39 30 30 3D 20  ESX900= 
        .byte   $20,$20,$30,$30,$54,$45,$54,$52 ; B87E 20 20 30 30 54 45 54 52    00TETR
        .byte   $49,$53,$58,$32,$35,$30,$30,$3D ; B886 49 53 58 32 35 30 30 3D  ISX2500=
        .byte   $20,$20,$20,$30,$30,$54,$4F,$54 ; B88E 20 20 20 30 30 54 4F 54     00TOT
        .byte   $41,$4C,$EF,$BF,$EA,$BA,$FF,$33 ; B896 41 4C EF BF EA BA FF 33  AL.....3
        .byte   $DD,$FF,$00,$00,$55,$55,$FF,$FF ; B89E DD FF 00 00 55 55 FF FF  ....UU..
        .byte   $0F,$0F                         ; B8A6 0F 0F                    ..
possibleMenuNametable:
        .byte   $60,$61,$62,$62,$62,$62,$62,$62 ; B8A8 60 61 62 62 62 62 62 62  `abbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; B8B0 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; B8B8 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$63,$64 ; B8C0 62 62 62 62 62 62 63 64  bbbbbbcd
        .byte   $65,$66,$67,$67,$67,$67,$67,$67 ; B8C8 65 66 67 67 67 67 67 67  efgggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; B8D0 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; B8D8 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$68,$69 ; B8E0 67 67 67 67 67 67 68 69  gggggghi
        .byte   $6A,$6B,$00,$00,$00,$00,$6C,$00 ; B8E8 6A 6B 00 00 00 00 6C 00  jk....l.
        .byte   $00,$00,$00,$00,$00,$6D,$6E,$6F ; B8F0 00 00 00 00 00 6D 6E 6F  .....mno
        .byte   $70,$71,$72,$00,$00,$00,$00,$00 ; B8F8 70 71 72 00 00 00 00 00  pqr.....
        .byte   $00,$6C,$00,$00,$00,$00,$73,$74 ; B900 00 6C 00 00 00 00 73 74  .l....st
        .byte   $6A,$6B,$00,$00,$00,$00,$75,$76 ; B908 6A 6B 00 00 00 00 75 76  jk....uv
        .byte   $76,$76,$76,$76,$76,$77,$76,$76 ; B910 76 76 76 76 76 77 76 76  vvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$76 ; B918 76 76 78 76 76 76 76 76  vvxvvvvv
        .byte   $76,$79,$00,$00,$00,$00,$73,$74 ; B920 76 79 00 00 00 00 73 74  vy....st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B928 6A 6B 00 00 00 00 00 00  jk......
        .byte   $6C,$00,$00,$00,$00,$7A,$7B,$7C ; B930 6C 00 00 00 00 7A 7B 7C  l....z{|
        .byte   $7D,$7E,$7F,$00,$00,$00,$00,$6C ; B938 7D 7E 7F 00 00 00 00 6C  }~.....l
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B940 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B948 6A 6B 00 00 00 00 00 00  jk......
        .byte   $75,$76,$76,$76,$76,$77,$76,$76 ; B950 75 76 76 76 76 77 76 76  uvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$79 ; B958 76 76 78 76 76 76 76 79  vvxvvvvy
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B960 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B968 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$6C,$00,$00,$7A,$80,$81 ; B970 00 00 6C 00 00 7A 80 81  ..l..z..
        .byte   $82,$83,$84,$00,$00,$6C,$00,$00 ; B978 82 83 84 00 00 6C 00 00  .....l..
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B980 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B988 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$75,$76,$76,$85,$76,$76 ; B990 00 00 75 76 76 85 76 76  ..uvv.vv
        .byte   $76,$76,$86,$76,$76,$79,$00,$00 ; B998 76 76 86 76 76 79 00 00  vv.vvy..
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B9A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B9A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9B0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9B8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B9C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B9C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9D0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9D8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; B9E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; B9E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9F0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; B9F8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BA00 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BA08 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA10 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA18 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BA20 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BA28 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA30 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA38 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BA40 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BA48 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA50 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA58 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BA60 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BA68 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA70 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA78 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BA80 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BA88 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA90 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BA98 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BAA0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BAA8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAB0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAB8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BAC0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BAC8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAD0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAD8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BAE0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BAE8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAF0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BAF8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BB00 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BB08 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB10 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB18 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BB20 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BB28 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB30 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB38 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BB40 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BB48 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB50 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB58 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BB60 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BB68 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB70 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB78 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BB80 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BB88 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB90 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BB98 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BBA0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BBA8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBB0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBB8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BBC0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BBC8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBD0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBD8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BBE0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BBE8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBF0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BBF8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BC00 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BC08 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BC10 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BC18 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BC20 00 00 00 00 00 00 73 74  ......st
        .byte   $87,$88,$89,$89,$89,$89,$89,$89 ; BC28 87 88 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$89,$89 ; BC30 89 89 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$89,$89 ; BC38 89 89 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$8A,$8B ; BC40 89 89 89 89 89 89 8A 8B  ........
        .byte   $8C,$8D,$8E,$8E,$8E,$8E,$8E,$8E ; BC48 8C 8D 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8E,$8E ; BC50 8E 8E 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8E,$8E ; BC58 8E 8E 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8F,$90 ; BC60 8E 8E 8E 8E 8E 8E 8F 90  ........
        .byte   $60,$61,$62,$62,$62,$62,$62,$62 ; BC68 60 61 62 62 62 62 62 62  `abbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; BC70 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; BC78 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$63,$64 ; BC80 62 62 62 62 62 62 63 64  bbbbbbcd
        .byte   $65,$66,$67,$67,$67,$67,$67,$67 ; BC88 65 66 67 67 67 67 67 67  efgggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; BC90 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; BC98 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$68,$69 ; BCA0 67 67 67 67 67 67 68 69  gggggghi
dataPastPossibleMenuNametable:
        .byte   $6A,$6B,$91,$92,$93,$94,$6C,$00 ; BCA8 6A 6B 91 92 93 94 6C 00  jk....l.
        .byte   $00,$00,$00,$00,$00,$6D,$6E,$6F ; BCB0 00 00 00 00 00 6D 6E 6F  .....mno
        .byte   $70,$71,$72,$00,$00,$00,$00,$00 ; BCB8 70 71 72 00 00 00 00 00  pqr.....
        .byte   $00,$6C,$91,$92,$93,$94,$73,$74 ; BCC0 00 6C 91 92 93 94 73 74  .l....st
        .byte   $6A,$6B,$00,$00,$00,$00,$75,$76 ; BCC8 6A 6B 00 00 00 00 75 76  jk....uv
        .byte   $76,$76,$76,$76,$76,$77,$76,$76 ; BCD0 76 76 76 76 76 77 76 76  vvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$76 ; BCD8 76 76 78 76 76 76 76 76  vvxvvvvv
        .byte   $76,$79,$00,$00,$00,$00,$73,$74 ; BCE0 76 79 00 00 00 00 73 74  vy....st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BCE8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $6C,$00,$00,$00,$00,$7A,$7B,$7C ; BCF0 6C 00 00 00 00 7A 7B 7C  l....z{|
        .byte   $7D,$7E,$7F,$00,$00,$00,$00,$6C ; BCF8 7D 7E 7F 00 00 00 00 6C  }~.....l
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BD00 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BD08 6A 6B 00 00 00 00 00 00  jk......
        .byte   $75,$76,$76,$76,$76,$85,$76,$76 ; BD10 75 76 76 76 76 85 76 76  uvvvv.vv
        .byte   $76,$76,$86,$76,$76,$76,$76,$79 ; BD18 76 76 86 76 76 76 76 79  vv.vvvvy
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BD20 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BD28 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BD30 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BD38 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BD40 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BD48 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BD50 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BD58 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BD60 00 00 00 00 00 00 73 74  ......st
        .byte   $87,$88,$89,$89,$89,$89,$89,$89 ; BD68 87 88 89 89 89 89 89 89  ........
        .byte   $95,$96,$00,$00,$00,$00,$00,$00 ; BD70 95 96 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$97,$98 ; BD78 00 00 00 00 00 00 97 98  ........
        .byte   $89,$89,$89,$89,$89,$89,$8A,$8B ; BD80 89 89 89 89 89 89 8A 8B  ........
        .byte   $8C,$8D,$8E,$8E,$8E,$8E,$8E,$8E ; BD88 8C 8D 8E 8E 8E 8E 8E 8E  ........
        .byte   $99,$9A,$00,$00,$00,$00,$00,$00 ; BD90 99 9A 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$9B,$9C ; BD98 00 00 00 00 00 00 9B 9C  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8F,$90 ; BDA0 8E 8E 8E 8E 8E 8E 8F 90  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BDA8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BDB0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BDB8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BDC0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$4C,$45,$56,$45,$4C,$00 ; BDC8 00 00 4C 45 56 45 4C 00  ..LEVEL.
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BDD0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BDD8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$48,$49,$47,$48,$00,$00,$00 ; BDE0 00 48 49 47 48 00 00 00  .HIGH...
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BDE8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BDF0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BDF8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$53,$43,$4F,$52,$45,$00,$00 ; BE00 00 53 43 4F 52 45 00 00  .SCORE..
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE08 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BE10 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BE18 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE20 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE28 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BE30 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BE38 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE40 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE48 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BE50 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BE58 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE60 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BE68 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BE70 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BE78 00 00 00 00 00 00 73 74  ......st
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BE80 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BE88 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BE90 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BE98 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BEA0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BEA8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BEB0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BEB8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BEC0 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BEC8 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BED0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BED8 00 00 00 00 00 00 73 74  ......st
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BEE0 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BEE8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BEF0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BEF8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF00 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF08 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BF10 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BF18 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF20 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BF28 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BF30 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BF38 00 00 00 00 00 00 73 74  ......st
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BF40 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF48 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BF50 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BF58 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF60 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF68 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BF70 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BF78 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BF80 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BF88 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BF90 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BF98 00 00 00 00 00 00 73 74  ......st
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BFA0 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BFA8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BFB0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BFB8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BFC0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BFC8 00 00 00 00 00 00 00 00  ........
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; BFD0 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; BFD8 00 00 00 00 00 00 73 74  ......st
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; BFE0 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; BFE8 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $87,$88,$89,$89,$89,$89,$89,$89 ; BFF0 87 88 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$8A,$8B ; BFF8 89 89 89 89 89 89 8A 8B  ........
        .byte   $9D,$9D,$9D,$9D,$9D,$9D,$9D,$9D ; C000 9D 9D 9D 9D 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C008 00 00 00 00 00 00 00 00  ........
        .byte   $8C,$8D,$8E,$8E,$8E,$8E,$8E,$8E ; C010 8C 8D 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8F,$90 ; C018 8E 8E 8E 8E 8E 8E 8F 90  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C020 00 00 00 00 00 00 00 00  ........
possibleGameNametable:
        .byte   $60,$61,$62,$62,$62,$62,$62,$62 ; C028 60 61 62 62 62 62 62 62  `abbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; C030 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; C038 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$9E,$64 ; C040 62 62 62 62 62 62 9E 64  bbbbbb.d
        .byte   $65,$66,$67,$67,$67,$67,$67,$67 ; C048 65 66 67 67 67 67 67 67  efgggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; C050 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; C058 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$9F,$69 ; C060 67 67 67 67 67 67 9F 69  gggggg.i
        .byte   $6A,$6B,$91,$92,$93,$94,$6C,$00 ; C068 6A 6B 91 92 93 94 6C 00  jk....l.
        .byte   $00,$00,$00,$00,$00,$6D,$6E,$6F ; C070 00 00 00 00 00 6D 6E 6F  .....mno
        .byte   $70,$71,$72,$00,$48,$49,$47,$48 ; C078 70 71 72 00 48 49 47 48  pqr.HIGH
        .byte   $00,$53,$43,$4F,$52,$45,$73,$74 ; C080 00 53 43 4F 52 45 73 74  .SCOREst
        .byte   $6A,$6B,$00,$00,$00,$00,$75,$76 ; C088 6A 6B 00 00 00 00 75 76  jk....uv
        .byte   $76,$76,$76,$76,$76,$77,$76,$76 ; C090 76 76 76 76 76 77 76 76  vvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$76 ; C098 76 76 78 76 76 76 76 76  vvxvvvvv
        .byte   $76,$76,$76,$76,$76,$76,$73,$74 ; C0A0 76 76 76 76 76 76 73 74  vvvvvvst
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C0A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $6C,$00,$00,$00,$00,$7A,$7B,$7C ; C0B0 6C 00 00 00 00 7A 7B 7C  l....z{|
        .byte   $7D,$7E,$7F,$00,$00,$00,$00,$00 ; C0B8 7D 7E 7F 00 00 00 00 00  }~......
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C0C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C0C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $75,$76,$76,$76,$76,$77,$76,$76 ; C0D0 75 76 76 76 76 77 76 76  uvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$76 ; C0D8 76 76 78 76 76 76 76 76  vvxvvvvv
        .byte   $76,$76,$76,$76,$76,$76,$73,$74 ; C0E0 76 76 76 76 76 76 73 74  vvvvvvst
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C0E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$6C,$00,$00,$7A,$80,$81 ; C0F0 00 00 6C 00 00 7A 80 81  ..l..z..
        .byte   $82,$83,$84,$00,$00,$00,$53,$54 ; C0F8 82 83 84 00 00 00 53 54  ......ST
        .byte   $41,$54,$53,$00,$00,$00,$73,$74 ; C100 41 54 53 00 00 00 73 74  ATS...st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C108 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$75,$76,$76,$85,$76,$76 ; C110 00 00 75 76 76 85 76 76  ..uvv.vv
        .byte   $76,$76,$86,$76,$76,$76,$76,$76 ; C118 76 76 86 76 76 76 76 76  vv.vvvvv
        .byte   $76,$76,$76,$76,$76,$76,$73,$74 ; C120 76 76 76 76 76 76 73 74  vvvvvvst
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C128 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$97,$98,$89,$89 ; C130 00 00 00 00 97 98 89 89  ........
        .byte   $89,$89,$95,$96,$00,$00,$00,$00 ; C138 89 89 95 96 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C140 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C148 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$9B,$9C,$8E,$8E ; C150 00 00 00 00 9B 9C 8E 8E  ........
        .byte   $8E,$8E,$99,$9A,$00,$00,$00,$00 ; C158 8E 8E 99 9A 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C160 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C168 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$16,$17 ; C170 00 00 00 00 73 74 16 17  ....st..
        .byte   $18,$19,$6A,$6B,$00,$00,$00,$00 ; C178 18 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C180 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C188 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A0,$A1 ; C190 00 00 00 00 73 74 A0 A1  ....st..
        .byte   $A2,$A3,$6A,$6B,$00,$00,$00,$00 ; C198 A2 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C1A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C1A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C1B0 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C1B8 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C1C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C1C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$1B ; C1D0 00 00 00 00 73 74 1A 1B  ....st..
        .byte   $1C,$19,$6A,$6B,$00,$00,$00,$00 ; C1D8 1C 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C1E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C1E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$A9 ; C1F0 00 00 00 00 73 74 A8 A9  ....st..
        .byte   $AA,$A3,$6A,$6B,$00,$00,$00,$00 ; C1F8 AA A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C200 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C208 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$AB ; C210 00 00 00 00 73 74 A4 AB  ....st..
        .byte   $AC,$AD,$6A,$6B,$00,$00,$00,$00 ; C218 AC AD 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C220 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C228 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$16,$17 ; C230 00 00 00 00 73 74 16 17  ....st..
        .byte   $18,$19,$6A,$6B,$00,$00,$00,$00 ; C238 18 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C240 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C248 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A0,$A1 ; C250 00 00 00 00 73 74 A0 A1  ....st..
        .byte   $A2,$A3,$6A,$6B,$00,$00,$00,$00 ; C258 A2 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C260 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C268 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C270 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C278 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C280 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C288 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$1F ; C290 00 00 00 00 73 74 1A 1F  ....st..
        .byte   $AE,$AF,$6A,$6B,$00,$00,$00,$00 ; C298 AE AF 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C2A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C2A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$B0 ; C2B0 00 00 00 00 73 74 A8 B0  ....st..
        .byte   $B1,$A3,$6A,$6B,$00,$00,$00,$00 ; C2B8 B1 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C2C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C2C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$B2 ; C2D0 00 00 00 00 73 74 A4 B2  ....st..
        .byte   $B3,$A7,$6A,$6B,$00,$00,$00,$00 ; C2D8 B3 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C2E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C2E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$B4 ; C2F0 00 00 00 00 73 74 1A B4  ....st..
        .byte   $B5,$AF,$6A,$6B,$00,$00,$00,$00 ; C2F8 B5 AF 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C300 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C308 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$B6 ; C310 00 00 00 00 73 74 A8 B6  ....st..
        .byte   $B7,$A3,$6A,$6B,$00,$00,$00,$00 ; C318 B7 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C320 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C328 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C330 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C338 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C340 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C348 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$B8 ; C350 00 00 00 00 73 74 1A B8  ....st..
        .byte   $B9,$BA,$6A,$6B,$00,$00,$00,$00 ; C358 B9 BA 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C360 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C368 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$BB ; C370 00 00 00 00 73 74 A8 BB  ....st..
        .byte   $BC,$A3,$6A,$6B,$00,$BD,$BE,$BF ; C378 BC A3 6A 6B 00 BD BE BF  ..jk....
        .byte   $C0,$C1,$C2,$C3,$00,$00,$73,$74 ; C380 C0 C1 C2 C3 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C388 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$C4 ; C390 00 00 00 00 73 74 A4 C4  ....st..
        .byte   $C5,$A7,$6A,$6B,$00,$C6,$C7,$00 ; C398 C5 A7 6A 6B 00 C6 C7 00  ..jk....
        .byte   $C8,$C9,$CA,$C7,$00,$00,$73,$74 ; C3A0 C8 C9 CA C7 00 00 73 74  ......st
        .byte   $87,$88,$89,$89,$89,$89,$89,$89 ; C3A8 87 88 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$8A,$CB,$CC,$CC ; C3B0 89 89 89 89 8A CB CC CC  ........
        .byte   $CC,$CC,$CD,$88,$89,$89,$89,$89 ; C3B8 CC CC CD 88 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$8A,$8B ; C3C0 89 89 89 89 89 89 8A 8B  ........
        .byte   $8C,$8D,$8E,$8E,$8E,$8E,$8E,$8E ; C3C8 8C 8D 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8F,$CE,$CF,$CF ; C3D0 8E 8E 8E 8E 8F CE CF CF  ........
        .byte   $CF,$CF,$D0,$8D,$8E,$8E,$8E,$8E ; C3D8 CF CF D0 8D 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8F,$D1 ; C3E0 8E 8E 8E 8E 8E 8E 8F D1  ........
        .byte   $60,$61,$62,$62,$62,$62,$62,$62 ; C3E8 60 61 62 62 62 62 62 62  `abbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; C3F0 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$62,$62 ; C3F8 62 62 62 62 62 62 62 62  bbbbbbbb
        .byte   $62,$62,$62,$62,$62,$62,$63,$64 ; C400 62 62 62 62 62 62 63 64  bbbbbbcd
        .byte   $65,$66,$67,$67,$67,$67,$67,$67 ; C408 65 66 67 67 67 67 67 67  efgggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; C410 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$67,$67 ; C418 67 67 67 67 67 67 67 67  gggggggg
        .byte   $67,$67,$67,$67,$67,$67,$68,$69 ; C420 67 67 67 67 67 67 68 69  gggggghi
dataPastPossibleGameNametable:
        .byte   $6A,$6B,$91,$92,$93,$94,$6C,$00 ; C428 6A 6B 91 92 93 94 6C 00  jk....l.
        .byte   $00,$00,$00,$00,$00,$6D,$6E,$6F ; C430 00 00 00 00 00 6D 6E 6F  .....mno
        .byte   $70,$71,$72,$00,$00,$00,$00,$00 ; C438 70 71 72 00 00 00 00 00  pqr.....
        .byte   $00,$6C,$91,$92,$93,$94,$73,$74 ; C440 00 6C 91 92 93 94 73 74  .l....st
        .byte   $6A,$6B,$00,$00,$00,$00,$75,$76 ; C448 6A 6B 00 00 00 00 75 76  jk....uv
        .byte   $76,$76,$76,$76,$76,$77,$76,$76 ; C450 76 76 76 76 76 77 76 76  vvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$76 ; C458 76 76 78 76 76 76 76 76  vvxvvvvv
        .byte   $76,$79,$00,$00,$00,$00,$73,$74 ; C460 76 79 00 00 00 00 73 74  vy....st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C468 6A 6B 00 00 00 00 00 00  jk......
        .byte   $6C,$00,$00,$00,$00,$7A,$7B,$7C ; C470 6C 00 00 00 00 7A 7B 7C  l....z{|
        .byte   $7D,$7E,$7F,$00,$00,$00,$00,$6C ; C478 7D 7E 7F 00 00 00 00 6C  }~.....l
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C480 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C488 6A 6B 00 00 00 00 00 00  jk......
        .byte   $75,$76,$76,$76,$76,$77,$76,$76 ; C490 75 76 76 76 76 77 76 76  uvvvvwvv
        .byte   $76,$76,$78,$76,$76,$76,$76,$79 ; C498 76 76 78 76 76 76 76 79  vvxvvvvy
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C4A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C4A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$6C,$00,$00,$7A,$80,$81 ; C4B0 00 00 6C 00 00 7A 80 81  ..l..z..
        .byte   $82,$83,$84,$00,$00,$6C,$00,$00 ; C4B8 82 83 84 00 00 6C 00 00  .....l..
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C4C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C4C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$75,$76,$76,$85,$76,$76 ; C4D0 00 00 75 76 76 85 76 76  ..uvv.vv
        .byte   $76,$76,$86,$76,$76,$79,$00,$00 ; C4D8 76 76 86 76 76 79 00 00  vv.vvy..
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C4E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C4E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$97,$98,$89,$89 ; C4F0 00 00 00 00 97 98 89 89  ........
        .byte   $89,$89,$95,$96,$00,$00,$00,$00 ; C4F8 89 89 95 96 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C500 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C508 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$9B,$9C,$8E,$8E ; C510 00 00 00 00 9B 9C 8E 8E  ........
        .byte   $8E,$8E,$99,$9A,$00,$00,$00,$00 ; C518 8E 8E 99 9A 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C520 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C528 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$16,$17 ; C530 00 00 00 00 73 74 16 17  ....st..
        .byte   $18,$19,$6A,$6B,$00,$00,$00,$00 ; C538 18 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C540 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C548 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A0,$A1 ; C550 00 00 00 00 73 74 A0 A1  ....st..
        .byte   $A2,$A3,$6A,$6B,$00,$00,$00,$00 ; C558 A2 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C560 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C568 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C570 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C578 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C580 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C588 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$1B ; C590 00 00 00 00 73 74 1A 1B  ....st..
        .byte   $1C,$19,$6A,$6B,$00,$00,$00,$00 ; C598 1C 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C5A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C5A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$A9 ; C5B0 00 00 00 00 73 74 A8 A9  ....st..
        .byte   $AA,$A3,$6A,$6B,$00,$00,$00,$00 ; C5B8 AA A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C5C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C5C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$AB ; C5D0 00 00 00 00 73 74 A4 AB  ....st..
        .byte   $AC,$AD,$6A,$6B,$00,$00,$00,$00 ; C5D8 AC AD 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C5E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C5E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$16,$17 ; C5F0 00 00 00 00 73 74 16 17  ....st..
        .byte   $18,$19,$6A,$6B,$00,$00,$00,$00 ; C5F8 18 19 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C600 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C608 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A0,$A1 ; C610 00 00 00 00 73 74 A0 A1  ....st..
        .byte   $A2,$A3,$6A,$6B,$00,$00,$00,$00 ; C618 A2 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C620 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C628 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C630 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C638 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C640 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C648 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$1F ; C650 00 00 00 00 73 74 1A 1F  ....st..
        .byte   $AE,$AF,$6A,$6B,$00,$00,$00,$00 ; C658 AE AF 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C660 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C668 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$B0 ; C670 00 00 00 00 73 74 A8 B0  ....st..
        .byte   $B1,$A3,$6A,$6B,$00,$00,$00,$00 ; C678 B1 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C680 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C688 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$B2 ; C690 00 00 00 00 73 74 A4 B2  ....st..
        .byte   $B3,$A7,$6A,$6B,$00,$00,$00,$00 ; C698 B3 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C6A0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C6A8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$B4 ; C6B0 00 00 00 00 73 74 1A B4  ....st..
        .byte   $B5,$AF,$6A,$6B,$00,$00,$00,$00 ; C6B8 B5 AF 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C6C0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C6C8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$B6 ; C6D0 00 00 00 00 73 74 A8 B6  ....st..
        .byte   $B7,$A3,$6A,$6B,$00,$00,$00,$00 ; C6D8 B7 A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C6E0 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C6E8 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$A5 ; C6F0 00 00 00 00 73 74 A4 A5  ....st..
        .byte   $A6,$A7,$6A,$6B,$00,$00,$00,$00 ; C6F8 A6 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C700 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C708 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$1A,$B8 ; C710 00 00 00 00 73 74 1A B8  ....st..
        .byte   $B9,$BA,$6A,$6B,$00,$00,$00,$00 ; C718 B9 BA 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C720 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C728 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A8,$BB ; C730 00 00 00 00 73 74 A8 BB  ....st..
        .byte   $BC,$A3,$6A,$6B,$00,$00,$00,$00 ; C738 BC A3 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C740 00 00 00 00 00 00 73 74  ......st
        .byte   $6A,$6B,$00,$00,$00,$00,$00,$00 ; C748 6A 6B 00 00 00 00 00 00  jk......
        .byte   $00,$00,$00,$00,$73,$74,$A4,$C4 ; C750 00 00 00 00 73 74 A4 C4  ....st..
        .byte   $C5,$A7,$6A,$6B,$00,$00,$00,$00 ; C758 C5 A7 6A 6B 00 00 00 00  ..jk....
        .byte   $00,$00,$00,$00,$00,$00,$73,$74 ; C760 00 00 00 00 00 00 73 74  ......st
        .byte   $87,$88,$89,$89,$89,$89,$89,$89 ; C768 87 88 89 89 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$8A,$CB,$CC,$CC ; C770 89 89 89 89 8A CB CC CC  ........
        .byte   $CC,$CC,$CD,$88,$89,$89,$89,$89 ; C778 CC CC CD 88 89 89 89 89  ........
        .byte   $89,$89,$89,$89,$89,$89,$8A,$8B ; C780 89 89 89 89 89 89 8A 8B  ........
        .byte   $8C,$8D,$8E,$8E,$8E,$8E,$8E,$8E ; C788 8C 8D 8E 8E 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8F,$CE,$CF,$CF ; C790 8E 8E 8E 8E 8F CE CF CF  ........
        .byte   $CF,$CF,$D0,$8D,$8E,$8E,$8E,$8E ; C798 CF CF D0 8D 8E 8E 8E 8E  ........
        .byte   $8E,$8E,$8E,$8E,$8E,$8E,$8F,$90 ; C7A0 8E 8E 8E 8E 8E 8E 8F 90  ........
        .byte   $16,$17,$18,$19,$1A,$1B,$1C,$19 ; C7A8 16 17 18 19 1A 1B 1C 19  ........
        .byte   $16,$17,$18,$19,$1A,$1F,$AE,$AF ; C7B0 16 17 18 19 1A 1F AE AF  ........
        .byte   $1A,$B4,$B5,$AF,$1A,$B8,$B9,$BA ; C7B8 1A B4 B5 AF 1A B8 B9 BA  ........
        .byte   $A0,$A1,$A2,$A3,$A8,$A9,$AA,$A3 ; C7C0 A0 A1 A2 A3 A8 A9 AA A3  ........
        .byte   $A0,$A1,$A2,$A3,$A8,$B0,$B1,$A3 ; C7C8 A0 A1 A2 A3 A8 B0 B1 A3  ........
        .byte   $A8,$B6,$B7,$A3,$A8,$BB,$BC,$A3 ; C7D0 A8 B6 B7 A3 A8 BB BC A3  ........
        .byte   $A4,$A5,$A6,$A7,$A4,$AB,$AC,$AD ; C7D8 A4 A5 A6 A7 A4 AB AC AD  ........
        .byte   $A4,$A5,$A6,$A7,$A4,$B2,$B3,$A7 ; C7E0 A4 A5 A6 A7 A4 B2 B3 A7  ........
        .byte   $A4,$A5,$A6,$A7,$A4,$C4,$C5,$A7 ; C7E8 A4 A5 A6 A7 A4 C4 C5 A7  ........
        .byte   $10,$11,$D2,$D3,$D4,$D5,$D6,$12 ; C7F0 10 11 D2 D3 D4 D5 D6 12  ........
        .byte   $13,$14,$D7,$D8,$D9,$DA,$DB,$15 ; C7F8 13 14 D7 D8 D9 DA DB 15  ........
        .byte   $29,$2A,$2A,$2A,$2A,$2B,$2C,$47 ; C800 29 2A 2A 2A 2A 2B 2C 47  )****+,G
        .byte   $41,$4D,$45,$2F,$2C,$4F,$56,$45 ; C808 41 4D 45 2F 2C 4F 56 45  AME/,OVE
        .byte   $52,$2F,$3A,$3B,$3B,$3B,$3B,$3C ; C810 52 2F 3A 3B 3B 3B 3B 3C  R/:;;;;<
        .byte   $DC,$DD,$DE,$DF,$E0,$E1,$E1,$E2 ; C818 DC DD DE DF E0 E1 E1 E2  ........
        .byte   $E3,$E4,$E5,$E6,$E7,$E8,$E9,$E9 ; C820 E3 E4 E5 E6 E7 E8 E9 E9  ........
        .byte   $EA,$EB,$EC,$ED,$00,$00,$00,$00 ; C828 EA EB EC ED 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C830 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$00,$00,$00,$00 ; C838 9D 9D 9D 9D 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$9D,$9D,$9D,$9D ; C840 00 00 00 00 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C848 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$00,$00,$00,$00 ; C850 9D 9D 9D 9D 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$9D,$9D,$9D,$9D ; C858 00 00 00 00 9D 9D 9D 9D  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C860 00 00 00 00 00 00 00 00  ........
        .byte   $9D,$9D,$9D,$9D,$00,$00,$00,$00 ; C868 9D 9D 9D 9D 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$16,$17,$18,$19 ; C870 00 00 00 00 16 17 18 19  ........
        .byte   $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7 ; C878 A0 A1 A2 A3 A4 A5 A6 A7  ........
        .byte   $1A,$1B,$1C,$19,$A8,$A9,$AA,$A3 ; C880 1A 1B 1C 19 A8 A9 AA A3  ........
        .byte   $A4,$AB,$AC,$AD,$16,$17,$18,$19 ; C888 A4 AB AC AD 16 17 18 19  ........
        .byte   $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7 ; C890 A0 A1 A2 A3 A4 A5 A6 A7  ........
        .byte   $1A,$1F,$AE,$AF,$A8,$B0,$B1,$A3 ; C898 1A 1F AE AF A8 B0 B1 A3  ........
        .byte   $A4,$B2,$B3,$A7,$1A,$B4,$B5,$AF ; C8A0 A4 B2 B3 A7 1A B4 B5 AF  ........
        .byte   $A8,$B6,$B7,$A3,$A4,$A5,$A6,$A7 ; C8A8 A8 B6 B7 A3 A4 A5 A6 A7  ........
        .byte   $1A,$B8,$B9,$BA,$A8,$BB,$BC,$A3 ; C8B0 1A B8 B9 BA A8 BB BC A3  ........
        .byte   $A4,$C4,$C5,$A7,$05,$06,$07,$08 ; C8B8 A4 C4 C5 A7 05 06 07 08  ........
        .byte   $09,$0A,$0B,$0C,$0D,$0E,$0F,$10 ; C8C0 09 0A 0B 0C 0D 0E 0F 10  ........
        .byte   $11,$12,$0B,$13,$14,$15,$16,$17 ; C8C8 11 12 0B 13 14 15 16 17  ........
        .byte   $18,$19,$1A,$0C,$0D,$0E,$1B,$1C ; C8D0 18 19 1A 0C 0D 0E 1B 1C  ........
        .byte   $1D,$1E,$1F,$20,$1D,$1E,$21,$20 ; C8D8 1D 1E 1F 20 1D 1E 21 20  ... ..! 
        .byte   $1D,$1E,$22,$23,$24,$25,$26,$27 ; C8E0 1D 1E 22 23 24 25 26 27  .."#$%&'
        .byte   $28,$29,$26,$27,$2A,$0A,$26,$27 ; C8E8 28 29 26 27 2A 0A 26 27  ()&'*.&'
        .byte   $2B,$0A,$2C,$27,$2D,$2E,$2F,$30 ; C8F0 2B 0A 2C 27 2D 2E 2F 30  +.,'-./0
        .byte   $31,$32,$33,$34,$35,$36,$37,$38 ; C8F8 31 32 33 34 35 36 37 38  12345678
        .byte   $39,$3A,$3B,$3C,$3D,$3E,$3F,$40 ; C900 39 3A 3B 3C 3D 3E 3F 40  9:;<=>?@
        .byte   $41,$42,$43,$44,$45,$46,$43,$44 ; C908 41 42 43 44 45 46 43 44  ABCDEFCD
        .byte   $47,$48,$49,$4A,$4B,$4C,$4D,$4E ; C910 47 48 49 4A 4B 4C 4D 4E  GHIJKLMN
        .byte   $4F,$50,$51,$52,$3D,$32,$53,$34 ; C918 4F 50 51 52 3D 32 53 34  OPQR=2S4
        .byte   $54,$55,$43,$44,$3D,$32,$3F,$56 ; C920 54 55 43 44 3D 32 3F 56  TUCD=2?V
        .byte   $57,$58,$59,$5A,$05,$06,$5B,$5C ; C928 57 58 59 5A 05 06 5B 5C  WXYZ..[\
        .byte   $5D,$5E,$5F,$60,$61,$62,$63,$64 ; C930 5D 5E 5F 60 61 62 63 64  ]^_`abcd
        .byte   $65,$66,$67,$68,$69,$6A,$6B,$6C ; C938 65 66 67 68 69 6A 6B 6C  efghijkl
        .byte   $66,$6D,$6E,$6F,$70,$71,$72,$73 ; C940 66 6D 6E 6F 70 71 72 73  fmnopqrs
        .byte   $65,$66,$74,$75,$66,$76,$66,$77 ; C948 65 66 74 75 66 76 66 77  eftufvfw
        .byte   $66,$66,$66,$78,$79,$7A,$66,$7B ; C950 66 66 66 78 79 7A 66 7B  fffxyzf{
        .byte   $7C,$7D,$66,$66,$7E,$7F,$80,$81 ; C958 7C 7D 66 66 7E 7F 80 81  |}ff~...
        .byte   $82,$83,$84,$85,$7E,$3A,$86,$87 ; C960 82 83 84 85 7E 3A 86 87  ....~:..
        .byte   $88,$89,$8A,$8B,$8C,$8D,$8E,$8F ; C968 88 89 8A 8B 8C 8D 8E 8F  ........
        .byte   $90,$91,$92,$93,$90,$91,$92,$94 ; C970 90 91 92 93 90 91 92 94  ........
        .byte   $90,$91,$95,$93,$8C,$8D,$96,$97 ; C978 90 91 95 93 8C 8D 96 97  ........
        .byte   $98,$99,$9A,$9B,$9C,$0A,$9D,$27 ; C980 98 99 9A 9B 9C 0A 9D 27  .......'
        .byte   $9E,$0A,$26,$27,$9F,$0A,$26,$27 ; C988 9E 0A 26 27 9F 0A 26 27  ..&'..&'
        .byte   $A0,$0A,$A1,$A2,$A3,$66,$A4,$A5 ; C990 A0 0A A1 A2 A3 66 A4 A5  .....f..
        .byte   $A6,$A7,$A8,$A9,$AA,$66,$AB,$AC ; C998 A6 A7 A8 A9 AA 66 AB AC  .....f..
        .byte   $AD,$AE,$AF,$66,$B0,$B1,$B2,$B3 ; C9A0 AD AE AF 66 B0 B1 B2 B3  ...f....
        .byte   $B4,$B5,$B6,$B7,$9C,$06,$B8,$08 ; C9A8 B4 B5 B6 B7 9C 06 B8 08  ........
        .byte   $B9,$BA,$BB,$BC,$BD,$BE,$BF,$C0 ; C9B0 B9 BA BB BC BD BE BF C0  ........
        .byte   $C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8 ; C9B8 C1 C2 C3 C4 C5 C6 C7 C8  ........
        .byte   $C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0 ; C9C0 C9 CA CB CC CD CE CF D0  ........
        .byte   $D1,$D2,$D3,$66,$D4,$D5,$D6,$D7 ; C9C8 D1 D2 D3 66 D4 D5 D6 D7  ...f....
        .byte   $D4,$D8,$D9,$DA,$D4,$DB,$DC,$DD ; C9D0 D4 D8 D9 DA D4 DB DC DD  ........
        .byte   $D1,$D2,$DE,$DF,$D1,$E0,$E1,$E2 ; C9D8 D1 D2 DE DF D1 E0 E1 E2  ........
        .byte   $D1,$E0,$E3,$E4,$E5,$E6,$E7,$E8 ; C9E0 D1 E0 E3 E4 E5 E6 E7 E8  ........
        .byte   $E9,$66,$EA,$EB,$EC,$66,$ED,$EE ; C9E8 E9 66 EA EB EC 66 ED EE  .f...f..
        .byte   $EF,$F0,$F1,$F2,$66,$F3,$F4,$F5 ; C9F0 EF F0 F1 F2 66 F3 F4 F5  ....f...
        .byte   $66,$F6,$F7,$F8,$F9,$FA,$FB,$FC ; C9F8 66 F6 F7 F8 F9 FA FB FC  f.......
possibleTitleScreenNametable:
        .byte   $00,$01,$02,$03,$02,$03,$02,$03 ; CA00 00 01 02 03 02 03 02 03  ........
        .byte   $02,$03,$02,$03,$00,$01,$02,$03 ; CA08 02 03 02 03 00 01 02 03  ........
        .byte   $02,$03,$00,$01,$02,$03,$02,$03 ; CA10 02 03 00 01 02 03 02 03  ........
        .byte   $02,$03,$02,$03,$02,$03,$00,$01 ; CA18 02 03 02 03 02 03 00 01  ........
        .byte   $04,$05,$06,$07,$06,$07,$06,$07 ; CA20 04 05 06 07 06 07 06 07  ........
        .byte   $06,$07,$06,$07,$04,$05,$06,$07 ; CA28 06 07 06 07 04 05 06 07  ........
        .byte   $06,$07,$04,$05,$06,$07,$06,$07 ; CA30 06 07 04 05 06 07 06 07  ........
        .byte   $06,$07,$06,$07,$06,$07,$04,$05 ; CA38 06 07 06 07 06 07 04 05  ........
        .byte   $08,$09,$0A,$0B,$0C,$0C,$0C,$0C ; CA40 08 09 0A 0B 0C 0C 0C 0C  ........
        .byte   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C ; CA48 0C 0C 0C 0C 0C 0C 0C 0C  ........
        .byte   $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C ; CA50 0C 0C 0C 0C 0C 0C 0C 0C  ........
        .byte   $0C,$0C,$0C,$0C,$0D,$0E,$0F,$10 ; CA58 0C 0C 0C 0C 0D 0E 0F 10  ........
        .byte   $11,$12,$13,$14,$15,$15,$15,$15 ; CA60 11 12 13 14 15 15 15 15  ........
        .byte   $15,$15,$15,$15,$15,$15,$15,$15 ; CA68 15 15 15 15 15 15 15 15  ........
        .byte   $15,$15,$15,$15,$15,$15,$15,$15 ; CA70 15 15 15 15 15 15 15 15  ........
        .byte   $15,$15,$15,$15,$16,$17,$18,$19 ; CA78 15 15 15 15 16 17 18 19  ........
        .byte   $08,$1A,$1B,$1C,$1D,$1D,$1D,$1D ; CA80 08 1A 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1E,$1F,$20,$21,$22,$23 ; CA88 1D 1D 1E 1F 20 21 22 23  .... !"#
        .byte   $24,$25,$20,$21,$22,$23,$1D,$1D ; CA90 24 25 20 21 22 23 1D 1D  $% !"#..
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CA98 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$12,$1B,$1C,$1D,$1D,$1D,$1D ; CAA0 11 12 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$28,$29,$2A,$2B,$2C,$2D ; CAA8 1D 1D 28 29 2A 2B 2C 2D  ..()*+,-
        .byte   $2E,$2F,$2A,$2B,$2C,$2D,$1D,$1D ; CAB0 2E 2F 2A 2B 2C 2D 1D 1D  ./*+,-..
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CAB8 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $08,$1A,$1B,$1C,$1D,$1D,$1D,$1D ; CAC0 08 1A 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$30,$31,$32,$33 ; CAC8 1D 1D 1D 1D 30 31 32 33  ....0123
        .byte   $32,$34,$35,$33,$1D,$1D,$1D,$1D ; CAD0 32 34 35 33 1D 1D 1D 1D  2453....
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CAD8 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$36,$1B,$1C,$1D,$1D,$37,$38 ; CAE0 11 36 1B 1C 1D 1D 37 38  .6....78
        .byte   $39,$1D,$3A,$3B,$3C,$3D,$39,$37 ; CAE8 39 1D 3A 3B 3C 3D 39 37  9.:;<=97
        .byte   $1D,$3E,$3D,$3F,$40,$1D,$41,$42 ; CAF0 1D 3E 3D 3F 40 1D 41 42  .>=?@.AB
        .byte   $3E,$39,$1D,$1D,$26,$27,$18,$19 ; CAF8 3E 39 1D 1D 26 27 18 19  >9..&'..
        .byte   $08,$1A,$1B,$1C,$1D,$1D,$1D,$1D ; CB00 08 1A 1B 1C 1D 1D 1D 1D  ........
        .byte   $43,$44,$45,$46,$47,$48,$43,$44 ; CB08 43 44 45 46 47 48 43 44  CDEFGHCD
        .byte   $45,$49,$4A,$4B,$4C,$4D,$4E,$4F ; CB10 45 49 4A 4B 4C 4D 4E 4F  EIJKLMNO
        .byte   $4D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CB18 4D 1D 1D 1D 26 27 0F 10  M...&'..
        .byte   $11,$36,$1B,$1C,$1D,$1D,$1D,$1D ; CB20 11 36 1B 1C 1D 1D 1D 1D  .6......
        .byte   $50,$51,$52,$53,$54,$55,$50,$51 ; CB28 50 51 52 53 54 55 50 51  PQRSTUPQ
        .byte   $56,$57,$58,$59,$5A,$5B,$5C,$5D ; CB30 56 57 58 59 5A 5B 5C 5D  VWXYZ[\]
        .byte   $5E,$1D,$1D,$1D,$26,$27,$18,$19 ; CB38 5E 1D 1D 1D 26 27 18 19  ^...&'..
        .byte   $00,$01,$1B,$1C,$1D,$1D,$1D,$1D ; CB40 00 01 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$5F,$1D,$60,$61,$62,$1D,$5F ; CB48 1D 5F 1D 60 61 62 1D 5F  ._.`ab._
        .byte   $1D,$63,$64,$65,$66,$67,$68,$69 ; CB50 1D 63 64 65 66 67 68 69  .cdefghi
        .byte   $6A,$6B,$6C,$1D,$26,$27,$00,$01 ; CB58 6A 6B 6C 1D 26 27 00 01  jkl.&'..
        .byte   $04,$05,$1B,$1C,$1D,$1D,$1D,$1D ; CB60 04 05 1B 1C 1D 1D 1D 1D  ........
        .byte   $6D,$6E,$6F,$70,$71,$72,$6D,$6E ; CB68 6D 6E 6F 70 71 72 6D 6E  mnopqrmn
        .byte   $73,$74,$75,$76,$77,$78,$71,$79 ; CB70 73 74 75 76 77 78 71 79  stuvwxqy
        .byte   $1D,$7A,$7B,$1D,$26,$27,$04,$05 ; CB78 1D 7A 7B 1D 26 27 04 05  .z{.&'..
        .byte   $08,$1A,$1B,$1C,$1D,$1D,$1D,$1D ; CB80 08 1A 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D ; CB88 1D 1D 1D 1D 1D 1D 1D 1D  ........
        .byte   $7C,$1D,$1D,$1D,$1D,$1D,$1D,$1D ; CB90 7C 1D 1D 1D 1D 1D 1D 1D  |.......
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CB98 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$36,$1B,$1C,$1D,$1D,$1D,$1D ; CBA0 11 36 1B 1C 1D 1D 1D 1D  .6......
        .byte   $1D,$1D,$1D,$1D,$1D,$1D,$1D,$7D ; CBA8 1D 1D 1D 1D 1D 1D 1D 7D  .......}
        .byte   $7E,$1D,$1D,$1D,$1D,$1D,$1D,$1D ; CBB0 7E 1D 1D 1D 1D 1D 1D 1D  ~.......
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CBB8 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $00,$01,$1B,$1C,$1D,$1D,$1D,$1D ; CBC0 00 01 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D ; CBC8 1D 1D 1D 1D 1D 1D 1D 1D  ........
        .byte   $7F,$1D,$1D,$1D,$1D,$1D,$1D,$1D ; CBD0 7F 1D 1D 1D 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$00,$01 ; CBD8 1D 1D 1D 1D 26 27 00 01  ....&'..
        .byte   $04,$05,$1B,$1C,$1D,$1D,$1D,$1D ; CBE0 04 05 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$1D,$80,$1D,$81 ; CBE8 1D 1D 1D 1D 1D 80 1D 81  ........
        .byte   $82,$83,$1D,$84,$1D,$80,$1D,$1D ; CBF0 82 83 1D 84 1D 80 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$04,$05 ; CBF8 1D 1D 1D 1D 26 27 04 05  ....&'..
        .byte   $08,$1A,$1B,$1C,$1D,$1D,$1D,$1D ; CC00 08 1A 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$1D,$85,$1D,$86 ; CC08 1D 1D 1D 1D 1D 85 1D 86  ........
        .byte   $87,$88,$1D,$89,$1D,$85,$1D,$1D ; CC10 87 88 1D 89 1D 85 1D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CC18 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$36,$1B,$1C,$1D,$1D,$1D,$1D ; CC20 11 36 1B 1C 1D 1D 1D 1D  .6......
        .byte   $1D,$1D,$8A,$1D,$8B,$8C,$8D,$8E ; CC28 1D 1D 8A 1D 8B 8C 8D 8E  ........
        .byte   $8F,$90,$1D,$91,$8B,$8C,$8D,$1D ; CC30 8F 90 1D 91 8B 8C 8D 1D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CC38 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $00,$01,$1B,$1C,$1D,$1D,$1D,$1D ; CC40 00 01 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$92,$1D,$93,$94,$95,$96 ; CC48 1D 1D 92 1D 93 94 95 96  ........
        .byte   $97,$98,$99,$9A,$9B,$94,$95,$9C ; CC50 97 98 99 9A 9B 94 95 9C  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$00,$01 ; CC58 1D 1D 1D 1D 26 27 00 01  ....&'..
        .byte   $04,$05,$1B,$1C,$1D,$1D,$1D,$1D ; CC60 04 05 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$9D,$9E,$9C,$9F,$A0,$A1,$A2 ; CC68 1D 9D 9E 9C 9F A0 A1 A2  ........
        .byte   $A3,$A4,$A5,$A6,$A7,$A0,$A8,$A9 ; CC70 A3 A4 A5 A6 A7 A0 A8 A9  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$04,$05 ; CC78 1D 1D 1D 1D 26 27 04 05  ....&'..
        .byte   $08,$09,$1B,$1C,$1D,$1D,$1D,$1D ; CC80 08 09 1B 1C 1D 1D 1D 1D  ........
        .byte   $8B,$AA,$AB,$AC,$AD,$AE,$AF,$B0 ; CC88 8B AA AB AC AD AE AF B0  ........
        .byte   $B1,$B2,$B3,$B4,$B5,$AE,$AF,$1D ; CC90 B1 B2 B3 B4 B5 AE AF 1D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CC98 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$12,$1B,$1C,$1D,$1D,$1D,$1D ; CCA0 11 12 1B 1C 1D 1D 1D 1D  ........
        .byte   $B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD ; CCA8 B6 B7 B8 B9 BA BB BC BD  ........
        .byte   $BE,$BF,$C0,$C1,$C2,$BB,$BC,$8D ; CCB0 BE BF C0 C1 C2 BB BC 8D  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CCB8 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $08,$09,$1B,$1C,$1D,$1D,$1D,$1D ; CCC0 08 09 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$C3,$C4,$C5,$C6,$C7,$C8,$C9 ; CCC8 1D C3 C4 C5 C6 C7 C8 C9  ........
        .byte   $CA,$CB,$CC,$CD,$CE,$C7,$CF,$D0 ; CCD0 CA CB CC CD CE C7 CF D0  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$0F,$10 ; CCD8 1D 1D 1D 1D 26 27 0F 10  ....&'..
        .byte   $11,$12,$1B,$1C,$1D,$1D,$1D,$1D ; CCE0 11 12 1B 1C 1D 1D 1D 1D  ........
        .byte   $D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8 ; CCE8 D1 D2 D3 D4 D5 D6 D7 D8  ........
        .byte   $D9,$DA,$DB,$DC,$DD,$D6,$D7,$DE ; CCF0 D9 DA DB DC DD D6 D7 DE  ........
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CCF8 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $08,$09,$1B,$1C,$DF,$E0,$E1,$E2 ; CD00 08 09 1B 1C DF E0 E1 E2  ........
        .byte   $E3,$1D,$42,$E4,$42,$40,$39,$3E ; CD08 E3 1D 42 E4 42 40 39 3E  ..B.B@9>
        .byte   $E5,$3A,$3B,$E6,$37,$E7,$39,$E8 ; CD10 E5 3A 3B E6 37 E7 39 E8  .:;.7.9.
        .byte   $3B,$E9,$41,$EA,$26,$27,$0F,$10 ; CD18 3B E9 41 EA 26 27 0F 10  ;.A.&'..
        .byte   $11,$12,$1B,$1C,$1D,$1D,$1D,$1D ; CD20 11 12 1B 1C 1D 1D 1D 1D  ........
        .byte   $1D,$1D,$DF,$E0,$E1,$E2,$E2,$1D ; CD28 1D 1D DF E0 E1 E2 E2 1D  ........
        .byte   $37,$39,$3F,$41,$39,$3F,$1D,$1D ; CD30 37 39 3F 41 39 3F 1D 1D  79?A9?..
        .byte   $1D,$1D,$1D,$1D,$26,$27,$18,$19 ; CD38 1D 1D 1D 1D 26 27 18 19  ....&'..
        .byte   $08,$09,$EB,$EC,$ED,$ED,$ED,$ED ; CD40 08 09 EB EC ED ED ED ED  ........
        .byte   $ED,$ED,$ED,$ED,$ED,$ED,$ED,$ED ; CD48 ED ED ED ED ED ED ED ED  ........
        .byte   $ED,$ED,$ED,$ED,$ED,$ED,$ED,$ED ; CD50 ED ED ED ED ED ED ED ED  ........
        .byte   $ED,$ED,$ED,$ED,$EE,$EF,$0F,$10 ; CD58 ED ED ED ED EE EF 0F 10  ........
        .byte   $11,$12,$F0,$F1,$F2,$F2,$F2,$F2 ; CD60 11 12 F0 F1 F2 F2 F2 F2  ........
        .byte   $F2,$F2,$F2,$F2,$F2,$F2,$F2,$F2 ; CD68 F2 F2 F2 F2 F2 F2 F2 F2  ........
        .byte   $F2,$F2,$F2,$F2,$F2,$F2,$F2,$F2 ; CD70 F2 F2 F2 F2 F2 F2 F2 F2  ........
        .byte   $F2,$F2,$F2,$F2,$F3,$F4,$18,$19 ; CD78 F2 F2 F2 F2 F3 F4 18 19  ........
        .byte   $00,$01,$F5,$F6,$F5,$F6,$F5,$F6 ; CD80 00 01 F5 F6 F5 F6 F5 F6  ........
        .byte   $F5,$F6,$F5,$F7,$00,$01,$F8,$F6 ; CD88 F5 F6 F5 F7 00 01 F8 F6  ........
        .byte   $F5,$F7,$00,$01,$F8,$F6,$F5,$F6 ; CD90 F5 F7 00 01 F8 F6 F5 F6  ........
        .byte   $F5,$F6,$F5,$F6,$F5,$F6,$00,$01 ; CD98 F5 F6 F5 F6 F5 F6 00 01  ........
        .byte   $04,$05,$F9,$FA,$F9,$FA,$F9,$FA ; CDA0 04 05 F9 FA F9 FA F9 FA  ........
        .byte   $F9,$FA,$F9,$FA,$04,$05,$F9,$FA ; CDA8 F9 FA F9 FA 04 05 F9 FA  ........
        .byte   $F9,$FA,$04,$05,$F9,$FA,$F9,$FA ; CDB0 F9 FA 04 05 F9 FA F9 FA  ........
        .byte   $F9,$FA,$F9,$FA,$F9,$FA,$04,$05 ; CDB8 F9 FA F9 FA F9 FA 04 05  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDC0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDC8 00 00 00 00 00 00 00 00  ........
        .byte   $91,$92,$00,$00,$00,$00,$00,$93 ; CDD0 91 92 00 00 00 00 00 93  ........
        .byte   $94,$95,$00,$00,$00,$00,$00,$96 ; CDD8 94 95 00 00 00 00 00 96  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDE0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDE8 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDF0 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CDF8 00 00 00 00 00 00 00 00  ........
dataPastPossibleTitle:
        .byte   $00,$97,$98,$99,$00,$00,$00,$00 ; CE00 00 97 98 99 00 00 00 00  ........
        .byte   $9A,$9B,$9C,$00,$00,$00,$00,$9D ; CE08 9A 9B 9C 00 00 00 00 9D  ........
        .byte   $9E,$9F,$00,$00,$00,$00,$00,$00 ; CE10 9E 9F 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; CE18 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$A0,$00,$00 ; CE20 00 00 00 00 00 A0 00 00  ........
        .byte   $00,$00,$A1,$A2,$A3,$A4,$A5,$00 ; CE28 00 00 A1 A2 A3 A4 A5 00  ........
        .byte   $00,$A6,$A7,$A8,$A9,$AA,$00,$AB ; CE30 00 A6 A7 A8 A9 AA 00 AB  ........
        .byte   $AC,$AD,$AE,$AF,$B0,$00,$00,$B1 ; CE38 AC AD AE AF B0 00 00 B1  ........
        .byte   $B2,$B3,$B4,$B5,$00,$00,$B6,$B7 ; CE40 B2 B3 B4 B5 00 00 B6 B7  ........
        .byte   $B8,$B9,$BA,$00,$00,$00,$00,$BB ; CE48 B8 B9 BA 00 00 00 00 BB  ........
        .byte   $00,$00,$00,$00,$BC,$BD,$BE,$BF ; CE50 00 00 00 00 BC BD BE BF  ........
        .byte   $C0,$00,$00,$C1,$C2,$C3,$C4,$C5 ; CE58 C0 00 00 C1 C2 C3 C4 C5  ........
        .byte   $C6,$C7,$C8,$C9,$14,$CA,$CB,$CC ; CE60 C6 C7 C8 C9 14 CA CB CC  ........
        .byte   $CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4 ; CE68 CD CE CF D0 D1 D2 D3 D4  ........
        .byte   $D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC ; CE70 D5 D6 D7 D8 D9 DA DB DC  ........
        .byte   $DD,$DE,$DF,$E0,$E1,$00,$E2,$E3 ; CE78 DD DE DF E0 E1 00 E2 E3  ........
        .byte   $E4,$E5,$E6,$00,$00,$E7,$E8,$E9 ; CE80 E4 E5 E6 00 00 E7 E8 E9  ........
        .byte   $EA,$EB,$00,$00,$EC,$00,$00,$00 ; CE88 EA EB 00 00 EC 00 00 00  ........
        .byte   $ED,$EE,$EF,$00,$00,$00,$00,$00 ; CE90 ED EE EF 00 00 00 00 00  ........
        .byte   $F0,$F1,$00,$00,$00,$00,$00,$F2 ; CE98 F0 F1 00 00 00 00 00 F2  ........
        .byte   $F3,$00,$00,$00,$00,$00,$F4,$F5 ; CEA0 F3 00 00 00 00 00 F4 F5  ........
        .byte   $F6,$00,$00,$00,$F7,$F8,$00,$F9 ; CEA8 F6 00 00 00 F7 F8 00 F9  ........
        .byte   $FA,$FB,$FC,$FD,$00,$00,$17,$15 ; CEB0 FA FB FC FD 00 00 17 15  ........
        .byte   $14,$15,$16,$00,$16,$14,$14,$15 ; CEB8 14 15 16 00 16 14 14 15  ........
        .byte   $14,$14,$17,$15,$14,$15,$16,$14 ; CEC0 14 14 17 15 14 15 16 14  ........
        .byte   $14,$15,$14,$14,$14,$16,$16,$15 ; CEC8 14 15 14 14 14 16 16 15  ........
        .byte   $14,$14,$15,$14,$14,$15,$14,$15 ; CED0 14 14 15 14 14 15 14 15  ........
        .byte   $15,$14,$16,$14,$15,$14,$16,$00 ; CED8 15 14 16 14 15 14 16 00  ........
        .byte   $17,$15,$15,$14,$17,$00,$00,$14 ; CEE0 17 15 15 14 17 00 00 14  ........
        .byte   $16,$15,$16,$17,$00,$17,$15,$15 ; CEE8 16 15 16 17 00 17 15 15  ........
        .byte   $16,$15,$15,$14,$16,$15,$16,$17 ; CEF0 16 15 15 14 16 15 16 17  ........
        .byte   $15,$15,$16,$15,$15,$15,$17,$17 ; CEF8 15 15 16 15 15 15 17 17  ........
        .byte   $16,$15,$15,$16,$15,$15,$16,$15 ; CF00 16 15 15 16 15 15 16 15  ........
        .byte   $16,$16,$15,$17,$15,$16,$15,$17 ; CF08 16 16 15 17 15 16 15 17  ........
        .byte   $00,$14,$16,$16,$15,$14,$00,$00 ; CF10 00 14 16 16 15 14 00 00  ........
        .byte   $15,$17,$16,$17,$14,$00,$14,$16 ; CF18 15 17 16 17 14 00 14 16  ........
        .byte   $16,$17,$16,$16,$15,$17,$16,$17 ; CF20 16 17 16 16 15 17 16 17  ........
        .byte   $14,$15,$16,$17,$16,$15,$15,$14 ; CF28 14 15 16 17 16 15 15 14  ........
        .byte   $14,$17,$16,$16,$17,$16,$15,$17 ; CF30 14 17 16 16 17 16 15 17  ........
        .byte   $16,$17,$17,$16,$14,$16,$17,$16 ; CF38 16 17 17 16 14 16 17 16  ........
        .byte   $14,$00,$15,$17,$17,$16,$15,$00 ; CF40 14 00 15 17 17 16 15 00  ........
        .byte   $00,$16,$14,$17,$14,$15,$00,$15 ; CF48 00 16 14 17 14 15 00 15  ........
        .byte   $16,$17,$14,$17,$17,$16,$14,$17 ; CF50 16 17 14 17 17 16 14 17  ........
        .byte   $14,$15,$16,$17,$14,$17,$16,$16 ; CF58 14 15 16 17 14 17 16 16  ........
        .byte   $15,$15,$14,$17,$17,$14,$17,$16 ; CF60 15 15 14 17 17 14 17 16  ........
        .byte   $14,$17,$14,$14,$17,$14,$17,$14 ; CF68 14 17 14 14 17 14 17 14  ........
        .byte   $17,$15,$00,$16,$14,$14,$17,$16 ; CF70 17 15 00 16 14 14 17 16  ........
        .byte   $00                             ; CF78 00                       .
; ----------------------------------------------------------------------------
LCF79:
        jsr     LD2C9                           ; CF79 20 C9 D2                  ..
        lda     #$0D                            ; CF7C A9 0D                    ..
        sta     $03F6                           ; CF7E 8D F6 03                 ...
        lda     #$00                            ; CF81 A9 00                    ..
        sta     $FA                             ; CF83 85 FA                    ..
        sta     $0208                           ; CF85 8D 08 02                 ...
        sta     $0209                           ; CF88 8D 09 02                 ...
        ldx     #$0E                            ; CF8B A2 0E                    ..
LCF8D:
        sta     $03DC,x                         ; CF8D 9D DC 03                 ...
        dex                                     ; CF90 CA                       .
        bpl     LCF8D                           ; CF91 10 FA                    ..
        ldx     #$0A                            ; CF93 A2 0A                    ..
LCF95:
        sta     $0292,x                         ; CF95 9D 92 02                 ...
        sta     $022F,x                         ; CF98 9D 2F 02                 ./.
        sta     $023A,x                         ; CF9B 9D 3A 02                 .:.
        sta     $0245,x                         ; CF9E 9D 45 02                 .E.
        sta     $0250,x                         ; CFA1 9D 50 02                 .P.
        sta     $029D,x                         ; CFA4 9D 9D 02                 ...
        dex                                     ; CFA7 CA                       .
        bpl     LCF95                           ; CFA8 10 EB                    ..
        sta     $03EF                           ; CFAA 8D EF 03                 ...
        sta     SND_CHN                         ; CFAD 8D 15 40                 ..@
        rts                                     ; CFB0 60                       `

; ----------------------------------------------------------------------------
possibleSetSoundOrMusic:
        ldy     $0209                           ; CFB1 AC 09 02                 ...
        iny                                     ; CFB4 C8                       .
        cpy     #$08                            ; CFB5 C0 08                    ..
        bcc     LCFBB                           ; CFB7 90 02                    ..
        ldy     #$00                            ; CFB9 A0 00                    ..
LCFBB:
        sty     $0209                           ; CFBB 8C 09 02                 ...
        cpy     $0208                           ; CFBE CC 08 02                 ...
        bne     LCFC6                           ; CFC1 D0 03                    ..
        lda     #$FF                            ; CFC3 A9 FF                    ..
        rts                                     ; CFC5 60                       `

; ----------------------------------------------------------------------------
LCFC6:
        sta     $0200,y                         ; CFC6 99 00 02                 ...
        rts                                     ; CFC9 60                       `

; ----------------------------------------------------------------------------
LCFCA:
        inc     $F3                             ; CFCA E6 F3                    ..
        ldx     $0208                           ; CFCC AE 08 02                 ...
        cpx     $0209                           ; CFCF EC 09 02                 ...
        beq     LCFE4                           ; CFD2 F0 10                    ..
        inx                                     ; CFD4 E8                       .
        cpx     #$08                            ; CFD5 E0 08                    ..
        bcc     LCFDB                           ; CFD7 90 02                    ..
        ldx     #$00                            ; CFD9 A2 00                    ..
LCFDB:
        stx     $0208                           ; CFDB 8E 08 02                 ...
        ldy     $0200,x                         ; CFDE BC 00 02                 ...
        jsr     LCFF7                           ; CFE1 20 F7 CF                  ..
LCFE4:
        ldx     #$00                            ; CFE4 A2 00                    ..
        jsr     setupMusicTrack                 ; CFE6 20 46 D8                  F.
        inx                                     ; CFE9 E8                       .
        jsr     setupMusicTrack                 ; CFEA 20 46 D8                  F.
        inx                                     ; CFED E8                       .
        jsr     setupMusicTrack                 ; CFEE 20 46 D8                  F.
        inx                                     ; CFF1 E8                       .
        jsr     setupMusicTrack                 ; CFF2 20 46 D8                  F.
        inx                                     ; CFF5 E8                       .
        rts                                     ; CFF6 60                       `

; ----------------------------------------------------------------------------
LCFF7:
        cpy     #$1A                            ; CFF7 C0 1A                    ..
        bcs     LD00F                           ; CFF9 B0 14                    ..
        lda     LDE9C,y                         ; CFFB B9 9C DE                 ...
        cmp     #$0F                            ; CFFE C9 0F                    ..
        bcs     LD00F                           ; D000 B0 0D                    ..
        asl     a                               ; D002 0A                       .
        tax                                     ; D003 AA                       .
        lda     possibleJumpTable+1,x           ; D004 BD 11 D0                 ...
        pha                                     ; D007 48                       H
        lda     possibleJumpTable,x             ; D008 BD 10 D0                 ...
        pha                                     ; D00B 48                       H
        lda     LDEB6,y                         ; D00C B9 B6 DE                 ...
LD00F:
        rts                                     ; D00F 60                       `

; ----------------------------------------------------------------------------
possibleJumpTable:
        .byte   $2D,$D0,$32,$D0,$33,$D0,$34,$D0 ; D010 2D D0 32 D0 33 D0 34 D0  -.2.3.4.
        .byte   $3F,$D0,$57,$D0,$78,$D0,$C7,$D2 ; D018 3F D0 57 D0 78 D0 C7 D2  ?.W.x...
        .byte   $E3,$D0,$9C,$D0,$9C,$D0,$9C,$D0 ; D020 E3 D0 9C D0 9C D0 9C D0  ........
        .byte   $C7,$D2,$9C,$D0,$C7,$D2         ; D028 C7 D2 9C D0 C7 D2        ......
; ----------------------------------------------------------------------------
        asl     a                               ; D02E 0A                       .
        asl     a                               ; D02F 0A                       .
        sta     $FA                             ; D030 85 FA                    ..
        rts                                     ; D032 60                       `

; ----------------------------------------------------------------------------
        .byte   $60,$60,$0A,$A8,$B9,$D1,$DE,$48 ; D033 60 60 0A A8 B9 D1 DE 48  ``.....H
        .byte   $B9,$D0,$DE,$48,$60             ; D03B B9 D0 DE 48 60           ...H`
; ----------------------------------------------------------------------------
        sta     $020B                           ; D040 8D 0B 02                 ...
        ldy     #$0A                            ; D043 A0 0A                    ..
LD045:
        lda     $0292,y                         ; D045 B9 92 02                 ...
        lsr     a                               ; D048 4A                       J
        lsr     a                               ; D049 4A                       J
        eor     $020B                           ; D04A 4D 0B 02                 M..
        bne     LD054                           ; D04D D0 05                    ..
        lda     #$FF                            ; D04F A9 FF                    ..
        sta     $020E,y                         ; D051 99 0E 02                 ...
LD054:
        dey                                     ; D054 88                       .
        bpl     LD045                           ; D055 10 EE                    ..
        rts                                     ; D057 60                       `

; ----------------------------------------------------------------------------
        tay                                     ; D058 A8                       .
        lda     LDE9C,y                         ; D059 B9 9C DE                 ...
        cmp     #$08                            ; D05C C9 08                    ..
        bne     LD078                           ; D05E D0 18                    ..
        lda     LDEB6,y                         ; D060 B9 B6 DE                 ...
        sta     $020B                           ; D063 8D 0B 02                 ...
        ldy     #$0A                            ; D066 A0 0A                    ..
LD068:
        cmp     $020E,y                         ; D068 D9 0E 02                 ...
        bne     LD075                           ; D06B D0 08                    ..
        lda     #$FF                            ; D06D A9 FF                    ..
        sta     $020E,y                         ; D06F 99 0E 02                 ...
        lda     $020B                           ; D072 AD 0B 02                 ...
LD075:
        dey                                     ; D075 88                       .
        bpl     LD068                           ; D076 10 F0                    ..
LD078:
        rts                                     ; D078 60                       `

; ----------------------------------------------------------------------------
        sta     $020B                           ; D079 8D 0B 02                 ...
        lsr     a                               ; D07C 4A                       J
        lsr     a                               ; D07D 4A                       J
        lsr     a                               ; D07E 4A                       J
        lsr     a                               ; D07F 4A                       J
        tay                                     ; D080 A8                       .
        lda     $020B                           ; D081 AD 0B 02                 ...
        and     #$0F                            ; D084 29 0F                    ).
        clc                                     ; D086 18                       .
        adc     LDD2E,y                         ; D087 79 2E DD                 y..
        tay                                     ; D08A A8                       .
        lda     $03DC,y                         ; D08B B9 DC 03                 ...
        beq     LD09C                           ; D08E F0 0C                    ..
LD090:
        tay                                     ; D090 A8                       .
        dey                                     ; D091 88                       .
        lda     #$FF                            ; D092 A9 FF                    ..
        sta     $020E,y                         ; D094 99 0E 02                 ...
        lda     $03DC,y                         ; D097 B9 DC 03                 ...
        bne     LD090                           ; D09A D0 F4                    ..
LD09C:
        rts                                     ; D09C 60                       `

; ----------------------------------------------------------------------------
        tax                                     ; D09D AA                       .
        lda     LE02F,x                         ; D09E BD 2F E0                 ./.
        cmp     #$29                            ; D0A1 C9 29                    .)
        bcs     LD0E3                           ; D0A3 B0 3E                    .>
        cmp     #$08                            ; D0A5 C9 08                    ..
        bcc     LD0BD                           ; D0A7 90 14                    ..
        cmp     #$0A                            ; D0A9 C9 0A                    ..
        bcc     LD0E3                           ; D0AB 90 36                    .6
        cmp     #$0D                            ; D0AD C9 0D                    ..
        bcc     LD0BD                           ; D0AF 90 0C                    ..
        cmp     #$12                            ; D0B1 C9 12                    ..
        bcc     LD0E3                           ; D0B3 90 2E                    ..
        cmp     #$16                            ; D0B5 C9 16                    ..
        bcc     LD0BD                           ; D0B7 90 04                    ..
        cmp     #$19                            ; D0B9 C9 19                    ..
        bcc     LD0E3                           ; D0BB 90 26                    .&
LD0BD:
        asl     a                               ; D0BD 0A                       .
        tay                                     ; D0BE A8                       .
        lda     LE032,x                         ; D0BF BD 32 E0                 .2.
        clc                                     ; D0C2 18                       .
        adc     #$0B                            ; D0C3 69 0B                    i.
        pha                                     ; D0C5 48                       H
        lda     LE030,x                         ; D0C6 BD 30 E0                 .0.
        sta     $03F5                           ; D0C9 8D F5 03                 ...
        lda     LE031,x                         ; D0CC BD 31 E0                 .1.
        tax                                     ; D0CF AA                       .
        lda     LDE9C,x                         ; D0D0 BD 9C DE                 ...
        cmp     #$08                            ; D0D3 C9 08                    ..
        bne     LD0E2                           ; D0D5 D0 0B                    ..
        lda     LDEB6,x                         ; D0D7 BD B6 DE                 ...
        sta     $03F4                           ; D0DA 8D F4 03                 ...
        pla                                     ; D0DD 68                       h
        tax                                     ; D0DE AA                       .
        jmp     LD91E                           ; D0DF 4C 1E D9                 L..

; ----------------------------------------------------------------------------
LD0E2:
        pla                                     ; D0E2 68                       h
LD0E3:
        rts                                     ; D0E3 60                       `

; ----------------------------------------------------------------------------
        sta     $020B                           ; D0E4 8D 0B 02                 ...
        tay                                     ; D0E7 A8                       .
        asl     a                               ; D0E8 0A                       .
        tax                                     ; D0E9 AA                       .
        bcs     LD0F1                           ; D0EA B0 05                    ..
        lda     LDED4,x                         ; D0EC BD D4 DE                 ...
        bcc     LD0F4                           ; D0EF 90 03                    ..
LD0F1:
        .byte   $BD,$D4,$DF                     ; D0F1 BD D4 DF                 ...
; ----------------------------------------------------------------------------
LD0F4:
        sta     $EF                             ; D0F4 85 EF                    ..
        bcs     LD0FD                           ; D0F6 B0 05                    ..
        lda     LDED5,x                         ; D0F8 BD D5 DE                 ...
        bcc     LD100                           ; D0FB 90 03                    ..
LD0FD:
        .byte   $BD,$D5,$DF                     ; D0FD BD D5 DF                 ...
; ----------------------------------------------------------------------------
LD100:
        sta     $F0                             ; D100 85 F0                    ..
        lda     LDEFE,y                         ; D102 B9 FE DE                 ...
        bne     LD11D                           ; D105 D0 16                    ..
        lda     $020B                           ; D107 AD 0B 02                 ...
        ldy     #$0A                            ; D10A A0 0A                    ..
LD10C:
        cmp     $020E,y                         ; D10C D9 0E 02                 ...
        bne     LD11A                           ; D10F D0 09                    ..
        lda     $0292,y                         ; D111 B9 92 02                 ...
        beq     LD117                           ; D114 F0 01                    ..
        .byte   $60                             ; D116 60                       `
; ----------------------------------------------------------------------------
LD117:
        lda     $020B                           ; D117 AD 0B 02                 ...
LD11A:
        dey                                     ; D11A 88                       .
        bpl     LD10C                           ; D11B 10 EF                    ..
LD11D:
        ldy     #$0A                            ; D11D A0 0A                    ..
LD11F:
        sty     $020D                           ; D11F 8C 0D 02                 ...
        lda     $0292,y                         ; D122 B9 92 02                 ...
        beq     LD1A6                           ; D125 F0 7F                    ..
        dey                                     ; D127 88                       .
        bpl     LD11F                           ; D128 10 F5                    ..
        ldy     #$00                            ; D12A A0 00                    ..
        lda     #$13                            ; D12C A9 13                    ..
        clc                                     ; D12E 18                       .
        adc     $EF                             ; D12F 65 EF                    e.
        sta     $F1                             ; D131 85 F1                    ..
        lda     #$DF                            ; D133 A9 DF                    ..
        adc     $F0                             ; D135 65 F0                    e.
        sta     $F2                             ; D137 85 F2                    ..
        lda     ($F1),y                         ; D139 B1 F1                    ..
        sta     $020C                           ; D13B 8D 0C 02                 ...
        lda     #$42                            ; D13E A9 42                    .B
        clc                                     ; D140 18                       .
        adc     $EF                             ; D141 65 EF                    e.
        sta     $F1                             ; D143 85 F1                    ..
        lda     #$DF                            ; D145 A9 DF                    ..
        adc     $F0                             ; D147 65 F0                    e.
        sta     $F2                             ; D149 85 F2                    ..
        lda     ($F1),y                         ; D14B B1 F1                    ..
        clc                                     ; D14D 18                       .
        adc     #$0B                            ; D14E 69 0B                    i.
        tax                                     ; D150 AA                       .
        ldy     $03DC,x                         ; D151 BC DC 03                 ...
        beq     LD198                           ; D154 F0 42                    .B
        dey                                     ; D156 88                       .
        lda     $020C                           ; D157 AD 0C 02                 ...
        asl     a                               ; D15A 0A                       .
        sec                                     ; D15B 38                       8
        rol     a                               ; D15C 2A                       *
        cmp     $0292,y                         ; D15D D9 92 02                 ...
        bcc     LD198                           ; D160 90 36                    .6
        stx     $020C                           ; D162 8E 0C 02                 ...
        sty     $020D                           ; D165 8C 0D 02                 ...
        lda     $020E,y                         ; D168 B9 0E 02                 ...
        asl     a                               ; D16B 0A                       .
        tax                                     ; D16C AA                       .
        bcs     LD174                           ; D16D B0 05                    ..
        lda     LDED4,x                         ; D16F BD D4 DE                 ...
        bcc     LD177                           ; D172 90 03                    ..
LD174:
        lda     LDFD4,x                         ; D174 BD D4 DF                 ...
LD177:
        sta     $F4                             ; D177 85 F4                    ..
        bcs     LD180                           ; D179 B0 05                    ..
        lda     LDED5,x                         ; D17B BD D5 DE                 ...
        bcc     LD183                           ; D17E 90 03                    ..
LD180:
        lda     LDFD5,x                         ; D180 BD D5 DF                 ...
LD183:
        sta     $F5                             ; D183 85 F5                    ..
        ldy     #$00                            ; D185 A0 00                    ..
        lda     #$13                            ; D187 A9 13                    ..
        clc                                     ; D189 18                       .
        adc     $F4                             ; D18A 65 F4                    e.
        sta     $F1                             ; D18C 85 F1                    ..
        lda     #$DF                            ; D18E A9 DF                    ..
        adc     $F5                             ; D190 65 F5                    e.
        sta     $F2                             ; D192 85 F2                    ..
        lda     ($F1),y                         ; D194 B1 F1                    ..
        bpl     LD19A                           ; D196 10 02                    ..
LD198:
        sec                                     ; D198 38                       8
        rts                                     ; D199 60                       `

; ----------------------------------------------------------------------------
LD19A:
        ldx     $020C                           ; D19A AE 0C 02                 ...
        ldy     $020D                           ; D19D AC 0D 02                 ...
        lda     $03DC,y                         ; D1A0 B9 DC 03                 ...
        sta     $03DC,x                         ; D1A3 9D DC 03                 ...
LD1A6:
        ldx     $020D                           ; D1A6 AE 0D 02                 ...
        lda     #$07                            ; D1A9 A9 07                    ..
        sta     $029D,x                         ; D1AB 9D 9D 02                 ...
        lda     #$40                            ; D1AE A9 40                    .@
        sta     $0342,x                         ; D1B0 9D 42 03                 .B.
        lda     #$B0                            ; D1B3 A9 B0                    ..
        sta     $036E,x                         ; D1B5 9D 6E 03                 .n.
        lda     #$00                            ; D1B8 A9 00                    ..
        sta     $0379,x                         ; D1BA 9D 79 03                 .y.
        sta     $03DC,x                         ; D1BD 9D DC 03                 ...
        sta     $034D,x                         ; D1C0 9D 4D 03                 .M.
        sta     $025B,x                         ; D1C3 9D 5B 02                 .[.
        sta     $0266,x                         ; D1C6 9D 66 02                 .f.
        sta     $0384,x                         ; D1C9 9D 84 03                 ...
        sta     $03BB,x                         ; D1CC 9D BB 03                 ...
        sta     $038F,x                         ; D1CF 9D 8F 03                 ...
        sta     $039A,x                         ; D1D2 9D 9A 03                 ...
        sta     $03A5,x                         ; D1D5 9D A5 03                 ...
        sta     $03B0,x                         ; D1D8 9D B0 03                 ...
        sta     $0271,x                         ; D1DB 9D 71 02                 .q.
        sta     $027C,x                         ; D1DE 9D 7C 02                 .|.
        sta     $0287,x                         ; D1E1 9D 87 02                 ...
        sta     $03C6,x                         ; D1E4 9D C6 03                 ...
        sta     $03D1,x                         ; D1E7 9D D1 03                 ...
        sta     $0363,x                         ; D1EA 9D 63 03                 .c.
        sta     $0358,x                         ; D1ED 9D 58 03                 .X.
        sta     $030B,x                         ; D1F0 9D 0B 03                 ...
        sta     $0337,x                         ; D1F3 9D 37 03                 .7.
        sta     $02C9,x                         ; D1F6 9D C9 02                 ...
        sta     $02DF,x                         ; D1F9 9D DF 02                 ...
        sta     $02A8,x                         ; D1FC 9D A8 02                 ...
        lda     #$32                            ; D1FF A9 32                    .2
        sta     $02B3,x                         ; D201 9D B3 02                 ...
        sta     $02F5,x                         ; D204 9D F5 02                 ...
        lda     #$DD                            ; D207 A9 DD                    ..
        sta     $02BE,x                         ; D209 9D BE 02                 ...
        sta     $0300,x                         ; D20C 9D 00 03                 ...
        ldy     #$00                            ; D20F A0 00                    ..
        lda     #$13                            ; D211 A9 13                    ..
        clc                                     ; D213 18                       .
        adc     $EF                             ; D214 65 EF                    e.
        sta     $F1                             ; D216 85 F1                    ..
        lda     #$DF                            ; D218 A9 DF                    ..
        adc     $F0                             ; D21A 65 F0                    e.
        sta     $F2                             ; D21C 85 F2                    ..
        lda     ($F1),y                         ; D21E B1 F1                    ..
        asl     a                               ; D220 0A                       .
        sec                                     ; D221 38                       8
        rol     a                               ; D222 2A                       *
        sta     $0292,x                         ; D223 9D 92 02                 ...
        lda     #$42                            ; D226 A9 42                    .B
        clc                                     ; D228 18                       .
        adc     $EF                             ; D229 65 EF                    e.
        sta     $F1                             ; D22B 85 F1                    ..
        lda     #$DF                            ; D22D A9 DF                    ..
        adc     $F0                             ; D22F 65 F0                    e.
        sta     $F2                             ; D231 85 F2                    ..
        lda     ($F1),y                         ; D233 B1 F1                    ..
        clc                                     ; D235 18                       .
        adc     #$0B                            ; D236 69 0B                    i.
        sta     $020C                           ; D238 8D 0C 02                 ...
        lda     $EF                             ; D23B A5 EF                    ..
        asl     a                               ; D23D 0A                       .
        sta     $F1                             ; D23E 85 F1                    ..
        lda     $F0                             ; D240 A5 F0                    ..
        rol     a                               ; D242 2A                       *
        sta     $F2                             ; D243 85 F2                    ..
        lda     #$71                            ; D245 A9 71                    .q
        clc                                     ; D247 18                       .
        adc     $F1                             ; D248 65 F1                    e.
        sta     $F1                             ; D24A 85 F1                    ..
        lda     #$DF                            ; D24C A9 DF                    ..
        adc     $F2                             ; D24E 65 F2                    e.
        sta     $F2                             ; D250 85 F2                    ..
        lda     ($F1),y                         ; D252 B1 F1                    ..
        sta     $0219,x                         ; D254 9D 19 02                 ...
        iny                                     ; D257 C8                       .
        lda     ($F1),y                         ; D258 B1 F1                    ..
        sta     $0224,x                         ; D25A 9D 24 02                 .$.
        ldy     $020C                           ; D25D AC 0C 02                 ...
        php                                     ; D260 08                       .
        sei                                     ; D261 78                       x
LD262:
        sty     $020C                           ; D262 8C 0C 02                 ...
        lda     $03DC,y                         ; D265 B9 DC 03                 ...
        beq     LD293                           ; D268 F0 29                    .)
        tay                                     ; D26A A8                       .
        dey                                     ; D26B 88                       .
        lda     $0292,y                         ; D26C B9 92 02                 ...
        ora     #$01                            ; D26F 09 01                    ..
        cmp     $0292,x                         ; D271 DD 92 02                 ...
        bcc     LD262                           ; D274 90 EC                    ..
        beq     LD27C                           ; D276 F0 04                    ..
        iny                                     ; D278 C8                       .
        tya                                     ; D279 98                       .
        bcs     LD28D                           ; D27A B0 11                    ..
LD27C:
        txa                                     ; D27C 8A                       .
        pha                                     ; D27D 48                       H
        tya                                     ; D27E 98                       .
        tax                                     ; D27F AA                       .
        jsr     LD328                           ; D280 20 28 D3                  (.
        pla                                     ; D283 68                       h
        tax                                     ; D284 AA                       .
        lda     #$00                            ; D285 A9 00                    ..
        sta     $0292,y                         ; D287 99 92 02                 ...
        lda     $03DC,y                         ; D28A B9 DC 03                 ...
LD28D:
        sta     $03DC,x                         ; D28D 9D DC 03                 ...
        ldy     $020C                           ; D290 AC 0C 02                 ...
LD293:
        lda     $020B                           ; D293 AD 0B 02                 ...
        sta     $020E,x                         ; D296 9D 0E 02                 ...
        inx                                     ; D299 E8                       .
        txa                                     ; D29A 8A                       .
        sta     $03DC,y                         ; D29B 99 DC 03                 ...
        plp                                     ; D29E 28                       (
        ldy     #$00                            ; D29F A0 00                    ..
        lda     $EF                             ; D2A1 A5 EF                    ..
        asl     a                               ; D2A3 0A                       .
        sta     $F1                             ; D2A4 85 F1                    ..
        lda     $F0                             ; D2A6 A5 F0                    ..
        rol     a                               ; D2A8 2A                       *
        sta     $F2                             ; D2A9 85 F2                    ..
        lda     #$CF                            ; D2AB A9 CF                    ..
        clc                                     ; D2AD 18                       .
        adc     $F1                             ; D2AE 65 F1                    e.
        sta     $F1                             ; D2B0 85 F1                    ..
        lda     #$DF                            ; D2B2 A9 DF                    ..
        adc     $F2                             ; D2B4 65 F2                    e.
        sta     $F2                             ; D2B6 85 F2                    ..
        lda     ($F1),y                         ; D2B8 B1 F1                    ..
        sta     $EF                             ; D2BA 85 EF                    ..
        iny                                     ; D2BC C8                       .
        ora     ($F1),y                         ; D2BD 11 F1                    ..
        beq     LD2C8                           ; D2BF F0 07                    ..
        lda     ($F1),y                         ; D2C1 B1 F1                    ..
        sta     $F0                             ; D2C3 85 F0                    ..
        jmp     LD11D                           ; D2C5 4C 1D D1                 L..

; ----------------------------------------------------------------------------
LD2C8:
        rts                                     ; D2C8 60                       `

; ----------------------------------------------------------------------------
LD2C9:
        lda     #$01                            ; D2C9 A9 01                    ..
        sta     $FB                             ; D2CB 85 FB                    ..
        jsr     LD306                           ; D2CD 20 06 D3                  ..
        lda     #$02                            ; D2D0 A9 02                    ..
LD2D2:
        sta     ($FC),y                         ; D2D2 91 FC                    ..
        tax                                     ; D2D4 AA                       .
        inx                                     ; D2D5 E8                       .
        lda     $FC                             ; D2D6 A5 FC                    ..
        clc                                     ; D2D8 18                       .
        adc     #$04                            ; D2D9 69 04                    i.
        sta     $FC                             ; D2DB 85 FC                    ..
        bcc     LD2E1                           ; D2DD 90 02                    ..
        inc     $FD                             ; D2DF E6 FD                    ..
LD2E1:
        txa                                     ; D2E1 8A                       .
        cmp     #$08                            ; D2E2 C9 08                    ..
        bcc     LD2D2                           ; D2E4 90 EC                    ..
        dec     $FD                             ; D2E6 C6 FD                    ..
        lda     $FC                             ; D2E8 A5 FC                    ..
        sec                                     ; D2EA 38                       8
        sbc     #$04                            ; D2EB E9 04                    ..
        sta     $FC                             ; D2ED 85 FC                    ..
        lda     #$00                            ; D2EF A9 00                    ..
        sta     ($FC),y                         ; D2F1 91 FC                    ..
        rts                                     ; D2F3 60                       `

; ----------------------------------------------------------------------------
LD2F4:
        lda     $FB                             ; D2F4 A5 FB                    ..
        jsr     LD306                           ; D2F6 20 06 D3                  ..
        pha                                     ; D2F9 48                       H
        lda     ($FC),y                         ; D2FA B1 FC                    ..
        beq     LD302                           ; D2FC F0 04                    ..
        sta     $FB                             ; D2FE 85 FB                    ..
        pla                                     ; D300 68                       h
        rts                                     ; D301 60                       `

; ----------------------------------------------------------------------------
LD302:
        .byte   $68,$A9,$00,$60                 ; D302 68 A9 00 60              h..`
; ----------------------------------------------------------------------------
LD306:
        pha                                     ; D306 48                       H
        tay                                     ; D307 A8                       .
        dey                                     ; D308 88                       .
        sty     $FC                             ; D309 84 FC                    ..
        sty     $EF                             ; D30B 84 EF                    ..
        ldy     #$00                            ; D30D A0 00                    ..
        sty     $FD                             ; D30F 84 FD                    ..
        asl     $FC                             ; D311 06 FC                    ..
        rol     $FD                             ; D313 26 FD                    &.
        asl     $FC                             ; D315 06 FC                    ..
        rol     $FD                             ; D317 26 FD                    &.
        lda     #$F7                            ; D319 A9 F7                    ..
        clc                                     ; D31B 18                       .
        adc     $FC                             ; D31C 65 FC                    e.
        sta     $FC                             ; D31E 85 FC                    ..
        lda     #$03                            ; D320 A9 03                    ..
        adc     $FD                             ; D322 65 FD                    e.
        sta     $FD                             ; D324 85 FD                    ..
        pla                                     ; D326 68                       h
        rts                                     ; D327 60                       `

; ----------------------------------------------------------------------------
LD328:
        tya                                     ; D328 98                       .
        pha                                     ; D329 48                       H
LD32A:
        lda     $03B0,x                         ; D32A BD B0 03                 ...
        beq     LD342                           ; D32D F0 13                    ..
        jsr     LD306                           ; D32F 20 06 D3                  ..
        pha                                     ; D332 48                       H
        lda     ($FC),y                         ; D333 B1 FC                    ..
        sta     $03B0,x                         ; D335 9D B0 03                 ...
        lda     $FB                             ; D338 A5 FB                    ..
        sta     ($FC),y                         ; D33A 91 FC                    ..
        pla                                     ; D33C 68                       h
        sta     $FB                             ; D33D 85 FB                    ..
        jmp     LD32A                           ; D33F 4C 2A D3                 L*.

; ----------------------------------------------------------------------------
LD342:
        lda     $03A5,x                         ; D342 BD A5 03                 ...
        beq     LD35A                           ; D345 F0 13                    ..
        .byte   $20,$06,$D3,$48,$B1,$FC,$9D,$A5 ; D347 20 06 D3 48 B1 FC 9D A5   ..H....
        .byte   $03,$A5,$FB,$91,$FC,$68,$85,$FB ; D34F 03 A5 FB 91 FC 68 85 FB  .....h..
        .byte   $4C,$42,$D3                     ; D357 4C 42 D3                 LB.
; ----------------------------------------------------------------------------
LD35A:
        pla                                     ; D35A 68                       h
        tay                                     ; D35B A8                       .
        rts                                     ; D35C 60                       `

; ----------------------------------------------------------------------------
LD35D:
        lda     $03DC,x                         ; D35D BD DC 03                 ...
        beq     LD364                           ; D360 F0 02                    ..
        lda     #$FF                            ; D362 A9 FF                    ..
LD364:
        sta     $FE                             ; D364 85 FE                    ..
        lda     $0292,x                         ; D366 BD 92 02                 ...
        beq     LD372                           ; D369 F0 07                    ..
        ldy     $020E,x                         ; D36B BC 0E 02                 ...
        iny                                     ; D36E C8                       .
        bne     LD375                           ; D36F D0 04                    ..
        tya                                     ; D371 98                       .
LD372:
        jmp     LD4AE                           ; D372 4C AE D4                 L..

; ----------------------------------------------------------------------------
LD375:
        sta     $03F0                           ; D375 8D F0 03                 ...
        and     #$01                            ; D378 29 01                    ).
        sta     $03F1                           ; D37A 8D F1 03                 ...
        lda     $0219,x                         ; D37D BD 19 02                 ...
        sta     $F4                             ; D380 85 F4                    ..
        lda     $0224,x                         ; D382 BD 24 02                 .$.
        sta     $F5                             ; D385 85 F5                    ..
        lda     $0287,x                         ; D387 BD 87 02                 ...
        cmp     #$FF                            ; D38A C9 FF                    ..
        bne     LD397                           ; D38C D0 09                    ..
        lda     #$00                            ; D38E A9 00                    ..
        sta     $0287,x                         ; D390 9D 87 02                 ...
        lda     #$01                            ; D393 A9 01                    ..
        bne     LD399                           ; D395 D0 02                    ..
LD397:
        lda     #$00                            ; D397 A9 00                    ..
LD399:
        sta     $FF                             ; D399 85 FF                    ..
        lda     $025B,x                         ; D39B BD 5B 02                 .[.
        sec                                     ; D39E 38                       8
        sbc     $0342,x                         ; D39F FD 42 03                 .B.
        sta     $025B,x                         ; D3A2 9D 5B 02                 .[.
        bcs     LD3AA                           ; D3A5 B0 03                    ..
        dec     $0266,x                         ; D3A7 DE 66 02                 .f.
LD3AA:
        lda     $0266,x                         ; D3AA BD 66 02                 .f.
        bpl     LD3B2                           ; D3AD 10 03                    ..
        jmp     LD3D3                           ; D3AF 4C D3 D3                 L..

; ----------------------------------------------------------------------------
LD3B2:
        lda     $0271,x                         ; D3B2 BD 71 02                 .q.
        sec                                     ; D3B5 38                       8
        sbc     $0342,x                         ; D3B6 FD 42 03                 .B.
        sta     $0271,x                         ; D3B9 9D 71 02                 .q.
        bcs     LD3D0                           ; D3BC B0 12                    ..
        dec     $027C,x                         ; D3BE DE 7C 02                 .|.
        bpl     LD3D0                           ; D3C1 10 0D                    ..
        lda     #$7F                            ; D3C3 A9 7F                    ..
        sta     $027C,x                         ; D3C5 9D 7C 02                 .|.
        lda     $03F1                           ; D3C8 AD F1 03                 ...
        beq     LD3D0                           ; D3CB F0 03                    ..
        jmp     LD829                           ; D3CD 4C 29 D8                 L).

; ----------------------------------------------------------------------------
LD3D0:
        jmp     LD60F                           ; D3D0 4C 0F D6                 L..

; ----------------------------------------------------------------------------
LD3D3:
        lda     $0219,x                         ; D3D3 BD 19 02                 ...
        clc                                     ; D3D6 18                       .
        adc     #$02                            ; D3D7 69 02                    i.
        sta     $0219,x                         ; D3D9 9D 19 02                 ...
        bcc     LD3E1                           ; D3DC 90 03                    ..
        inc     $0224,x                         ; D3DE FE 24 02                 .$.
LD3E1:
        ldy     #$00                            ; D3E1 A0 00                    ..
        lda     ($F4),y                         ; D3E3 B1 F4                    ..
        bpl     LD400                           ; D3E5 10 19                    ..
        jsr     LD8EE                           ; D3E7 20 EE D8                  ..
        bcc     LD3F8                           ; D3EA 90 0C                    ..
        lda     $0224,x                         ; D3EC BD 24 02                 .$.
        sta     $F5                             ; D3EF 85 F5                    ..
        lda     $0219,x                         ; D3F1 BD 19 02                 ...
        sta     $F4                             ; D3F4 85 F4                    ..
        bcs     LD3D3                           ; D3F6 B0 DB                    ..
LD3F8:
        .byte   $A9,$00,$8D,$F0,$03,$4C,$38,$D8 ; D3F8 A9 00 8D F0 03 4C 38 D8  .....L8.
; ----------------------------------------------------------------------------
LD400:
        ldy     $03F1                           ; D400 AC F1 03                 ...
        beq     LD409                           ; D403 F0 04                    ..
        cmp     #$00                            ; D405 C9 00                    ..
        beq     LD417                           ; D407 F0 0E                    ..
LD409:
        clc                                     ; D409 18                       .
        adc     $034D,x                         ; D40A 7D 4D 03                 }M.
        ldy     $03F3                           ; D40D AC F3 03                 ...
        cpy     #$01                            ; D410 C0 01                    ..
        bne     LD417                           ; D412 D0 03                    ..
        clc                                     ; D414 18                       .
        adc     #$0C                            ; D415 69 0C                    i.
LD417:
        ldy     $03F1                           ; D417 AC F1 03                 ...
        bne     LD445                           ; D41A D0 29                    .)
        pha                                     ; D41C 48                       H
        sec                                     ; D41D 38                       8
        sbc     $022F,x                         ; D41E FD 2F 02                 ./.
        sta     $038F,x                         ; D421 9D 8F 03                 ...
        asl     a                               ; D424 0A                       .
        lda     #$FF                            ; D425 A9 FF                    ..
        bcs     LD42B                           ; D427 B0 02                    ..
        lda     #$00                            ; D429 A9 00                    ..
LD42B:
        sta     $039A,x                         ; D42B 9D 9A 03                 ...
        lda     $FE                             ; D42E A5 FE                    ..
        bne     LD438                           ; D430 D0 06                    ..
        lda     $FF                             ; D432 A5 FF                    ..
        ora     #$01                            ; D434 09 01                    ..
        sta     $FF                             ; D436 85 FF                    ..
LD438:
        pla                                     ; D438 68                       h
        sta     $022F,x                         ; D439 9D 2F 02                 ./.
        lda     $034D,x                         ; D43C BD 4D 03                 .M.
        sta     $023A,x                         ; D43F 9D 3A 02                 .:.
        jmp     LD479                           ; D442 4C 79 D4                 Ly.

; ----------------------------------------------------------------------------
LD445:
        asl     a                               ; D445 0A                       .
        tay                                     ; D446 A8                       .
        sec                                     ; D447 38                       8
        lda     $022F,x                         ; D448 BD 2F 02                 ./.
        sbc     LDD36,y                         ; D44B F9 36 DD                 .6.
        sta     $038F,x                         ; D44E 9D 8F 03                 ...
        lda     $023A,x                         ; D451 BD 3A 02                 .:.
        sbc     LDD37,y                         ; D454 F9 37 DD                 .7.
        sta     $039A,x                         ; D457 9D 9A 03                 ...
        cpy     #$00                            ; D45A C0 00                    ..
        beq     LD46D                           ; D45C F0 0F                    ..
        lda     $0287,x                         ; D45E BD 87 02                 ...
        bmi     LD46D                           ; D461 30 0A                    0.
        lda     $FE                             ; D463 A5 FE                    ..
        bne     LD46D                           ; D465 D0 06                    ..
        lda     $FF                             ; D467 A5 FF                    ..
        ora     #$01                            ; D469 09 01                    ..
        sta     $FF                             ; D46B 85 FF                    ..
LD46D:
        lda     LDD36,y                         ; D46D B9 36 DD                 .6.
        sta     $022F,x                         ; D470 9D 2F 02                 ./.
        lda     LDD37,y                         ; D473 B9 37 DD                 .7.
        sta     $023A,x                         ; D476 9D 3A 02                 .:.
LD479:
        ldy     #$01                            ; D479 A0 01                    ..
        lda     #$00                            ; D47B A9 00                    ..
        sta     $F8                             ; D47D 85 F8                    ..
        lda     ($F4),y                         ; D47F B1 F4                    ..
        beq     LD486                           ; D481 F0 03                    ..
        jmp     LD4E1                           ; D483 4C E1 D4                 L..

; ----------------------------------------------------------------------------
LD486:
        lda     $03A5,x                         ; D486 BD A5 03                 ...
        beq     LD4AE                           ; D489 F0 23                    .#
        .byte   $48,$20,$06,$D3,$B1,$FC,$9D,$A5 ; D48B 48 20 06 D3 B1 FC 9D A5  H ......
        .byte   $03,$A5,$FB,$91,$FC,$68,$85,$FB ; D493 03 A5 FB 91 FC 68 85 FB  .....h..
        .byte   $C8,$B1,$FC,$9D,$19,$02,$85,$F4 ; D49B C8 B1 FC 9D 19 02 85 F4  ........
        .byte   $C8,$B1,$FC,$9D,$24,$02,$85,$F5 ; D4A3 C8 B1 FC 9D 24 02 85 F5  ....$...
        .byte   $4C,$D3,$D3                     ; D4AB 4C D3 D3                 L..
; ----------------------------------------------------------------------------
LD4AE:
        sta     $0292,x                         ; D4AE 9D 92 02                 ...
        sta     $029D,x                         ; D4B1 9D 9D 02                 ...
        sta     $0287,x                         ; D4B4 9D 87 02                 ...
        lda     $FE                             ; D4B7 A5 FE                    ..
        bne     LD4C2                           ; D4B9 D0 07                    ..
        sta     $03EC                           ; D4BB 8D EC 03                 ...
        lda     #$02                            ; D4BE A9 02                    ..
        sta     $FF                             ; D4C0 85 FF                    ..
LD4C2:
        jsr     LD328                           ; D4C2 20 28 D3                  (.
        lda     $03DC,x                         ; D4C5 BD DC 03                 ...
        ldx     $03F2                           ; D4C8 AE F2 03                 ...
        sta     $03DC,x                         ; D4CB 9D DC 03                 ...
        cmp     #$00                            ; D4CE C9 00                    ..
        beq     LD4D7                           ; D4D0 F0 05                    ..
        tax                                     ; D4D2 AA                       .
        dex                                     ; D4D3 CA                       .
        jmp     LD35D                           ; D4D4 4C 5D D3                 L].

; ----------------------------------------------------------------------------
LD4D7:
        cpx     #$0B                            ; D4D7 E0 0B                    ..
        bcs     LD4E0                           ; D4D9 B0 05                    ..
        lda     #$FF                            ; D4DB A9 FF                    ..
        sta     $0287,x                         ; D4DD 9D 87 02                 ...
LD4E0:
        rts                                     ; D4E0 60                       `

; ----------------------------------------------------------------------------
LD4E1:
        pha                                     ; D4E1 48                       H
        lda     $0292,x                         ; D4E2 BD 92 02                 ...
        and     #$02                            ; D4E5 29 02                    ).
        bne     LD4F1                           ; D4E7 D0 08                    ..
        lda     $03F1                           ; D4E9 AD F1 03                 ...
        bne     LD4F1                           ; D4EC D0 03                    ..
        jmp     LD587                           ; D4EE 4C 87 D5                 L..

; ----------------------------------------------------------------------------
LD4F1:
        pla                                     ; D4F1 68                       h
        sta     $F8                             ; D4F2 85 F8                    ..
        and     #$0F                            ; D4F4 29 0F                    ).
        asl     a                               ; D4F6 0A                       .
        tay                                     ; D4F7 A8                       .
        lda     LDDFC,y                         ; D4F8 B9 FC DD                 ...
        clc                                     ; D4FB 18                       .
        adc     $025B,x                         ; D4FC 7D 5B 02                 }[.
        sta     $025B,x                         ; D4FF 9D 5B 02                 .[.
        lda     LDDFD,y                         ; D502 B9 FD DD                 ...
        adc     $0266,x                         ; D505 7D 66 02                 }f.
        sta     $0266,x                         ; D508 9D 66 02                 .f.
        lda     $F8                             ; D50B A5 F8                    ..
        and     #$40                            ; D50D 29 40                    )@
        beq     LD528                           ; D50F F0 17                    ..
        lda     LDDFD,y                         ; D511 B9 FD DD                 ...
        lsr     a                               ; D514 4A                       J
        pha                                     ; D515 48                       H
        lda     LDDFC,y                         ; D516 B9 FC DD                 ...
        ror     a                               ; D519 6A                       j
        clc                                     ; D51A 18                       .
        adc     $025B,x                         ; D51B 7D 5B 02                 }[.
        sta     $025B,x                         ; D51E 9D 5B 02                 .[.
        pla                                     ; D521 68                       h
        adc     $0266,x                         ; D522 7D 66 02                 }f.
        sta     $0266,x                         ; D525 9D 66 02                 .f.
LD528:
        lda     #$7F                            ; D528 A9 7F                    ..
        sta     $027C,x                         ; D52A 9D 7C 02                 .|.
        lda     $F8                             ; D52D A5 F8                    ..
        bmi     LD562                           ; D52F 30 31                    01
        lda     $0266,x                         ; D531 BD 66 02                 .f.
        sta     $027C,x                         ; D534 9D 7C 02                 .|.
        lda     #$00                            ; D537 A9 00                    ..
        sta     $F0                             ; D539 85 F0                    ..
        lda     $0342,x                         ; D53B BD 42 03                 .B.
        asl     a                               ; D53E 0A                       .
        rol     $F0                             ; D53F 26 F0                    &.
        sta     $EF                             ; D541 85 EF                    ..
        lda     $025B,x                         ; D543 BD 5B 02                 .[.
        sec                                     ; D546 38                       8
        sbc     $EF                             ; D547 E5 EF                    ..
        sta     $0271,x                         ; D549 9D 71 02                 .q.
        lda     $027C,x                         ; D54C BD 7C 02                 .|.
        sbc     $F0                             ; D54F E5 F0                    ..
        sta     $027C,x                         ; D551 9D 7C 02                 .|.
        lda     $F8                             ; D554 A5 F8                    ..
        and     #$30                            ; D556 29 30                    )0
        cmp     #$10                            ; D558 C9 10                    ..
        bne     LD562                           ; D55A D0 06                    ..
        lsr     $027C,x                         ; D55C 5E 7C 02                 ^|.
        ror     $0271,x                         ; D55F 7E 71 02                 ~q.
LD562:
        lda     $0287,x                         ; D562 BD 87 02                 ...
        bpl     LD574                           ; D565 10 0D                    ..
        lda     $0384,x                         ; D567 BD 84 03                 ...
        bne     LD5B3                           ; D56A D0 47                    .G
        sta     $038F,x                         ; D56C 9D 8F 03                 ...
        sta     $039A,x                         ; D56F 9D 9A 03                 ...
        beq     LD5B3                           ; D572 F0 3F                    .?
LD574:
        lda     #$00                            ; D574 A9 00                    ..
        sta     $038F,x                         ; D576 9D 8F 03                 ...
        sta     $039A,x                         ; D579 9D 9A 03                 ...
        lda     $F8                             ; D57C A5 F8                    ..
        and     #$38                            ; D57E 29 38                    )8
        asl     a                               ; D580 0A                       .
        sta     $02A8,x                         ; D581 9D A8 02                 ...
        jmp     LD5B3                           ; D584 4C B3 D5                 L..

; ----------------------------------------------------------------------------
LD587:
        sta     $02A8,x                         ; D587 9D A8 02                 ...
        sta     $038F,x                         ; D58A 9D 8F 03                 ...
        sta     $039A,x                         ; D58D 9D 9A 03                 ...
        pla                                     ; D590 68                       h
        and     #$7F                            ; D591 29 7F                    ).
        lsr     a                               ; D593 4A                       J
        ror     $F8                             ; D594 66 F8                    f.
        lsr     a                               ; D596 4A                       J
        ror     $F8                             ; D597 66 F8                    f.
        pha                                     ; D599 48                       H
        clc                                     ; D59A 18                       .
        lda     $F8                             ; D59B A5 F8                    ..
        adc     $025B,x                         ; D59D 7D 5B 02                 }[.
        sta     $025B,x                         ; D5A0 9D 5B 02                 .[.
        pla                                     ; D5A3 68                       h
        adc     $0266,x                         ; D5A4 7D 66 02                 }f.
        sta     $0266,x                         ; D5A7 9D 66 02                 .f.
        lda     ($F4),y                         ; D5AA B1 F4                    ..
        sta     $F8                             ; D5AC 85 F8                    ..
        and     #$80                            ; D5AE 29 80                    ).
        sta     $0287,x                         ; D5B0 9D 87 02                 ...
LD5B3:
        lda     $0287,x                         ; D5B3 BD 87 02                 ...
        pha                                     ; D5B6 48                       H
        lda     $F8                             ; D5B7 A5 F8                    ..
        and     #$80                            ; D5B9 29 80                    ).
        sta     $0287,x                         ; D5BB 9D 87 02                 ...
        pla                                     ; D5BE 68                       h
        bmi     LD60F                           ; D5BF 30 4E                    0N
        lda     #$00                            ; D5C1 A9 00                    ..
        tay                                     ; D5C3 A8                       .
        sta     $0321,x                         ; D5C4 9D 21 03                 .!.
        sta     $032C,x                         ; D5C7 9D 2C 03                 .,.
        sta     $0337,x                         ; D5CA 9D 37 03                 .7.
        lda     $02F5,x                         ; D5CD BD F5 02                 ...
        sta     $F4                             ; D5D0 85 F4                    ..
        lda     $0300,x                         ; D5D2 BD 00 03                 ...
        sta     $F5                             ; D5D5 85 F5                    ..
        lda     ($F4),y                         ; D5D7 B1 F4                    ..
        sta     $0316,x                         ; D5D9 9D 16 03                 ...
        iny                                     ; D5DC C8                       .
        ora     ($F4),y                         ; D5DD 11 F4                    ..
        iny                                     ; D5DF C8                       .
        ora     ($F4),y                         ; D5E0 11 F4                    ..
        beq     LD5E8                           ; D5E2 F0 04                    ..
        inc     $0316,x                         ; D5E4 FE 16 03                 ...
        tya                                     ; D5E7 98                       .
LD5E8:
        sta     $030B,x                         ; D5E8 9D 0B 03                 ...
        lda     #$00                            ; D5EB A9 00                    ..
        tay                                     ; D5ED A8                       .
        sta     $02D4,x                         ; D5EE 9D D4 02                 ...
        sta     $02DF,x                         ; D5F1 9D DF 02                 ...
        lda     $02B3,x                         ; D5F4 BD B3 02                 ...
        sta     $F4                             ; D5F7 85 F4                    ..
        lda     $02BE,x                         ; D5F9 BD BE 02                 ...
        sta     $F5                             ; D5FC 85 F5                    ..
        lda     ($F4),y                         ; D5FE B1 F4                    ..
        sta     $02EA,x                         ; D600 9D EA 02                 ...
        iny                                     ; D603 C8                       .
        ora     ($F4),y                         ; D604 11 F4                    ..
        beq     LD60C                           ; D606 F0 04                    ..
        inc     $02EA,x                         ; D608 FE EA 02                 ...
        tya                                     ; D60B 98                       .
LD60C:
        sta     $02C9,x                         ; D60C 9D C9 02                 ...
LD60F:
        lda     $03F1                           ; D60F AD F1 03                 ...
        beq     LD61F                           ; D612 F0 0B                    ..
        lda     $022F,x                         ; D614 BD 2F 02                 ./.
        ora     $023A,x                         ; D617 1D 3A 02                 .:.
        bne     LD61F                           ; D61A D0 03                    ..
        jmp     LD829                           ; D61C 4C 29 D8                 L).

; ----------------------------------------------------------------------------
LD61F:
        lda     $F3                             ; D61F A5 F3                    ..
        and     #$06                            ; D621 29 06                    ).
        bne     LD62F                           ; D623 D0 0A                    ..
        lda     $039A,x                         ; D625 BD 9A 03                 ...
        asl     a                               ; D628 0A                       .
        ror     $039A,x                         ; D629 7E 9A 03                 ~..
        ror     $038F,x                         ; D62C 7E 8F 03                 ~..
LD62F:
        lda     $02F5,x                         ; D62F BD F5 02                 ...
        sta     $F4                             ; D632 85 F4                    ..
        lda     $0300,x                         ; D634 BD 00 03                 ...
        sta     $F5                             ; D637 85 F5                    ..
        ldy     $030B,x                         ; D639 BC 0B 03                 ...
        bne     LD643                           ; D63C D0 05                    ..
        tya                                     ; D63E 98                       .
        clc                                     ; D63F 18                       .
        jmp     LD6E9                           ; D640 4C E9 D6                 L..

; ----------------------------------------------------------------------------
LD643:
        dec     $0316,x                         ; D643 DE 16 03                 ...
        bne     LD69E                           ; D646 D0 56                    .V
        iny                                     ; D648 C8                       .
        lda     ($F4),y                         ; D649 B1 F4                    ..
        sta     $0316,x                         ; D64B 9D 16 03                 ...
        iny                                     ; D64E C8                       .
        cmp     #$FF                            ; D64F C9 FF                    ..
        bne     LD679                           ; D651 D0 26                    .&
        .byte   $BD,$37,$03,$F0,$08,$DE,$37,$03 ; D653 BD 37 03 F0 08 DE 37 03  .7....7.
        .byte   $D0,$08,$C8,$D0,$E8,$B1,$F4,$9D ; D65B D0 08 C8 D0 E8 B1 F4 9D  ........
        .byte   $37,$03,$C8,$38,$A5,$F4,$F1,$F4 ; D663 37 03 C8 38 A5 F4 F1 F4  7..8....
        .byte   $85,$F4,$9D,$F5,$02,$B0,$D6,$C6 ; D66B 85 F4 9D F5 02 B0 D6 C6  ........
        .byte   $F5,$DE,$00,$03,$90,$CF         ; D673 F5 DE 00 03 90 CF        ......
; ----------------------------------------------------------------------------
LD679:
        ora     ($F4),y                         ; D679 11 F4                    ..
        iny                                     ; D67B C8                       .
        cpy     #$F9                            ; D67C C0 F9                    ..
        ora     ($F4),y                         ; D67E 11 F4                    ..
        bne     LD689                           ; D680 D0 07                    ..
        .byte   $9D,$0B,$03,$A8,$4C,$E9,$D6     ; D682 9D 0B 03 A8 4C E9 D6     ....L..
; ----------------------------------------------------------------------------
LD689:
        tya                                     ; D689 98                       .
        bcc     LD69B                           ; D68A 90 0F                    ..
        .byte   $E9,$02,$7D,$F5,$02,$9D,$F5,$02 ; D68C E9 02 7D F5 02 9D F5 02  ..}.....
        .byte   $A9,$01,$90,$03,$FE,$00,$03     ; D694 A9 01 90 03 FE 00 03     .......
; ----------------------------------------------------------------------------
LD69B:
        sta     $030B,x                         ; D69B 9D 0B 03                 ...
LD69E:
        lda     $0321,x                         ; D69E BD 21 03                 .!.
        sta     $F8                             ; D6A1 85 F8                    ..
        lda     $032C,x                         ; D6A3 BD 2C 03                 .,.
        sta     $F9                             ; D6A6 85 F9                    ..
        dey                                     ; D6A8 88                       .
        lda     ($F4),y                         ; D6A9 B1 F4                    ..
        clc                                     ; D6AB 18                       .
        adc     $0321,x                         ; D6AC 7D 21 03                 }!.
        sta     $0321,x                         ; D6AF 9D 21 03                 .!.
        iny                                     ; D6B2 C8                       .
        lda     ($F4),y                         ; D6B3 B1 F4                    ..
        adc     $032C,x                         ; D6B5 7D 2C 03                 },.
        sta     $032C,x                         ; D6B8 9D 2C 03                 .,.
        tay                                     ; D6BB A8                       .
        ora     $0321,x                         ; D6BC 1D 21 03                 .!.
        beq     LD6E9                           ; D6BF F0 28                    .(
        lda     #$00                            ; D6C1 A9 00                    ..
        sta     $F9                             ; D6C3 85 F9                    ..
        lda     $032C,x                         ; D6C5 BD 2C 03                 .,.
        bpl     LD6CC                           ; D6C8 10 02                    ..
        .byte   $C6,$F9                         ; D6CA C6 F9                    ..
; ----------------------------------------------------------------------------
LD6CC:
        sta     $F8                             ; D6CC 85 F8                    ..
        lda     $0321,x                         ; D6CE BD 21 03                 .!.
        asl     a                               ; D6D1 0A                       .
        rol     $F8                             ; D6D2 26 F8                    &.
        rol     $F9                             ; D6D4 26 F9                    &.
        asl     a                               ; D6D6 0A                       .
        rol     $F8                             ; D6D7 26 F8                    &.
        rol     $F9                             ; D6D9 26 F9                    &.
        asl     a                               ; D6DB 0A                       .
        rol     $F8                             ; D6DC 26 F8                    &.
        rol     $F9                             ; D6DE 26 F9                    &.
        asl     a                               ; D6E0 0A                       .
        rol     $F8                             ; D6E1 26 F8                    &.
        rol     $F9                             ; D6E3 26 F9                    &.
        lda     $F8                             ; D6E5 A5 F8                    ..
        ldy     $F9                             ; D6E7 A4 F9                    ..
LD6E9:
        clc                                     ; D6E9 18                       .
        adc     $022F,x                         ; D6EA 7D 2F 02                 }/.
        sta     $F8                             ; D6ED 85 F8                    ..
        tya                                     ; D6EF 98                       .
        adc     $023A,x                         ; D6F0 7D 3A 02                 }:.
        tay                                     ; D6F3 A8                       .
        lda     $FE                             ; D6F4 A5 FE                    ..
        bne     LD749                           ; D6F6 D0 51                    .Q
        clc                                     ; D6F8 18                       .
        lda     $F8                             ; D6F9 A5 F8                    ..
        adc     $038F,x                         ; D6FB 7D 8F 03                 }..
        sta     $03EC                           ; D6FE 8D EC 03                 ...
        tya                                     ; D701 98                       .
        adc     $039A,x                         ; D702 7D 9A 03                 }..
        sta     $03ED                           ; D705 8D ED 03                 ...
        lda     $FE                             ; D708 A5 FE                    ..
        bne     LD728                           ; D70A D0 1C                    ..
        lda     $03EC                           ; D70C AD EC 03                 ...
        cmp     $0245,x                         ; D70F DD 45 02                 .E.
        beq     LD71A                           ; D712 F0 06                    ..
        lda     #$10                            ; D714 A9 10                    ..
        ora     $FF                             ; D716 05 FF                    ..
        sta     $FF                             ; D718 85 FF                    ..
LD71A:
        lda     $03ED                           ; D71A AD ED 03                 ...
        cmp     $0250,x                         ; D71D DD 50 02                 .P.
        beq     LD728                           ; D720 F0 06                    ..
        lda     #$20                            ; D722 A9 20                    . 
        ora     $FF                             ; D724 05 FF                    ..
        sta     $FF                             ; D726 85 FF                    ..
LD728:
        lda     $03EC                           ; D728 AD EC 03                 ...
        sta     $0245,x                         ; D72B 9D 45 02                 .E.
        lda     $03ED                           ; D72E AD ED 03                 ...
        sta     $0250,x                         ; D731 9D 50 02                 .P.
        lda     $036E,x                         ; D734 BD 6E 03                 .n.
        and     #$20                            ; D737 29 20                    ) 
        bne     LD743                           ; D739 D0 08                    ..
        .byte   $AD,$ED,$03,$09,$08,$8D,$ED,$03 ; D73B AD ED 03 09 08 8D ED 03  ........
; ----------------------------------------------------------------------------
LD743:
        lda     $0379,x                         ; D743 BD 79 03                 .y.
        sta     $03EE                           ; D746 8D EE 03                 ...
LD749:
        lda     $02B3,x                         ; D749 BD B3 02                 ...
        sta     $F4                             ; D74C 85 F4                    ..
        lda     $02BE,x                         ; D74E BD BE 02                 ...
        sta     $F5                             ; D751 85 F5                    ..
        lda     $02C9,x                         ; D753 BD C9 02                 ...
        bne     LD75B                           ; D756 D0 03                    ..
        jmp     LD7DC                           ; D758 4C DC D7                 L..

; ----------------------------------------------------------------------------
LD75B:
        tay                                     ; D75B A8                       .
        dec     $02EA,x                         ; D75C DE EA 02                 ...
        bne     LD7B3                           ; D75F D0 52                    .R
        iny                                     ; D761 C8                       .
        lda     ($F4),y                         ; D762 B1 F4                    ..
        sta     $02EA,x                         ; D764 9D EA 02                 ...
        iny                                     ; D767 C8                       .
        cmp     #$FF                            ; D768 C9 FF                    ..
        bne     LD792                           ; D76A D0 26                    .&
        .byte   $BD,$DF,$02,$F0,$08,$DE,$DF,$02 ; D76C BD DF 02 F0 08 DE DF 02  ........
        .byte   $D0,$08,$C8,$D0,$E8,$B1,$F4,$9D ; D774 D0 08 C8 D0 E8 B1 F4 9D  ........
        .byte   $DF,$02,$C8,$38,$A5,$F4,$F1,$F4 ; D77C DF 02 C8 38 A5 F4 F1 F4  ...8....
        .byte   $85,$F4,$9D,$B3,$02,$B0,$D6,$C6 ; D784 85 F4 9D B3 02 B0 D6 C6  ........
        .byte   $F5,$DE,$BE,$02,$90,$CF         ; D78C F5 DE BE 02 90 CF        ......
; ----------------------------------------------------------------------------
LD792:
        cpy     #$F9                            ; D792 C0 F9                    ..
        ora     ($F4),y                         ; D794 11 F4                    ..
        bne     LD79E                           ; D796 D0 06                    ..
        sta     $02C9,x                         ; D798 9D C9 02                 ...
        jmp     LD7DC                           ; D79B 4C DC D7                 L..

; ----------------------------------------------------------------------------
LD79E:
        tya                                     ; D79E 98                       .
        bcc     LD7B0                           ; D79F 90 0F                    ..
        .byte   $E9,$02,$7D,$B3,$02,$9D,$B3,$02 ; D7A1 E9 02 7D B3 02 9D B3 02  ..}.....
        .byte   $A9,$01,$90,$03,$FE,$BE,$02     ; D7A9 A9 01 90 03 FE BE 02     .......
; ----------------------------------------------------------------------------
LD7B0:
        sta     $02C9,x                         ; D7B0 9D C9 02                 ...
LD7B3:
        lda     $02D4,x                         ; D7B3 BD D4 02                 ...
        sta     $F8                             ; D7B6 85 F8                    ..
        lda     ($F4),y                         ; D7B8 B1 F4                    ..
        clc                                     ; D7BA 18                       .
        adc     $02D4,x                         ; D7BB 7D D4 02                 }..
        bvc     LD7C6                           ; D7BE 50 06                    P.
        .byte   $A9,$80,$B0,$02,$A9,$7F         ; D7C0 A9 80 B0 02 A9 7F        ......
; ----------------------------------------------------------------------------
LD7C6:
        sta     $02D4,x                         ; D7C6 9D D4 02                 ...
        eor     $F8                             ; D7C9 45 F8                    E.
        and     #$F8                            ; D7CB 29 F8                    ).
        beq     LD7D9                           ; D7CD F0 0A                    ..
        lda     $FE                             ; D7CF A5 FE                    ..
        bne     LD7D9                           ; D7D1 D0 06                    ..
        lda     #$04                            ; D7D3 A9 04                    ..
        ora     $FF                             ; D7D5 05 FF                    ..
        sta     $FF                             ; D7D7 85 FF                    ..
LD7D9:
        lda     $02D4,x                         ; D7D9 BD D4 02                 ...
LD7DC:
        pha                                     ; D7DC 48                       H
        ldy     $02A8,x                         ; D7DD BC A8 02                 ...
        lda     LDE1C,y                         ; D7E0 B9 1C DE                 ...
        beq     LD7EF                           ; D7E3 F0 0A                    ..
        .byte   $A5,$FE,$D0,$06,$A9,$04,$05,$FF ; D7E5 A5 FE D0 06 A9 04 05 FF  ........
        .byte   $85,$FF                         ; D7ED 85 FF                    ..
; ----------------------------------------------------------------------------
LD7EF:
        pla                                     ; D7EF 68                       h
        clc                                     ; D7F0 18                       .
        adc     LDE1C,y                         ; D7F1 79 1C DE                 y..
        bvc     LD7FC                           ; D7F4 50 06                    P.
        .byte   $A9,$80,$B0,$02,$A9,$7F         ; D7F6 A9 80 B0 02 A9 7F        ......
; ----------------------------------------------------------------------------
LD7FC:
        pha                                     ; D7FC 48                       H
        tya                                     ; D7FD 98                       .
        and     #$0F                            ; D7FE 29 0F                    ).
        cmp     #$0F                            ; D800 C9 0F                    ..
        beq     LD807                           ; D802 F0 03                    ..
        inc     $02A8,x                         ; D804 FE A8 02                 ...
LD807:
        pla                                     ; D807 68                       h
        lsr     a                               ; D808 4A                       J
        lsr     a                               ; D809 4A                       J
        lsr     a                               ; D80A 4A                       J
        cmp     #$10                            ; D80B C9 10                    ..
        bcc     LD811                           ; D80D 90 02                    ..
        ora     #$F0                            ; D80F 09 F0                    ..
LD811:
        clc                                     ; D811 18                       .
        adc     $029D,x                         ; D812 7D 9D 02                 }..
        bpl     LD819                           ; D815 10 02                    ..
        lda     #$00                            ; D817 A9 00                    ..
LD819:
        cmp     #$10                            ; D819 C9 10                    ..
        bcc     LD81F                           ; D81B 90 02                    ..
        lda     #$0F                            ; D81D A9 0F                    ..
LD81F:
        ora     $036E,x                         ; D81F 1D 6E 03                 .n.
        ldy     $FE                             ; D822 A4 FE                    ..
        bne     LD838                           ; D824 D0 12                    ..
        jmp     LD835                           ; D826 4C 35 D8                 L5.

; ----------------------------------------------------------------------------
LD829:
        lda     $FE                             ; D829 A5 FE                    ..
        bne     LD838                           ; D82B D0 0B                    ..
        lda     #$02                            ; D82D A9 02                    ..
        ora     $FF                             ; D82F 05 FF                    ..
        sta     $FF                             ; D831 85 FF                    ..
        lda     #$B0                            ; D833 A9 B0                    ..
LD835:
        sta     $03EB                           ; D835 8D EB 03                 ...
LD838:
        lda     $03DC,x                         ; D838 BD DC 03                 ...
        beq     LD845                           ; D83B F0 08                    ..
        stx     $03F2                           ; D83D 8E F2 03                 ...
        tax                                     ; D840 AA                       .
        dex                                     ; D841 CA                       .
        jmp     LD35D                           ; D842 4C 5D D3                 L].

; ----------------------------------------------------------------------------
LD845:
        rts                                     ; D845 60                       `

; ----------------------------------------------------------------------------
setupMusicTrack:
        lda     apuRegistersLow,x               ; D846 BD 1E DD                 ...
        sta     $F6                             ; D849 85 F6                    ..
        lda     apuRegistersHigh,x              ; D84B BD 22 DD                 .".
        sta     $F7                             ; D84E 85 F7                    ..
        lda     LDD26,x                         ; D850 BD 26 DD                 .&.
        sta     $03F3                           ; D853 8D F3 03                 ...
        bne     LD85B                           ; D856 D0 03                    ..
        jmp     LD86A                           ; D858 4C 6A D8                 Lj.

; ----------------------------------------------------------------------------
LD85B:
        cmp     #$01                            ; D85B C9 01                    ..
        bne     LD862                           ; D85D D0 03                    ..
        jmp     LD86A                           ; D85F 4C 6A D8                 Lj.

; ----------------------------------------------------------------------------
LD862:
        cmp     #$02                            ; D862 C9 02                    ..
        bne     LD869                           ; D864 D0 03                    ..
        jmp     LD86A                           ; D866 4C 6A D8                 Lj.

; ----------------------------------------------------------------------------
LD869:
        .byte   $60                             ; D869 60                       `
; ----------------------------------------------------------------------------
LD86A:
        txa                                     ; D86A 8A                       .
        pha                                     ; D86B 48                       H
        lda     LDD2E,x                         ; D86C BD 2E DD                 ...
        tay                                     ; D86F A8                       .
        ldx     #$00                            ; D870 A2 00                    ..
        stx     $03EB                           ; D872 8E EB 03                 ...
        stx     $03F0                           ; D875 8E F0 03                 ...
        stx     $FF                             ; D878 86 FF                    ..
        ldx     $03DC,y                         ; D87A BE DC 03                 ...
        beq     LD8DD                           ; D87D F0 5E                    .^
        dex                                     ; D87F CA                       .
        sty     $03F2                           ; D880 8C F2 03                 ...
        jsr     LD35D                           ; D883 20 5D D3                  ].
        lda     $03F0                           ; D886 AD F0 03                 ...
        cmp     $FA                             ; D889 C5 FA                    ..
        bcc     LD8DD                           ; D88B 90 50                    .P
        lda     $FF                             ; D88D A5 FF                    ..
        and     #$35                            ; D88F 29 35                    )5
        bne     LD89C                           ; D891 D0 09                    ..
        lda     $FF                             ; D893 A5 FF                    ..
        and     #$02                            ; D895 29 02                    ).
        bne     LD8DD                           ; D897 D0 44                    .D
        pla                                     ; D899 68                       h
        tax                                     ; D89A AA                       .
        rts                                     ; D89B 60                       `

; ----------------------------------------------------------------------------
LD89C:
        lda     $FF                             ; D89C A5 FF                    ..
        and     #$05                            ; D89E 29 05                    ).
        beq     LD8A9                           ; D8A0 F0 07                    ..
        lda     $03EB                           ; D8A2 AD EB 03                 ...
        ldy     #$00                            ; D8A5 A0 00                    ..
        sta     ($F6),y                         ; D8A7 91 F6                    ..
LD8A9:
        ldy     #$01                            ; D8A9 A0 01                    ..
        pla                                     ; D8AB 68                       h
        tax                                     ; D8AC AA                       .
        lda     $FF                             ; D8AD A5 FF                    ..
        and     #$01                            ; D8AF 29 01                    ).
        beq     LD8C4                           ; D8B1 F0 11                    ..
        lda     LDD2A,x                         ; D8B3 BD 2A DD                 .*.
        ora     $03EF                           ; D8B6 0D EF 03                 ...
        sta     $03EF                           ; D8B9 8D EF 03                 ...
        sta     SND_CHN                         ; D8BC 8D 15 40                 ..@
        lda     $03EE                           ; D8BF AD EE 03                 ...
        sta     ($F6),y                         ; D8C2 91 F6                    ..
LD8C4:
        iny                                     ; D8C4 C8                       .
        lda     $FF                             ; D8C5 A5 FF                    ..
        and     #$11                            ; D8C7 29 11                    ).
        beq     LD8D0                           ; D8C9 F0 05                    ..
        lda     $03EC                           ; D8CB AD EC 03                 ...
        sta     ($F6),y                         ; D8CE 91 F6                    ..
LD8D0:
        iny                                     ; D8D0 C8                       .
        lda     $FF                             ; D8D1 A5 FF                    ..
        and     #$21                            ; D8D3 29 21                    )!
        beq     LD8DC                           ; D8D5 F0 05                    ..
        lda     $03ED                           ; D8D7 AD ED 03                 ...
        sta     ($F6),y                         ; D8DA 91 F6                    ..
LD8DC:
        rts                                     ; D8DC 60                       `

; ----------------------------------------------------------------------------
LD8DD:
        pla                                     ; D8DD 68                       h
        tax                                     ; D8DE AA                       .
        lda     LDD2A,x                         ; D8DF BD 2A DD                 .*.
        eor     #$FF                            ; D8E2 49 FF                    I.
        and     $03EF                           ; D8E4 2D EF 03                 -..
        sta     $03EF                           ; D8E7 8D EF 03                 ...
        sta     SND_CHN                         ; D8EA 8D 15 40                 ..@
        rts                                     ; D8ED 60                       `

; ----------------------------------------------------------------------------
LD8EE:
        cmp     #$A9                            ; D8EE C9 A9                    ..
        bcc     LD8F9                           ; D8F0 90 07                    ..
        .byte   $A9,$FF,$9D,$0E,$02,$18,$60     ; D8F2 A9 FF 9D 0E 02 18 60     ......`
; ----------------------------------------------------------------------------
LD8F9:
        iny                                     ; D8F9 C8                       .
        stx     $F8                             ; D8FA 86 F8                    ..
        asl     a                               ; D8FC 0A                       .
        tax                                     ; D8FD AA                       .
        lda     LD93E,x                         ; D8FE BD 3E D9                 .>.
        pha                                     ; D901 48                       H
        lda     LD93D,x                         ; D902 BD 3D D9                 .=.
        pha                                     ; D905 48                       H
        ldx     $F8                             ; D906 A6 F8                    ..
        lda     ($F4),y                         ; D908 B1 F4                    ..
        sec                                     ; D90A 38                       8
        rts                                     ; D90B 60                       `

; ----------------------------------------------------------------------------
LD90C:
        lda     $0219,x                         ; D90C BD 19 02                 ...
        clc                                     ; D90F 18                       .
        adc     #$01                            ; D910 69 01                    i.
        sta     $0219,x                         ; D912 9D 19 02                 ...
        bcc     LD91A                           ; D915 90 03                    ..
        .byte   $FE,$24,$02                     ; D917 FE 24 02                 .$.
; ----------------------------------------------------------------------------
LD91A:
        iny                                     ; D91A C8                       .
        lda     ($F4),y                         ; D91B B1 F4                    ..
        rts                                     ; D91D 60                       `

; ----------------------------------------------------------------------------
LD91E:
        .byte   $BD,$DC,$03,$F0,$0D,$AA,$CA,$BD ; D91E BD DC 03 F0 0D AA CA BD  ........
        .byte   $0E,$02,$CD,$F4,$03,$D0,$F1,$20 ; D926 0E 02 CD F4 03 D0 F1 20  ....... 
        .byte   $31,$D9,$60,$B9,$3E,$D9,$48,$B9 ; D92E 31 D9 60 B9 3E D9 48 B9  1.`.>.H.
        .byte   $3D,$D9,$48,$AD,$F5,$03,$60     ; D936 3D D9 48 AD F5 03 60     =.H...`
LD93D:
        .byte   $10                             ; D93D 10                       .
LD93E:
        .byte   $DA,$07,$DA,$23,$DA,$15,$DA,$35 ; D93E DA 07 DA 23 DA 15 DA 35  ...#...5
        .byte   $DA,$31,$DA,$FC,$D9,$F1,$D9,$8E ; D946 DA 31 DA FC D9 F1 D9 8E  .1......
        .byte   $D9,$E8,$D9,$D2,$D3,$D2,$D3,$3A ; D94E D9 E8 D9 D2 D3 D2 D3 3A  .......:
        .byte   $DA,$3E,$DA,$6C,$DA,$97,$DA,$C9 ; D956 DA 3E DA 6C DA 97 DA C9  .>.l....
        .byte   $DA,$E0,$DA,$EC,$DA,$12,$DB,$31 ; D95E DA E0 DA EC DA 12 DB 31  .......1
        .byte   $DB,$D2,$D3,$D2,$D3,$D2,$D3,$D2 ; D966 DB D2 D3 D2 D3 D2 D3 D2  ........
        .byte   $D3,$0E,$DD,$D2,$D3,$D2,$D3,$D2 ; D96E D3 0E DD D2 D3 D2 D3 D2  ........
        .byte   $D3,$D2,$D3,$D2,$D3,$D2,$D3,$D2 ; D976 D3 D2 D3 D2 D3 D2 D3 D2  ........
        .byte   $D3,$D2,$D3,$D2,$D3,$D2,$D3,$D2 ; D97E D3 D2 D3 D2 D3 D2 D3 D2  ........
        .byte   $D3,$D2,$D3,$D2,$D3,$D2,$D3,$D2 ; D986 D3 D2 D3 D2 D3 D2 D3 D2  ........
        .byte   $D3,$A9,$00,$9D,$5B,$02,$9D,$66 ; D98E D3 A9 00 9D 5B 02 9D 66  ....[..f
        .byte   $02,$BC,$58,$03,$F0,$08,$C8,$D0 ; D996 02 BC 58 03 F0 08 C8 D0  ..X.....
        .byte   $38,$9D,$58,$03,$38,$60,$BD,$63 ; D99E 38 9D 58 03 38 60 BD 63  8.X.8`.c
        .byte   $03,$9D,$58,$03,$A0,$0A,$D9,$63 ; D9A6 03 9D 58 03 A0 0A D9 63  ..X....c
        .byte   $03,$D0,$0D,$D9,$58,$03,$F0,$08 ; D9AE 03 D0 0D D9 58 03 F0 08  ....X...
        .byte   $B9,$92,$02,$D0,$1C,$BD,$63,$03 ; D9B6 B9 92 02 D0 1C BD 63 03  ......c.
        .byte   $88,$10,$EB,$A0,$0A,$D9,$63,$03 ; D9BE 88 10 EB A0 0A D9 63 03  ......c.
        .byte   $D0,$08,$A9,$FF,$99,$58,$03,$BD ; D9C6 D0 08 A9 FF 99 58 03 BD  .....X..
        .byte   $63,$03,$88,$10,$F0,$A9,$00,$F0 ; D9CE 63 03 88 10 F0 A9 00 F0  c.......
        .byte   $C8,$BD,$19,$02,$C9,$02,$B0,$03 ; D9D6 C8 BD 19 02 C9 02 B0 03  ........
        .byte   $DE,$24,$02,$DE,$19,$02,$DE,$19 ; D9DE DE 24 02 DE 19 02 DE 19  .$......
        .byte   $02,$18,$60,$9D,$63,$03,$A9,$00 ; D9E6 02 18 60 9D 63 03 A9 00  ..`.c...
        .byte   $9D,$58,$03,$60                 ; D9EE 9D 58 03 60              .X.`
; ----------------------------------------------------------------------------
        sta     $02B3,x                         ; D9F2 9D B3 02                 ...
        jsr     LD90C                           ; D9F5 20 0C D9                  ..
        sta     $02BE,x                         ; D9F8 9D BE 02                 ...
        sec                                     ; D9FB 38                       8
        rts                                     ; D9FC 60                       `

; ----------------------------------------------------------------------------
        sta     $02F5,x                         ; D9FD 9D F5 02                 ...
        jsr     LD90C                           ; DA00 20 0C D9                  ..
        sta     $0300,x                         ; DA03 9D 00 03                 ...
        sec                                     ; DA06 38                       8
        rts                                     ; DA07 60                       `

; ----------------------------------------------------------------------------
        clc                                     ; DA08 18                       .
        adc     $0342,x                         ; DA09 7D 42 03                 }B.
        sta     $0342,x                         ; DA0C 9D 42 03                 .B.
        sec                                     ; DA0F 38                       8
        rts                                     ; DA10 60                       `

; ----------------------------------------------------------------------------
        sta     $0342,x                         ; DA11 9D 42 03                 .B.
        sec                                     ; DA14 38                       8
        rts                                     ; DA15 60                       `

; ----------------------------------------------------------------------------
        ldy     $020E,x                         ; DA16 BC 0E 02                 ...
        cpy     #$FE                            ; DA19 C0 FE                    ..
        beq     LDA30                           ; DA1B F0 13                    ..
        clc                                     ; DA1D 18                       .
        adc     $029D,x                         ; DA1E 7D 9D 02                 }..
        jmp     LDA2B                           ; DA21 4C 2B DA                 L+.

; ----------------------------------------------------------------------------
        ldy     $020E,x                         ; DA24 BC 0E 02                 ...
        cpy     #$FE                            ; DA27 C0 FE                    ..
        beq     LDA30                           ; DA29 F0 05                    ..
LDA2B:
        sta     $029D,x                         ; DA2B 9D 9D 02                 ...
        sec                                     ; DA2E 38                       8
        rts                                     ; DA2F 60                       `

; ----------------------------------------------------------------------------
LDA30:
        .byte   $18,$60,$18,$7D,$4D,$03         ; DA30 18 60 18 7D 4D 03        .`.}M.
; ----------------------------------------------------------------------------
        sta     $034D,x                         ; DA36 9D 4D 03                 .M.
        sec                                     ; DA39 38                       8
        rts                                     ; DA3A 60                       `

; ----------------------------------------------------------------------------
        .byte   $9D,$84,$03,$60,$85,$F8,$20,$0C ; DA3B 9D 84 03 60 85 F8 20 0C  ...`.. .
        .byte   $D9,$85,$F9,$20,$F4,$D2,$F0,$20 ; DA43 D9 85 F9 20 F4 D2 F0 20  ... ... 
        .byte   $48,$BD,$A5,$03,$91,$FC,$68,$9D ; DA4B 48 BD A5 03 91 FC 68 9D  H.....h.
        .byte   $A5,$03,$C8,$BD,$19,$02,$91,$FC ; DA53 A5 03 C8 BD 19 02 91 FC  ........
        .byte   $C8,$BD,$24,$02,$91,$FC,$A5,$F8 ; DA5B C8 BD 24 02 91 FC A5 F8  ..$.....
        .byte   $9D,$19,$02,$A5,$F9,$9D,$24,$02 ; DA63 9D 19 02 A5 F9 9D 24 02  ......$.
        .byte   $38,$60                         ; DA6B 38 60                    8`
; ----------------------------------------------------------------------------
        pha                                     ; DA6D 48                       H
        jsr     LD2F4                           ; DA6E 20 F4 D2                  ..
        beq     LDA95                           ; DA71 F0 22                    ."
        pha                                     ; DA73 48                       H
        lda     $03B0,x                         ; DA74 BD B0 03                 ...
        sta     ($FC),y                         ; DA77 91 FC                    ..
        pla                                     ; DA79 68                       h
        sta     $03B0,x                         ; DA7A 9D B0 03                 ...
        iny                                     ; DA7D C8                       .
        lda     $0219,x                         ; DA7E BD 19 02                 ...
        sta     ($FC),y                         ; DA81 91 FC                    ..
        iny                                     ; DA83 C8                       .
        lda     $0224,x                         ; DA84 BD 24 02                 .$.
        sta     ($FC),y                         ; DA87 91 FC                    ..
        iny                                     ; DA89 C8                       .
        lda     $03BB,x                         ; DA8A BD BB 03                 ...
        sta     ($FC),y                         ; DA8D 91 FC                    ..
        pla                                     ; DA8F 68                       h
        sta     $03BB,x                         ; DA90 9D BB 03                 ...
        sec                                     ; DA93 38                       8
        rts                                     ; DA94 60                       `

; ----------------------------------------------------------------------------
LDA95:
        .byte   $68,$38,$60                     ; DA95 68 38 60                 h8`
; ----------------------------------------------------------------------------
        lda     $03B0,x                         ; DA98 BD B0 03                 ...
        beq     LDAB1                           ; DA9B F0 14                    ..
        jsr     LD306                           ; DA9D 20 06 D3                  ..
        dec     $03BB,x                         ; DAA0 DE BB 03                 ...
        beq     LDAB3                           ; DAA3 F0 0E                    ..
        iny                                     ; DAA5 C8                       .
        lda     ($FC),y                         ; DAA6 B1 FC                    ..
        sta     $0219,x                         ; DAA8 9D 19 02                 ...
        iny                                     ; DAAB C8                       .
        lda     ($FC),y                         ; DAAC B1 FC                    ..
        sta     $0224,x                         ; DAAE 9D 24 02                 .$.
LDAB1:
        sec                                     ; DAB1 38                       8
        rts                                     ; DAB2 60                       `

; ----------------------------------------------------------------------------
LDAB3:
        pha                                     ; DAB3 48                       H
        lda     ($FC),y                         ; DAB4 B1 FC                    ..
        sta     $03B0,x                         ; DAB6 9D B0 03                 ...
        lda     $FB                             ; DAB9 A5 FB                    ..
        sta     ($FC),y                         ; DABB 91 FC                    ..
        pla                                     ; DABD 68                       h
        sta     $FB                             ; DABE 85 FB                    ..
        iny                                     ; DAC0 C8                       .
        iny                                     ; DAC1 C8                       .
        iny                                     ; DAC2 C8                       .
        lda     ($FC),y                         ; DAC3 B1 FC                    ..
        sta     $03BB,x                         ; DAC5 9D BB 03                 ...
        sec                                     ; DAC8 38                       8
        rts                                     ; DAC9 60                       `

; ----------------------------------------------------------------------------
        ldy     $03F3                           ; DACA AC F3 03                 ...
        cpy     #$00                            ; DACD C0 00                    ..
        bne     LDADF                           ; DACF D0 0E                    ..
        and     #$C0                            ; DAD1 29 C0                    ).
        sta     $F8                             ; DAD3 85 F8                    ..
        lda     $036E,x                         ; DAD5 BD 6E 03                 .n.
        and     #$3F                            ; DAD8 29 3F                    )?
        ora     $F8                             ; DADA 05 F8                    ..
        sta     $036E,x                         ; DADC 9D 6E 03                 .n.
LDADF:
        sec                                     ; DADF 38                       8
        rts                                     ; DAE0 60                       `

; ----------------------------------------------------------------------------
        ldy     $03F3                           ; DAE1 AC F3 03                 ...
        cpy     #$00                            ; DAE4 C0 00                    ..
        bne     LDAEB                           ; DAE6 D0 03                    ..
        sta     $0379,x                         ; DAE8 9D 79 03                 .y.
LDAEB:
        sec                                     ; DAEB 38                       8
        rts                                     ; DAEC 60                       `

; ----------------------------------------------------------------------------
        ldy     $03F3                           ; DAED AC F3 03                 ...
        cpy     #$01                            ; DAF0 C0 01                    ..
        beq     LDB07                           ; DAF2 F0 13                    ..
        cmp     #$00                            ; DAF4 C9 00                    ..
        beq     LDB09                           ; DAF6 F0 11                    ..
        .byte   $BD,$6E,$03,$29,$E0,$29,$D0,$9D ; DAF8 BD 6E 03 29 E0 29 D0 9D  .n.).)..
        .byte   $6E,$03,$A9,$00,$9D,$9D,$02     ; DB00 6E 03 A9 00 9D 9D 02     n......
LDB07:
        .byte   $38,$60                         ; DB07 38 60                    8`
; ----------------------------------------------------------------------------
LDB09:
        lda     $036E,x                         ; DB09 BD 6E 03                 .n.
        ora     #$30                            ; DB0C 09 30                    .0
        sta     $036E,x                         ; DB0E 9D 6E 03                 .n.
        sec                                     ; DB11 38                       8
        rts                                     ; DB12 60                       `

; ----------------------------------------------------------------------------
        .byte   $AC,$F3,$03,$C0,$01,$F0,$0C,$C9 ; DB13 AC F3 03 C0 01 F0 0C C9  ........
        .byte   $00,$D0,$0A,$A9,$D0,$3D,$6E,$03 ; DB1B 00 D0 0A A9 D0 3D 6E 03  .....=n.
        .byte   $9D,$6E,$03,$38,$60,$BD,$6E,$03 ; DB23 9D 6E 03 38 60 BD 6E 03  .n.8`.n.
        .byte   $09,$20,$9D,$6E,$03,$38,$60     ; DB2B 09 20 9D 6E 03 38 60     . .n.8`
; ----------------------------------------------------------------------------
        lda     $0292,x                         ; DB32 BD 92 02                 ...
        and     #$FE                            ; DB35 29 FE                    ).
        sta     $0292,x                         ; DB37 9D 92 02                 ...
        lda     #$00                            ; DB3A A9 00                    ..
        sta     $03F1                           ; DB3C 8D F1 03                 ...
        rts                                     ; DB3F 60                       `

; ----------------------------------------------------------------------------
        .byte   $18,$7D,$C6,$03,$9D,$C6,$03,$9D ; DB40 18 7D C6 03 9D C6 03 9D  .}......
        .byte   $D1,$03,$38,$60,$85,$F8,$BD,$C6 ; DB48 D1 03 38 60 85 F8 BD C6  ..8`....
        .byte   $03,$E5,$F8,$4C,$44,$DB,$3D,$C6 ; DB50 03 E5 F8 4C 44 DB 3D C6  ...LD.=.
        .byte   $03,$4C,$44,$DB,$1D,$C6,$03,$4C ; DB58 03 4C 44 DB 1D C6 03 4C  .LD....L
        .byte   $44,$DB,$5D,$C6,$03,$4C,$44,$DB ; DB60 44 DB 5D C6 03 4C 44 DB  D.]..LD.
        .byte   $18,$A8,$BD,$C6,$03,$C0,$04,$F0 ; DB68 18 A8 BD C6 03 C0 04 F0  ........
        .byte   $1D,$C0,$02,$F0,$1B,$C0,$06,$F0 ; DB70 1D C0 02 F0 1B C0 06 F0  ........
        .byte   $13,$C0,$07,$F0,$0E,$C0,$05,$F0 ; DB78 13 C0 07 F0 0E C0 05 F0  ........
        .byte   $0C,$C0,$03,$F0,$0A,$C0,$01,$F0 ; DB80 0C C0 03 F0 0A C0 01 F0  ........
        .byte   $08,$38,$60,$4A,$4A,$4A,$4A,$4A ; DB88 08 38 60 4A 4A 4A 4A 4A  .8`JJJJJ
        .byte   $4A,$4A,$4C,$44,$DB,$18,$A8,$BD ; DB90 4A 4A 4C 44 DB 18 A8 BD  JJLD....
        .byte   $C6,$03,$C0,$04,$F0,$1D,$C0,$02 ; DB98 C6 03 C0 04 F0 1D C0 02  ........
        .byte   $F0,$1B,$C0,$06,$F0,$13,$C0,$07 ; DBA0 F0 1B C0 06 F0 13 C0 07  ........
        .byte   $F0,$0E,$C0,$05,$F0,$0C,$C0,$03 ; DBA8 F0 0E C0 05 F0 0C C0 03  ........
        .byte   $F0,$0A,$C0,$01,$F0,$08,$38,$60 ; DBB0 F0 0A C0 01 F0 08 38 60  ......8`
        .byte   $0A,$0A,$0A,$0A,$0A,$0A,$0A,$4C ; DBB8 0A 0A 0A 0A 0A 0A 0A 4C  .......L
        .byte   $44,$DB,$85,$F8,$BD,$C6,$03,$D0 ; DBC0 44 DB 85 F8 BD C6 03 D0  D.......
        .byte   $05,$A5,$F8,$4C,$DE,$DB,$8D,$0B ; DBC8 05 A5 F8 4C DE DB 8D 0B  ...L....
        .byte   $02,$20,$0C,$D9,$20,$0C,$D9,$85 ; DBD0 02 20 0C D9 20 0C D9 85  . .. ...
        .byte   $F8,$CE,$0B,$02,$D0,$F3,$20,$0C ; DBD8 F8 CE 0B 02 D0 F3 20 0C  ...... .
        .byte   $D9,$9D,$24,$02,$A5,$F8,$9D,$19 ; DBE0 D9 9D 24 02 A5 F8 9D 19  ..$.....
        .byte   $02,$38,$60,$85,$F8,$BD,$C6,$03 ; DBE8 02 38 60 85 F8 BD C6 03  .8`.....
        .byte   $D0,$05,$A5,$F8,$4C,$07,$DC,$8D ; DBF0 D0 05 A5 F8 4C 07 DC 8D  ....L...
        .byte   $0B,$02,$20,$0C,$D9,$20,$0C,$D9 ; DBF8 0B 02 20 0C D9 20 0C D9  .. .. ..
        .byte   $85,$F8,$CE,$0B,$02,$D0,$F3,$20 ; DC00 85 F8 CE 0B 02 D0 F3 20  ....... 
        .byte   $0C,$D9,$9D,$24,$02,$A5,$F8,$9D ; DC08 0C D9 9D 24 02 A5 F8 9D  ...$....
        .byte   $19,$02,$FE,$C6,$03,$BD,$C6,$03 ; DC10 19 02 FE C6 03 BD C6 03  ........
        .byte   $4C,$44,$DB,$C9,$06,$B0,$2C,$C9 ; DC18 4C 44 DB C9 06 B0 2C C9  LD....,.
        .byte   $06,$90,$03,$4C,$4B,$DC,$C9,$05 ; DC20 06 90 03 4C 4B DC C9 05  ...LK...
        .byte   $F0,$21,$C9,$03,$F0,$1D,$A8,$BD ; DC28 F0 21 C9 03 F0 1D A8 BD  .!......
        .byte   $C6,$03,$C0,$04,$90,$03,$4C,$4B ; DC30 C6 03 C0 04 90 03 4C 4B  ......LK
        .byte   $DC,$C0,$02,$90,$03,$4C,$36,$DA ; DC38 DC C0 02 90 03 4C 36 DA  .....L6.
        .byte   $C0,$01,$90,$03,$4C,$11,$DA,$38 ; DC40 C0 01 90 03 4C 11 DA 38  ....L..8
        .byte   $4C,$24,$DA,$38,$60,$C9,$05,$B0 ; DC48 4C 24 DA 38 60 C9 05 B0  L$.8`...
        .byte   $21,$C9,$03,$F0,$1D,$A8,$BD,$C6 ; DC50 21 C9 03 F0 1D A8 BD C6  !.......
        .byte   $03,$C0,$04,$90,$03,$4C,$72,$DC ; DC58 03 C0 04 90 03 4C 72 DC  .....Lr.
        .byte   $C0,$02,$90,$03,$4C,$32,$DA,$C0 ; DC60 C0 02 90 03 4C 32 DA C0  ....L2..
        .byte   $01,$90,$03,$4C,$08,$DA,$38,$4C ; DC68 01 90 03 4C 08 DA 38 4C  ...L..8L
        .byte   $16,$DA,$38,$60,$20,$BD,$DC,$4C ; DC70 16 DA 38 60 20 BD DC 4C  ..8` ..L
        .byte   $44,$DB,$20,$BD,$DC,$85,$F8,$BD ; DC78 44 DB 20 BD DC 85 F8 BD  D. .....
        .byte   $C6,$03,$E5,$F8,$9D,$D1,$03,$38 ; DC80 C6 03 E5 F8 9D D1 03 38  .......8
        .byte   $60,$20,$BD,$DC,$F0,$1D,$D0,$13 ; DC88 60 20 BD DC F0 1D D0 13  ` ......
        .byte   $20,$BD,$DC,$D0,$16,$F0,$0C,$20 ; DC90 20 BD DC D0 16 F0 0C 20   ...... 
        .byte   $BD,$DC,$10,$0F,$30,$05,$20,$BD ; DC98 BD DC 10 0F 30 05 20 BD  ....0. .
        .byte   $DC,$30,$08,$20,$0C,$D9,$20,$0C ; DCA0 DC 30 08 20 0C D9 20 0C  .0. .. .
        .byte   $D9,$38,$60,$20,$0C,$D9,$85,$F8 ; DCA8 D9 38 60 20 0C D9 85 F8  .8` ....
        .byte   $20,$0C,$D9,$9D,$24,$02,$A5,$F8 ; DCB0 20 0C D9 9D 24 02 A5 F8   ...$...
        .byte   $9D,$19,$02,$38,$60,$84,$F8,$C9 ; DCB8 9D 19 02 38 60 84 F8 C9  ...8`...
        .byte   $06,$B0,$46,$C9,$06,$B0,$2B,$C9 ; DCC0 06 B0 46 C9 06 B0 2B C9  ..F...+.
        .byte   $05,$F0,$2C,$C9,$03,$F0,$3A,$C9 ; DCC8 05 F0 2C C9 03 F0 3A C9  ..,...:.
        .byte   $04,$90,$36,$4C,$09,$DD,$B0,$31 ; DCD0 04 90 36 4C 09 DD B0 31  ..6L...1
        .byte   $C9,$02,$90,$06,$A4,$F8,$BD,$4D ; DCD8 C9 02 90 06 A4 F8 BD 4D  .......M
        .byte   $03,$60,$C9,$01,$90,$06,$A4,$F8 ; DCE0 03 60 C9 01 90 06 A4 F8  .`......
        .byte   $BD,$42,$03,$60,$A4,$F8,$BD,$9D ; DCE8 BD 42 03 60 A4 F8 BD 9D  .B.`....
        .byte   $02,$60,$48,$A4,$F8,$68,$60,$AD ; DCF0 02 60 48 A4 F8 68 60 AD  .`H..h`.
        .byte   $F6,$03,$0A,$4D,$F6,$03,$0A,$0A ; DCF8 F6 03 0A 4D F6 03 0A 0A  ...M....
        .byte   $2E,$F6,$03,$AD,$F6,$03,$A4,$F8 ; DD00 2E F6 03 AD F6 03 A4 F8  ........
        .byte   $60,$A4,$F8,$BD,$D1,$03,$60     ; DD08 60 A4 F8 BD D1 03 60     `.....`
; ----------------------------------------------------------------------------
        sta     $F8                             ; DD0F 85 F8                    ..
        jsr     LD90C                           ; DD11 20 0C D9                  ..
        sta     $0224,x                         ; DD14 9D 24 02                 .$.
        lda     $F8                             ; DD17 A5 F8                    ..
        sta     $0219,x                         ; DD19 9D 19 02                 ...
        sec                                     ; DD1C 38                       8
        rts                                     ; DD1D 60                       `

; ----------------------------------------------------------------------------
apuRegistersLow:
        .byte   $00,$04,$08,$0C                 ; DD1E 00 04 08 0C              ....
apuRegistersHigh:
        .byte   $40,$40,$40,$40                 ; DD22 40 40 40 40              @@@@
LDD26:
        .byte   $00,$00,$01,$02                 ; DD26 00 00 01 02              ....
LDD2A:
        .byte   $01,$02,$04,$08                 ; DD2A 01 02 04 08              ....
LDD2E:
        .byte   $0B,$0C,$0D,$0E,$00,$00,$00,$00 ; DD2E 0B 0C 0D 0E 00 00 00 00  ........
LDD36:
        .byte   $00                             ; DD36 00                       .
LDD37:
        .byte   $00,$FF,$07,$FF,$07,$FF,$07,$FF ; DD37 00 FF 07 FF 07 FF 07 FF  ........
        .byte   $07,$FF,$07,$FF,$07,$FF,$07,$FF ; DD3F 07 FF 07 FF 07 FF 07 FF  ........
        .byte   $07,$FF,$07,$FF,$07,$FF,$07,$FF ; DD47 07 FF 07 FF 07 FF 07 FF  ........
        .byte   $07,$FF,$07,$FF,$07,$FF,$07,$FF ; DD4F 07 FF 07 FF 07 FF 07 FF  ........
        .byte   $07,$FF,$07,$FF,$07,$FF,$07,$FF ; DD57 07 FF 07 FF 07 FF 07 FF  ........
        .byte   $07,$FF,$07,$F6,$07,$80,$07,$14 ; DD5F 07 FF 07 F6 07 80 07 14  ........
        .byte   $07,$AE,$06,$4E,$06,$F4,$05,$9E ; DD67 07 AE 06 4E 06 F4 05 9E  ...N....
        .byte   $05,$4D,$05,$01,$05,$B9,$04,$75 ; DD6F 05 4D 05 01 05 B9 04 75  .M.....u
        .byte   $04,$35,$04,$F9,$03,$C0,$03,$8A ; DD77 04 35 04 F9 03 C0 03 8A  .5......
        .byte   $03,$57,$03,$27,$03,$FA,$02,$CF ; DD7F 03 57 03 27 03 FA 02 CF  .W.'....
        .byte   $02,$A7,$02,$81,$02,$5D,$02,$3B ; DD87 02 A7 02 81 02 5D 02 3B  .....].;
        .byte   $02,$1B,$02,$FC,$01,$E0,$01,$C5 ; DD8F 02 1B 02 FC 01 E0 01 C5  ........
        .byte   $01,$AC,$01,$94,$01,$7D,$01,$68 ; DD97 01 AC 01 94 01 7D 01 68  .....}.h
        .byte   $01,$53,$01,$40,$01,$2E,$01,$1D ; DD9F 01 53 01 40 01 2E 01 1D  .S.@....
        .byte   $01,$0D,$01,$FE,$00,$F0,$00,$E2 ; DDA7 01 0D 01 FE 00 F0 00 E2  ........
        .byte   $00,$D6,$00,$CA,$00,$BE,$00,$B4 ; DDAF 00 D6 00 CA 00 BE 00 B4  ........
        .byte   $00,$AA,$00,$A0,$00,$97,$00,$8F ; DDB7 00 AA 00 A0 00 97 00 8F  ........
        .byte   $00,$87,$00,$7F,$00,$78,$00,$71 ; DDBF 00 87 00 7F 00 78 00 71  .....x.q
        .byte   $00,$6B,$00,$65,$00,$5F,$00,$5A ; DDC7 00 6B 00 65 00 5F 00 5A  .k.e._.Z
        .byte   $00,$55,$00,$50,$00,$4C,$00,$47 ; DDCF 00 55 00 50 00 4C 00 47  .U.P.L.G
        .byte   $00,$43,$00,$40,$00,$3C,$00,$39 ; DDD7 00 43 00 40 00 3C 00 39  .C.@.<.9
        .byte   $00,$35,$00,$32,$00,$30,$00,$2D ; DDDF 00 35 00 32 00 30 00 2D  .5.2.0.-
        .byte   $00,$2A,$00,$28,$00,$26,$00,$23 ; DDE7 00 2A 00 28 00 26 00 23  .*.(.&.#
        .byte   $00,$21,$00,$1F,$00,$1D,$00,$1B ; DDEF 00 21 00 1F 00 1D 00 1B  .!......
        .byte   $00,$1A,$00,$01,$00             ; DDF7 00 1A 00 01 00           .....
LDDFC:
        .byte   $00                             ; DDFC 00                       .
LDDFD:
        .byte   $00,$00,$0F,$80,$07,$C0,$03,$E0 ; DDFD 00 00 0F 80 07 C0 03 E0  ........
        .byte   $01,$00,$05,$80,$02,$40,$01,$00 ; DE05 01 00 05 80 02 40 01 00  .....@..
        .byte   $03,$F0,$00,$78,$00,$3C,$00,$1E ; DE0D 03 F0 00 78 00 3C 00 1E  ...x.<..
        .byte   $00,$A0,$00,$50,$00,$80,$01     ; DE15 00 A0 00 50 00 80 01     ...P...
LDE1C:
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE1C 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE24 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE2C 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE34 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE3C 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE44 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE4C 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE54 00 00 00 00 00 00 00 00  ........
        .byte   $18,$18,$18,$12,$10,$0C,$08,$01 ; DE5C 18 18 18 12 10 0C 08 01  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE64 00 00 00 00 00 00 00 00  ........
        .byte   $18,$14,$0C,$04,$01,$00,$00,$00 ; DE6C 18 14 0C 04 01 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE74 00 00 00 00 00 00 00 00  ........
        .byte   $40,$40,$40,$40,$40,$3B,$35,$2D ; DE7C 40 40 40 40 40 3B 35 2D  @@@@@;5-
        .byte   $24,$18,$0C,$04,$01,$00,$00,$00 ; DE84 24 18 0C 04 01 00 00 00  $.......
        .byte   $40,$40,$34,$28,$10,$04,$00,$00 ; DE8C 40 40 34 28 10 04 00 00  @@4(....
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; DE94 00 00 00 00 00 00 00 00  ........
LDE9C:
        .byte   $03,$00,$00,$03,$08,$08,$08,$08 ; DE9C 03 00 00 03 08 08 08 08  ........
        .byte   $04,$08,$08,$08,$08,$08,$08,$08 ; DEA4 04 08 08 08 08 08 08 08  ........
        .byte   $08,$08,$08,$08,$08,$08,$08,$08 ; DEAC 08 08 08 08 08 08 08 08  ........
        .byte   $08,$08                         ; DEB4 08 08                    ..
LDEB6:
        .byte   $00,$3C,$00,$01,$00,$01,$02,$03 ; DEB6 00 3C 00 01 00 01 02 03  .<......
        .byte   $07,$04,$05,$06,$07,$08,$09,$0A ; DEBE 07 04 05 06 07 08 09 0A  ........
        .byte   $0B,$0C,$0D,$0E,$0F,$10,$11,$12 ; DEC6 0B 0C 0D 0E 0F 10 11 12  ........
        .byte   $13,$14,$78,$CF,$78,$CF         ; DECE 13 14 78 CF 78 CF        ..x.x.
LDED4:
        .byte   $00                             ; DED4 00                       .
LDED5:
        .byte   $00,$03,$00,$07,$00,$0B,$00,$0F ; DED5 00 03 00 07 00 0B 00 0F  ........
        .byte   $00,$13,$00,$17,$00,$1B,$00,$1F ; DEDD 00 13 00 17 00 1B 00 1F  ........
        .byte   $00,$23,$00,$24,$00,$25,$00,$26 ; DEE5 00 23 00 24 00 25 00 26  .#.$.%.&
        .byte   $00,$27,$00,$28,$00,$29,$00,$2A ; DEED 00 27 00 28 00 29 00 2A  .'.(.).*
        .byte   $00,$2B,$00,$2C,$00,$2D,$00,$2E ; DEF5 00 2B 00 2C 00 2D 00 2E  .+.,.-..
        .byte   $00                             ; DEFD 00                       .
LDEFE:
        .byte   $FF,$FF,$FF,$FF,$00,$00,$FF,$FF ; DEFE FF FF FF FF 00 00 FF FF  ........
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; DF06 FF FF FF FF FF FF FF FF  ........
        .byte   $FF,$FF,$FF,$FF,$FF,$07,$07,$07 ; DF0E FF FF FF FF FF 07 07 07  ........
        .byte   $07,$07,$07,$07,$07,$07,$07,$07 ; DF16 07 07 07 07 07 07 07 07  ........
        .byte   $07,$07,$07,$07,$08,$08,$08,$08 ; DF1E 07 07 07 07 08 08 08 08  ........
        .byte   $08,$08,$08,$08,$08,$08,$08,$08 ; DF26 08 08 08 08 08 08 08 08  ........
        .byte   $08,$08,$08,$08,$07,$07,$07,$07 ; DF2E 08 08 08 08 07 07 07 07  ........
        .byte   $1D,$1D,$1D,$1D,$1D,$1D,$1D,$3E ; DF36 1D 1D 1D 1D 1D 1D 1D 3E  .......>
        .byte   $3E,$3E,$3E,$3E,$00,$01,$02,$00 ; DF3E 3E 3E 3E 3E 00 01 02 00  >>>>....
        .byte   $01,$02,$03,$00,$01,$02,$03,$00 ; DF46 01 02 03 00 01 02 03 00  ........
        .byte   $01,$02,$03,$00,$01,$02,$03,$00 ; DF4E 01 02 03 00 01 02 03 00  ........
        .byte   $01,$02,$03,$00,$01,$02,$03,$00 ; DF56 01 02 03 00 01 02 03 00  ........
        .byte   $01,$02,$03,$00,$01,$02,$03,$03 ; DF5E 01 02 03 00 01 02 03 03  ........
        .byte   $03,$01,$01,$00,$01,$01,$00,$03 ; DF66 03 01 01 00 01 01 00 03  ........
        .byte   $03,$03,$03,$43,$E0,$64,$E3,$CF ; DF6E 03 03 03 43 E0 64 E3 CF  ...C.d..
        .byte   $E5,$34,$E8,$01,$EC,$26,$EE,$45 ; DF76 E5 34 E8 01 EC 26 EE 45  .4...&.E
        .byte   $F0,$30,$F5,$CD,$F5,$0A,$F6,$7F ; DF7E F0 30 F5 CD F5 0A F6 7F  .0......
        .byte   $F6,$D3,$F6,$8E,$F7,$E9,$F7,$D6 ; DF86 F6 D3 F6 8E F7 E9 F7 D6  ........
        .byte   $F8,$E1,$F2,$7F,$F3,$39,$F4,$FD ; DF8E F8 E1 F2 7F F3 39 F4 FD  .....9..
        .byte   $F4,$11,$F2,$33,$F2,$53,$F2,$67 ; DF96 F4 11 F2 33 F2 53 F2 67  ...3.S.g
        .byte   $F2,$8B,$F1,$B9,$F1,$DF,$F1,$05 ; DF9E F2 8B F1 B9 F1 DF F1 05  ........
        .byte   $F2,$73,$F2,$97,$F2,$B9,$F2,$D7 ; DFA6 F2 73 F2 97 F2 B9 F2 D7  .s......
        .byte   $F2,$02,$F9,$BE,$F9,$92,$FA,$60 ; DFAE F2 02 F9 BE F9 92 FA 60  .......`
        .byte   $FB,$BF,$FB,$E6,$FB,$2D,$FC,$86 ; DFB6 FB BF FB E6 FB 2D FC 86  .....-..
        .byte   $FC,$AF,$FC,$F8,$FC,$31,$FD,$62 ; DFBE FC AF FC F8 FC 31 FD 62  .....1.b
        .byte   $FD,$95,$FD,$DE,$FD,$2D,$FE,$6E ; DFC6 FD 95 FD DE FD 2D FE 6E  .....-.n
        .byte   $FE,$01,$00,$02,$00,$00         ; DFCE FE 01 00 02 00 00        ......
LDFD4:
        .byte   $00                             ; DFD4 00                       .
LDFD5:
        .byte   $04,$00,$05,$00,$06,$00,$00,$00 ; DFD5 04 00 05 00 06 00 00 00  ........
        .byte   $08,$00,$09,$00,$0A,$00,$00,$00 ; DFDD 08 00 09 00 0A 00 00 00  ........
        .byte   $0C,$00,$0D,$00,$0E,$00,$00,$00 ; DFE5 0C 00 0D 00 0E 00 00 00  ........
        .byte   $10,$00,$11,$00,$12,$00,$00,$00 ; DFED 10 00 11 00 12 00 00 00  ........
        .byte   $14,$00,$15,$00,$16,$00,$00,$00 ; DFF5 14 00 15 00 16 00 00 00  ........
        .byte   $18,$00,$19,$00,$1A,$00,$00,$00 ; DFFD 18 00 19 00 1A 00 00 00  ........
        .byte   $1C,$00,$1D,$00,$1E,$00,$00,$00 ; E005 1C 00 1D 00 1E 00 00 00  ........
        .byte   $20,$00,$21,$00,$22,$00,$00,$00 ; E00D 20 00 21 00 22 00 00 00   .!."...
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; E015 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; E01D 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; E025 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00                         ; E02D 00 00                    ..
LE02F:
        .byte   $00                             ; E02F 00                       .
LE030:
        .byte   $00                             ; E030 00                       .
LE031:
        .byte   $00                             ; E031 00                       .
LE032:
        .byte   $00,$01,$68,$03,$F0,$06,$F8,$00 ; E032 00 01 68 03 F0 06 F8 00  ..h.....
        .byte   $00,$01,$68,$03,$E0,$06,$F8,$00 ; E03A 00 01 68 03 E0 06 F8 00  ..h.....
        .byte   $00,$82,$05,$80,$20,$8E,$02,$43 ; E042 00 82 05 80 20 8E 02 43  .... ..C
        .byte   $13,$44,$14,$00,$04,$44,$02,$43 ; E04A 13 44 14 00 04 44 02 43  .D...D.C
        .byte   $13,$44,$13,$44,$02,$43,$84,$44 ; E052 13 44 13 44 02 43 84 44  .D.D.C.D
        .byte   $84,$43,$84,$44,$04,$46,$84,$44 ; E05A 84 43 84 44 04 46 84 44  .C.D.F.D
        .byte   $04,$43,$84,$41,$04,$43,$03,$44 ; E062 04 43 84 41 04 43 03 44  .C.A.C.D
        .byte   $14,$00,$04,$44,$02,$41,$13,$42 ; E06A 14 00 04 44 02 41 13 42  ...D.A.B
        .byte   $14,$00,$04,$42,$02,$41,$13,$42 ; E072 14 00 04 42 02 41 13 42  ...B.A.B
        .byte   $13,$42,$02,$41,$84,$42,$84,$41 ; E07A 13 42 02 41 84 42 84 41  .B.A.B.A
        .byte   $84,$42,$04,$44,$84,$42,$84,$41 ; E082 84 42 04 44 84 42 84 41  .B.D.B.A
        .byte   $84,$3F,$04,$81,$FE,$3D,$84,$3F ; E08A 84 3F 04 81 FE 3D 84 3F  .?...=.?
        .byte   $84,$81,$FE,$3D,$84,$3F,$04,$81 ; E092 84 81 FE 3D 84 3F 04 81  ...=.?..
        .byte   $FE,$41,$84,$3F,$84,$81,$FE,$3D ; E09A FE 41 84 3F 84 81 FE 3D  .A.?...=
        .byte   $84,$3C,$84,$81,$0E,$8F,$00,$80 ; E0A2 84 3C 84 81 0E 8F 00 80  .<......
        .byte   $2B,$8E,$02,$48,$14,$48,$14,$46 ; E0AA 2B 8E 02 48 14 48 14 46  +..H.H.F
        .byte   $14,$46,$14,$44,$14,$44,$14,$46 ; E0B2 14 46 14 44 14 44 14 46  .F.D.D.F
        .byte   $14,$46,$14,$8F,$00,$48,$14,$48 ; E0BA 14 46 14 8F 00 48 14 48  .F...H.H
        .byte   $14,$46,$14,$46,$14,$44,$14,$44 ; E0C2 14 46 14 46 14 44 14 44  .F.F.D.D
        .byte   $14,$43,$14,$43,$14,$41,$13,$00 ; E0CA 14 43 14 43 14 41 13 00  .C.C.A..
        .byte   $42,$3C,$14,$3C,$14,$3D,$84,$3C ; E0D2 42 3C 14 3C 14 3D 84 3C  B<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E0DA 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E0E2 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E0EA 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3A,$14,$3A,$14,$3C,$84,$3A ; E0F2 14 3A 14 3A 14 3C 84 3A  .:.:.<.:
        .byte   $14,$38,$14,$38,$14,$3A,$84,$38 ; E0FA 14 38 14 38 14 3A 84 38  .8.8.:.8
        .byte   $14,$37,$14,$37,$14,$38,$84,$37 ; E102 14 37 14 37 14 38 84 37  .7.7.8.7
        .byte   $04,$38,$14,$38,$14,$38,$14,$00 ; E10A 04 38 14 38 14 38 14 00  .8.8.8..
        .byte   $04,$3C,$14,$3C,$14,$3D,$84,$3C ; E112 04 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E11A 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E122 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3C,$14,$3C,$14,$3D,$84,$3C ; E12A 14 3C 14 3C 14 3D 84 3C  .<.<.=.<
        .byte   $14,$3A,$14,$3A,$14,$3C,$84,$3A ; E132 14 3A 14 3A 14 3C 84 3A  .:.:.<.:
        .byte   $14,$38,$14,$38,$14,$3A,$84,$38 ; E13A 14 38 14 38 14 3A 84 38  .8.8.:.8
        .byte   $14,$37,$14,$37,$14,$38,$84,$37 ; E142 14 37 14 37 14 38 84 37  .7.7.8.7
        .byte   $14,$38,$14,$38,$14,$3A,$84,$38 ; E14A 14 38 14 38 14 3A 84 38  .8.8.:.8
        .byte   $14,$3A,$14,$3A,$14,$3C,$84,$3A ; E152 14 3A 14 3A 14 3C 84 3A  .:.:.<.:
        .byte   $14,$38,$14,$38,$14,$3A,$84,$38 ; E15A 14 38 14 38 14 3A 84 38  .8.8.:.8
        .byte   $14,$37,$14,$37,$14,$38,$84,$37 ; E162 14 37 14 37 14 38 84 37  .7.7.8.7
        .byte   $14,$38,$14,$38,$14,$38,$14,$00 ; E16A 14 38 14 38 14 38 14 00  .8.8.8..
        .byte   $04,$3C,$14,$3C,$14,$3D,$09,$3C ; E172 04 3C 14 3C 14 3D 09 3C  .<.<.=.<
        .byte   $09,$3C,$14,$3C,$14,$3C,$14,$3D ; E17A 09 3C 14 3C 14 3C 14 3D  .<.<.<.=
        .byte   $09,$3C,$09,$3C,$14,$3C,$14,$3C ; E182 09 3C 09 3C 14 3C 14 3C  .<.<.<.<
        .byte   $14,$3D,$09,$3C,$09,$3C,$14,$3C ; E18A 14 3D 09 3C 09 3C 14 3C  .=.<.<.<
        .byte   $14,$3C,$14,$3D,$09,$3C,$09,$3C ; E192 14 3C 14 3D 09 3C 09 3C  .<.=.<.<
        .byte   $14,$3A,$14,$3A,$14,$3C,$09,$3A ; E19A 14 3A 14 3A 14 3C 09 3A  .:.:.<.:
        .byte   $09,$3A,$14,$38,$14,$38,$14,$3A ; E1A2 09 3A 14 38 14 38 14 3A  .:.8.8.:
        .byte   $09,$38,$09,$38,$14,$37,$14,$37 ; E1AA 09 38 09 38 14 37 14 37  .8.8.7.7
        .byte   $14,$38,$09,$37,$09,$37,$14,$38 ; E1B2 14 38 09 37 09 37 14 38  .8.7.7.8
        .byte   $14,$38,$14,$3A,$09,$38,$09,$38 ; E1BA 14 38 14 3A 09 38 09 38  .8.:.8.8
        .byte   $14,$3A,$14,$3A,$14,$3C,$09,$3A ; E1C2 14 3A 14 3A 14 3C 09 3A  .:.:.<.:
        .byte   $09,$3A,$14,$38,$14,$38,$14,$3A ; E1CA 09 3A 14 38 14 38 14 3A  .:.8.8.:
        .byte   $09,$38,$09,$38,$14,$37,$14,$37 ; E1D2 09 38 09 38 14 37 14 37  .8.8.7.7
        .byte   $14,$38,$09,$37,$09,$37,$14,$38 ; E1DA 14 38 09 37 09 37 14 38  .8.7.7.8
        .byte   $14,$38,$14,$38,$14,$00,$04,$3C ; E1E2 14 38 14 38 14 00 04 3C  .8.8...<
        .byte   $14,$3C,$14,$3D,$09,$3C,$09,$3A ; E1EA 14 3C 14 3D 09 3C 09 3A  .<.=.<.:
        .byte   $09,$3C,$09,$3C,$14,$3C,$14,$3D ; E1F2 09 3C 09 3C 14 3C 14 3D  .<.<.<.=
        .byte   $09,$3C,$09,$3A,$09,$3C,$09,$3C ; E1FA 09 3C 09 3A 09 3C 09 3C  .<.:.<.<
        .byte   $14,$3C,$14,$3D,$09,$3C,$09,$3A ; E202 14 3C 14 3D 09 3C 09 3A  .<.=.<.:
        .byte   $09,$3C,$09,$3C,$14,$3C,$14,$3D ; E20A 09 3C 09 3C 14 3C 14 3D  .<.<.<.=
        .byte   $09,$3C,$09,$3A,$09,$3C,$09,$3A ; E212 09 3C 09 3A 09 3C 09 3A  .<.:.<.:
        .byte   $14,$3A,$14,$3C,$09,$3A,$09,$38 ; E21A 14 3A 14 3C 09 3A 09 38  .:.<.:.8
        .byte   $09,$3A,$09,$38,$14,$38,$14,$3A ; E222 09 3A 09 38 14 38 14 3A  .:.8.8.:
        .byte   $09,$38,$09,$37,$09,$38,$09,$37 ; E22A 09 38 09 37 09 38 09 37  .8.7.8.7
        .byte   $14,$37,$14,$38,$09,$37,$09,$35 ; E232 14 37 14 38 09 37 09 35  .7.8.7.5
        .byte   $09,$37,$09,$38,$14,$38,$14,$3A ; E23A 09 37 09 38 14 38 14 3A  .7.8.8.:
        .byte   $09,$38,$09,$37,$09,$38,$09,$3A ; E242 09 38 09 37 09 38 09 3A  .8.7.8.:
        .byte   $14,$3A,$14,$3C,$09,$3A,$09,$38 ; E24A 14 3A 14 3C 09 3A 09 38  .:.<.:.8
        .byte   $09,$3A,$09,$38,$14,$38,$14,$3A ; E252 09 3A 09 38 14 38 14 3A  .:.8.8.:
        .byte   $09,$38,$09,$37,$09,$38,$09,$37 ; E25A 09 38 09 37 09 38 09 37  .8.7.8.7
        .byte   $14,$37,$14,$38,$09,$37,$09,$35 ; E262 14 37 14 38 09 37 09 35  .7.8.7.5
        .byte   $09,$37,$09,$38,$09,$37,$09,$35 ; E26A 09 37 09 38 09 37 09 35  .7.8.7.5
        .byte   $09,$37,$09,$38,$09,$37,$09,$35 ; E272 09 37 09 38 09 37 09 35  .7.8.7.5
        .byte   $09,$37,$09,$3F,$09,$3D,$09,$3C ; E27A 09 37 09 3F 09 3D 09 3C  .7.?.=.<
        .byte   $09,$3A,$09,$3D,$09,$3C,$09,$3A ; E282 09 3A 09 3D 09 3C 09 3A  .:.=.<.:
        .byte   $09,$38,$09,$3C,$09,$3A,$09,$38 ; E28A 09 38 09 3C 09 3A 09 38  .8.<.:.8
        .byte   $09,$37,$09,$3A,$09,$38,$09,$37 ; E292 09 37 09 3A 09 38 09 37  .7.:.8.7
        .byte   $09,$3A,$09,$38,$14,$38,$14,$38 ; E29A 09 3A 09 38 14 38 14 38  .:.8.8.8
        .byte   $14,$00,$04,$00,$02,$80,$30,$8E ; E2A2 14 00 04 00 02 80 30 8E  ......0.
        .byte   $02,$48,$43,$44,$04,$3F,$13,$3F ; E2AA 02 48 43 44 04 3F 13 3F  .HCD.?.?
        .byte   $13,$49,$43,$46,$04,$43,$13,$41 ; E2B2 13 49 43 46 04 43 13 41  .ICF.C.A
        .byte   $13,$3F,$13,$3F,$13,$41,$13,$43 ; E2BA 13 3F 13 3F 13 41 13 43  .?.?.A.C
        .byte   $13,$46,$04,$44,$03,$43,$09,$44 ; E2C2 13 46 04 44 03 43 09 44  .F.D.C.D
        .byte   $09,$46,$09,$44,$09,$43,$09,$46 ; E2CA 09 46 09 44 09 43 09 46  .F.D.C.F
        .byte   $09,$44,$13,$8F,$00,$48,$13,$48 ; E2D2 09 44 13 8F 00 48 13 48  .D...H.H
        .byte   $13,$4B,$13,$4B,$13,$49,$04,$49 ; E2DA 13 4B 13 4B 13 49 04 49  .K.K.I.I
        .byte   $03,$48,$04,$49,$04,$49,$53,$46 ; E2E2 03 48 04 49 04 49 53 46  .H.I.ISF
        .byte   $13,$46,$13,$49,$13,$49,$13,$48 ; E2EA 13 46 13 49 13 49 13 48  .F.I.I.H
        .byte   $04,$48,$03,$46,$04,$48,$04,$48 ; E2F2 04 48 03 46 04 48 04 48  .H.F.H.H
        .byte   $03,$46,$04,$44,$13,$44,$13,$48 ; E2FA 03 46 04 44 13 44 13 48  .F.D.D.H
        .byte   $13,$48,$13,$46,$04,$46,$03,$45 ; E302 13 48 13 46 04 46 03 45  .H.F.F.E
        .byte   $04,$46,$04,$46,$03,$43,$04,$3F ; E30A 04 46 04 46 03 43 04 3F  .F.F.C.?
        .byte   $13,$00,$04,$3F,$04,$41,$13,$43 ; E312 13 00 04 3F 04 41 13 43  ...?.A.C
        .byte   $13,$46,$04,$44,$03,$43,$09,$44 ; E31A 13 46 04 44 03 43 09 44  .F.D.C.D
        .byte   $09,$46,$09,$44,$09,$43,$09,$46 ; E322 09 46 09 44 09 43 09 46  .F.D.C.F
        .byte   $09,$44,$13,$8E,$02,$48,$43,$44 ; E32A 09 44 13 8E 02 48 43 44  .D...HCD
        .byte   $04,$3F,$13,$3F,$13,$49,$43,$46 ; E332 04 3F 13 3F 13 49 43 46  .?.?.ICF
        .byte   $04,$43,$13,$41,$13,$3F,$13,$3F ; E33A 04 43 13 41 13 3F 13 3F  .C.A.?.?
        .byte   $13,$41,$13,$43,$13,$46,$04,$44 ; E342 13 41 13 43 13 46 04 44  .A.C.F.D
        .byte   $03,$43,$09,$44,$09,$46,$09,$44 ; E34A 03 43 09 44 09 46 09 44  .C.D.F.D
        .byte   $09,$43,$09,$46,$09,$44,$13,$8F ; E352 09 43 09 46 09 44 13 8F  .C.F.D..
        .byte   $00,$00,$02,$84,$00,$99,$47,$E0 ; E35A 00 00 02 84 00 99 47 E0  ......G.
        .byte   $00,$00,$82,$03,$80,$20,$8E,$02 ; E362 00 00 82 03 80 20 8E 02  ..... ..
        .byte   $00,$03,$3C,$14,$00,$04,$00,$03 ; E36A 00 03 3C 14 00 04 00 03  ..<.....
        .byte   $3C,$03,$00,$03,$3C,$13,$00,$03 ; E372 3C 03 00 03 3C 13 00 03  <...<...
        .byte   $3C,$03,$00,$03,$3C,$03,$00,$03 ; E37A 3C 03 00 03 3C 03 00 03  <...<...
        .byte   $3C,$03,$00,$03,$3C,$14,$00,$04 ; E382 3C 03 00 03 3C 14 00 04  <...<...
        .byte   $00,$03,$3C,$03,$00,$03,$3A,$14 ; E38A 00 03 3C 03 00 03 3A 14  ..<...:.
        .byte   $00,$04,$00,$03,$3A,$03,$00,$03 ; E392 00 04 00 03 3A 03 00 03  ....:...
        .byte   $3A,$13,$00,$03,$3A,$03,$00,$03 ; E39A 3A 13 00 03 3A 03 00 03  :...:...
        .byte   $3A,$03,$00,$03,$3A,$03,$81,$FE ; E3A2 3A 03 00 03 3A 03 81 FE  :...:...
        .byte   $38,$84,$3A,$84,$81,$FE,$38,$84 ; E3AA 38 84 3A 84 81 FE 38 84  8.:...8.
        .byte   $3A,$04,$81,$FE,$3C,$84,$3A,$84 ; E3B2 3A 04 81 FE 3C 84 3A 84  :...<.:.
        .byte   $81,$FE,$38,$84,$37,$84,$81,$0E ; E3BA 81 FE 38 84 37 84 81 0E  ..8.7...
        .byte   $8F,$00,$80,$2B,$8E,$02,$35,$13 ; E3C2 8F 00 80 2B 8E 02 35 13  ...+..5.
        .byte   $33,$13,$31,$13,$33,$13,$8F,$00 ; E3CA 33 13 31 13 33 13 8F 00  3.1.3...
        .byte   $35,$13,$33,$13,$31,$13,$30,$13 ; E3D2 35 13 33 13 31 13 30 13  5.3.1.0.
        .byte   $30,$13,$00,$42,$8E,$03,$33,$03 ; E3DA 30 13 00 42 8E 03 33 03  0..B..3.
        .byte   $00,$03,$33,$03,$00,$03,$8F,$00 ; E3E2 00 03 33 03 00 03 8F 00  ..3.....
        .byte   $33,$03,$00,$03,$33,$14,$33,$14 ; E3EA 33 03 00 03 33 14 33 14  3...3.3.
        .byte   $33,$14,$00,$04,$8E,$05,$33,$13 ; E3F2 33 14 00 04 8E 05 33 13  3.....3.
        .byte   $33,$13,$33,$13,$33,$13,$8F,$00 ; E3FA 33 13 33 13 33 13 8F 00  3.3.3...
        .byte   $33,$13,$33,$13,$33,$13,$33,$14 ; E402 33 13 33 13 33 13 33 14  3.3.3.3.
        .byte   $00,$04,$8E,$05,$33,$13,$33,$13 ; E40A 00 04 8E 05 33 13 33 13  ....3.3.
        .byte   $33,$13,$33,$14,$33,$14,$8F,$00 ; E412 33 13 33 14 33 14 8F 00  3.3.3...
        .byte   $33,$13,$33,$13,$33,$13,$33,$14 ; E41A 33 13 33 13 33 13 33 14  3.3.3.3.
        .byte   $00,$04,$8E,$02,$2C,$07,$30,$07 ; E422 00 04 8E 02 2C 07 30 07  ....,.0.
        .byte   $33,$07,$38,$07,$33,$07,$30,$07 ; E42A 33 07 38 07 33 07 30 07  3.8.3.0.
        .byte   $2C,$07,$30,$07,$33,$07,$38,$07 ; E432 2C 07 30 07 33 07 38 07  ,.0.3.8.
        .byte   $33,$07,$30,$07,$8F,$00,$8E,$03 ; E43A 33 07 30 07 8F 00 8E 03  3.0.....
        .byte   $2B,$07,$31,$07,$33,$07,$37,$07 ; E442 2B 07 31 07 33 07 37 07  +.1.3.7.
        .byte   $33,$07,$31,$07,$2C,$07,$30,$07 ; E44A 33 07 31 07 2C 07 30 07  3.1.,.0.
        .byte   $33,$07,$38,$07,$33,$07,$30,$07 ; E452 33 07 38 07 33 07 30 07  3.8.3.0.
        .byte   $8F,$00,$8E,$02,$2B,$07,$31,$07 ; E45A 8F 00 8E 02 2B 07 31 07  ....+.1.
        .byte   $33,$07,$37,$07,$33,$07,$31,$07 ; E462 33 07 37 07 33 07 31 07  3.7.3.1.
        .byte   $2B,$07,$31,$07,$33,$07,$37,$07 ; E46A 2B 07 31 07 33 07 37 07  +.1.3.7.
        .byte   $33,$07,$31,$07,$8F,$00,$33,$14 ; E472 33 07 31 07 8F 00 33 14  3.1...3.
        .byte   $33,$14,$33,$14,$00,$04,$00,$02 ; E47A 33 14 33 14 00 04 00 02  3.3.....
        .byte   $80,$30,$8E,$02,$00,$04,$33,$04 ; E482 80 30 8E 02 00 04 33 04  .0....3.
        .byte   $00,$04,$33,$04,$00,$04,$33,$04 ; E48A 00 04 33 04 00 04 33 04  ..3...3.
        .byte   $00,$04,$33,$04,$00,$04,$35,$04 ; E492 00 04 33 04 00 04 35 04  ..3...5.
        .byte   $00,$04,$35,$04,$00,$04,$35,$04 ; E49A 00 04 35 04 00 04 35 04  ..5...5.
        .byte   $00,$04,$35,$04,$00,$04,$31,$04 ; E4A2 00 04 35 04 00 04 31 04  ..5...1.
        .byte   $00,$04,$31,$04,$00,$04,$31,$04 ; E4AA 00 04 31 04 00 04 31 04  ..1...1.
        .byte   $00,$04,$31,$04,$00,$04,$33,$04 ; E4B2 00 04 31 04 00 04 33 04  ..1...3.
        .byte   $00,$04,$33,$04,$00,$04,$31,$04 ; E4BA 00 04 33 04 00 04 31 04  ..3...1.
        .byte   $00,$04,$33,$04,$8F,$00,$00,$04 ; E4C2 00 04 33 04 8F 00 00 04  ..3.....
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E4CA 33 04 00 04 33 04 00 04  3...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E4D2 33 04 00 04 33 04 00 04  3...3...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E4DA 35 04 00 04 35 04 00 04  5...5...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E4E2 35 04 00 04 35 04 00 04  5...5...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E4EA 31 04 00 04 31 04 00 04  1...1...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E4F2 31 04 00 04 31 04 00 04  1...1...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E4FA 33 04 00 04 33 04 00 04  3...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E502 33 04 00 04 33 04 00 04  3...3...
        .byte   $30,$04,$00,$04,$30,$04,$00,$04 ; E50A 30 04 00 04 30 04 00 04  0...0...
        .byte   $30,$04,$00,$04,$30,$04,$00,$04 ; E512 30 04 00 04 30 04 00 04  0...0...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E51A 35 04 00 04 35 04 00 04  5...5...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E522 35 04 00 04 35 04 00 04  5...5...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E52A 31 04 00 04 31 04 00 04  1...1...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E532 31 04 00 04 31 04 00 04  1...1...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E53A 33 04 00 04 33 04 00 04  3...3...
        .byte   $31,$04,$00,$04,$33,$04,$00,$04 ; E542 31 04 00 04 33 04 00 04  1...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E54A 33 04 00 04 33 04 00 04  3...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E552 33 04 00 04 33 04 00 04  3...3...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E55A 35 04 00 04 35 04 00 04  5...5...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E562 35 04 00 04 35 04 00 04  5...5...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E56A 31 04 00 04 31 04 00 04  1...1...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E572 31 04 00 04 31 04 00 04  1...1...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E57A 33 04 00 04 33 04 00 04  3...3...
        .byte   $31,$04,$00,$04,$33,$04,$00,$04 ; E582 31 04 00 04 33 04 00 04  1...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E58A 33 04 00 04 33 04 00 04  3...3...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E592 33 04 00 04 33 04 00 04  3...3...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E59A 35 04 00 04 35 04 00 04  5...5...
        .byte   $35,$04,$00,$04,$35,$04,$00,$04 ; E5A2 35 04 00 04 35 04 00 04  5...5...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E5AA 31 04 00 04 31 04 00 04  1...1...
        .byte   $31,$04,$00,$04,$31,$04,$00,$04 ; E5B2 31 04 00 04 31 04 00 04  1...1...
        .byte   $33,$04,$00,$04,$33,$04,$00,$04 ; E5BA 33 04 00 04 33 04 00 04  3...3...
        .byte   $31,$04,$30,$13,$00,$02,$84,$00 ; E5C2 31 04 30 13 00 02 84 00  1.0.....
        .byte   $99,$68,$E3,$00,$00,$82,$03,$80 ; E5CA 99 68 E3 00 00 82 03 80  .h......
        .byte   $20,$8E,$02,$29,$03,$38,$14,$00 ; E5D2 20 8E 02 29 03 38 14 00   ..).8..
        .byte   $04,$24,$03,$38,$03,$29,$03,$38 ; E5DA 04 24 03 38 03 29 03 38  .$.8.).8
        .byte   $13,$24,$03,$38,$03,$29,$03,$38 ; E5E2 13 24 03 38 03 29 03 38  .$.8.).8
        .byte   $03,$24,$03,$38,$03,$29,$03,$38 ; E5EA 03 24 03 38 03 29 03 38  .$.8.).8
        .byte   $14,$00,$04,$24,$03,$38,$03,$27 ; E5F2 14 00 04 24 03 38 03 27  ...$.8.'
        .byte   $03,$36,$14,$00,$04,$22,$03,$36 ; E5FA 03 36 14 00 04 22 03 36  .6...".6
        .byte   $03,$27,$03,$36,$13,$22,$03,$36 ; E602 03 27 03 36 13 22 03 36  .'.6.".6
        .byte   $03,$27,$03,$36,$03,$22,$03,$36 ; E60A 03 27 03 36 03 22 03 36  .'.6.".6
        .byte   $03,$81,$FE,$00,$03,$81,$FE,$00 ; E612 03 81 FE 00 03 81 FE 00  ........
        .byte   $03,$81,$FE,$00,$03,$81,$FE,$00 ; E61A 03 81 FE 00 03 81 FE 00  ........
        .byte   $03,$81,$0E,$8F,$00,$80,$2B,$8E ; E622 03 81 0E 8F 00 80 2B 8E  ......+.
        .byte   $02,$31,$13,$30,$13,$2E,$13,$30 ; E62A 02 31 13 30 13 2E 13 30  .1.0...0
        .byte   $13,$8F,$00,$31,$13,$30,$13,$2E ; E632 13 8F 00 31 13 30 13 2E  ...1.0..
        .byte   $13,$2E,$13,$2C,$13,$00,$03,$1D ; E63A 13 2E 13 2C 13 00 03 1D  ...,....
        .byte   $13,$00,$03,$30,$03,$00,$03,$30 ; E642 13 00 03 30 03 00 03 30  ...0...0
        .byte   $03,$00,$03,$30,$03,$00,$03,$30 ; E64A 03 00 03 30 03 00 03 30  ...0...0
        .byte   $03,$00,$03,$31,$03,$00,$03,$30 ; E652 03 00 03 31 03 00 03 30  ...1...0
        .byte   $03,$00,$03,$31,$03,$00,$03,$30 ; E65A 03 00 03 31 03 00 03 30  ...1...0
        .byte   $14,$30,$14,$30,$14,$00,$04,$8E ; E662 14 30 14 30 14 00 04 8E  .0.0....
        .byte   $02,$30,$13,$30,$13,$30,$13,$30 ; E66A 02 30 13 30 13 30 13 30  .0.0.0.0
        .byte   $13,$8F,$00,$8E,$03,$31,$13,$31 ; E672 13 8F 00 8E 03 31 13 31  .....1.1
        .byte   $13,$30,$13,$30,$13,$8F,$00,$31 ; E67A 13 30 13 30 13 8F 00 31  .0.0...1
        .byte   $13,$31,$13,$30,$14,$30,$14,$30 ; E682 13 31 13 30 14 30 14 30  .1.0.0.0
        .byte   $14,$00,$04,$8E,$02,$30,$13,$30 ; E68A 14 00 04 8E 02 30 13 30  .....0.0
        .byte   $13,$30,$13,$30,$14,$30,$14,$8F ; E692 13 30 13 30 14 30 14 8F  .0.0.0..
        .byte   $00,$8E,$03,$31,$13,$31,$13,$30 ; E69A 00 8E 03 31 13 31 13 30  ...1.1.0
        .byte   $13,$30,$14,$30,$14,$8F,$00,$31 ; E6A2 13 30 14 30 14 8F 00 31  .0.0...1
        .byte   $13,$31,$13,$30,$14,$30,$14,$30 ; E6AA 13 31 13 30 14 30 14 30  .1.0.0.0
        .byte   $14,$00,$04,$8E,$02,$2C,$13,$2C ; E6B2 14 00 04 8E 02 2C 13 2C  .....,.,
        .byte   $13,$2C,$13,$2C,$13,$8F,$00,$8E ; E6BA 13 2C 13 2C 13 8F 00 8E  .,.,....
        .byte   $03,$27,$13,$27,$13,$2C,$13,$2C ; E6C2 03 27 13 27 13 2C 13 2C  .'.'.,.,
        .byte   $13,$8F,$00,$27,$13,$27,$13,$27 ; E6CA 13 8F 00 27 13 27 13 27  ...'.'.'
        .byte   $13,$27,$13,$27,$13,$27,$13,$27 ; E6D2 13 27 13 27 13 27 13 27  .'.'.'.'
        .byte   $13,$27,$13,$2C,$14,$2C,$14,$2C ; E6DA 13 27 13 2C 14 2C 14 2C  .'.,.,.,
        .byte   $14,$00,$04,$00,$02,$80,$30,$8E ; E6E2 14 00 04 00 02 80 30 8E  ......0.
        .byte   $02,$2C,$04,$30,$04,$27,$04,$30 ; E6EA 02 2C 04 30 04 27 04 30  .,.0.'.0
        .byte   $04,$2C,$04,$30,$04,$27,$04,$30 ; E6F2 04 2C 04 30 04 27 04 30  .,.0.'.0
        .byte   $04,$2E,$04,$31,$04,$29,$04,$31 ; E6FA 04 2E 04 31 04 29 04 31  ...1.).1
        .byte   $04,$2E,$04,$31,$04,$29,$04,$31 ; E702 04 2E 04 31 04 29 04 31  ...1.).1
        .byte   $04,$27,$04,$2B,$04,$2C,$04,$2B ; E70A 04 27 04 2B 04 2C 04 2B  .'.+.,.+
        .byte   $04,$27,$04,$2B,$04,$2C,$04,$2B ; E712 04 27 04 2B 04 2C 04 2B  .'.+.,.+
        .byte   $04,$2C,$04,$30,$04,$29,$04,$30 ; E71A 04 2C 04 30 04 29 04 30  .,.0.).0
        .byte   $04,$27,$04,$2B,$04,$2C,$04,$30 ; E722 04 27 04 2B 04 2C 04 30  .'.+.,.0
        .byte   $04,$8F,$00,$2C,$04,$30,$04,$27 ; E72A 04 8F 00 2C 04 30 04 27  ...,.0.'
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E732 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$2E,$04,$31,$04,$29 ; E73A 04 30 04 2E 04 31 04 29  .0...1.)
        .byte   $04,$31,$04,$2E,$04,$31,$04,$29 ; E742 04 31 04 2E 04 31 04 29  .1...1.)
        .byte   $04,$31,$04,$27,$04,$2B,$04,$22 ; E74A 04 31 04 27 04 2B 04 22  .1.'.+."
        .byte   $04,$2B,$04,$27,$04,$2B,$04,$22 ; E752 04 2B 04 27 04 2B 04 22  .+.'.+."
        .byte   $04,$2B,$04,$2C,$04,$30,$04,$27 ; E75A 04 2B 04 2C 04 30 04 27  .+.,.0.'
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E762 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$29,$04,$2C,$04,$24 ; E76A 04 30 04 29 04 2C 04 24  .0.).,.$
        .byte   $04,$2C,$04,$29,$04,$2C,$04,$24 ; E772 04 2C 04 29 04 2C 04 24  .,.).,.$
        .byte   $04,$2C,$04,$2E,$04,$31,$04,$29 ; E77A 04 2C 04 2E 04 31 04 29  .,...1.)
        .byte   $04,$31,$04,$2E,$04,$31,$04,$29 ; E782 04 31 04 2E 04 31 04 29  .1...1.)
        .byte   $04,$31,$04,$27,$04,$2B,$04,$2C ; E78A 04 31 04 27 04 2B 04 2C  .1.'.+.,
        .byte   $04,$2B,$04,$27,$04,$2B,$04,$2C ; E792 04 2B 04 27 04 2B 04 2C  .+.'.+.,
        .byte   $04,$2B,$04,$2C,$04,$30,$04,$29 ; E79A 04 2B 04 2C 04 30 04 29  .+.,.0.)
        .byte   $04,$30,$04,$27,$04,$2B,$04,$2C ; E7A2 04 30 04 27 04 2B 04 2C  .0.'.+.,
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E7AA 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E7B2 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$2E,$04,$31,$04,$29 ; E7BA 04 30 04 2E 04 31 04 29  .0...1.)
        .byte   $04,$31,$04,$2E,$04,$31,$04,$29 ; E7C2 04 31 04 2E 04 31 04 29  .1...1.)
        .byte   $04,$31,$04,$27,$04,$2B,$04,$2C ; E7CA 04 31 04 27 04 2B 04 2C  .1.'.+.,
        .byte   $04,$2B,$04,$27,$04,$2B,$04,$2C ; E7D2 04 2B 04 27 04 2B 04 2C  .+.'.+.,
        .byte   $04,$2B,$04,$2C,$04,$30,$04,$29 ; E7DA 04 2B 04 2C 04 30 04 29  .+.,.0.)
        .byte   $04,$30,$04,$27,$04,$2B,$04,$2C ; E7E2 04 30 04 27 04 2B 04 2C  .0.'.+.,
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E7EA 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$2C,$04,$30,$04,$27 ; E7F2 04 30 04 2C 04 30 04 27  .0.,.0.'
        .byte   $04,$30,$04,$2E,$04,$31,$04,$29 ; E7FA 04 30 04 2E 04 31 04 29  .0...1.)
        .byte   $04,$31,$04,$2E,$04,$31,$04,$29 ; E802 04 31 04 2E 04 31 04 29  .1...1.)
        .byte   $04,$31,$04,$27,$04,$2B,$04,$2C ; E80A 04 31 04 27 04 2B 04 2C  .1.'.+.,
        .byte   $04,$2B,$04,$27,$04,$2B,$04,$2C ; E812 04 2B 04 27 04 2B 04 2C  .+.'.+.,
        .byte   $04,$2B,$04,$2C,$04,$30,$04,$29 ; E81A 04 2B 04 2C 04 30 04 29  .+.,.0.)
        .byte   $04,$30,$04,$27,$04,$2B,$04,$2C ; E822 04 30 04 27 04 2B 04 2C  .0.'.+.,
        .byte   $03,$00,$02,$84,$00,$99,$D3,$E5 ; E82A 03 00 02 84 00 99 D3 E5  ........
        .byte   $00,$00,$80,$2C,$82,$07,$8E,$02 ; E832 00 00 80 2C 82 07 8E 02  ...,....
        .byte   $48,$09,$00,$09,$48,$09,$00,$09 ; E83A 48 09 00 09 48 09 00 09  H...H...
        .byte   $49,$09,$48,$09,$46,$09,$49,$09 ; E842 49 09 48 09 46 09 49 09  I.H.F.I.
        .byte   $48,$09,$00,$09,$46,$09,$00,$09 ; E84A 48 09 00 09 46 09 00 09  H...F...
        .byte   $44,$84,$46,$09,$00,$09,$44,$09 ; E852 44 84 46 09 00 09 44 09  D.F...D.
        .byte   $00,$09,$44,$09,$00,$09,$46,$09 ; E85A 00 09 44 09 00 09 46 09  ..D...F.
        .byte   $44,$09,$43,$09,$44,$09,$41,$04 ; E862 44 09 43 09 44 09 41 04  D.C.D.A.
        .byte   $00,$04,$30,$04,$00,$04,$8F,$00 ; E86A 00 04 30 04 00 04 8F 00  ..0.....
        .byte   $48,$09,$00,$09,$48,$09,$00,$09 ; E872 48 09 00 09 48 09 00 09  H...H...
        .byte   $49,$09,$48,$09,$46,$09,$49,$09 ; E87A 49 09 48 09 46 09 49 09  I.H.F.I.
        .byte   $46,$09,$00,$09,$46,$09,$00,$09 ; E882 46 09 00 09 46 09 00 09  F...F...
        .byte   $48,$09,$46,$09,$44,$09,$48,$09 ; E88A 48 09 46 09 44 09 48 09  H.F.D.H.
        .byte   $44,$09,$00,$09,$44,$09,$00,$09 ; E892 44 09 00 09 44 09 00 09  D...D...
        .byte   $46,$09,$44,$09,$43,$09,$46,$09 ; E89A 46 09 44 09 43 09 46 09  F.D.C.F.
        .byte   $43,$09,$00,$09,$43,$09,$00,$09 ; E8A2 43 09 00 09 43 09 00 09  C...C...
        .byte   $44,$84,$46,$09,$00,$09,$48,$09 ; E8AA 44 84 46 09 00 09 48 09  D.F...H.
        .byte   $00,$09,$48,$09,$00,$09,$49,$09 ; E8B2 00 09 48 09 00 09 49 09  ..H...I.
        .byte   $48,$09,$46,$09,$49,$09,$48,$09 ; E8BA 48 09 46 09 49 09 48 09  H.F.I.H.
        .byte   $00,$09,$46,$09,$00,$09,$44,$84 ; E8C2 00 09 46 09 00 09 44 84  ..F...D.
        .byte   $46,$09,$00,$09,$44,$09,$00,$09 ; E8CA 46 09 00 09 44 09 00 09  F...D...
        .byte   $44,$09,$00,$09,$46,$09,$44,$09 ; E8D2 44 09 00 09 46 09 44 09  D...F.D.
        .byte   $43,$09,$44,$09,$41,$04,$00,$04 ; E8DA 43 09 44 09 41 04 00 04  C.D.A...
        .byte   $30,$04,$00,$04,$48,$09,$00,$09 ; E8E2 30 04 00 04 48 09 00 09  0...H...
        .byte   $48,$09,$00,$09,$49,$84,$4B,$09 ; E8EA 48 09 00 09 49 84 4B 09  H...I.K.
        .byte   $00,$09,$4D,$84,$4B,$09,$00,$09 ; E8F2 00 09 4D 84 4B 09 00 09  ..M.K...
        .byte   $49,$84,$48,$09,$00,$09,$46,$09 ; E8FA 49 84 48 09 00 09 46 09  I.H...F.
        .byte   $00,$09,$46,$09,$00,$09,$48,$84 ; E902 00 09 46 09 00 09 48 84  ..F...H.
        .byte   $46,$09,$00,$09,$44,$09,$00,$09 ; E90A 46 09 00 09 44 09 00 09  F...D...
        .byte   $44,$09,$00,$09,$46,$84,$48,$09 ; E912 44 09 00 09 46 84 48 09  D...F.H.
        .byte   $00,$09,$48,$09,$00,$09,$48,$09 ; E91A 00 09 48 09 00 09 48 09  ..H...H.
        .byte   $00,$09,$49,$84,$4B,$09,$00,$09 ; E922 00 09 49 84 4B 09 00 09  ..I.K...
        .byte   $4D,$84,$4B,$09,$00,$09,$49,$84 ; E92A 4D 84 4B 09 00 09 49 84  M.K...I.
        .byte   $48,$09,$00,$09,$46,$09,$00,$09 ; E932 48 09 00 09 46 09 00 09  H...F...
        .byte   $46,$09,$00,$09,$48,$84,$46,$09 ; E93A 46 09 00 09 48 84 46 09  F...H.F.
        .byte   $00,$09,$44,$04,$00,$04,$30,$04 ; E942 00 09 44 04 00 04 30 04  ..D...0.
        .byte   $00,$04,$48,$09,$00,$09,$48,$09 ; E94A 00 04 48 09 00 09 48 09  ..H...H.
        .byte   $00,$09,$49,$84,$4B,$09,$00,$09 ; E952 00 09 49 84 4B 09 00 09  ..I.K...
        .byte   $4D,$84,$4B,$09,$00,$09,$49,$84 ; E95A 4D 84 4B 09 00 09 49 84  M.K...I.
        .byte   $48,$09,$00,$09,$46,$09,$00,$09 ; E962 48 09 00 09 46 09 00 09  H...F...
        .byte   $46,$09,$00,$09,$48,$84,$46,$09 ; E96A 46 09 00 09 48 84 46 09  F...H.F.
        .byte   $00,$09,$44,$09,$00,$09,$44,$09 ; E972 00 09 44 09 00 09 44 09  ..D...D.
        .byte   $00,$09,$46,$84,$48,$09,$00,$09 ; E97A 00 09 46 84 48 09 00 09  ..F.H...
        .byte   $48,$09,$00,$09,$48,$09,$00,$09 ; E982 48 09 00 09 48 09 00 09  H...H...
        .byte   $49,$84,$4B,$09,$00,$09,$4D,$84 ; E98A 49 84 4B 09 00 09 4D 84  I.K...M.
        .byte   $4B,$09,$00,$09,$49,$84,$48,$09 ; E992 4B 09 00 09 49 84 48 09  K...I.H.
        .byte   $00,$09,$46,$09,$00,$09,$46,$09 ; E99A 00 09 46 09 00 09 46 09  ..F...F.
        .byte   $00,$09,$44,$84,$43,$09,$00,$09 ; E9A2 00 09 44 84 43 09 00 09  ..D.C...
        .byte   $41,$04,$00,$04,$30,$04,$00,$04 ; E9AA 41 04 00 04 30 04 00 04  A...0...
        .byte   $8E,$02,$48,$09,$00,$09,$48,$09 ; E9B2 8E 02 48 09 00 09 48 09  ..H...H.
        .byte   $00,$09,$49,$09,$48,$09,$46,$09 ; E9BA 00 09 49 09 48 09 46 09  ..I.H.F.
        .byte   $49,$09,$48,$09,$00,$09,$46,$09 ; E9C2 49 09 48 09 00 09 46 09  I.H...F.
        .byte   $00,$09,$44,$84,$46,$09,$00,$09 ; E9CA 00 09 44 84 46 09 00 09  ..D.F...
        .byte   $44,$09,$00,$09,$44,$09,$00,$09 ; E9D2 44 09 00 09 44 09 00 09  D...D...
        .byte   $46,$09,$44,$09,$43,$09,$44,$09 ; E9DA 46 09 44 09 43 09 44 09  F.D.C.D.
        .byte   $41,$04,$00,$04,$30,$04,$00,$04 ; E9E2 41 04 00 04 30 04 00 04  A...0...
        .byte   $8F,$00,$48,$09,$00,$09,$48,$09 ; E9EA 8F 00 48 09 00 09 48 09  ..H...H.
        .byte   $00,$09,$49,$09,$48,$09,$46,$09 ; E9F2 00 09 49 09 48 09 46 09  ..I.H.F.
        .byte   $49,$09,$46,$09,$00,$09,$46,$09 ; E9FA 49 09 46 09 00 09 46 09  I.F...F.
        .byte   $00,$09,$48,$09,$46,$09,$44,$09 ; EA02 00 09 48 09 46 09 44 09  ..H.F.D.
        .byte   $48,$09,$44,$09,$00,$09,$44,$09 ; EA0A 48 09 44 09 00 09 44 09  H.D...D.
        .byte   $00,$09,$46,$09,$44,$09,$43,$09 ; EA12 00 09 46 09 44 09 43 09  ..F.D.C.
        .byte   $46,$09,$43,$09,$00,$09,$43,$09 ; EA1A 46 09 43 09 00 09 43 09  F.C...C.
        .byte   $00,$09,$44,$84,$46,$09,$00,$09 ; EA22 00 09 44 84 46 09 00 09  ..D.F...
        .byte   $48,$09,$00,$09,$48,$09,$00,$09 ; EA2A 48 09 00 09 48 09 00 09  H...H...
        .byte   $49,$09,$48,$09,$46,$09,$49,$09 ; EA32 49 09 48 09 46 09 49 09  I.H.F.I.
        .byte   $48,$09,$00,$09,$46,$09,$00,$09 ; EA3A 48 09 00 09 46 09 00 09  H...F...
        .byte   $44,$84,$46,$09,$00,$09,$44,$09 ; EA42 44 84 46 09 00 09 44 09  D.F...D.
        .byte   $00,$09,$44,$09,$00,$09,$46,$09 ; EA4A 00 09 44 09 00 09 46 09  ..D...F.
        .byte   $44,$09,$43,$09,$44,$09,$41,$04 ; EA52 44 09 43 09 44 09 41 04  D.C.D.A.
        .byte   $00,$04,$30,$04,$00,$04,$48,$07 ; EA5A 00 04 30 04 00 04 48 07  ..0...H.
        .byte   $48,$07,$48,$07,$49,$87,$48,$07 ; EA62 48 07 48 07 49 87 48 07  H.H.I.H.
        .byte   $48,$07,$4B,$87,$48,$07,$48,$07 ; EA6A 48 07 4B 87 48 07 48 07  H.K.H.H.
        .byte   $4C,$87,$48,$07,$48,$07,$4D,$07 ; EA72 4C 87 48 07 48 07 4D 07  L.H.H.M.
        .byte   $4C,$07,$4B,$07,$49,$07,$4B,$07 ; EA7A 4C 07 4B 07 49 07 4B 07  L.K.I.K.
        .byte   $49,$07,$48,$07,$46,$07,$44,$07 ; EA82 49 07 48 07 46 07 44 07  I.H.F.D.
        .byte   $43,$07,$44,$07,$40,$07,$41,$07 ; EA8A 43 07 44 07 40 07 41 07  C.D.@.A.
        .byte   $43,$07,$44,$07,$46,$07,$48,$07 ; EA92 43 07 44 07 46 07 48 07  C.D.F.H.
        .byte   $49,$07,$4B,$87,$48,$07,$48,$07 ; EA9A 49 07 4B 87 48 07 48 07  I.K.H.H.
        .byte   $4C,$87,$48,$07,$48,$07,$49,$07 ; EAA2 4C 87 48 07 48 07 49 07  L.H.H.I.
        .byte   $50,$07,$4F,$07,$4D,$07,$4B,$07 ; EAAA 50 07 4F 07 4D 07 4B 07  P.O.M.K.
        .byte   $49,$07,$48,$07,$46,$07,$44,$07 ; EAB2 49 07 48 07 46 07 44 07  I.H.F.D.
        .byte   $43,$07,$44,$07,$46,$07,$48,$07 ; EABA 43 07 44 07 46 07 48 07  C.D.F.H.
        .byte   $46,$07,$44,$07,$43,$07,$46,$07 ; EAC2 46 07 44 07 43 07 46 07  F.D.C.F.
        .byte   $44,$07,$41,$07,$44,$07,$43,$07 ; EACA 44 07 41 07 44 07 43 07  D.A.D.C.
        .byte   $40,$07,$43,$07,$40,$07,$41,$07 ; EAD2 40 07 43 07 40 07 41 07  @.C.@.A.
        .byte   $43,$07,$44,$07,$46,$07,$48,$07 ; EADA 43 07 44 07 46 07 48 07  C.D.F.H.
        .byte   $49,$07,$4D,$07,$4C,$07,$4B,$07 ; EAE2 49 07 4D 07 4C 07 4B 07  I.M.L.K.
        .byte   $49,$07,$48,$07,$46,$07,$44,$07 ; EAEA 49 07 48 07 46 07 44 07  I.H.F.D.
        .byte   $46,$07,$44,$07,$43,$07,$44,$07 ; EAF2 46 07 44 07 43 07 44 07  F.D.C.D.
        .byte   $40,$07,$41,$07,$43,$07,$44,$07 ; EAFA 40 07 41 07 43 07 44 07  @.A.C.D.
        .byte   $46,$07,$48,$07,$49,$07,$4D,$07 ; EB02 46 07 48 07 49 07 4D 07  F.H.I.M.
        .byte   $52,$07,$50,$07,$4F,$07,$4D,$07 ; EB0A 52 07 50 07 4F 07 4D 07  R.P.O.M.
        .byte   $4B,$07,$4D,$07,$4B,$07,$49,$07 ; EB12 4B 07 4D 07 4B 07 49 07  K.M.K.I.
        .byte   $48,$07,$46,$07,$44,$07,$46,$07 ; EB1A 48 07 46 07 44 07 46 07  H.F.D.F.
        .byte   $44,$07,$43,$07,$44,$07,$43,$07 ; EB22 44 07 43 07 44 07 43 07  D.C.D.C.
        .byte   $41,$07,$43,$87,$40,$07,$40,$07 ; EB2A 41 07 43 87 40 07 40 07  A.C.@.@.
        .byte   $43,$87,$40,$07,$40,$07,$46,$87 ; EB32 43 87 40 07 40 07 46 87  C.@.@.F.
        .byte   $43,$07,$43,$07,$46,$87,$43,$07 ; EB3A 43 07 43 07 46 87 43 07  C.C.F.C.
        .byte   $43,$07,$49,$87,$46,$07,$46,$07 ; EB42 43 07 49 87 46 07 46 07  C.I.F.F.
        .byte   $49,$87,$46,$07,$46,$07,$4C,$87 ; EB4A 49 87 46 07 46 07 4C 87  I.F.F.L.
        .byte   $49,$07,$49,$07,$4C,$87,$49,$07 ; EB52 49 07 49 07 4C 87 49 07  I.I.L.I.
        .byte   $49,$07,$4F,$87,$4C,$07,$4C,$07 ; EB5A 49 07 4F 87 4C 07 4C 07  I.O.L.L.
        .byte   $4F,$87,$4C,$07,$4C,$07,$4D,$04 ; EB62 4F 87 4C 07 4C 07 4D 04  O.L.L.M.
        .byte   $00,$04,$00,$03,$46,$04,$00,$04 ; EB6A 00 04 00 03 46 04 00 04  ....F...
        .byte   $00,$03,$44,$04,$00,$04,$00,$42 ; EB72 00 03 44 04 00 04 00 42  ..D....B
        .byte   $48,$43,$44,$04,$41,$03,$00,$03 ; EB7A 48 43 44 04 41 03 00 03  HCD.A...
        .byte   $49,$43,$46,$04,$42,$03,$00,$03 ; EB82 49 43 46 04 42 03 00 03  ICF.B...
        .byte   $48,$43,$44,$04,$41,$04,$00,$04 ; EB8A 48 43 44 04 41 04 00 04  HCD.A...
        .byte   $41,$04,$00,$04,$46,$43,$43,$04 ; EB92 41 04 00 04 46 43 43 04  A...FCC.
        .byte   $40,$04,$43,$04,$46,$04,$43,$04 ; EB9A 40 04 43 04 46 04 43 04  @.C.F.C.
        .byte   $48,$43,$44,$04,$41,$04,$00,$04 ; EBA2 48 43 44 04 41 04 00 04  HCD.A...
        .byte   $41,$04,$00,$04,$49,$43,$46,$04 ; EBAA 41 04 00 04 49 43 46 04  A...ICF.
        .byte   $42,$04,$46,$04,$49,$04,$46,$04 ; EBB2 42 04 46 04 49 04 46 04  B.F.I.F.
        .byte   $48,$04,$44,$04,$41,$04,$44,$04 ; EBBA 48 04 44 04 41 04 44 04  H.D.A.D.
        .byte   $40,$04,$43,$04,$46,$04,$43,$04 ; EBC2 40 04 43 04 46 04 43 04  @.C.F.C.
        .byte   $41,$04,$44,$04,$48,$04,$44,$04 ; EBCA 41 04 44 04 48 04 44 04  A.D.H.D.
        .byte   $46,$04,$43,$04,$40,$04,$43,$04 ; EBD2 46 04 43 04 40 04 43 04  F.C.@.C.
        .byte   $48,$04,$44,$04,$41,$04,$44,$04 ; EBDA 48 04 44 04 41 04 44 04  H.D.A.D.
        .byte   $40,$04,$43,$04,$46,$04,$40,$04 ; EBE2 40 04 43 04 46 04 40 04  @.C.F.@.
        .byte   $41,$04,$00,$04,$00,$03,$48,$04 ; EBEA 41 04 00 04 00 03 48 04  A.....H.
        .byte   $00,$04,$00,$03,$4D,$04,$00,$04 ; EBF2 00 04 00 03 4D 04 00 04  ....M...
        .byte   $00,$42,$99,$38,$E8,$00,$00,$80 ; EBFA 00 42 99 38 E8 00 00 80  .B.8....
        .byte   $2C,$82,$03,$8E,$02,$00,$04,$3C ; EC02 2C 82 03 8E 02 00 04 3C  ,......<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3D ; EC0A 04 00 04 3C 04 00 04 3D  ...<...=
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3A ; EC12 04 00 04 3D 04 00 04 3A  ...=...:
        .byte   $04,$00,$04,$3A,$04,$38,$04,$00 ; EC1A 04 00 04 3A 04 38 04 00  ...:.8..
        .byte   $04,$2C,$04,$00,$04,$8F,$00,$00 ; EC22 04 2C 04 00 04 8F 00 00  .,......
        .byte   $04,$3C,$04,$00,$04,$3C,$04,$00 ; EC2A 04 3C 04 00 04 3C 04 00  .<...<..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; EC32 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; EC3A 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3A,$04,$00,$04,$3A,$04,$00 ; EC42 04 3A 04 00 04 3A 04 00  .:...:..
        .byte   $04,$3C,$04,$00,$04,$3C,$04,$00 ; EC4A 04 3C 04 00 04 3C 04 00  .<...<..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; EC52 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3A,$04,$00,$04,$3A,$04,$38 ; EC5A 04 3A 04 00 04 3A 04 38  .:...:.8
        .byte   $04,$00,$04,$2C,$04,$00,$04,$8E ; EC62 04 00 04 2C 04 00 04 8E  ...,....
        .byte   $02,$00,$04,$3C,$04,$00,$04,$3C ; EC6A 02 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EC72 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3A,$04,$00,$04,$3A ; EC7A 04 00 04 3A 04 00 04 3A  ...:...:
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EC82 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EC8A 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EC92 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3A,$04,$00,$04,$3A ; EC9A 04 00 04 3A 04 00 04 3A  ...:...:
        .byte   $04,$3C,$04,$00,$04,$2C,$04,$00 ; ECA2 04 3C 04 00 04 2C 04 00  .<...,..
        .byte   $04,$8F,$00,$8E,$02,$00,$04,$3C ; ECAA 04 8F 00 8E 02 00 04 3C  .......<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3D ; ECB2 04 00 04 3C 04 00 04 3D  ...<...=
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3A ; ECBA 04 00 04 3D 04 00 04 3A  ...=...:
        .byte   $04,$00,$04,$3A,$04,$38,$04,$00 ; ECC2 04 00 04 3A 04 38 04 00  ...:.8..
        .byte   $04,$2C,$04,$00,$04,$8F,$00,$00 ; ECCA 04 2C 04 00 04 8F 00 00  .,......
        .byte   $04,$3C,$04,$00,$04,$3C,$04,$00 ; ECD2 04 3C 04 00 04 3C 04 00  .<...<..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; ECDA 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; ECE2 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3A,$04,$00,$04,$3A,$04,$00 ; ECEA 04 3A 04 00 04 3A 04 00  .:...:..
        .byte   $04,$3C,$04,$00,$04,$3C,$04,$00 ; ECF2 04 3C 04 00 04 3C 04 00  .<...<..
        .byte   $04,$3D,$04,$00,$04,$3D,$04,$00 ; ECFA 04 3D 04 00 04 3D 04 00  .=...=..
        .byte   $04,$3A,$04,$00,$04,$3A,$04,$38 ; ED02 04 3A 04 00 04 3A 04 38  .:...:.8
        .byte   $04,$00,$04,$2C,$04,$00,$04,$00 ; ED0A 04 00 04 2C 04 00 04 00  ...,....
        .byte   $01,$8E,$03,$2C,$04,$00,$04,$2C ; ED12 01 8E 03 2C 04 00 04 2C  ...,...,
        .byte   $04,$00,$04,$2C,$04,$00,$04,$2E ; ED1A 04 00 04 2C 04 00 04 2E  ...,....
        .byte   $04,$00,$04,$8F,$00,$2C,$04,$00 ; ED22 04 00 04 8F 00 2C 04 00  .....,..
        .byte   $04,$00,$42,$2C,$04,$00,$04,$2C ; ED2A 04 00 42 2C 04 00 04 2C  ..B,...,
        .byte   $04,$00,$04,$2C,$04,$00,$04,$2E ; ED32 04 00 04 2C 04 00 04 2E  ...,....
        .byte   $04,$00,$04,$2C,$04,$00,$04,$2C ; ED3A 04 00 04 2C 04 00 04 2C  ...,...,
        .byte   $04,$00,$04,$2C,$04,$00,$04,$2C ; ED42 04 00 04 2C 04 00 04 2C  ...,...,
        .byte   $04,$00,$04,$2E,$04,$00,$04,$2E ; ED4A 04 00 04 2E 04 00 04 2E  ........
        .byte   $04,$00,$04,$2E,$04,$00,$04,$2E ; ED52 04 00 04 2E 04 00 04 2E  ........
        .byte   $04,$00,$04,$2C,$04,$00,$04,$2C ; ED5A 04 00 04 2C 04 00 04 2C  ...,...,
        .byte   $04,$00,$04,$2E,$04,$00,$04,$00 ; ED62 04 00 04 2E 04 00 04 00  ........
        .byte   $03,$31,$04,$00,$04,$00,$03,$34 ; ED6A 03 31 04 00 04 00 03 34  .1.....4
        .byte   $04,$00,$04,$00,$03,$37,$04,$00 ; ED72 04 00 04 00 03 37 04 00  .....7..
        .byte   $04,$00,$03,$3A,$87,$37,$07,$37 ; ED7A 04 00 03 3A 87 37 07 37  ...:.7.7
        .byte   $07,$3A,$87,$37,$07,$37,$07,$38 ; ED82 07 3A 87 37 07 37 07 38  .:.7.7.8
        .byte   $04,$00,$04,$00,$03,$34,$04,$00 ; ED8A 04 00 04 00 03 34 04 00  .....4..
        .byte   $04,$00,$03,$35,$04,$00,$04,$00 ; ED92 04 00 03 35 04 00 04 00  ...5....
        .byte   $42,$00,$04,$3C,$04,$00,$04,$3C ; ED9A 42 00 04 3C 04 00 04 3C  B..<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EDA2 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3D ; EDAA 04 00 04 3D 04 00 04 3D  ...=...=
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3D ; EDB2 04 00 04 3D 04 00 04 3D  ...=...=
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EDBA 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EDC2 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3A,$04,$00,$04,$3A ; EDCA 04 00 04 3A 04 00 04 3A  ...:...:
        .byte   $04,$00,$04,$3A,$04,$00,$04,$3A ; EDD2 04 00 04 3A 04 00 04 3A  ...:...:
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EDDA 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3C,$04,$00,$04,$3C ; EDE2 04 00 04 3C 04 00 04 3C  ...<...<
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3D ; EDEA 04 00 04 3D 04 00 04 3D  ...=...=
        .byte   $04,$00,$04,$3D,$04,$00,$04,$3D ; EDF2 04 00 04 3D 04 00 04 3D  ...=...=
        .byte   $04,$8E,$03,$00,$04,$3C,$04,$00 ; EDFA 04 8E 03 00 04 3C 04 00  .....<..
        .byte   $04,$3C,$04,$00,$04,$3A,$04,$00 ; EE02 04 3C 04 00 04 3A 04 00  .<...:..
        .byte   $04,$3A,$04,$8F,$00,$38,$04,$00 ; EE0A 04 3A 04 8F 00 38 04 00  .:...8..
        .byte   $04,$00,$03,$3A,$04,$00,$04,$00 ; EE12 04 00 03 3A 04 00 04 00  ...:....
        .byte   $03,$38,$04,$00,$04,$00,$42,$99 ; EE1A 03 38 04 00 04 00 42 99  .8....B.
        .byte   $05,$EC,$00,$00,$80,$2C,$82,$03 ; EE22 05 EC 00 00 80 2C 82 03  .....,..
        .byte   $8E,$02,$29,$04,$38,$04,$24,$04 ; EE2A 8E 02 29 04 38 04 24 04  ..).8.$.
        .byte   $38,$04,$2B,$04,$3A,$04,$25,$04 ; EE32 38 04 2B 04 3A 04 25 04  8.+.:.%.
        .byte   $3A,$04,$24,$04,$34,$04,$1F,$04 ; EE3A 3A 04 24 04 34 04 1F 04  :.$.4...
        .byte   $34,$04,$29,$04,$00,$04,$29,$04 ; EE42 34 04 29 04 00 04 29 04  4.)...).
        .byte   $00,$04,$8F,$00,$29,$04,$38,$04 ; EE4A 00 04 8F 00 29 04 38 04  ....).8.
        .byte   $24,$04,$38,$04,$22,$04,$3A,$04 ; EE52 24 04 38 04 22 04 3A 04  $.8.".:.
        .byte   $29,$04,$3A,$04,$2B,$04,$3A,$04 ; EE5A 29 04 3A 04 2B 04 3A 04  ).:.+.:.
        .byte   $25,$04,$3A,$04,$24,$04,$34,$04 ; EE62 25 04 3A 04 24 04 34 04  %.:.$.4.
        .byte   $1F,$04,$34,$04,$29,$04,$38,$04 ; EE6A 1F 04 34 04 29 04 38 04  ..4.).8.
        .byte   $24,$04,$38,$04,$2B,$04,$3A,$04 ; EE72 24 04 38 04 2B 04 3A 04  $.8.+.:.
        .byte   $25,$04,$3A,$04,$24,$04,$34,$04 ; EE7A 25 04 3A 04 24 04 34 04  %.:.$.4.
        .byte   $1F,$04,$34,$04,$29,$04,$00,$04 ; EE82 1F 04 34 04 29 04 00 04  ..4.)...
        .byte   $29,$04,$00,$04,$8E,$02,$29,$04 ; EE8A 29 04 00 04 8E 02 29 04  ).....).
        .byte   $38,$04,$24,$04,$38,$04,$29,$04 ; EE92 38 04 24 04 38 04 29 04  8.$.8.).
        .byte   $38,$04,$24,$04,$38,$04,$24,$04 ; EE9A 38 04 24 04 38 04 24 04  8.$.8.$.
        .byte   $34,$04,$1F,$04,$34,$04,$29,$04 ; EEA2 34 04 1F 04 34 04 29 04  4...4.).
        .byte   $38,$04,$24,$04,$38,$04,$29,$04 ; EEAA 38 04 24 04 38 04 29 04  8.$.8.).
        .byte   $38,$04,$24,$04,$38,$04,$29,$04 ; EEB2 38 04 24 04 38 04 29 04  8.$.8.).
        .byte   $38,$04,$24,$04,$38,$04,$24,$04 ; EEBA 38 04 24 04 38 04 24 04  8.$.8.$.
        .byte   $34,$04,$1F,$04,$34,$04,$29,$04 ; EEC2 34 04 1F 04 34 04 29 04  4...4.).
        .byte   $00,$04,$29,$04,$00,$04,$8F,$00 ; EECA 00 04 29 04 00 04 8F 00  ..).....
        .byte   $8E,$02,$29,$04,$38,$04,$24,$04 ; EED2 8E 02 29 04 38 04 24 04  ..).8.$.
        .byte   $38,$04,$2B,$04,$3A,$04,$25,$04 ; EEDA 38 04 2B 04 3A 04 25 04  8.+.:.%.
        .byte   $3A,$04,$24,$04,$34,$04,$1F,$04 ; EEE2 3A 04 24 04 34 04 1F 04  :.$.4...
        .byte   $34,$04,$29,$04,$00,$04,$29,$04 ; EEEA 34 04 29 04 00 04 29 04  4.)...).
        .byte   $00,$04,$8F,$00,$29,$04,$38,$04 ; EEF2 00 04 8F 00 29 04 38 04  ....).8.
        .byte   $24,$04,$38,$04,$22,$04,$3A,$04 ; EEFA 24 04 38 04 22 04 3A 04  $.8.".:.
        .byte   $29,$04,$3A,$04,$2B,$04,$3A,$04 ; EF02 29 04 3A 04 2B 04 3A 04  ).:.+.:.
        .byte   $25,$04,$3A,$04,$24,$04,$34,$04 ; EF0A 25 04 3A 04 24 04 34 04  %.:.$.4.
        .byte   $1F,$04,$34,$04,$29,$04,$38,$04 ; EF12 1F 04 34 04 29 04 38 04  ..4.).8.
        .byte   $24,$04,$38,$04,$2B,$04,$3A,$04 ; EF1A 24 04 38 04 2B 04 3A 04  $.8.+.:.
        .byte   $25,$04,$3A,$04,$24,$04,$34,$04 ; EF22 25 04 3A 04 24 04 34 04  %.:.$.4.
        .byte   $1F,$04,$34,$04,$29,$04,$00,$04 ; EF2A 1F 04 34 04 29 04 00 04  ..4.)...
        .byte   $29,$04,$00,$04,$00,$01,$8E,$03 ; EF32 29 04 00 04 00 01 8E 03  ).......
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF3A 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$28,$04,$00,$04 ; EF42 29 04 00 04 28 04 00 04  )...(...
        .byte   $8F,$00,$29,$04,$00,$04,$00,$42 ; EF4A 8F 00 29 04 00 04 00 42  ..)....B
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF52 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$28,$04,$00,$04 ; EF5A 29 04 00 04 28 04 00 04  )...(...
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF62 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF6A 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF72 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF7A 29 04 00 04 29 04 00 04  )...)...
        .byte   $29,$04,$00,$04,$29,$04,$00,$04 ; EF82 29 04 00 04 29 04 00 04  )...)...
        .byte   $28,$04,$00,$04,$00,$04,$00,$04 ; EF8A 28 04 00 04 00 04 00 04  (.......
        .byte   $2E,$04,$00,$04,$00,$03,$31,$04 ; EF92 2E 04 00 04 00 03 31 04  ......1.
        .byte   $00,$04,$00,$03,$34,$04,$00,$04 ; EF9A 00 04 00 03 34 04 00 04  ....4...
        .byte   $00,$42,$35,$04,$00,$04,$00,$03 ; EFA2 00 42 35 04 00 04 00 03  .B5.....
        .byte   $30,$04,$00,$04,$00,$03,$29,$04 ; EFAA 30 04 00 04 00 03 29 04  0.....).
        .byte   $00,$04,$00,$42,$29,$04,$38,$04 ; EFB2 00 04 00 42 29 04 38 04  ...B).8.
        .byte   $24,$04,$38,$04,$29,$04,$38,$04 ; EFBA 24 04 38 04 29 04 38 04  $.8.).8.
        .byte   $24,$04,$38,$04,$2A,$04,$3A,$04 ; EFC2 24 04 38 04 2A 04 3A 04  $.8.*.:.
        .byte   $25,$04,$3A,$04,$2A,$04,$3A,$04 ; EFCA 25 04 3A 04 2A 04 3A 04  %.:.*.:.
        .byte   $25,$04,$3A,$04,$29,$04,$38,$04 ; EFD2 25 04 3A 04 29 04 38 04  %.:.).8.
        .byte   $24,$04,$38,$04,$29,$04,$38,$04 ; EFDA 24 04 38 04 29 04 38 04  $.8.).8.
        .byte   $24,$04,$38,$04,$24,$04,$34,$04 ; EFE2 24 04 38 04 24 04 34 04  $.8.$.4.
        .byte   $1F,$04,$34,$04,$24,$04,$34,$04 ; EFEA 1F 04 34 04 24 04 34 04  ..4.$.4.
        .byte   $1F,$04,$34,$04,$29,$04,$38,$04 ; EFF2 1F 04 34 04 29 04 38 04  ..4.).8.
        .byte   $24,$04,$38,$04,$29,$04,$38,$04 ; EFFA 24 04 38 04 29 04 38 04  $.8.).8.
        .byte   $24,$04,$38,$04,$2A,$04,$3A,$04 ; F002 24 04 38 04 2A 04 3A 04  $.8.*.:.
        .byte   $25,$04,$3A,$04,$2A,$04,$3A,$04 ; F00A 25 04 3A 04 2A 04 3A 04  %.:.*.:.
        .byte   $25,$04,$3A,$04,$8E,$03,$29,$04 ; F012 25 04 3A 04 8E 03 29 04  %.:...).
        .byte   $38,$04,$24,$04,$38,$04,$24,$04 ; F01A 38 04 24 04 38 04 24 04  8.$.8.$.
        .byte   $34,$04,$1F,$04,$34,$04,$8F,$00 ; F022 34 04 1F 04 34 04 8F 00  4...4...
        .byte   $29,$04,$00,$04,$00,$03,$28,$04 ; F02A 29 04 00 04 00 03 28 04  ).....(.
        .byte   $00,$04,$00,$03,$29,$04,$00,$04 ; F032 00 04 00 03 29 04 00 04  ....)...
        .byte   $00,$03,$1D,$03,$00,$03,$99,$2A ; F03A 00 03 1D 03 00 03 99 2A  .......*
        .byte   $EE,$00,$00,$87,$3B,$E0,$80,$2C ; F042 EE 00 00 87 3B E0 80 2C  ....;..,
        .byte   $82,$05,$8E,$02,$00,$04,$57,$14 ; F04A 82 05 8E 02 00 04 57 14  ......W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F052 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F05A 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$02,$8F,$00 ; F062 00 04 57 14 00 02 8F 00  ..W.....
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F06A 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F072 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F07A 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F082 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F08A 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F092 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $00,$04,$57,$14,$00,$04,$57,$14 ; F09A 00 04 57 14 00 04 57 14  ..W...W.
        .byte   $57,$14,$00,$43,$8E,$02,$00,$04 ; F0A2 57 14 00 43 8E 02 00 04  W..C....
        .byte   $57,$09,$57,$09,$57,$14,$57,$09 ; F0AA 57 09 57 09 57 14 57 09  W.W.W.W.
        .byte   $57,$09,$57,$14,$57,$09,$57,$09 ; F0B2 57 09 57 14 57 09 57 09  W.W.W.W.
        .byte   $57,$14,$57,$09,$57,$09,$57,$14 ; F0BA 57 14 57 09 57 09 57 14  W.W.W.W.
        .byte   $57,$09,$57,$09,$57,$14,$57,$09 ; F0C2 57 09 57 09 57 14 57 09  W.W.W.W.
        .byte   $57,$09,$57,$14,$57,$09,$57,$09 ; F0CA 57 09 57 14 57 09 57 09  W.W.W.W.
        .byte   $57,$14,$57,$09,$57,$09,$57,$14 ; F0D2 57 14 57 09 57 09 57 14  W.W.W.W.
        .byte   $57,$09,$57,$09,$57,$14,$57,$09 ; F0DA 57 09 57 09 57 14 57 09  W.W.W.W.
        .byte   $57,$09,$57,$14,$57,$09,$57,$09 ; F0E2 57 09 57 14 57 09 57 09  W.W.W.W.
        .byte   $57,$14,$57,$09,$57,$09,$57,$14 ; F0EA 57 14 57 09 57 09 57 14  W.W.W.W.
        .byte   $57,$09,$57,$09,$57,$14,$57,$09 ; F0F2 57 09 57 09 57 14 57 09  W.W.W.W.
        .byte   $57,$09,$57,$14,$00,$43,$8F,$00 ; F0FA 57 09 57 14 00 43 8F 00  W.W..C..
        .byte   $8E,$02,$00,$04,$57,$14,$00,$04 ; F102 8E 02 00 04 57 14 00 04  ....W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F10A 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F112 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$02,$8F,$00,$00,$04 ; F11A 57 14 00 02 8F 00 00 04  W.......
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F122 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F12A 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F132 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F13A 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F142 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$00,$04 ; F14A 57 14 00 04 57 14 00 04  W...W...
        .byte   $57,$14,$00,$04,$57,$14,$57,$14 ; F152 57 14 00 04 57 14 57 14  W...W.W.
        .byte   $00,$43,$8E,$0D,$00,$01,$8F,$00 ; F15A 00 43 8E 0D 00 01 8F 00  .C......
        .byte   $82,$02,$8E,$09,$00,$04,$55,$04 ; F162 82 02 8E 09 00 04 55 04  ......U.
        .byte   $00,$04,$55,$04,$00,$04,$55,$04 ; F16A 00 04 55 04 00 04 55 04  ..U...U.
        .byte   $00,$04,$55,$04,$8F,$00,$55,$14 ; F172 00 04 55 04 8F 00 55 14  ..U...U.
        .byte   $00,$43,$55,$14,$00,$43,$55,$14 ; F17A 00 43 55 14 00 43 55 14  .CU..CU.
        .byte   $00,$43,$00,$02,$99,$4A,$F0,$00 ; F182 00 43 00 02 99 4A F0 00  .C...J..
        .byte   $00,$82,$07,$80,$32,$00,$09,$30 ; F18A 00 82 07 80 32 00 09 30  ....2..0
        .byte   $07,$35,$17,$37,$17,$3C,$03,$35 ; F192 07 35 17 37 17 3C 03 35  .5.7.<.5
        .byte   $07,$3A,$17,$39,$17,$3E,$03,$81 ; F19A 07 3A 17 39 17 3E 03 81  .:.9.>..
        .byte   $FE,$3A,$17,$3E,$17,$3C,$17,$81 ; F1A2 FE 3A 17 3E 17 3C 17 81  .:.>.<..
        .byte   $FD,$40,$17,$3E,$17,$81,$FD,$3C ; F1AA FD 40 17 3E 17 81 FD 3C  .@.>...<
        .byte   $17,$41,$03,$00,$02,$00,$00,$82 ; F1B2 17 41 03 00 02 00 00 82  .A......
        .byte   $07,$80,$32,$00,$09,$00,$03,$39 ; F1BA 07 80 32 00 09 00 03 39  ..2....9
        .byte   $03,$00,$03,$3A,$03,$81,$FE,$37 ; F1C2 03 00 03 3A 03 81 FE 37  ...:...7
        .byte   $17,$3A,$17,$39,$17,$81,$FD,$3C ; F1CA 17 3A 17 39 17 81 FD 3C  .:.9...<
        .byte   $17,$3A,$17,$81,$FD,$37,$17,$39 ; F1D2 17 3A 17 81 FD 37 17 39  .:...7.9
        .byte   $03,$00,$02,$00,$00,$82,$07,$80 ; F1DA 03 00 02 00 00 82 07 80  ........
        .byte   $32,$00,$09,$00,$03,$29,$03,$00 ; F1E2 32 00 09 00 03 29 03 00  2....)..
        .byte   $03,$2B,$03,$81,$FE,$00,$17,$00 ; F1EA 03 2B 03 81 FE 00 17 00  .+......
        .byte   $17,$00,$17,$81,$FD,$30,$17,$32 ; F1F2 17 00 17 81 FD 30 17 32  .....0.2
        .byte   $17,$81,$FD,$34,$17,$35,$03,$00 ; F1FA 17 81 FD 34 17 35 03 00  ...4.5..
        .byte   $02,$00,$00,$80,$32,$00,$09,$00 ; F202 02 00 00 80 32 00 09 00  ....2...
        .byte   $01,$00,$01,$00,$03,$00,$00,$82 ; F20A 01 00 01 00 03 00 00 82  ........
        .byte   $07,$80,$29,$4B,$07,$4D,$07,$4B ; F212 07 80 29 4B 07 4D 07 4B  ..)K.M.K
        .byte   $07,$49,$07,$4B,$07,$49,$07,$48 ; F21A 07 49 07 4B 07 49 07 48  .I.K.I.H
        .byte   $07,$49,$07,$48,$07,$46,$07,$48 ; F222 07 49 07 48 07 46 07 48  .I.H.F.H
        .byte   $07,$43,$07,$44,$13,$00,$43,$00 ; F22A 07 43 07 44 13 00 43 00  .C.D..C.
        .byte   $00,$82,$07,$80,$29,$48,$07,$49 ; F232 00 82 07 80 29 48 07 49  ....)H.I
        .byte   $07,$48,$07,$46,$07,$48,$07,$46 ; F23A 07 48 07 46 07 48 07 46  .H.F.H.F
        .byte   $07,$44,$07,$46,$07,$44,$07,$43 ; F242 07 44 07 46 07 44 07 43  .D.F.D.C
        .byte   $07,$44,$07,$3F,$07,$3C,$13,$00 ; F24A 07 44 07 3F 07 3C 13 00  .D.?.<..
        .byte   $00,$80,$29,$82,$07,$2C,$13,$2B ; F252 00 80 29 82 07 2C 13 2B  ..)..,.+
        .byte   $13,$29,$13,$27,$13,$2C,$13,$20 ; F25A 13 29 13 27 13 2C 13 20  .).'.,. 
        .byte   $13,$00,$04,$00,$00,$80,$29,$82 ; F262 13 00 04 00 00 80 29 82  ......).
        .byte   $07,$00,$01,$00,$02,$00,$04,$00 ; F26A 07 00 01 00 02 00 04 00  ........
        .byte   $00,$80,$20,$82,$07,$38,$19,$3C ; F272 00 80 20 82 07 38 19 3C  .. ..8.<
        .byte   $19,$41,$14,$40,$19,$43,$19,$46 ; F27A 19 41 14 40 19 43 19 46  .A.@.C.F
        .byte   $17,$43,$17,$46,$17,$4A,$17,$45 ; F282 17 43 17 46 17 4A 17 45  .C.F.J.E
        .byte   $17,$48,$17,$4C,$17,$46,$17,$4A ; F28A 17 48 17 4C 17 46 17 4A  .H.L.F.J
        .byte   $17,$4D,$02,$00,$00,$80,$20,$00 ; F292 17 4D 02 00 00 80 20 00  .M.... .
        .byte   $04,$82,$07,$39,$14,$3C,$19,$40 ; F29A 04 82 07 39 14 3C 19 40  ...9.<.@
        .byte   $19,$43,$17,$40,$17,$3C,$17,$46 ; F2A2 19 43 17 40 17 3C 17 46  .C.@.<.F
        .byte   $17,$41,$17,$3E,$17,$3C,$17,$40 ; F2AA 17 41 17 3E 17 3C 17 40  .A.>.<.@
        .byte   $17,$43,$17,$45,$02,$00,$00,$80 ; F2B2 17 43 17 45 02 00 00 80  .C.E....
        .byte   $20,$00,$04,$82,$07,$21,$14,$24 ; F2BA 20 00 04 82 07 21 14 24   ....!.$
        .byte   $19,$28,$19,$1C,$17,$1F,$86,$1F ; F2C2 19 28 19 1C 17 1F 86 1F  .(......
        .byte   $17,$21,$86,$21,$17,$22,$17,$24 ; F2CA 17 21 86 21 17 22 17 24  .!.!.".$
        .byte   $17,$29,$02,$00,$00,$80,$20,$00 ; F2D2 17 29 02 00 00 80 20 00  .).... .
        .byte   $04,$00,$01,$00,$02,$00,$00,$82 ; F2DA 04 00 01 00 02 00 00 82  ........
        .byte   $07,$80,$29,$48,$14,$48,$13,$48 ; F2E2 07 80 29 48 14 48 13 48  ..)H.H.H
        .byte   $04,$46,$06,$48,$07,$46,$04,$43 ; F2EA 04 46 06 48 07 46 04 43  .F.H.F.C
        .byte   $14,$44,$14,$44,$13,$44,$04,$43 ; F2F2 14 44 14 44 13 44 04 43  .D.D.D.C
        .byte   $06,$44,$07,$43,$04,$40,$14,$41 ; F2FA 06 44 07 43 04 40 14 41  .D.C.@.A
        .byte   $14,$41,$13,$41,$04,$43,$06,$44 ; F302 14 41 13 41 04 43 06 44  .A.A.C.D
        .byte   $07,$46,$04,$43,$14,$44,$14,$44 ; F30A 07 46 04 43 14 44 14 44  .F.C.D.D
        .byte   $13,$44,$04,$46,$06,$48,$07,$49 ; F312 13 44 04 46 06 48 07 49  .D.F.H.I
        .byte   $04,$46,$14,$48,$14,$48,$13,$48 ; F31A 04 46 14 48 14 48 13 48  .F.H.H.H
        .byte   $04,$49,$06,$48,$07,$46,$04,$49 ; F322 04 49 06 48 07 46 04 49  .I.H.F.I
        .byte   $14,$46,$14,$46,$13,$46,$04,$48 ; F32A 14 46 14 46 13 46 04 48  .F.F.F.H
        .byte   $06,$46,$07,$44,$04,$40,$14,$41 ; F332 06 46 07 44 04 40 14 41  .F.D.@.A
        .byte   $14,$41,$13,$41,$84,$43,$14,$43 ; F33A 14 41 13 41 84 43 14 43  .A.A.C.C
        .byte   $13,$43,$84,$44,$14,$44,$13,$44 ; F342 13 43 84 44 14 44 13 44  .C.D.D.D
        .byte   $84,$46,$14,$46,$13,$46,$84,$48 ; F34A 84 46 14 46 13 46 84 48  .F.F.F.H
        .byte   $14,$48,$13,$48,$84,$46,$14,$46 ; F352 14 48 13 48 84 46 14 46  .H.H.F.F
        .byte   $13,$43,$84,$44,$14,$44,$13,$44 ; F35A 13 43 84 44 14 44 13 44  .C.D.D.D
        .byte   $84,$43,$14,$43,$13,$40,$84,$41 ; F362 84 43 14 43 13 40 84 41  .C.C.@.A
        .byte   $13,$00,$03,$44,$07,$43,$07,$41 ; F36A 13 00 03 44 07 43 07 41  ...D.C.A
        .byte   $07,$40,$07,$3D,$07,$3C,$07,$4D ; F372 07 40 07 3D 07 3C 07 4D  .@.=.<.M
        .byte   $04,$00,$04,$00,$00,$82,$07,$80 ; F37A 04 00 04 00 00 82 07 80  ........
        .byte   $29,$00,$04,$3C,$14,$00,$04,$3C ; F382 29 00 04 3C 14 00 04 3C  )..<...<
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F38A 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$3D,$14,$00,$04,$3D ; F392 14 00 04 3D 14 00 04 3D  ...=...=
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F39A 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F3A2 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$3D,$14,$00,$04,$3D ; F3AA 14 00 04 3D 14 00 04 3D  ...=...=
        .byte   $14,$00,$04,$3F,$14,$00,$04,$3F ; F3B2 14 00 04 3F 14 00 04 3F  ...?...?
        .byte   $14,$00,$04,$41,$14,$00,$04,$41 ; F3BA 14 00 04 41 14 00 04 41  ...A...A
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F3C2 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$41,$14,$00,$04,$41 ; F3CA 14 00 04 41 14 00 04 41  ...A...A
        .byte   $14,$00,$04,$3D,$14,$00,$04,$3D ; F3D2 14 00 04 3D 14 00 04 3D  ...=...=
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F3DA 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F3E2 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$3D,$14,$00,$04,$3D ; F3EA 14 00 04 3D 14 00 04 3D  ...=...=
        .byte   $14,$00,$04,$3F,$14,$00,$04,$3F ; F3F2 14 00 04 3F 14 00 04 3F  ...?...?
        .byte   $14,$00,$04,$41,$14,$00,$04,$41 ; F3FA 14 00 04 41 14 00 04 41  ...A...A
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F402 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$04,$41,$14,$00,$04,$41 ; F40A 14 00 04 41 14 00 04 41  ...A...A
        .byte   $14,$00,$04,$3D,$14,$00,$04,$3D ; F412 14 00 04 3D 14 00 04 3D  ...=...=
        .byte   $14,$00,$04,$3C,$14,$00,$04,$3C ; F41A 14 00 04 3C 14 00 04 3C  ...<...<
        .byte   $14,$00,$02,$48,$07,$46,$07,$44 ; F422 14 00 02 48 07 46 07 44  ...H.F.D
        .byte   $07,$43,$07,$41,$07,$40,$07,$00 ; F42A 07 43 07 41 07 40 07 00  .C.A.@..
        .byte   $03,$3C,$04,$00,$04,$00,$00,$82 ; F432 03 3C 04 00 04 00 00 82  .<......
        .byte   $07,$80,$29,$29,$04,$38,$14,$24 ; F43A 07 80 29 29 04 38 14 24  ..)).8.$
        .byte   $04,$38,$14,$29,$04,$38,$14,$24 ; F442 04 38 14 29 04 38 14 24  .8.).8.$
        .byte   $04,$38,$14,$2B,$04,$3A,$14,$25 ; F44A 04 38 14 2B 04 3A 14 25  .8.+.:.%
        .byte   $04,$3A,$14,$28,$04,$3A,$14,$24 ; F452 04 3A 14 28 04 3A 14 24  .:.(.:.$
        .byte   $04,$3A,$14,$29,$04,$38,$14,$24 ; F45A 04 3A 14 29 04 38 14 24  .:.).8.$
        .byte   $04,$38,$14,$2B,$04,$3A,$14,$25 ; F462 04 38 14 2B 04 3A 14 25  .8.+.:.%
        .byte   $04,$3A,$14,$2C,$04,$3C,$14,$27 ; F46A 04 3A 14 2C 04 3C 14 27  .:.,.<.'
        .byte   $04,$3C,$14,$2E,$04,$3D,$14,$29 ; F472 04 3C 14 2E 04 3D 14 29  .<...=.)
        .byte   $04,$3D,$14,$29,$04,$38,$14,$24 ; F47A 04 3D 14 29 04 38 14 24  .=.).8.$
        .byte   $04,$38,$14,$22,$04,$3D,$14,$29 ; F482 04 38 14 22 04 3D 14 29  .8.".=.)
        .byte   $04,$3D,$14,$2B,$04,$3A,$14,$25 ; F48A 04 3D 14 2B 04 3A 14 25  .=.+.:.%
        .byte   $04,$3A,$14,$28,$04,$3A,$14,$24 ; F492 04 3A 14 28 04 3A 14 24  .:.(.:.$
        .byte   $04,$3A,$14,$29,$04,$38,$14,$24 ; F49A 04 3A 14 29 04 38 14 24  .:.).8.$
        .byte   $04,$38,$14,$2B,$04,$3A,$14,$25 ; F4A2 04 38 14 2B 04 3A 14 25  .8.+.:.%
        .byte   $04,$3A,$14,$2C,$04,$3C,$14,$27 ; F4AA 04 3A 14 2C 04 3C 14 27  .:.,.<.'
        .byte   $04,$3C,$14,$2E,$04,$3D,$14,$29 ; F4B2 04 3C 14 2E 04 3D 14 29  .<...=.)
        .byte   $04,$3D,$14,$29,$04,$38,$14,$24 ; F4BA 04 3D 14 29 04 38 14 24  .=.).8.$
        .byte   $04,$38,$14,$22,$04,$3D,$14,$29 ; F4C2 04 38 14 22 04 3D 14 29  .8.".=.)
        .byte   $04,$3D,$14,$2B,$04,$3A,$14,$25 ; F4CA 04 3D 14 2B 04 3A 14 25  .=.+.:.%
        .byte   $04,$3A,$14,$28,$04,$3A,$14,$24 ; F4D2 04 3A 14 28 04 3A 14 24  .:.(.:.$
        .byte   $04,$3A,$14,$29,$07,$2B,$07,$2C ; F4DA 04 3A 14 29 07 2B 07 2C  .:.).+.,
        .byte   $07,$2E,$07,$30,$07,$31,$07,$34 ; F4E2 07 2E 07 30 07 31 07 34  ...0.1.4
        .byte   $07,$35,$07,$37,$07,$38,$07,$3A ; F4EA 07 35 07 37 07 38 07 3A  .5.7.8.:
        .byte   $07,$3C,$07,$00,$02,$29,$04,$00 ; F4F2 07 3C 07 00 02 29 04 00  .<...)..
        .byte   $04,$00,$00,$82,$01,$80,$29,$87 ; F4FA 04 00 00 82 01 80 29 87  ......).
        .byte   $3B,$E0,$8E,$0A,$00,$14,$55,$14 ; F502 3B E0 8E 0A 00 14 55 14  ;.....U.
        .byte   $00,$14,$55,$14,$00,$14,$55,$14 ; F50A 00 14 55 14 00 14 55 14  ..U...U.
        .byte   $00,$14,$55,$14,$8F,$00,$55,$14 ; F512 00 14 55 14 8F 00 55 14  ..U...U.
        .byte   $00,$43,$55,$14,$00,$43,$55,$14 ; F51A 00 43 55 14 00 43 55 14  .CU..CU.
        .byte   $00,$04,$82,$05,$57,$14,$00,$04 ; F522 00 04 82 05 57 14 00 04  ....W...
        .byte   $57,$14,$00,$04,$00,$00,$82,$05 ; F52A 57 14 00 04 00 00 82 05  W.......
        .byte   $80,$27,$3F,$03,$3D,$02,$3A,$04 ; F532 80 27 3F 03 3D 02 3A 04  .'?.=.:.
        .byte   $3D,$04,$3B,$04,$3A,$09,$38,$09 ; F53A 3D 04 3B 04 3A 09 38 09  =.;.:.8.
        .byte   $36,$03,$31,$03,$3A,$04,$3D,$04 ; F542 36 03 31 03 3A 04 3D 04  6.1.:.=.
        .byte   $38,$04,$3A,$04,$36,$03,$31,$03 ; F54A 38 04 3A 04 36 03 31 03  8.:.6.1.
        .byte   $33,$03,$33,$04,$35,$04,$38,$04 ; F552 33 03 33 04 35 04 38 04  3.3.5.8.
        .byte   $36,$04,$35,$04,$33,$04,$31,$03 ; F55A 36 04 35 04 33 04 31 03  6.5.3.1.
        .byte   $31,$03,$31,$03,$3D,$03,$3A,$04 ; F562 31 03 31 03 3D 03 3A 04  1.1.=.:.
        .byte   $3D,$04,$3B,$04,$3A,$09,$38,$09 ; F56A 3D 04 3B 04 3A 09 38 09  =.;.:.8.
        .byte   $36,$03,$31,$03,$3A,$04,$3D,$04 ; F572 36 03 31 03 3A 04 3D 04  6.1.:.=.
        .byte   $38,$04,$3A,$04,$36,$03,$31,$03 ; F57A 38 04 3A 04 36 03 31 03  8.:.6.1.
        .byte   $33,$03,$33,$04,$35,$04,$38,$04 ; F582 33 03 33 04 35 04 38 04  3.3.5.8.
        .byte   $36,$04,$35,$04,$33,$04,$3D,$03 ; F58A 36 04 35 04 33 04 3D 03  6.5.3.=.
        .byte   $3B,$03,$3A,$01,$38,$03,$35,$04 ; F592 3B 03 3A 01 38 03 35 04  ;.:.8.5.
        .byte   $36,$04,$38,$03,$35,$04,$36,$04 ; F59A 36 04 38 03 35 04 36 04  6.8.5.6.
        .byte   $38,$03,$36,$04,$35,$04,$33,$03 ; F5A2 38 03 36 04 35 04 33 03  8.6.5.3.
        .byte   $33,$04,$33,$04,$38,$44,$36,$09 ; F5AA 33 04 33 04 38 44 36 09  3.3.8D6.
        .byte   $35,$04,$36,$04,$38,$03,$35,$04 ; F5B2 35 04 36 04 38 03 35 04  5.6.8.5.
        .byte   $36,$04,$38,$03,$36,$04,$35,$04 ; F5BA 36 04 38 03 36 04 35 04  6.8.6.5.
        .byte   $33,$13,$3F,$03,$3D,$02,$99,$38 ; F5C2 33 13 3F 03 3D 02 99 38  3.?.=..8
        .byte   $F5,$00,$00,$82,$03,$80,$27,$00 ; F5CA F5 00 00 82 03 80 27 00  ......'.
        .byte   $42,$8E,$03,$00,$01,$8F,$00,$00 ; F5D2 42 8E 03 00 01 8F 00 00  B.......
        .byte   $04,$38,$04,$00,$04,$38,$04,$38 ; F5DA 04 38 04 00 04 38 04 38  .8...8.8
        .byte   $03,$00,$03,$8E,$03,$00,$01,$8F ; F5E2 03 00 03 8E 03 00 01 8F  ........
        .byte   $00,$00,$02,$35,$01,$3B,$12,$3B ; F5EA 00 00 02 35 01 3B 12 3B  ...5.;.;
        .byte   $12,$3B,$12,$3A,$03,$3D,$04,$3D ; F5F2 12 3B 12 3A 03 3D 04 3D  .;.:.=.=
        .byte   $04,$3B,$12,$3B,$12,$3B,$12,$3A ; F5FA 04 3B 12 3B 12 3B 12 3A  .;.;.;.:
        .byte   $13,$00,$42,$99,$D3,$F5,$00,$00 ; F602 13 00 42 99 D3 F5 00 00  ..B.....
        .byte   $82,$05,$80,$27,$00,$42,$2A,$13 ; F60A 82 05 80 27 00 42 2A 13  ...'.B*.
        .byte   $25,$13,$2A,$13,$2A,$13,$2A,$13 ; F612 25 13 2A 13 2A 13 2A 13  %.*.*.*.
        .byte   $25,$13,$1E,$13,$22,$13,$23,$13 ; F61A 25 13 1E 13 22 13 23 13  %...".#.
        .byte   $23,$13,$20,$13,$20,$13,$25,$13 ; F622 23 13 20 13 20 13 25 13  #. . .%.
        .byte   $25,$13,$25,$13,$00,$03,$2A,$13 ; F62A 25 13 25 13 00 03 2A 13  %.%...*.
        .byte   $25,$13,$2A,$13,$2A,$13,$2A,$13 ; F632 25 13 2A 13 2A 13 2A 13  %.*.*.*.
        .byte   $25,$13,$1E,$13,$22,$13,$23,$13 ; F63A 25 13 1E 13 22 13 23 13  %...".#.
        .byte   $23,$13,$24,$13,$24,$13,$25,$13 ; F642 23 13 24 13 24 13 25 13  #.$.$.%.
        .byte   $25,$13,$22,$01,$22,$13,$22,$04 ; F64A 25 13 22 01 22 13 22 04  %.".".".
        .byte   $2E,$04,$22,$13,$22,$04,$2E,$04 ; F652 2E 04 22 13 22 04 2E 04  .."."...
        .byte   $22,$13,$2E,$04,$22,$04,$27,$13 ; F65A 22 13 2E 04 22 04 27 13  "...".'.
        .byte   $27,$13,$22,$44,$2E,$09,$22,$04 ; F662 27 13 22 44 2E 09 22 04  '."D..".
        .byte   $2E,$04,$22,$03,$22,$04,$2E,$04 ; F66A 2E 04 22 03 22 04 2E 04  .."."...
        .byte   $22,$13,$2E,$04,$22,$04,$27,$13 ; F672 22 13 2E 04 22 04 27 13  "...".'.
        .byte   $00,$42,$99,$10,$F6,$80,$27,$87 ; F67A 00 42 99 10 F6 80 27 87  .B....'.
        .byte   $3B,$E0,$82,$03,$00,$42,$8E,$03 ; F682 3B E0 82 03 00 42 8E 03  ;....B..
        .byte   $00,$04,$55,$14,$00,$04,$55,$14 ; F68A 00 04 55 14 00 04 55 14  ..U...U.
        .byte   $00,$04,$55,$14,$00,$04,$55,$14 ; F692 00 04 55 14 00 04 55 14  ..U...U.
        .byte   $8F,$00,$00,$04,$55,$14,$00,$04 ; F69A 8F 00 00 04 55 14 00 04  ....U...
        .byte   $55,$14,$55,$14,$00,$43,$8E,$02 ; F6A2 55 14 55 14 00 43 8E 02  U.U..C..
        .byte   $8E,$03,$00,$04,$55,$14,$00,$04 ; F6AA 8E 03 00 04 55 14 00 04  ....U...
        .byte   $55,$14,$00,$04,$55,$14,$00,$04 ; F6B2 55 14 00 04 55 14 00 04  U...U...
        .byte   $55,$14,$8F,$00,$00,$04,$55,$14 ; F6BA 55 14 8F 00 00 04 55 14  U.....U.
        .byte   $00,$04,$55,$14,$55,$14,$00,$04 ; F6C2 00 04 55 14 55 14 00 04  ..U.U...
        .byte   $00,$42,$8F,$00,$99,$88,$F6,$00 ; F6CA 00 42 8F 00 99 88 F6 00  .B......
        .byte   $00,$82,$05,$80,$27,$8E,$02,$00 ; F6D2 00 82 05 80 27 8E 02 00  ....'...
        .byte   $01,$8F,$00,$8E,$02,$41,$02,$3D ; F6DA 01 8F 00 8E 02 41 02 3D  .....A.=
        .byte   $02,$3F,$02,$3C,$02,$3D,$04,$39 ; F6E2 02 3F 02 3C 02 3D 04 39  .?.<.=.9
        .byte   $04,$3A,$04,$3C,$04,$3D,$04,$3A ; F6EA 04 3A 04 3C 04 3D 04 3A  .:.<.=.:
        .byte   $04,$3C,$04,$3D,$04,$3F,$02,$39 ; F6F2 04 3C 04 3D 04 3F 02 39  .<.=.?.9
        .byte   $02,$41,$82,$41,$04,$3A,$04,$3C ; F6FA 02 41 82 41 04 3A 04 3C  .A.A.:.<
        .byte   $04,$3D,$04,$3F,$42,$3D,$04,$3C ; F702 04 3D 04 3F 42 3D 04 3C  .=.?B=.<
        .byte   $04,$3A,$02,$39,$02,$3A,$02,$37 ; F70A 04 3A 02 39 02 3A 02 37  .:.9.:.7
        .byte   $04,$39,$04,$3A,$04,$3C,$04,$8F ; F712 04 39 04 3A 04 3C 04 8F  .9.:.<..
        .byte   $00,$8E,$02,$46,$02,$46,$14,$46 ; F71A 00 8E 02 46 02 46 14 46  ...F.F.F
        .byte   $14,$45,$14,$46,$14,$48,$43,$45 ; F722 14 45 14 46 14 48 43 45  .E.F.HCE
        .byte   $04,$41,$02,$49,$03,$46,$03,$3D ; F72A 04 41 02 49 03 46 03 3D  .A.I.F.=
        .byte   $03,$3F,$03,$41,$42,$00,$03,$46 ; F732 03 3F 03 41 42 00 03 46  .?.AB..F
        .byte   $43,$48,$14,$49,$14,$48,$14,$46 ; F73A 43 48 14 49 14 48 14 46  CH.I.H.F
        .byte   $14,$41,$14,$3F,$43,$42,$04,$46 ; F742 14 41 14 3F 43 42 04 46  .A.?CB.F
        .byte   $03,$48,$04,$46,$14,$41,$43,$42 ; F74A 03 48 04 46 14 41 43 42  .H.F.ACB
        .byte   $04,$41,$14,$3F,$14,$3C,$14,$3D ; F752 04 41 14 3F 14 3C 14 3D  .A.?.<.=
        .byte   $14,$3A,$42,$00,$04,$41,$04,$8F ; F75A 14 3A 42 00 04 41 04 8F  .:B..A..
        .byte   $00,$46,$43,$48,$14,$49,$14,$48 ; F762 00 46 43 48 14 49 14 48  .FCH.I.H
        .byte   $14,$46,$14,$41,$14,$3F,$43,$42 ; F76A 14 46 14 41 14 3F 43 42  .F.A.?CB
        .byte   $04,$46,$03,$48,$04,$46,$14,$41 ; F772 04 46 03 48 04 46 14 41  .F.H.F.A
        .byte   $43,$42,$04,$41,$14,$3F,$14,$3C ; F77A 43 42 04 41 14 3F 14 3C  CB.A.?.<
        .byte   $14,$3D,$14,$3A,$42,$00,$03,$99 ; F782 14 3D 14 3A 42 00 03 99  .=.:B...
        .byte   $DD,$F6,$00,$00,$82,$05,$80,$27 ; F78A DD F6 00 00 82 05 80 27  .......'
        .byte   $8E,$02,$00,$01,$8F,$00,$8E,$08 ; F792 8E 02 00 01 8F 00 8E 08  ........
        .byte   $00,$01,$8F,$00,$3A,$13,$3A,$13 ; F79A 00 01 8F 00 3A 13 3A 13  ....:.:.
        .byte   $3A,$13,$3A,$13,$35,$13,$35,$13 ; F7A2 3A 13 3A 13 35 13 35 13  :.:.5.5.
        .byte   $35,$13,$35,$13,$3A,$13,$3A,$13 ; F7AA 35 13 35 13 3A 13 3A 13  5.5.:.:.
        .byte   $36,$13,$36,$13,$35,$13,$35,$13 ; F7B2 36 13 36 13 35 13 35 13  6.6.5.5.
        .byte   $35,$13,$35,$13,$3A,$13,$3A,$13 ; F7BA 35 13 35 13 3A 13 3A 13  5.5.:.:.
        .byte   $3A,$13,$3A,$13,$33,$13,$33,$13 ; F7C2 3A 13 3A 13 33 13 33 13  :.:.3.3.
        .byte   $33,$13,$33,$13,$35,$13,$35,$13 ; F7CA 33 13 33 13 35 13 35 13  3.3.5.5.
        .byte   $35,$13,$35,$13,$3A,$13,$3A,$13 ; F7D2 35 13 35 13 3A 13 3A 13  5.5.:.:.
        .byte   $3A,$13,$3A,$13,$8E,$14,$00,$01 ; F7DA 3A 13 3A 13 8E 14 00 01  :.:.....
        .byte   $8F,$00,$99,$98,$F7,$00,$00,$82 ; F7E2 8F 00 99 98 F7 00 00 82  ........
        .byte   $05,$80,$27,$22,$04,$29,$04,$25 ; F7EA 05 80 27 22 04 29 04 25  ..'".).%
        .byte   $04,$29,$04,$21,$04,$29,$04,$27 ; F7F2 04 29 04 21 04 29 04 27  .).!.).'
        .byte   $04,$29,$04,$22,$04,$29,$04,$25 ; F7FA 04 29 04 22 04 29 04 25  .).".).%
        .byte   $04,$29,$04,$22,$04,$29,$04,$25 ; F802 04 29 04 22 04 29 04 25  .).".).%
        .byte   $04,$29,$04,$8E,$04,$22,$04,$29 ; F80A 04 29 04 8E 04 22 04 29  .)...".)
        .byte   $04,$25,$04,$29,$04,$22,$04,$29 ; F812 04 25 04 29 04 22 04 29  .%.).".)
        .byte   $04,$25,$04,$29,$04,$21,$04,$29 ; F81A 04 25 04 29 04 21 04 29  .%.).!.)
        .byte   $04,$27,$04,$29,$04,$21,$04,$29 ; F822 04 27 04 29 04 21 04 29  .'.).!.)
        .byte   $04,$27,$04,$29,$04,$22,$04,$29 ; F82A 04 27 04 29 04 22 04 29  .'.).".)
        .byte   $04,$25,$04,$29,$04,$22,$04,$2A ; F832 04 25 04 29 04 22 04 2A  .%.).".*
        .byte   $04,$27,$04,$2A,$04,$21,$04,$29 ; F83A 04 27 04 2A 04 21 04 29  .'.*.!.)
        .byte   $04,$27,$04,$29,$04,$21,$04,$29 ; F842 04 27 04 29 04 21 04 29  .'.).!.)
        .byte   $04,$27,$04,$29,$04,$22,$04,$29 ; F84A 04 27 04 29 04 22 04 29  .'.).".)
        .byte   $04,$25,$04,$29,$04,$22,$04,$29 ; F852 04 25 04 29 04 22 04 29  .%.).".)
        .byte   $04,$25,$04,$29,$04,$22,$04,$2A ; F85A 04 25 04 29 04 22 04 2A  .%.).".*
        .byte   $04,$27,$04,$2A,$04,$22,$04,$2A ; F862 04 27 04 2A 04 22 04 2A  .'.*.".*
        .byte   $04,$27,$04,$2A,$04,$22,$04,$29 ; F86A 04 27 04 2A 04 22 04 29  .'.*.".)
        .byte   $04,$25,$04,$29,$04,$21,$04,$29 ; F872 04 25 04 29 04 21 04 29  .%.).!.)
        .byte   $04,$27,$04,$29,$04,$22,$04,$29 ; F87A 04 27 04 29 04 22 04 29  .'.).".)
        .byte   $04,$25,$04,$29,$04,$22,$04,$29 ; F882 04 25 04 29 04 22 04 29  .%.).".)
        .byte   $04,$25,$04,$29,$04,$8F,$00,$22 ; F88A 04 25 04 29 04 8F 00 22  .%.)..."
        .byte   $04,$29,$04,$25,$04,$29,$04,$22 ; F892 04 29 04 25 04 29 04 22  .).%.)."
        .byte   $04,$29,$04,$25,$04,$29,$04,$22 ; F89A 04 29 04 25 04 29 04 22  .).%.)."
        .byte   $04,$2A,$04,$27,$04,$2A,$04,$22 ; F8A2 04 2A 04 27 04 2A 04 22  .*.'.*."
        .byte   $04,$2A,$04,$27,$04,$2A,$04,$22 ; F8AA 04 2A 04 27 04 2A 04 22  .*.'.*."
        .byte   $04,$29,$04,$25,$04,$29,$04,$21 ; F8B2 04 29 04 25 04 29 04 21  .).%.).!
        .byte   $04,$29,$04,$27,$04,$29,$04,$22 ; F8BA 04 29 04 27 04 29 04 22  .).'.)."
        .byte   $04,$29,$04,$25,$04,$29,$04,$22 ; F8C2 04 29 04 25 04 29 04 22  .).%.)."
        .byte   $04,$29,$04,$25,$04,$29,$04,$99 ; F8CA 04 29 04 25 04 29 04 99  .).%.)..
        .byte   $0D,$F8,$00,$00,$87,$3B,$E0,$82 ; F8D2 0D F8 00 00 87 3B E0 82  .....;..
        .byte   $03,$80,$27,$8E,$02,$00,$01,$8F ; F8DA 03 80 27 8E 02 00 01 8F  ..'.....
        .byte   $00,$8E,$10,$00,$01,$8F,$00,$8E ; F8E2 00 8E 10 00 01 8F 00 8E  ........
        .byte   $14,$00,$04,$55,$14,$00,$04,$55 ; F8EA 14 00 04 55 14 00 04 55  ...U...U
        .byte   $14,$00,$04,$55,$14,$00,$04,$55 ; F8F2 14 00 04 55 14 00 04 55  ...U...U
        .byte   $14,$8F,$00,$99,$E3,$F8,$00,$00 ; F8FA 14 8F 00 99 E3 F8 00 00  ........
        .byte   $82,$05,$80,$28,$90,$C0,$31,$43 ; F902 82 05 80 28 90 C0 31 43  ...(..1C
        .byte   $33,$04,$35,$43,$31,$04,$35,$03 ; F90A 33 04 35 43 31 04 35 03  3.5C1.5.
        .byte   $33,$04,$31,$04,$33,$03,$30,$03 ; F912 33 04 31 04 33 03 30 03  3.1.3.0.
        .byte   $33,$43,$35,$04,$36,$43,$33,$04 ; F91A 33 43 35 04 36 43 33 04  3C5.6C3.
        .byte   $36,$03,$35,$04,$33,$04,$31,$02 ; F922 36 03 35 04 33 04 31 02  6.5.3.1.
        .byte   $38,$03,$3D,$03,$3C,$03,$3D,$04 ; F92A 38 03 3D 03 3C 03 3D 04  8.=.<.=.
        .byte   $3C,$04,$3A,$03,$38,$04,$3A,$04 ; F932 3C 04 3A 03 38 04 3A 04  <.:.8.:.
        .byte   $35,$03,$31,$83,$31,$04,$3A,$03 ; F93A 35 03 31 83 31 04 3A 03  5.1.1.:.
        .byte   $36,$04,$38,$43,$3D,$04,$3C,$03 ; F942 36 04 38 43 3D 04 3C 03  6.8C=.<.
        .byte   $38,$04,$36,$04,$35,$03,$31,$03 ; F94A 38 04 36 04 35 03 31 03  8.6.5.1.
        .byte   $3C,$82,$3C,$04,$3D,$04,$3C,$04 ; F952 3C 82 3C 04 3D 04 3C 04  <.<.=.<.
        .byte   $3A,$04,$38,$42,$3D,$03,$3A,$82 ; F95A 3A 04 38 42 3D 03 3A 82  :.8B=.:.
        .byte   $3A,$04,$38,$04,$36,$04,$33,$04 ; F962 3A 04 38 04 36 04 33 04  :.8.6.3.
        .byte   $31,$82,$31,$04,$36,$04,$38,$04 ; F96A 31 82 31 04 36 04 38 04  1.1.6.8.
        .byte   $3A,$04,$3C,$82,$3C,$04,$3D,$04 ; F972 3A 04 3C 82 3C 04 3D 04  :.<.<.=.
        .byte   $3F,$04,$41,$04,$3D,$42,$3F,$04 ; F97A 3F 04 41 04 3D 42 3F 04  ?.A.=B?.
        .byte   $41,$04,$42,$82,$42,$04,$46,$04 ; F982 41 04 42 82 42 04 46 04  A.B.B.F.
        .byte   $44,$04,$42,$04,$44,$02,$48,$13 ; F98A 44 04 42 04 44 02 48 13  D.B.D.H.
        .byte   $50,$13,$3A,$03,$3D,$03,$3C,$03 ; F992 50 13 3A 03 3D 03 3C 03  P.:.=.<.
        .byte   $3D,$04,$3C,$14,$3A,$03,$38,$04 ; F99A 3D 04 3C 14 3A 03 38 04  =.<.:.8.
        .byte   $36,$14,$38,$03,$31,$83,$31,$04 ; F9A2 36 14 38 03 31 83 31 04  6.8.1.1.
        .byte   $3A,$03,$36,$04,$38,$83,$38,$04 ; F9AA 3A 03 36 04 38 83 38 04  :.6.8.8.
        .byte   $3A,$04,$3C,$03,$38,$04,$36,$04 ; F9B2 3A 04 3C 03 38 04 36 04  :.<.8.6.
        .byte   $35,$03,$00,$00,$80,$28,$82,$05 ; F9BA 35 03 00 00 80 28 82 05  5....(..
        .byte   $90,$C0,$31,$04,$38,$04,$35,$04 ; F9C2 90 C0 31 04 38 04 35 04  ..1.8.5.
        .byte   $38,$04,$31,$04,$38,$04,$35,$04 ; F9CA 38 04 31 04 38 04 35 04  8.1.8.5.
        .byte   $38,$04,$31,$04,$38,$04,$2C,$03 ; F9D2 38 04 31 04 38 04 2C 03  8.1.8.,.
        .byte   $38,$04,$3C,$04,$2C,$03,$33,$04 ; F9DA 38 04 3C 04 2C 03 33 04  8.<.,.3.
        .byte   $3C,$04,$38,$03,$33,$04,$3C,$04 ; F9E2 3C 04 38 03 33 04 3C 04  <.8.3.<.
        .byte   $2C,$03,$33,$04,$3C,$04,$38,$03 ; F9EA 2C 03 33 04 3C 04 38 03  ,.3.<.8.
        .byte   $38,$04,$3D,$04,$2C,$03,$31,$03 ; F9F2 38 04 3D 04 2C 03 31 03  8.=.,.1.
        .byte   $2C,$03,$31,$13,$2C,$03,$2E,$03 ; F9FA 2C 03 31 13 2C 03 2E 03  ,.1.,...
        .byte   $29,$03,$25,$03,$2C,$03,$2E,$03 ; FA02 29 03 25 03 2C 03 2E 03  ).%.,...
        .byte   $2A,$03,$31,$13,$2C,$03,$33,$03 ; FA0A 2A 03 31 13 2C 03 33 03  *.1.,.3.
        .byte   $31,$04,$30,$04,$31,$03,$00,$03 ; FA12 31 04 30 04 31 03 00 03  1.0.1...
        .byte   $00,$03,$35,$03,$2C,$13,$00,$03 ; FA1A 00 03 35 03 2C 13 00 03  ..5.,...
        .byte   $00,$03,$38,$03,$31,$02,$36,$03 ; FA22 00 03 38 03 31 02 36 03  ..8.1.6.
        .byte   $31,$03,$36,$02,$31,$02,$2E,$83 ; FA2A 31 03 36 02 31 02 2E 83  1.6.1...
        .byte   $2C,$03,$00,$04,$38,$04,$36,$04 ; FA32 2C 03 00 04 38 04 36 04  ,...8.6.
        .byte   $3C,$04,$30,$04,$38,$04,$36,$04 ; FA3A 3C 04 30 04 38 04 36 04  <.0.8.6.
        .byte   $3C,$04,$31,$04,$3D,$04,$35,$04 ; FA42 3C 04 31 04 3D 04 35 04  <.1.=.5.
        .byte   $38,$04,$31,$04,$38,$04,$3C,$04 ; FA4A 38 04 31 04 38 04 3C 04  8.1.8.<.
        .byte   $3D,$04,$31,$04,$3A,$04,$36,$04 ; FA52 3D 04 31 04 3A 04 36 04  =.1.:.6.
        .byte   $3D,$04,$36,$04,$3D,$04,$3A,$04 ; FA5A 3D 04 36 04 3D 04 3A 04  =.6.=.:.
        .byte   $3D,$04,$38,$04,$3F,$04,$3C,$04 ; FA62 3D 04 38 04 3F 04 3C 04  =.8.?.<.
        .byte   $3F,$04,$00,$02,$38,$03,$2C,$13 ; FA6A 3F 04 00 02 38 03 2C 13  ?...8.,.
        .byte   $31,$13,$2C,$03,$2E,$03,$29,$03 ; FA72 31 13 2C 03 2E 03 29 03  1.,...).
        .byte   $31,$13,$2C,$03,$2E,$03,$29,$03 ; FA7A 31 13 2C 03 2E 03 29 03  1.,...).
        .byte   $31,$13,$2C,$03,$30,$04,$2C,$04 ; FA82 31 13 2C 03 30 04 2C 04  1.,.0.,.
        .byte   $2E,$04,$30,$04,$31,$43,$00,$00 ; FA8A 2E 04 30 04 31 43 00 00  ..0.1C..
        .byte   $80,$28,$35,$43,$36,$04,$38,$43 ; FA92 80 28 35 43 36 04 38 43  .(5C6.8C
        .byte   $35,$04,$38,$03,$36,$04,$35,$04 ; FA9A 35 04 38 03 36 04 35 04  5.8.6.5.
        .byte   $36,$03,$33,$03,$36,$43,$38,$04 ; FAA2 36 03 33 03 36 43 38 04  6.3.6C8.
        .byte   $3A,$43,$36,$04,$3A,$03,$38,$04 ; FAAA 3A 43 36 04 3A 03 38 04  :C6.:.8.
        .byte   $36,$04,$35,$02,$3D,$03,$41,$03 ; FAB2 36 04 35 02 3D 03 41 03  6.5.=.A.
        .byte   $3F,$03,$41,$04,$3F,$04,$3D,$03 ; FABA 3F 03 41 04 3F 04 3D 03  ?.A.?.=.
        .byte   $41,$04,$3F,$04,$41,$03,$38,$83 ; FAC2 41 04 3F 04 41 03 38 83  A.?.A.8.
        .byte   $38,$04,$42,$03,$3F,$04,$41,$43 ; FACA 38 04 42 03 3F 04 41 43  8.B.?.AC
        .byte   $44,$04,$42,$04,$3C,$04,$44,$04 ; FAD2 44 04 42 04 3C 04 44 04  D.B.<.D.
        .byte   $42,$04,$41,$03,$00,$03,$35,$01 ; FADA 42 04 41 03 00 03 35 01  B.A...5.
        .byte   $38,$03,$38,$03,$38,$04,$36,$04 ; FAE2 38 03 38 03 38 04 36 04  8.8.8.6.
        .byte   $35,$04,$33,$04,$35,$01,$31,$03 ; FAEA 35 04 33 04 35 01 31 03  5.3.5.1.
        .byte   $31,$03,$31,$04,$30,$04,$2E,$04 ; FAF2 31 03 31 04 30 04 2E 04  1.1.0...
        .byte   $2C,$04,$24,$03,$24,$03,$24,$04 ; FAFA 2C 04 24 03 24 03 24 04  ,.$.$.$.
        .byte   $25,$04,$27,$04,$29,$04,$25,$42 ; FB02 25 04 27 04 29 04 25 42  %.'.).%B
        .byte   $27,$04,$29,$04,$2A,$03,$2A,$03 ; FB0A 27 04 29 04 2A 03 2A 03  '.).*.*.
        .byte   $2A,$04,$2E,$04,$2C,$04,$2A,$04 ; FB12 2A 04 2E 04 2C 04 2A 04  *...,.*.
        .byte   $2C,$02,$30,$13,$38,$13,$50,$14 ; FB1A 2C 02 30 13 38 13 50 14  ,.0.8.P.
        .byte   $4E,$14,$4D,$14,$4B,$14,$49,$14 ; FB22 4E 14 4D 14 4B 14 49 14  N.M.K.I.
        .byte   $48,$14,$46,$14,$44,$14,$50,$14 ; FB2A 48 14 46 14 44 14 50 14  H.F.D.P.
        .byte   $4E,$14,$4D,$14,$4B,$14,$4D,$14 ; FB32 4E 14 4D 14 4B 14 4D 14  N.M.K.M.
        .byte   $4E,$14,$50,$14,$52,$14,$54,$14 ; FB3A 4E 14 50 14 52 14 54 14  N.P.R.T.
        .byte   $52,$14,$50,$14,$4E,$14,$4D,$14 ; FB42 52 14 50 14 4E 14 4D 14  R.P.N.M.
        .byte   $4B,$14,$49,$14,$48,$14,$50,$19 ; FB4A 4B 14 49 14 48 14 50 19  K.I.H.P.
        .byte   $50,$19,$50,$14,$52,$14,$54,$14 ; FB52 50 19 50 14 52 14 54 14  P.P.R.T.
        .byte   $55,$13,$31,$13,$00,$00,$87,$3B ; FB5A 55 13 31 13 00 00 87 3B  U.1....;
        .byte   $E0,$82,$02,$80,$28,$8E,$08,$4B ; FB62 E0 82 02 80 28 8E 08 4B  ....(..K
        .byte   $04,$55,$04,$4B,$04,$55,$04,$4B ; FB6A 04 55 04 4B 04 55 04 4B  .U.K.U.K
        .byte   $04,$55,$09,$55,$09,$4B,$04,$55 ; FB72 04 55 09 55 09 4B 04 55  .U.U.K.U
        .byte   $04,$8F,$00,$4B,$13,$55,$13,$55 ; FB7A 04 8F 00 4B 13 55 13 55  ...K.U.U
        .byte   $13,$00,$03,$55,$13,$55,$13,$4B ; FB82 13 00 03 55 13 55 13 4B  ...U.U.K
        .byte   $13,$55,$13,$4B,$13,$55,$13,$55 ; FB8A 13 55 13 4B 13 55 13 55  .U.K.U.U
        .byte   $13,$00,$03,$4B,$13,$55,$13,$4B ; FB92 13 00 03 4B 13 55 13 4B  ...K.U.K
        .byte   $13,$55,$13,$8E,$07,$4B,$04,$55 ; FB9A 13 55 13 8E 07 4B 04 55  .U...K.U
        .byte   $04,$4B,$04,$55,$04,$4B,$04,$55 ; FBA2 04 4B 04 55 04 4B 04 55  .K.U.K.U
        .byte   $09,$55,$09,$4B,$04,$55,$04,$8F ; FBAA 09 55 09 4B 04 55 04 8F  .U.K.U..
        .byte   $00,$4B,$04,$55,$04,$4B,$04,$55 ; FBB2 00 4B 04 55 04 4B 04 55  .K.U.K.U
        .byte   $04,$55,$04,$00,$00,$94,$00,$82 ; FBBA 04 55 04 00 00 94 00 82  .U......
        .byte   $01,$83,$FF,$80,$40,$92,$00,$87 ; FBC2 01 83 FF 80 40 92 00 87  ....@...
        .byte   $DC,$FB,$86,$D3,$FB,$00,$0A,$00 ; FBCA DC FB 86 D3 FB 00 0A 00  ........
        .byte   $00,$01,$F0,$00,$09,$00,$00,$00 ; FBD2 00 01 F0 00 09 00 00 00  ........
        .byte   $00,$00,$01,$60,$03,$00,$01,$F8 ; FBDA 00 00 01 60 03 00 01 F8  ...`....
        .byte   $05,$F0,$00,$00,$94,$00,$82,$01 ; FBE2 05 F0 00 00 94 00 82 01  ........
        .byte   $83,$FF,$80,$40,$92,$00,$87,$1B ; FBEA 83 FF 80 40 92 00 87 1B  ...@....
        .byte   $FC,$86,$FA,$FB,$00,$0E,$00,$00 ; FBF2 FC 86 FA FB 00 0E 00 00  ........
        .byte   $01,$A0,$00,$02,$F0,$FF,$01,$E0 ; FBFA 01 A0 00 02 F0 FF 01 E0  ........
        .byte   $FF,$01,$F0,$FF,$01,$E0,$FF,$01 ; FC02 FF 01 F0 FF 01 E0 FF 01  ........
        .byte   $F0,$FF,$01,$E0,$FF,$01,$30,$00 ; FC0A F0 FF 01 E0 FF 01 30 00  ......0.
        .byte   $01,$20,$00,$04,$10,$00,$00,$00 ; FC12 01 20 00 04 10 00 00 00  . ......
        .byte   $00,$01,$18,$01,$08,$01,$10,$01 ; FC1A 00 01 18 01 08 01 10 01  ........
        .byte   $08,$03,$10,$01,$00,$05,$F0,$01 ; FC22 08 03 10 01 00 05 F0 01  ........
        .byte   $F8,$00,$00,$94,$00,$82,$01,$83 ; FC2A F8 00 00 94 00 82 01 83  ........
        .byte   $FF,$80,$40,$92,$00,$87,$6C,$FC ; FC32 FF 80 40 92 00 87 6C FC  ..@...l.
        .byte   $86,$45,$FC,$90,$80,$91,$00,$00 ; FC3A 86 45 FC 90 80 91 00 00  .E......
        .byte   $0C,$00,$00,$01,$50,$06,$01,$10 ; FC42 0C 00 00 01 50 06 01 10  ....P...
        .byte   $01,$01,$F0,$04,$01,$B0,$F3,$01 ; FC4A 01 01 F0 04 01 B0 F3 01  ........
        .byte   $C0,$0C,$01,$40,$F3,$01,$40,$09 ; FC52 C0 0C 01 40 F3 01 40 09  ...@..@.
        .byte   $01,$C0,$F6,$01,$90,$09,$01,$20 ; FC5A 01 C0 F6 01 90 09 01 20  ....... 
        .byte   $FF,$01,$B0,$03,$01,$C0,$FA,$00 ; FC62 FF 01 B0 03 01 C0 FA 00  ........
        .byte   $00,$00,$01,$20,$01,$48,$01,$B8 ; FC6A 00 00 01 20 01 48 01 B8  ... .H..
        .byte   $01,$48,$01,$D8,$01,$E0,$01,$50 ; FC72 01 48 01 D8 01 E0 01 50  .H.....P
        .byte   $01,$D0,$01,$30,$01,$B0,$01,$00 ; FC7A 01 D0 01 30 01 B0 01 00  ...0....
        .byte   $01,$50,$00,$00,$94,$00,$82,$01 ; FC82 01 50 00 00 94 00 82 01  .P......
        .byte   $83,$FF,$80,$40,$92,$00,$87,$A7 ; FC8A 83 FF 80 40 92 00 87 A7  ...@....
        .byte   $FC,$86,$9E,$FC,$90,$80,$91,$00 ; FC92 FC 86 9E FC 90 80 91 00  ........
        .byte   $00,$08,$00,$00,$01,$10,$02,$07 ; FC9A 00 08 00 00 01 10 02 07  ........
        .byte   $00,$00,$00,$00,$00,$01,$70,$04 ; FCA2 00 00 00 00 00 01 70 04  ......p.
        .byte   $F0,$03,$F8,$00,$00,$94,$00,$82 ; FCAA F0 03 F8 00 00 94 00 82  ........
        .byte   $01,$83,$FF,$80,$40,$92,$00,$87 ; FCB2 01 83 FF 80 40 92 00 87  ....@...
        .byte   $EE,$FC,$86,$C7,$FC,$90,$80,$91 ; FCBA EE FC 86 C7 FC 90 80 91  ........
        .byte   $00,$00,$0D,$00,$00,$01,$F0,$08 ; FCC2 00 00 0D 00 00 01 F0 08  ........
        .byte   $01,$A0,$FF,$01,$80,$FF,$01,$90 ; FCCA 01 A0 FF 01 80 FF 01 90  ........
        .byte   $FF,$01,$A0,$00,$01,$90,$FF,$01 ; FCD2 FF 01 A0 00 01 90 FF 01  ........
        .byte   $80,$FF,$01,$90,$FF,$01,$40,$00 ; FCDA 80 FF 01 90 FF 01 40 00  ......@.
        .byte   $01,$70,$FF,$02,$B0,$FF,$01,$A0 ; FCE2 01 70 FF 02 B0 FF 01 A0  .p......
        .byte   $FF,$00,$00,$00,$01,$60,$02,$00 ; FCEA FF 00 00 00 01 60 02 00  .....`..
        .byte   $06,$F8,$04,$08,$00,$00,$94,$00 ; FCF2 06 F8 04 08 00 00 94 00  ........
        .byte   $82,$01,$83,$FF,$80,$40,$92,$00 ; FCFA 82 01 83 FF 80 40 92 00  .....@..
        .byte   $87,$2B,$FD,$86,$10,$FD,$90,$80 ; FD02 87 2B FD 86 10 FD 90 80  .+......
        .byte   $91,$8A,$00,$0F,$00,$00,$01,$00 ; FD0A 91 8A 00 0F 00 00 01 00  ........
        .byte   $5B,$02,$00,$00,$01,$40,$FC,$02 ; FD12 5B 02 00 00 01 40 FC 02  [....@..
        .byte   $00,$00,$01,$30,$F3,$03,$00,$00 ; FD1A 00 00 01 30 F3 03 00 00  ...0....
        .byte   $01,$00,$FE,$04,$00,$00,$00,$00 ; FD22 01 00 FE 04 00 00 00 00  ........
        .byte   $00,$01,$60,$0E,$00,$00,$00,$94 ; FD2A 00 01 60 0E 00 00 00 94  ..`.....
        .byte   $00,$82,$01,$83,$FF,$80,$40,$92 ; FD32 00 82 01 83 FF 80 40 92  ......@.
        .byte   $00,$87,$52,$FD,$86,$49,$FD,$90 ; FD3A 00 87 52 FD 86 49 FD 90  ..R..I..
        .byte   $80,$91,$DA,$00,$0C,$00,$00,$01 ; FD42 80 91 DA 00 0C 00 00 01  ........
        .byte   $70,$4B,$0B,$00,$00,$00,$00,$00 ; FD4A 70 4B 0B 00 00 00 00 00  pK......
        .byte   $01,$60,$04,$00,$03,$F8,$01,$F0 ; FD52 01 60 04 00 03 F8 01 F0  .`......
        .byte   $01,$E8,$01,$F0,$01,$00,$00,$00 ; FD5A 01 E8 01 F0 01 00 00 00  ........
        .byte   $94,$00,$82,$01,$83,$FF,$80,$40 ; FD62 94 00 82 01 83 FF 80 40  .......@
        .byte   $92,$00,$87,$89,$FD,$86,$7A,$FD ; FD6A 92 00 87 89 FD 86 7A FD  ......z.
        .byte   $90,$80,$91,$AD,$00,$0C,$00,$00 ; FD72 90 80 91 AD 00 0C 00 00  ........
        .byte   $01,$10,$18,$03,$00,$00,$01,$C0 ; FD7A 01 10 18 03 00 00 01 C0  ........
        .byte   $07,$07,$00,$00,$00,$00,$00,$01 ; FD82 07 07 00 00 00 00 00 01  ........
        .byte   $48,$05,$00,$01,$F8,$02,$F0,$03 ; FD8A 48 05 00 01 F8 02 F0 03  H.......
        .byte   $F8,$00,$00,$94,$00,$82,$01,$83 ; FD92 F8 00 00 94 00 82 01 83  ........
        .byte   $FF,$80,$40,$92,$00,$87,$B2,$FD ; FD9A FF 80 40 92 00 87 B2 FD  ..@.....
        .byte   $86,$A9,$FD,$00,$3B,$00,$00,$01 ; FDA2 86 A9 FD 00 3B 00 00 01  ....;...
        .byte   $E0,$00,$3A,$00,$00,$00,$00,$00 ; FDAA E0 00 3A 00 00 00 00 00  ..:.....
        .byte   $01,$78,$04,$00,$01,$F8,$04,$00 ; FDB2 01 78 04 00 01 F8 04 00  .x......
        .byte   $01,$F8,$01,$F0,$01,$00,$01,$E8 ; FDBA 01 F8 01 F0 01 00 01 E8  ........
        .byte   $02,$00,$01,$F8,$02,$00,$01,$F0 ; FDC2 02 00 01 F8 02 00 01 F0  ........
        .byte   $03,$00,$01,$F8,$07,$00,$01,$F8 ; FDCA 03 00 01 F8 07 00 01 F8  ........
        .byte   $06,$00,$01,$F8,$08,$00,$01,$F8 ; FDD2 06 00 01 F8 08 00 01 F8  ........
        .byte   $0B,$00,$00,$00,$94,$00,$82,$01 ; FDDA 0B 00 00 00 94 00 82 01  ........
        .byte   $83,$FF,$80,$40,$92,$00,$87,$FB ; FDE2 83 FF 80 40 92 00 87 FB  ...@....
        .byte   $FD,$86,$F2,$FD,$00,$3E,$00,$00 ; FDEA FD 86 F2 FD 00 3E 00 00  .....>..
        .byte   $01,$C0,$00,$3D,$00,$00,$00,$00 ; FDF2 01 C0 00 3D 00 00 00 00  ...=....
        .byte   $00,$01,$78,$03,$00,$01,$F0,$01 ; FDFA 00 01 78 03 00 01 F0 01  ..x.....
        .byte   $00,$03,$F8,$02,$00,$01,$F8,$02 ; FE02 00 03 F8 02 00 01 F8 02  ........
        .byte   $00,$01,$F8,$02,$00,$01,$F8,$02 ; FE0A 00 01 F8 02 00 01 F8 02  ........
        .byte   $00,$01,$F8,$03,$00,$01,$F8,$03 ; FE12 00 01 F8 03 00 01 F8 03  ........
        .byte   $00,$01,$F8,$04,$00,$01,$F8,$05 ; FE1A 00 01 F8 04 00 01 F8 05  ........
        .byte   $00,$01,$F8,$09,$00,$01,$F8,$0C ; FE22 00 01 F8 09 00 01 F8 0C  ........
        .byte   $00,$00,$00,$94,$00,$82,$01,$83 ; FE2A 00 00 00 94 00 82 01 83  ........
        .byte   $FF,$80,$40,$92,$00,$87,$4A,$FE ; FE32 FF 80 40 92 00 87 4A FE  ..@...J.
        .byte   $86,$41,$FE,$00,$32,$00,$00,$01 ; FE3A 86 41 FE 00 32 00 00 01  .A..2...
        .byte   $D0,$00,$31,$00,$00,$00,$00,$00 ; FE42 D0 00 31 00 00 00 00 00  ..1.....
        .byte   $01,$78,$03,$00,$01,$F0,$06,$F8 ; FE4A 01 78 03 00 01 F0 06 F8  .x......
        .byte   $01,$00,$01,$F8,$01,$00,$01,$F8 ; FE52 01 00 01 F8 01 00 01 F8  ........
        .byte   $03,$00,$01,$F8,$04,$00,$01,$F8 ; FE5A 03 00 01 F8 04 00 01 F8  ........
        .byte   $05,$00,$01,$F8,$0A,$00,$01,$F8 ; FE62 05 00 01 F8 0A 00 01 F8  ........
        .byte   $09,$00,$00,$00,$94,$00,$82,$01 ; FE6A 09 00 00 00 94 00 82 01  ........
        .byte   $83,$FF,$80,$40,$92,$00,$87,$91 ; FE72 83 FF 80 40 92 00 87 91  ...@....
        .byte   $FE,$86,$82,$FE,$00,$33,$00,$00 ; FE7A FE 86 82 FE 00 33 00 00  .....3..
        .byte   $01,$E0,$00,$13,$00,$00,$01,$10 ; FE82 01 E0 00 13 00 00 01 10  ........
        .byte   $00,$1E,$00,$00,$00,$00,$00,$01 ; FE8A 00 1E 00 00 00 00 00 01  ........
        .byte   $78,$02,$00,$01,$F0,$01,$00,$01 ; FE92 78 02 00 01 F0 01 00 01  x.......
        .byte   $F8,$02,$00,$01,$F8,$02,$00,$01 ; FE9A F8 02 00 01 F8 02 00 01  ........
        .byte   $F8,$02,$00,$02,$F8,$02,$F0,$02 ; FEA2 F8 02 00 02 F8 02 F0 02  ........
        .byte   $F8,$01,$00,$01,$08,$02,$00,$01 ; FEAA F8 01 00 01 08 02 00 01  ........
        .byte   $08,$04,$00,$01,$08,$05,$00,$01 ; FEB2 08 04 00 01 08 05 00 01  ........
        .byte   $F8,$01,$00,$01,$F8,$03,$00,$01 ; FEBA F8 01 00 01 F8 03 00 01  ........
        .byte   $F8,$03,$00,$01,$F8,$05,$00,$00 ; FEC2 F8 03 00 01 F8 05 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FECA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FED2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FEDA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FEE2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FEEA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FEF2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FEFA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF02 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF0A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF12 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF1A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF22 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF2A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF32 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF3A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF42 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF4A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF52 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF5A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF62 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF6A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF72 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF7A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF82 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF8A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF92 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FF9A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFA2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFAA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFB2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFBA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFC2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFCA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFD2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFDA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFE2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; FFEA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00                 ; FFF2 00 00 00 00              ....
cnromBank2or3:
        .byte   $02,$03                         ; FFF6 02 03                    ..
unknownData02:
        .byte   $11,$A9                         ; FFF8 11 A9                    ..
; ----------------------------------------------------------------------------

.segment        "VECTORS": absolute

        .addr   nmi                             ; FFFA AC A7                    ..
        .addr   reset                           ; FFFC 11 A9                    ..
        .addr   reset                           ; FFFE 11 A9                    ..

; End of "VECTORS" segment
; ----------------------------------------------------------------------------
.code

