GPU =
  _vram: []
  _oam: []
  _reg: []
  _tilemap: []
  _objdata: []
  _objdatasorted: []
  _palette:
    bg: []
    obj0: []
    obj1: []

  _scanrow: []
  _curline: 0
  _curscan: 0
  _linemode: 0
  _modeclocks: 0
  _yscrl: 0
  _xscrl: 0
  _raster: 0
  _ints: 0
  _lcdon: 0
  _bgon: 0
  _objon: 0
  _winon: 0
  _objsize: 0
  _bgtilebase: 0x0000
  _bgmapbase: 0x1800
  _wintilebase: 0x1800
  reset: ->
    i = 0

    while i < 8192
      GPU._vram[i] = 0
      i++
    i = 0
    while i < 160
      GPU._oam[i] = 0
      i++
    i = 0
    while i < 4
      GPU._palette.bg[i] = 255
      GPU._palette.obj0[i] = 255
      GPU._palette.obj1[i] = 255
      i++
    i = 0
    while i < 512
      GPU._tilemap[i] = []
      j = 0
      while j < 8
        GPU._tilemap[i][j] = []
        k = 0
        while k < 8
          GPU._tilemap[i][j][k] = 0
          k++
        j++
      i++
    c = document.getElementById("screen")
    if c and c.getContext
      GPU._canvas = c.getContext("2d")
      unless GPU._canvas
        throw new Error("GPU: Canvas context could not be created.")
      else
        if GPU._canvas.createImageData
          GPU._scrn = GPU._canvas.createImageData(160, 144)
        else if GPU._canvas.getImageData
          GPU._scrn = GPU._canvas.getImageData(0, 0, 160, 144)
        else
          GPU._scrn =
            width: 160
            height: 144
            data: new Array(160 * 144 * 4)
        i = 0
        while i < GPU._scrn.data.length
          GPU._scrn.data[i] = 255
          i++
        GPU._canvas.putImageData GPU._scrn, 0, 0
    GPU._curline = 0
    GPU._curscan = 0
    GPU._linemode = 2
    GPU._modeclocks = 0
    GPU._yscrl = 0
    GPU._xscrl = 0
    GPU._raster = 0
    GPU._ints = 0
    GPU._lcdon = 0
    GPU._bgon = 0
    GPU._objon = 0
    GPU._winon = 0
    GPU._objsize = 0
    i = 0
    while i < 160
      GPU._scanrow[i] = 0
      i++
    i = 0
    while i < 40
      GPU._objdata[i] =
        y: -16
        x: -8
        tile: 0
        palette: 0
        yflip: 0
        xflip: 0
        prio: 0
        num: i
      i++
    
    # Set to values expected by BIOS, to start
    GPU._bgtilebase = 0x0000
    GPU._bgmapbase = 0x1800
    GPU._wintilebase = 0x1800

  checkline: ->
    GPU._modeclocks += Z80._r.m
    switch GPU._linemode
      
      # In hblank
      when 0
        if GPU._modeclocks >= 51
          
          # End of hblank for last scanline; render screen
          if GPU._curline is 143
            GPU._linemode = 1
            GPU._canvas.putImageData GPU._scrn, 0, 0
            MMU._if |= 1
          else
            GPU._linemode = 2
          GPU._curline++
          GPU._curscan += 640
          GPU._modeclocks = 0
      
      # In vblank
      when 1
        if GPU._modeclocks >= 114
          GPU._modeclocks = 0
          GPU._curline++
          if GPU._curline > 153
            GPU._curline = 0
            GPU._curscan = 0
            GPU._linemode = 2
      
      # In OAM-read mode
      when 2
        if GPU._modeclocks >= 20
          GPU._modeclocks = 0
          GPU._linemode = 3
      
      # In VRAM-read mode
      when 3
        
        # Render scanline at end of allotted time
        if GPU._modeclocks >= 43
          GPU._modeclocks = 0
          GPU._linemode = 0
          if GPU._lcdon
            if GPU._bgon
              linebase = GPU._curscan
              mapbase = GPU._bgmapbase + ((((GPU._curline + GPU._yscrl) & 255) >> 3) << 5)
              y = (GPU._curline + GPU._yscrl) & 7
              x = GPU._xscrl & 7
              t = (GPU._xscrl >> 3) & 31
              pixel = undefined
              w = 160
              if GPU._bgtilebase
                tile = GPU._vram[mapbase + t]
                tile = 256 + tile  if tile < 128
                tilerow = GPU._tilemap[tile][y]
                loop
                  GPU._scanrow[160 - x] = tilerow[x]
                  GPU._scrn.data[linebase + 3] = GPU._palette.bg[tilerow[x]]
                  x++
                  if x is 8
                    t = (t + 1) & 31
                    x = 0
                    tile = GPU._vram[mapbase + t]
                    tile = 256 + tile  if tile < 128
                    tilerow = GPU._tilemap[tile][y]
                  linebase += 4
                  break unless --w
              else
                tilerow = GPU._tilemap[GPU._vram[mapbase + t]][y]
                loop
                  GPU._scanrow[160 - x] = tilerow[x]
                  GPU._scrn.data[linebase + 3] = GPU._palette.bg[tilerow[x]]
                  x++
                  if x is 8
                    t = (t + 1) & 31
                    x = 0
                    tilerow = GPU._tilemap[GPU._vram[mapbase + t]][y]
                  linebase += 4
                  break unless --w
            if GPU._objon
              cnt = 0
              if GPU._objsize
                i = 0

                while i < 40
                  i++
              else
                tilerow = undefined
                obj = undefined
                pal = undefined
                pixel = undefined
                x = undefined
                linebase = GPU._curscan
                i = 0

                while i < 40
                  obj = GPU._objdatasorted[i]
                  if obj.y <= GPU._curline and (obj.y + 8) > GPU._curline
                    if obj.yflip
                      tilerow = GPU._tilemap[obj.tile][7 - (GPU._curline - obj.y)]
                    else
                      tilerow = GPU._tilemap[obj.tile][GPU._curline - obj.y]
                    if obj.palette
                      pal = GPU._palette.obj1
                    else
                      pal = GPU._palette.obj0
                    linebase = (GPU._curline * 160 + obj.x) * 4
                    if obj.xflip
                      x = 0
                      while x < 8
                        GPU._scrn.data[linebase + 3] = pal[tilerow[7 - x]]  if tilerow[7 - x] and (obj.prio or not GPU._scanrow[x])  if obj.x + x >= 0 and obj.x + x < 160
                        linebase += 4
                        x++
                    else
                      x = 0
                      while x < 8
                        GPU._scrn.data[linebase + 3] = pal[tilerow[x]]  if tilerow[x] and (obj.prio or not GPU._scanrow[x])  if obj.x + x >= 0 and obj.x + x < 160
                        linebase += 4
                        x++
                    cnt++
                    break  if cnt > 10
                  i++

  updatetile: (addr, val) ->
    saddr = addr
    if addr & 1
      saddr--
      addr--
    tile = (addr >> 4) & 511
    y = (addr >> 1) & 7
    sx = undefined
    x = 0

    while x < 8
      sx = 1 << (7 - x)
      GPU._tilemap[tile][y][x] = ((if (GPU._vram[saddr] & sx) then 1 else 0)) | ((if (GPU._vram[saddr + 1] & sx) then 2 else 0))
      x++

  updateoam: (addr, val) ->
    addr -= 0xFE00
    obj = addr >> 2
    if obj < 40
      switch addr & 3
        when 0
          GPU._objdata[obj].y = val - 16
        when 1
          GPU._objdata[obj].x = val - 8
        when 2
          if GPU._objsize
            GPU._objdata[obj].tile = (val & 0xFE)
          else
            GPU._objdata[obj].tile = val
        when 3
          GPU._objdata[obj].palette = (if (val & 0x10) then 1 else 0)
          GPU._objdata[obj].xflip = (if (val & 0x20) then 1 else 0)
          GPU._objdata[obj].yflip = (if (val & 0x40) then 1 else 0)
          GPU._objdata[obj].prio = (if (val & 0x80) then 1 else 0)
    GPU._objdatasorted = GPU._objdata
    GPU._objdatasorted.sort (a, b) ->
      return -1  if a.x > b.x
      -1  if a.num > b.num


  rb: (addr) ->
    gaddr = addr - 0xFF40
    switch gaddr
      when 0
        ((if GPU._lcdon then 0x80 else 0)) | ((if (GPU._bgtilebase is 0x0000) then 0x10 else 0)) | ((if (GPU._bgmapbase is 0x1C00) then 0x08 else 0)) | ((if GPU._objsize then 0x04 else 0)) | ((if GPU._objon then 0x02 else 0)) | ((if GPU._bgon then 0x01 else 0))
      when 1
        ((if GPU._curline is GPU._raster then 4 else 0)) | GPU._linemode
      when 2
        GPU._yscrl
      when 3
        GPU._xscrl
      when 4
        GPU._curline
      when 5
        GPU._raster
      else
        GPU._reg[gaddr]

  wb: (addr, val) ->
    gaddr = addr - 0xFF40
    GPU._reg[gaddr] = val
    switch gaddr
      when 0
        GPU._lcdon = (if (val & 0x80) then 1 else 0)
        GPU._bgtilebase = (if (val & 0x10) then 0x0000 else 0x0800)
        GPU._bgmapbase = (if (val & 0x08) then 0x1C00 else 0x1800)
        GPU._objsize = (if (val & 0x04) then 1 else 0)
        GPU._objon = (if (val & 0x02) then 1 else 0)
        GPU._bgon = (if (val & 0x01) then 1 else 0)
      when 2
        GPU._yscrl = val
      when 3
        GPU._xscrl = val
      when 5
        GPU._raster = val
      
      # OAM DMA
      when 6
        v = undefined
        i = 0

        while i < 160
          v = MMU.rb((val << 8) + i)
          GPU._oam[i] = v
          GPU.updateoam 0xFE00 + i, v
          i++
      
      # BG palette mapping
      when 7
        i = 0

        while i < 4
          switch (val >> (i * 2)) & 3
            when 0
              GPU._palette.bg[i] = 255
            when 1
              GPU._palette.bg[i] = 192
            when 2
              GPU._palette.bg[i] = 96
            when 3
              GPU._palette.bg[i] = 0
          i++
      
      # OBJ0 palette mapping
      when 8
        i = 0

        while i < 4
          switch (val >> (i * 2)) & 3
            when 0
              GPU._palette.obj0[i] = 255
            when 1
              GPU._palette.obj0[i] = 192
            when 2
              GPU._palette.obj0[i] = 96
            when 3
              GPU._palette.obj0[i] = 0
          i++
      
      # OBJ1 palette mapping
      when 9
        i = 0

        while i < 4
          switch (val >> (i * 2)) & 3
            when 0
              GPU._palette.obj1[i] = 255
            when 1
              GPU._palette.obj1[i] = 192
            when 2
              GPU._palette.obj1[i] = 96
            when 3
              GPU._palette.obj1[i] = 0
          i++
