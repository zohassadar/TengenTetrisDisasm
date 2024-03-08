"""
visualize orientationTable

todo:  use output to recreate orientationTable and orientationTiles
"""
import re

pieces = list(reversed("ITOJLSZ"))

# tiles = " ╒═╕╖║╜╩╠╦╣╔╝╚╗" alternate
tiles = " c═ↄn║u╩╠╦╣╔╝╚╗"  # maybe a set of chars exist with better endcaps?

# null orientation skipped (8 bytes of 0)
orientationTable = """
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


orientationTiles = """
tilesForI:
        .byte   $01,$02,$02,$03,$04,$05,$05,$06 ; 8703 01 02 02 03 04 05 05 06  ........
        .byte   $01,$02,$02,$03,$04,$05,$05,$06 ; 870B 01 02 02 03 04 05 05 06  ........
tilesForT:
        .byte   $01,$09,$03,$06,$04,$08,$03,$06 ; 8713 01 09 03 06 04 08 03 06  ........
        .byte   $04,$01,$07,$03,$04,$01,$0A,$06 ; 871B 04 01 07 03 04 01 0A 06  ........
tilesForO:
        .byte   $0B,$0E,$0D,$0C,$0B,$0E,$0D,$0C ; 8723 0B 0E 0D 0C 0B 0E 0D 0C  ........
        .byte   $0B,$0E,$0D,$0C,$0B,$0E,$0D,$0C ; 872B 0B 0E 0D 0C 0B 0E 0D 0C  ........
tilesForJ:
        .byte   $01,$02,$0E,$06,$0B,$03,$05,$06 ; 8733 01 02 0E 06 0B 03 05 06  ........
        .byte   $04,$0D,$02,$03,$04,$05,$01,$0C ; 873B 04 0D 02 03 04 05 01 0C  ........
tilesForL:
        .byte   $0B,$02,$03,$06,$04,$05,$0D,$03 ; 8743 0B 02 03 06 04 05 0D 03  ........
        .byte   $04,$01,$02,$0C,$01,$0E,$05,$06 ; 874B 04 01 02 0C 01 0E 05 06  ........
tilesForS:
        .byte   $0B,$03,$01,$0C,$04,$0D,$0E,$06 ; 8753 0B 03 01 0C 04 0D 0E 06  ........
        .byte   $0B,$03,$01,$0C,$04,$0D,$0E,$06 ; 875B 0B 03 01 0C 04 0D 0E 06  ........
tilesForZ:
        .byte   $01,$0E,$0D,$03,$04,$0B,$0C,$06 ; 8763 01 0E 0D 03 04 0B 0C 06  ........
        .byte   $01,$0E,$0D,$03,$04,$0B,$0C,$06 ; 876B 01 0E 0D 03 04 0B 0C 06  ........
"""


def numbers_from_code(code):
    return [int(i, 16) for i in re.findall(r"\$(\w\w)", code)]


numbers = numbers_from_code(orientationTable)
tile_indexes = numbers_from_code(orientationTiles)
tile_indexes.reverse()


def tile_replace(matchobj):
    if matchobj.group() == "0":
        return "."
    return tiles[tile_indexes.pop()]


def main():
    for i in range(0, len(numbers), 2):
        if not i % 8:
            print(f"# Piece: {pieces.pop()}")
        bintext = (
            f"{numbers[i+0] >> 4:04b}\n"
            f"{numbers[i+0] & 15:04b}\n"
            f"{numbers[i+1] >> 4:04b}\n"
            f"{numbers[i+1] & 15:04b}\n"
        )
        converted = re.sub(r"[01]", tile_replace, bintext)
        print(converted)


if __name__ == "__main__":
    main()
