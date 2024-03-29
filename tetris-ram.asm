.zeropage
ppuControl:	.res 1	; $0000
ppuMask:	.res 1	; $0001
ppuScrollX:	.res 1	; $0002
ppuScrollY:	.res 1	; $0003
currentCHRBank:	.res $4	; $0004
renderSlot0Data:	.res $2	; $0008
renderSlot2Data:	.res $2	; $000A
renderSlot4Data:	.res $2	; $000C
renderSlot6Data:	.res $2	; $000E
renderSlot8Data:	.res $2	; $0010
renderSlotAData:	.res $2	; $0012
renderSlotCData:	.res $2	; $0014
renderSlot0Addr:	.res $2	; $0016
renderSlot2Addr:	.res $2	; $0018
renderSlot4Addr:	.res $2	; $001A
renderSlot6Addr:	.res $2	; $001C
renderSlot8Addr:	.res $2	; $001E
renderSlotAAddr:	.res $2	; $0020
renderSlotCAddr:	.res $2	; $0022
ppuRenderSlot0Length:	.res 1	; $0024
currentPPUSlot:	.res 1	; $0025
ppuRenderSlot2Length:	.res 1	; $0026
nextPPUSlot:	.res 1	; $0027
ppuRenderSlot4Length:	.res 1	; $0028
gameState:	.res 1	; $0029
ppuRenderSlot6Length:	.res 1	; $002A
frameCounterLowLastFrame:	.res 1	; $002B
ppuRenderSlot8Length:	.res 1	; $002C
.res 1
ppuRenderSlotALength:	.res 1	; $002E
playMode:	.res 1	; $002F
ppuRenderSlotCLength:	.res 1	; $0030
.res 1
frameCounterLow:	.res 1	; $0032
frameCounterHigh:	.res 1	; $0033
rngSeed:	.res $2	; $0034
generalCounter36:	.res 1	; $0036
generalCounter37:	.res 1	; $0037
generalCounter38:	.res 1	; $0038
generalCounter39:	.res 1	; $0039
generalCounter3a:	.res 1	; $003A
generalCounter3b:	.res 1	; $003B
generalCounter3c:	.res 1	; $003C
generalCounter3d:	.res 1	; $003D
player1ControllerLastFrame:	.res 1	; $003E
player2ControllerLastFrame:	.res 1	; $003F
player1ExpansionLastFrame:	.res 1	; $0040
player2ExpansionLastFrame:	.res 1	; $0041
player1ControllerHeld:	.res 1	; $0042
player2ControllerHeld:	.res 1	; $0043
player1ExpansionHeld:	.res 1	; $0044
player2ExpansionHeld:	.res 1	; $0045
player1ControllerNew:	.res 1	; $0046
player2ControllerNew:	.res 1	; $0047
ppuStagingAddress:	.res $2	; $0048
player1GameActive:	.res 1	; $004A
player2GameActive:	.res 1	; $004B
.res 6
pieceStatistics:	.res 1	; $0052
pieceStatsI:	.res 1	; $0053
pieceStatsT:	.res 1	; $0054
pieceStatsO:	.res 1	; $0055
pieceStatsJ:	.res 1	; $0056
pieceStatsL:	.res 1	; $0057
pieceStatsS:	.res 1	; $0058
pieceStatsZ:	.res 1	; $0059
savedRNGSeed:	.res $2	; $005A
player1RNGSeed:	.res $2	; $005C
player2RNGSeed:	.res $2	; $005E
player1TetrominoY:	.res 1	; $0060
player2TetrominoY:	.res 1	; $0061
player1TetrominoX:	.res 1	; $0062
player2TetrominoX:	.res 1	; $0063
player1TetrominoCurrent:	.res 1	; $0064
player2TetrominoCurrent:	.res 1	; $0065
player1TetrominoNext:	.res 1	; $0066
player2TetrominoNext:	.res 1	; $0067
player1TetrominoOrientation:	.res 1	; $0068
player2TetrominoOrientation:	.res 1	; $0069
player1FallTimer:	.res 1	; $006A
player2FallTimer:	.res 1	; $006B
.res 10
relatesToAddrTableAB25:	.res $2	; $0076
.res 119
audioSomethingEF:	.res 1	; $00EF
audioSomethingF0:	.res 1	; $00F0
audioPointerF1:	.res $2	; $00F1
.res 1
audioDataAddr:	.res $2	; $00F4
apuRegister:	.res $2	; $00F6
.res 4
audioPointerFC:	.res $2	; $00FC
.res 1
audioFlags:	.res 1	; $00FF

