.segment "HEADER"
.include "constants.asm"
.include "header.asm"
.scope main 
.segment "PRG0" 
.include "main.asm" 
.endscope 

.segment "CHR" 
.incbin "gfx/game_tileset.chr"
.incbin "gfx/dancing_guy_tileset.chr"
.incbin "gfx/title_tileset.chr"
.incbin "gfx/various_tileset.chr"
