MMU =
  _bios: [
    0x31
    0xFE
    0xFF
    0xAF
    0x21
    0xFF
    0x9F
    0x32
    0xCB
    0x7C
    0x20
    0xFB
    0x21
    0x26
    0xFF
    0x0E
    0x11
    0x3E
    0x80
    0x32
    0xE2
    0x0C
    0x3E
    0xF3
    0xE2
    0x32
    0x3E
    0x77
    0x77
    0x3E
    0xFC
    0xE0
    0x47
    0x11
    0x04
    0x01
    0x21
    0x10
    0x80
    0x1A
    0xCD
    0x95
    0x00
    0xCD
    0x96
    0x00
    0x13
    0x7B
    0xFE
    0x34
    0x20
    0xF3
    0x11
    0xD8
    0x00
    0x06
    0x08
    0x1A
    0x13
    0x22
    0x23
    0x05
    0x20
    0xF9
    0x3E
    0x19
    0xEA
    0x10
    0x99
    0x21
    0x2F
    0x99
    0x0E
    0x0C
    0x3D
    0x28
    0x08
    0x32
    0x0D
    0x20
    0xF9
    0x2E
    0x0F
    0x18
    0xF3
    0x67
    0x3E
    0x64
    0x57
    0xE0
    0x42
    0x3E
    0x91
    0xE0
    0x40
    0x04
    0x1E
    0x02
    0x0E
    0x0C
    0xF0
    0x44
    0xFE
    0x90
    0x20
    0xFA
    0x0D
    0x20
    0xF7
    0x1D
    0x20
    0xF2
    0x0E
    0x13
    0x24
    0x7C
    0x1E
    0x83
    0xFE
    0x62
    0x28
    0x06
    0x1E
    0xC1
    0xFE
    0x64
    0x20
    0x06
    0x7B
    0xE2
    0x0C
    0x3E
    0x87
    0xF2
    0xF0
    0x42
    0x90
    0xE0
    0x42
    0x15
    0x20
    0xD2
    0x05
    0x20
    0x4F
    0x16
    0x20
    0x18
    0xCB
    0x4F
    0x06
    0x04
    0xC5
    0xCB
    0x11
    0x17
    0xC1
    0xCB
    0x11
    0x17
    0x05
    0x20
    0xF5
    0x22
    0x23
    0x22
    0x23
    0xC9
    0xCE
    0xED
    0x66
    0x66
    0xCC
    0x0D
    0x00
    0x0B
    0x03
    0x73
    0x00
    0x83
    0x00
    0x0C
    0x00
    0x0D
    0x00
    0x08
    0x11
    0x1F
    0x88
    0x89
    0x00
    0x0E
    0xDC
    0xCC
    0x6E
    0xE6
    0xDD
    0xDD
    0xD9
    0x99
    0xBB
    0xBB
    0x67
    0x63
    0x6E
    0x0E
    0xEC
    0xCC
    0xDD
    0xDC
    0x99
    0x9F
    0xBB
    0xB9
    0x33
    0x3E
    0x3c
    0x42
    0xB9
    0xA5
    0xB9
    0xA5
    0x42
    0x4C
    0x21
    0x04
    0x01
    0x11
    0xA8
    0x00
    0x1A
    0x13
    0xBE
    0x20
    0xFE
    0x23
    0x7D
    0xFE
    0x34
    0x20
    0xF5
    0x06
    0x19
    0x78
    0x86
    0x23
    0x05
    0x20
    0xFB
    0x86
    0x20
    0xFE
    0x3E
    0x01
    0xE0
    0x50
  ]
  _rom: ""
  _carttype: 0
  _mbc:
    rombank: 0
    rambank: 0
    ramon: 0
    mode: 0

  _romoffs: 0x4000
  _ramoffs: 0
  _eram: []
  _wram: []
  _zram: []
  _inbios: 1
  _ie: 0
  _if: 0
  reset: ->
    i = 0
    while i < 8192
      MMU._wram[i] = 0
      i++
    i = 0
    while i < 32768
      MMU._eram[i] = 0
      i++
    i = 0
    while i < 127
      MMU._zram[i] = 0
      i++
    MMU._inbios = 1
    MMU._ie = 0
    MMU._if = 0
    MMU._carttype = 0
    MMU._mbc =
      rombank: 0
      rambank: 0
      ramon: 0
      mode: 0

    MMU._romoffs = 0x4000
    MMU._ramoffs = 0

  load: (file) ->
    MMU._carttype = MMU._rom[0x0147]

  rb: (addr) ->
    switch addr & 0xF000
      
      # ROM bank 0
      when 0x0000
        if MMU._inbios
          if addr < 0x0100
            MMU._bios[addr]
          else if Z80._r.pc is 0x0100
            MMU._inbios = 0
          else
            MMU._rom[addr]
      when 0x1000, 0x2000, 0x3000
        MMU._rom[addr]
      
      # ROM bank 1
      when 0x4000, 0x5000, 0x6000, 0x7000
        MMU._rom[MMU._romoffs + (addr & 0x3FFF)]
      
      # VRAM
      when 0x8000, 0x9000
        GPU._vram[addr & 0x1FFF]
      
      # External RAM
      when 0xA000, 0xB000
        MMU._eram[MMU._ramoffs + (addr & 0x1FFF)]
      
      # Work RAM and echo
      when 0xC000, 0xD000, 0xE000
        MMU._wram[addr & 0x1FFF]
      
      # Everything else
      when 0xF000
        switch addr & 0x0F00
          
          # Echo RAM
          when 0x000, 0x100, 0x200, 0x300, 0x400, 0x500, 0x600, 0x700, 0x800, 0x900, 0xA00, 0xB00, 0xC00, 0xD00
            MMU._wram[addr & 0x1FFF]
          
          # OAM
          when 0xE00
            (if ((addr & 0xFF) < 0xA0) then GPU._oam[addr & 0xFF] else 0)
          
          # Zeropage RAM, I/O, interrupts
          when 0xF00
            if addr is 0xFFFF
              MMU._ie
            else if addr > 0xFF7F
              MMU._zram[addr & 0x7F]
            else
              switch addr & 0xF0
                when 0x00
                  switch addr & 0xF
                    
                    # JOYP
                    when 0
                      KEY.rb()
                    when 4, 5, 6, 7
                      TIMER.rb addr
                    
                    # Interrupt flags
                    when 15
                      MMU._if
                    else
                      0
                when 0x10, 0x20, 0x30
                  0
                when 0x40, 0x50, 0x60, 0x70
                  GPU.rb addr

  rw: (addr) ->
    MMU.rb(addr) + (MMU.rb(addr + 1) << 8)

  wb: (addr, val) ->
    switch addr & 0xF000
      
      # ROM bank 0
      # MBC1: Turn external RAM on
      when 0x0000, 0x1000
        switch MMU._carttype
          when 1
            MMU._mbc.ramon = (if ((val & 0xF) is 0xA) then 1 else 0)
      
      # MBC1: ROM bank switch
      when 0x2000, 0x3000
        switch MMU._carttype
          when 1
            MMU._mbc.rombank &= 0x60
            val &= 0x1F
            val = 1  unless val
            MMU._mbc.rombank |= val
            MMU._romoffs = MMU._mbc.rombank * 0x4000
      
      # ROM bank 1
      # MBC1: RAM bank switch
      when 0x4000, 0x5000
        switch MMU._carttype
          when 1
            if MMU._mbc.mode
              MMU._mbc.rambank = (val & 3)
              MMU._ramoffs = MMU._mbc.rambank * 0x2000
            else
              MMU._mbc.rombank &= 0x1F
              MMU._mbc.rombank |= ((val & 3) << 5)
              MMU._romoffs = MMU._mbc.rombank * 0x4000
      when 0x6000, 0x7000
        switch MMU._carttype
          when 1
            MMU._mbc.mode = val & 1
      
      # VRAM
      when 0x8000, 0x9000
        GPU._vram[addr & 0x1FFF] = val
        GPU.updatetile addr & 0x1FFF, val
      
      # External RAM
      when 0xA000, 0xB000
        MMU._eram[MMU._ramoffs + (addr & 0x1FFF)] = val
      
      # Work RAM and echo
      when 0xC000, 0xD000, 0xE000
        MMU._wram[addr & 0x1FFF] = val
      
      # Everything else
      when 0xF000
        switch addr & 0x0F00
          
          # Echo RAM
          when 0x000, 0x100, 0x200, 0x300, 0x400, 0x500, 0x600, 0x700, 0x800, 0x900, 0xA00, 0xB00, 0xC00, 0xD00
            MMU._wram[addr & 0x1FFF] = val
          
          # OAM
          when 0xE00
            GPU._oam[addr & 0xFF] = val  if (addr & 0xFF) < 0xA0
            GPU.updateoam addr, val
          
          # Zeropage RAM, I/O, interrupts
          when 0xF00
            if addr is 0xFFFF
              MMU._ie = val
            else if addr > 0xFF7F
              MMU._zram[addr & 0x7F] = val
            else
              switch addr & 0xF0
                when 0x00
                  switch addr & 0xF
                    when 0
                      KEY.wb val
                    when 4, 5, 6, 7
                      TIMER.wb addr, val
                    when 15
                      MMU._if = val
                when 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70
                  GPU.wb addr, val

  ww: (addr, val) ->
    MMU.wb addr, val & 255
    MMU.wb addr + 1, val >> 8
