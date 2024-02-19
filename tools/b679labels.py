"""
one off to handle the labels at 0xb679

first bit of first byte controls repeat
remaining 7 bits is # of columns

next byte is rows

next two bytes are PPU address

next two bytes are address of tiles

"""

START = 16+0xb679 - 0x8000
END = START + (0xb849-0xb67a) - 1
rom = bytearray(open('clean.nes', 'rb').read())

labels = list(reversed("""pause
unpause
gameOverCoop
gameOver1p
gameOver2p
clearScoresP1
clearSomething
pauseCoop
unpauseCoop
displayStatsP1
displayStatsP2
displayStatsCoop
levelUpAnimation
unsetLevelUpAnimation""".splitlines()))


sub_current = 1
pointer = START
current = rom[pointer]
label = labels.pop()

labels_processed = []

while True:
    if pointer >= END:
        break
    addr = pointer + 0x8000 - 0x10
    print (f'RANGE {{ START ${addr:04x}; END ${addr+1:02x}; TYPE BYTETABLE; NAME "{label}ColsRows{sub_current}"; }};')
    print (f'RANGE {{ START ${addr+2:04x}; END ${addr+3:02x}; TYPE WORDTABLE; NAME "{label}PPUAddr{sub_current}"; }};')
    print (f'RANGE {{ START ${addr+4:04x}; END ${addr+5:02x}; TYPE ADDRTABLE; NAME "{label}TilesAddr{sub_current}"; }};')
    # print(label, group.hex(), current, sub_current)
    sub_current += 1
    pointer+=6
    current = rom[pointer]
    if not current:
        addr = pointer + 0x8000 - 0x10
        print (f'RANGE {{ START ${addr:04x}; END ${addr:04x}; TYPE BYTETABLE; NAME "{label}End"; }};')
        if pointer < END:
            label = labels.pop()
            sub_current = 1
            pointer += 1



