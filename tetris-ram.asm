.zeropage
ppuControl:	.res 1	; $0000
ppuMask:	.res 1	; $0001
ppuScrollX:	.res 1	; $0002
ppuScrollY:	.res 1	; $0003
currentCHRBank:	.res $4	; $0004
ppuDataAddress1:	.res $2	; $0008
ppuDataAddress2:	.res $2	; $000A
ppuDataAddress3:	.res $2	; $000C
ppuDataAddress4:	.res $2	; $000E
ppuDataAddress5:	.res $2	; $0010
ppuDataAddress6:	.res $2	; $0012
ppuDataAddress7:	.res $2	; $0014
.res 15
ppuRenderFlagBefore:	.res 1	; $0025
.res 1
ppuRenderFlagAfter:	.res 1	; $0027
.res 1
gameState:	.res 1	; $0029
.res 1
frameCounterLowLastFrame:	.res 1	; $002b
.res 3
playMode:	.res 1	; $002f
.res 2
frameCounterLow:	.res 1	; $0032
frameCounterHigh:	.res 1	; $0033
rngSeed:	.res $2	; $0034
generalCounter36:	.res 1	; $0036
generalCounter37:	.res 1	; $0037
generalCounter38:	.res 1	; $0038
generalCounter39:	.res 1	; $0039
generalCounter3a:	.res 1	; $003a
generalCounter3b:	.res 1	; $003b
generalCounter3c:	.res 1	; $003c
generalCounter3d:	.res 1	; $003d
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
.res 8
pieceStatistics:	.res 1	; $0052
pieceStatsI:	.res 1	; $0053
pieceStatsT:	.res 1	; $0054
pieceStatsO:	.res 1	; $0055
pieceStatsJ:	.res 1	; $0056
pieceStatsL:	.res 1	; $0057
pieceStatsS:	.res 1	; $0058
pieceStatsZ:	.res 1	; $0059
savedRNGSeedForSomething:	.res $2	; $005a
player1RNGSeed:	.res $2	; $005c
player2RNGSeed:	.res $2	; $005e
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
player1FallTimer:	.res 1	; $006a
player2FallTimer:	.res 1	; $006b
.res 10
relatesToAddrTableAB25:	.res $2	; $0076
.res 136
ppuStaging:	.res $46	; $0100
.res 112
codeInputPlayer1:	.res 1	; $01b6
codeInputPlayer2:	.res 1	; $01b7
longBarCodeUsedP1:	.res 1	; $01b8
longBarCodeUsedP2:	.res 1	; $01b9
undoCodeUsedP1:	.res 1	; $01ba
undoCodeUsedP2:	.res 1	; $01bb
lastCurrentBlockP1:	.res 1	; $01bc
lastCurrentBlockP2:	.res 1	; $01bd
lastOrientationP1:	.res 1	; $01be
lastOrientationP2:	.res 1	; $01bf
lastTetrominoYP1:	.res 1	; $01c0
lastTetrominoYP2:	.res 1	; $01c1
lastTetrominoXP1:	.res 1	; $01c2
lastTetrominoXP2:	.res 1	; $01c3
lastRNGSeedP1:	.res $2	; $01c4
lastRNGSeedP2:	.res $2	; $01c6
pointsDisplayTimerP1:	.res 1	; $01c8
pointsDisplayTimerP2:	.res 1	; $01c9
.res 4
lineClearTimerP1:	.res 1	; $01ce
lineClearTimerP2:	.res 1	; $01cf
.res 3
stack:	.res $1d	; $01d3
.res 552
player1ScoreHundredThousands:	.res 1	; $0418
player1ScoreTenThousands:	.res 1	; $0419
player1ScoreThousands:	.res 1	; $041a
player1ScoreHundreds:	.res 1	; $041b
player1ScoreTens:	.res 1	; $041c
player1ScoreOnes:	.res 1	; $041d
player2ScoreHundredThousands:	.res 1	; $041e
player2ScoreTenThousands:	.res 1	; $041f
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
player2LinesTens:	.res 1	; $042a
player2LinesOnes:	.res 1	; $042b
player1LevelTens:	.res 1	; $042c
player1LevelOnes:	.res 1	; $042d
player2LevelTens:	.res 1	; $042e
player2LevelOnes:	.res 1	; $042f
player1ScoreMirrorPossible:	.res $6	; $0430
player1LinesMirrorPossible:	.res $6	; $0436
highScoreHundredThousands:	.res 1	; $043c
highScoreTenThousands:	.res 1	; $043d
highScoreThousands:	.res 1	; $043e
highScoreHundreds:	.res 1	; $043f
highScoreTens:	.res 1	; $0440
highScoreOnes:	.res 1	; $0441
leaderboardScores:	.res $54	; $0442
leaderboardLines:	.res $2d	; $0496
leaderboardInitials:	.res $2d	; $04c3
menuGameMode:	.res 1	; $04f0
menuPlayer1StartLevel:	.res 1	; $04f1
menuPlayer2StartLevel:	.res 1	; $04f2
menuPlayer1Handicap:	.res 1	; $04f3
menuPlayer2Handicap:	.res 1	; $04f4
menuMusic:	.res 1	; $04f5
ppuScrollYOffset:	.res 1	; $04f6
.res 9
oamStaging:	.res $100	; $0500
player1Playfield:	.res $DF	; $0600
.res 33
player2Playfield:	.res $DF	; $0700
