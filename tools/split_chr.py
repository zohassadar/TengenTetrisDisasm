"""Split out CHR data into 4096 byte segments"""

# python tools/split_chr.py -i clean.nes -s 32784 -c 4

import argparse
import os
import sys


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Split out tilesets",
    )

    parser.add_argument(
        "-i",
        "--input",
        help="Input file",
    )

    parser.add_argument(
        "-s",
        "--start",
        type=int,
        required=True,
        help="Start offset of tilesets",
    )

    parser.add_argument(
        "-c",
        "--count",
        type=int,
        required=True,
        help="Number of tilesets",
    )

    args = parser.parse_args()

    if not os.path.isfile(args.input):
        sys.exit("Input file not found.")
    print(args)
    return args




if __name__ == "__main__":
    args = parse_arguments()
    rom = open(args.input, "rb").read()
    for i in range(args.count):
        offset = 0x1000 * i + args.start
        open(f'{args.input}_chr{i}.bin', 'wb').write(rom[offset: offset+0x1000])

