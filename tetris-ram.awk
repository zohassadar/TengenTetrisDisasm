# MIT License
#
# Copyright (c) 2019 Eric Anderson
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.



BEGIN {
	FS=" *([;{}]+|#.*)+ *"
	OFS="\t"
	NEXT=0
	print ".zeropage"
}

! (/^LABEL/ && $2 ~ /^ADDR / && $3 ~ /^NAME /) { next }

NF > 4 { NF=4 }

{
	SIZE=1
	sizenum=SIZE
}

$4 ~ /^SIZE / {
	split($4, a, " ");
	SIZE=a[2]
	sizenum=SIZE
	sub(/\$/, "0x", sizenum)
	sizenum=strtonum(sizenum)
}

{
	split($2, a, " ")
	addrnum=a[2]
	sub(/\$/, "0x", addrnum)
	addrnum=strtonum(addrnum)

	if (addrnum >= 0x800) exit
	if (addrnum > NEXT) print ".res " (addrnum-NEXT)
	if (addrnum < NEXT) {
		print $3 " out of order" > "/dev/stderr"
		next
	}
	NEXT=addrnum+sizenum
	split($3, b, "[ \"]+")
	print b[2] ":", ".res " SIZE, "; " a[2]
	if (addrnum < 0x100 && NEXT >= 0x100) print "\n.bss";
}
