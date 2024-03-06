"""
visualize orientationTable
"""
import re

# N is used to indicate the hidden/null piece
pieces = list(reversed("NITOJLSZ"))

orientationTable = """
orientationTable:
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 86C3 00 00 00 00 00 00 00 00  ........
orientationForI:
        .byte   $F0,$00,$44,$44,$F0,$00,$44,$44 ; 86CB F0 00 44 44 F0 00 44 44  ..DD..DD
orientationForT:
        .byte   $E4,$00,$8C,$80,$4E,$00,$4C,$40 ; 86D3 E4 00 8C 80 4E 00 4C 40  ....N.L@
orientationForO:
        .byte   $CC,$00,$CC,$00,$CC,$00,$CC,$00 ; 86DB CC 00 CC 00 CC 00 CC 00  ........
orientationForJ:
        .byte   $E2,$00,$C8,$80,$8E,$00,$44,$C0 ; 86E3 E2 00 C8 80 8E 00 44 C0  ......D.
orientationForL:
        .byte   $E8,$00,$88,$C0,$2E,$00,$C4,$40 ; 86EB E8 00 88 C0 2E 00 C4 40  .......@
; 
; this shows up as the offset point for the tiles (id * 16)
; these 8 bytes are also orientationForS, but not referenced directly
orientationTiles:
        .byte   $6C,$00,$8C,$40,$6C,$00,$8C,$40 ; 86F3 6C 00 8C 40 6C 00 8C 40  l..@l..@
orientationForZ:
        .byte   $C6,$00,$4C,$80,$C6,$00,$4C,$80 ; 86FB C6 00 4C 80 C6 00 4C 80  ..L...L.
"""

numbers = [int(i, 16) for i in re.findall(r"\$(\w\w)", orientationTable)]


for i in range(0, 64, 2):
    if not i % 8:
        print(f"Piece: {pieces.pop()}")
    print(f"{numbers[i+0] >> 4:04b}")
    print(f"{numbers[i+0] & 15:04b}")
    print(f"{numbers[i+1] >> 4:04b}")
    print(f"{numbers[i+1] & 15:04b}")
    print("")
