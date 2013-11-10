class KEY_CLASS
  constructor: ->

  keys: [
    0xF
    0xF
  ]

  colidx: 0
  
  LEFT:   37
  UP:     38
  RIGHT:  39
  DOWN:   40
  A:      90
  B:      88
  START:  13
  SELECT: 32

  reset: ->
    @keys = [
      0xF
      0xF
    ]
    @colidx = 0

  rb: ->
    switch @colidx
      when 0x10 then @keys[0]
      when 0x20 then @keys[1]
      else 0x00

  wb: (v) ->
    @colidx = v & 0x30

  keydown: (e) =>
    switch e.keyCode
      when @RIGHT  then @keys[1] &= 0xE
      when @LEFT   then @keys[1] &= 0xD
      when @UP     then @keys[1] &= 0xB
      when @DOWN   then @keys[1] &= 0x7
      when @A      then @keys[0] &= 0xE
      when @B      then @keys[0] &= 0xD
      when @SELECT then @keys[0] &= 0xB
      when @START  then @keys[0] &= 0x7

  keyup: (e) =>
    switch e.keyCode
      when @RIGHT  then @keys[1] |= 0x1
      when @LEFT   then @keys[1] |= 0x2
      when @UP     then @keys[1] |= 0x4
      when @DOWN   then @keys[1] |= 0x8
      when @A      then @keys[0] |= 0x1
      when @B      then @keys[0] |= 0x2
      when @SELECT then @keys[0] |= 0x4
      when @START  then @keys[0] |= 0x8
