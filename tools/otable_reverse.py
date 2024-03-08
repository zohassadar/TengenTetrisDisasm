import sys
import re
from otable import tiles

tiles_by_index = {tile: index for index, tile in enumerate(tiles)}

collected = []
for line in sys.stdin.readlines():
    if line.strip().startswith("#"):
        continue
    collected.extend(re.findall(r'\S', line))

output_orientations = []
output_tiles = []
for i in range(0,len(collected),8):
    output = 0
    for j in range(8):
        tile = collected[j+i] != "."
        if tile:
            output_tiles.append(tiles_by_index[collected[j+i]])
        output <<= 1
        output |= tile
    output_orientations.append(output)

for i in range(0, len(output_orientations), 8):
    print("        .byte   " + ",".join(f"${f'{ob:02x}'.upper()}" for ob in output_orientations[i:i+8]))

for i in range(0, len(output_tiles), 8):
    print("        .byte   " + ",".join(f"${f'{ob:02x}'.upper()}" for ob in output_tiles[i:i+8]))