.bss
ppuStaging:	.res $46	; $0100
.res 74
lineClearStatsPPUStaging:	.res $4	; $0190
.res 22
dasLeftPlayer1:	.res 1	; $01AA
dasLeftPlayer2:	.res 1	; $01AB
dasRightPlayer1:	.res 1	; $01AC
dasRightPlayer2:	.res 1	; $01AD
autoRotateCounterP1:	.res 1	; $01AE
autoRotateCounterP2:	.res 1	; $01AF
autoRotateClockwiseP1:	.res 1	; $01B0
autoRotateClockwiseP2:	.res 1	; $01B1
dropRepeatP1:	.res 1	; $01B2
dropRepeatP2:	.res 1	; $01B3
dropRatePossibleP1:	.res 1	; $01B4
dropRatePossibleP2:	.res 1	; $01B5
codeInputYPlayer1:	.res 1	; $01B6
codeInputYPlayer2:	.res 1	; $01B7
longBarCodeUsedP1:	.res 1	; $01B8
longBarCodeUsedP2:	.res 1	; $01B9
undoCodeUsedP1:	.res 1	; $01BA
undoCodeUsedP2:	.res 1	; $01BB
lastCurrentBlockP1:	.res 1	; $01BC
lastCurrentBlockP2:	.res 1	; $01BD
lastOrientationP1:	.res 1	; $01BE
lastOrientationP2:	.res 1	; $01BF
lastTetrominoYP1:	.res 1	; $01C0
lastTetrominoYP2:	.res 1	; $01C1
lastTetrominoXP1:	.res 1	; $01C2
lastTetrominoXP2:	.res 1	; $01C3
lastRNGSeedP1:	.res $2	; $01C4
lastRNGSeedP2:	.res $2	; $01C6
pointsDisplayTimerP1:	.res 1	; $01C8
pointsDisplayTimerP2:	.res 1	; $01C9
.res 4
lineClearTimerP1:	.res 1	; $01CE
lineClearTimerP2:	.res 1	; $01CF
.res 2
relatedToLevelUpAnimations:	.res 1	; $01D2
stack:	.res $1D	; $01D3
.res 41
audioStagingAddrLo:	.res $0A	; $0219
.res 1
audioStagingAddrHi:	.res $0A	; $0224
.res 445
audioStagingSlot1:	.res 1	; $03EB
audioStagingSlot3:	.res 1	; $03EC
audioStagingSlot4:	.res 1	; $03ED
audioStagingSlot2:	.res 1	; $03EE
soundChannelsEnabled:	.res 1	; $03EF
.res 3
apuRegisterType:	.res 1	; $03F3
.res 3
audioBuffer:	.res $21	; $03F7
player1ScoreHundredThousands:	.res 1	; $0418
player1ScoreTenThousands:	.res 1	; $0419
player1ScoreThousands:	.res 1	; $041A
player1ScoreHundreds:	.res 1	; $041B
player1ScoreTens:	.res 1	; $041C
player1ScoreOnes:	.res 1	; $041D
player2ScoreHundredThousands:	.res 1	; $041E
player2ScoreTenThousands:	.res 1	; $041F
player2ScoreThousands:	.res 1	; $0420
player2ScoreHundreds:	.res 1	; $0421
player2ScoreTens:	.res 1	; $0422
player2ScoreOnes:	.res 1	; $0423
player1LinesThousands:	.res 1	; $0424
player1LinesHundreds:	.res 1	; $0425
player1LinesTens:	.res 1	; $0426
player1LinesOnes:	.res 1	; $0427
player2LinesThousands:	.res 1	; $0428
player2LinesHundreds:	.res 1	; $0429
player2LinesTens:	.res 1	; $042A
player2LinesOnes:	.res 1	; $042B
player1LevelTens:	.res 1	; $042C
player1LevelOnes:	.res 1	; $042D
player2LevelTens:	.res 1	; $042E
player2LevelOnes:	.res 1	; $042F
player1ScoreMirrorPossible:	.res $6	; $0430
player1LinesMirrorPossible:	.res $6	; $0436
highScoreHundredThousands:	.res 1	; $043C
highScoreTenThousands:	.res 1	; $043D
highScoreThousands:	.res 1	; $043E
highScoreHundreds:	.res 1	; $043F
highScoreTens:	.res 1	; $0440
highScoreOnes:	.res 1	; $0441
leaderboardScores:	.res $54	; $0442
leaderboardLines:	.res $2D	; $0496
leaderboardInitials:	.res $2D	; $04C3
menuGameMode:	.res 1	; $04F0
menuPlayer1StartLevel:	.res 1	; $04F1
menuPlayer2StartLevel:	.res 1	; $04F2
menuPlayer1Handicap:	.res 1	; $04F3
menuPlayer2Handicap:	.res 1	; $04F4
menuMusic:	.res 1	; $04F5
ppuScrollYOffset:	.res 1	; $04F6
initMagic:	.res $4	; $04F7
.res 5
oamStaging:	.res $100	; $0500
player1Playfield:	.res $DF	; $0600
.res 33
player2Playfield:	.res $DF	; $0700
