; unused while doing the labeling, but here for reference

BUTTON_A := $01
BUTTON_B := $02
BUTTON_SELECT := $04
BUTTON_START := $08
BUTTON_UP := $10
BUTTON_DOWN := $20
BUTTON_LEFT := $40
BUTTON_RIGHT := $80

BUTTON_DPAD := BUTTON_UP | BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT

; loaded into x several times throughout the code
PLAYER1 := $00
PLAYER2 := $00

MENU_GAMEMODE_1P = $00
MENU_GAMEMODE_2P = $01
MENU_GAMEMODE_COOP = $02
MENU_GAMEMODE_VS = $03
MENU_GAMEMODE_WITH = $04


; gameState values
GAMESTATE_LEADERBOARD := $F8
GAMESTATE_GAMEOVER := $F9
GAMESTATE_TITLE := $FA
GAMESTATE_DEMO := $FB
GAMESTATE_GAME_TYPE := $FC
GAMESTATE_LEVEL_SELECT := $FD
GAMESTATE_HANDICAP := $FE
GAMESTATE_MUSIC_SELECT := $FF
GAMESTATE_PLAYING := $00
GAMESTATE_PAUSED := $01
GAMESTATE_LEVELUP := $03

PLAYMODE_COOP := $FF
PLAYMODE_1P := $00
PLAYMODE_2P := $01

MUSIC_TROIKA := $07
MUSIC_KARINKA := $06
MUSIC_BRADINSKY := $05
MUSIC_LOGINSKA := $04
MUSIC_SILENCE := $08
MUSIC_TITLESCREEN := $09
MUSIC_GAMEOVER := $0a
MUSIC_LEVELWIN := $0b
MUSIC_UNKNOWN_EVENT := $0c
MUSIC_UNKNOWN_SONG := $0d
SOUND_DROP := $0e
SOUND_SWIPE := $0f
SOUND_CHIRP := $10
SOUND_PING := $11
SOUND_SPACE := $12
SOUND_ZAP := $13
SOUND_SELECTION := $14
SOUND_SCREEN_SWITCH := $15
SOUND_TOPOUT := $16
SOUND_TOPOUT2 := $17
SOUND_TOPOUT3 := $18
SOUND_TOPOUT4 := $19
