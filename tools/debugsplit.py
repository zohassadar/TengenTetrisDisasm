"""
Split apart trace output from mesen into 1 file per frame
"""

import re
import pathlib

blob = open('tetris.txt').read()

output_dir = pathlib.Path.cwd() / pathlib.Path('debug')

output_dir.mkdir(exist_ok=True)

for file in output_dir.glob("*.txt"):
    print(f"Deleting: {file}")
    file.unlink()

chunks = re.findall(r'(?:^8015|\A).*?(?=(?:^8015|\Z))', blob, flags=re.M|re.S)


for index, chunk in enumerate(chunks):
    output_file = output_dir / f"tetris{index:03d}.txt"
    print(output_file)
    with open(output_file, "w+") as file:
        file.write(chunk)
