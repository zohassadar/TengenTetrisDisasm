.segment "HEADER"
.include "constants.asm"
.include "header.asm"
.scope bank0 
.segment "PRG0" 
.include "bank0.asm" 
.endscope 

.segment "CHR" 
.incbin "gfx/game_tileset.chr"
.incbin "gfx/dancing_guy_tileset.chr"
.incbin "gfx/title_tileset.chr"
.incbin "gfx/various_tileset.chr"
