###
jsGB: Z80 core
Imran Nazar, May 2009
Notes: This is a GameBoy Z80, not a Z80. There are differences.
Bugs: If PC wraps at the top of memory, this will not be caught until the end of an instruction
###
Z80 =
  _r:
    a: 0
    b: 0
    c: 0
    d: 0
    e: 0
    h: 0
    l: 0
    f: 0
    sp: 0
    pc: 0
    i: 0
    r: 0
    m: 0
    ime: 0

  _rsv:
    a: 0
    b: 0
    c: 0
    d: 0
    e: 0
    h: 0
    l: 0
    f: 0

  _clock:
    m: 0

  _halt: 0
  _stop: 0

  reset: ->
    Z80._r.a = 0
    Z80._r.b = 0
    Z80._r.c = 0
    Z80._r.d = 0
    Z80._r.e = 0
    Z80._r.h = 0
    Z80._r.l = 0
    Z80._r.f = 0
    Z80._r.sp = 0
    Z80._r.pc = 0
    Z80._r.i = 0
    Z80._r.r = 0
    Z80._r.m = 0
    Z80._halt = 0
    Z80._stop = 0
    Z80._clock.m = 0
    Z80._r.ime = 1

  exec: ->
    Z80._r.r = (Z80._r.r + 1) & 127
    Z80._map[MMU.rb(Z80._r.pc++)]()
    Z80._r.pc &= 65535
    Z80._clock.m += Z80._r.m

  _ops:
    
    #--- Load/store ---
    LDrr_bb: ->
      Z80._r.b = Z80._r.b
      Z80._r.m = 1

    LDrr_bc: ->
      Z80._r.b = Z80._r.c
      Z80._r.m = 1

    LDrr_bd: ->
      Z80._r.b = Z80._r.d
      Z80._r.m = 1

    LDrr_be: ->
      Z80._r.b = Z80._r.e
      Z80._r.m = 1

    LDrr_bh: ->
      Z80._r.b = Z80._r.h
      Z80._r.m = 1

    LDrr_bl: ->
      Z80._r.b = Z80._r.l
      Z80._r.m = 1

    LDrr_ba: ->
      Z80._r.b = Z80._r.a
      Z80._r.m = 1

    LDrr_cb: ->
      Z80._r.c = Z80._r.b
      Z80._r.m = 1

    LDrr_cc: ->
      Z80._r.c = Z80._r.c
      Z80._r.m = 1

    LDrr_cd: ->
      Z80._r.c = Z80._r.d
      Z80._r.m = 1

    LDrr_ce: ->
      Z80._r.c = Z80._r.e
      Z80._r.m = 1

    LDrr_ch: ->
      Z80._r.c = Z80._r.h
      Z80._r.m = 1

    LDrr_cl: ->
      Z80._r.c = Z80._r.l
      Z80._r.m = 1

    LDrr_ca: ->
      Z80._r.c = Z80._r.a
      Z80._r.m = 1

    LDrr_db: ->
      Z80._r.d = Z80._r.b
      Z80._r.m = 1

    LDrr_dc: ->
      Z80._r.d = Z80._r.c
      Z80._r.m = 1

    LDrr_dd: ->
      Z80._r.d = Z80._r.d
      Z80._r.m = 1

    LDrr_de: ->
      Z80._r.d = Z80._r.e
      Z80._r.m = 1

    LDrr_dh: ->
      Z80._r.d = Z80._r.h
      Z80._r.m = 1

    LDrr_dl: ->
      Z80._r.d = Z80._r.l
      Z80._r.m = 1

    LDrr_da: ->
      Z80._r.d = Z80._r.a
      Z80._r.m = 1

    LDrr_eb: ->
      Z80._r.e = Z80._r.b
      Z80._r.m = 1

    LDrr_ec: ->
      Z80._r.e = Z80._r.c
      Z80._r.m = 1

    LDrr_ed: ->
      Z80._r.e = Z80._r.d
      Z80._r.m = 1

    LDrr_ee: ->
      Z80._r.e = Z80._r.e
      Z80._r.m = 1

    LDrr_eh: ->
      Z80._r.e = Z80._r.h
      Z80._r.m = 1

    LDrr_el: ->
      Z80._r.e = Z80._r.l
      Z80._r.m = 1

    LDrr_ea: ->
      Z80._r.e = Z80._r.a
      Z80._r.m = 1

    LDrr_hb: ->
      Z80._r.h = Z80._r.b
      Z80._r.m = 1

    LDrr_hc: ->
      Z80._r.h = Z80._r.c
      Z80._r.m = 1

    LDrr_hd: ->
      Z80._r.h = Z80._r.d
      Z80._r.m = 1

    LDrr_he: ->
      Z80._r.h = Z80._r.e
      Z80._r.m = 1

    LDrr_hh: ->
      Z80._r.h = Z80._r.h
      Z80._r.m = 1

    LDrr_hl: ->
      Z80._r.h = Z80._r.l
      Z80._r.m = 1

    LDrr_ha: ->
      Z80._r.h = Z80._r.a
      Z80._r.m = 1

    LDrr_lb: ->
      Z80._r.l = Z80._r.b
      Z80._r.m = 1

    LDrr_lc: ->
      Z80._r.l = Z80._r.c
      Z80._r.m = 1

    LDrr_ld: ->
      Z80._r.l = Z80._r.d
      Z80._r.m = 1

    LDrr_le: ->
      Z80._r.l = Z80._r.e
      Z80._r.m = 1

    LDrr_lh: ->
      Z80._r.l = Z80._r.h
      Z80._r.m = 1

    LDrr_ll: ->
      Z80._r.l = Z80._r.l
      Z80._r.m = 1

    LDrr_la: ->
      Z80._r.l = Z80._r.a
      Z80._r.m = 1

    LDrr_ab: ->
      Z80._r.a = Z80._r.b
      Z80._r.m = 1

    LDrr_ac: ->
      Z80._r.a = Z80._r.c
      Z80._r.m = 1

    LDrr_ad: ->
      Z80._r.a = Z80._r.d
      Z80._r.m = 1

    LDrr_ae: ->
      Z80._r.a = Z80._r.e
      Z80._r.m = 1

    LDrr_ah: ->
      Z80._r.a = Z80._r.h
      Z80._r.m = 1

    LDrr_al: ->
      Z80._r.a = Z80._r.l
      Z80._r.m = 1

    LDrr_aa: ->
      Z80._r.a = Z80._r.a
      Z80._r.m = 1

    LDrHLm_b: ->
      Z80._r.b = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_c: ->
      Z80._r.c = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_d: ->
      Z80._r.d = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_e: ->
      Z80._r.e = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_h: ->
      Z80._r.h = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_l: ->
      Z80._r.l = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDrHLm_a: ->
      Z80._r.a = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.m = 2

    LDHLmr_b: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.b
      Z80._r.m = 2

    LDHLmr_c: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.c
      Z80._r.m = 2

    LDHLmr_d: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.d
      Z80._r.m = 2

    LDHLmr_e: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.e
      Z80._r.m = 2

    LDHLmr_h: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.h
      Z80._r.m = 2

    LDHLmr_l: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.l
      Z80._r.m = 2

    LDHLmr_a: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.a
      Z80._r.m = 2

    LDrn_b: ->
      Z80._r.b = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_c: ->
      Z80._r.c = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_d: ->
      Z80._r.d = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_e: ->
      Z80._r.e = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_h: ->
      Z80._r.h = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_l: ->
      Z80._r.l = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDrn_a: ->
      Z80._r.a = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 2

    LDHLmn: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.m = 3

    LDBCmA: ->
      MMU.wb (Z80._r.b << 8) + Z80._r.c, Z80._r.a
      Z80._r.m = 2

    LDDEmA: ->
      MMU.wb (Z80._r.d << 8) + Z80._r.e, Z80._r.a
      Z80._r.m = 2

    LDmmA: ->
      MMU.wb MMU.rw(Z80._r.pc), Z80._r.a
      Z80._r.pc += 2
      Z80._r.m = 4

    LDABCm: ->
      Z80._r.a = MMU.rb((Z80._r.b << 8) + Z80._r.c)
      Z80._r.m = 2

    LDADEm: ->
      Z80._r.a = MMU.rb((Z80._r.d << 8) + Z80._r.e)
      Z80._r.m = 2

    LDAmm: ->
      Z80._r.a = MMU.rb(MMU.rw(Z80._r.pc))
      Z80._r.pc += 2
      Z80._r.m = 4

    LDBCnn: ->
      Z80._r.c = MMU.rb(Z80._r.pc)
      Z80._r.b = MMU.rb(Z80._r.pc + 1)
      Z80._r.pc += 2
      Z80._r.m = 3

    LDDEnn: ->
      Z80._r.e = MMU.rb(Z80._r.pc)
      Z80._r.d = MMU.rb(Z80._r.pc + 1)
      Z80._r.pc += 2
      Z80._r.m = 3

    LDHLnn: ->
      Z80._r.l = MMU.rb(Z80._r.pc)
      Z80._r.h = MMU.rb(Z80._r.pc + 1)
      Z80._r.pc += 2
      Z80._r.m = 3

    LDSPnn: ->
      Z80._r.sp = MMU.rw(Z80._r.pc)
      Z80._r.pc += 2
      Z80._r.m = 3

    LDHLmm: ->
      i = MMU.rw(Z80._r.pc)
      Z80._r.pc += 2
      Z80._r.l = MMU.rb(i)
      Z80._r.h = MMU.rb(i + 1)
      Z80._r.m = 5

    LDmmHL: ->
      i = MMU.rw(Z80._r.pc)
      Z80._r.pc += 2
      MMU.ww i, (Z80._r.h << 8) + Z80._r.l
      Z80._r.m = 5

    LDHLIA: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.a
      Z80._r.l = (Z80._r.l + 1) & 255
      Z80._r.h = (Z80._r.h + 1) & 255  unless Z80._r.l
      Z80._r.m = 2

    LDAHLI: ->
      Z80._r.a = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.l = (Z80._r.l + 1) & 255
      Z80._r.h = (Z80._r.h + 1) & 255  unless Z80._r.l
      Z80._r.m = 2

    LDHLDA: ->
      MMU.wb (Z80._r.h << 8) + Z80._r.l, Z80._r.a
      Z80._r.l = (Z80._r.l - 1) & 255
      Z80._r.h = (Z80._r.h - 1) & 255  if Z80._r.l is 255
      Z80._r.m = 2

    LDAHLD: ->
      Z80._r.a = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.l = (Z80._r.l - 1) & 255
      Z80._r.h = (Z80._r.h - 1) & 255  if Z80._r.l is 255
      Z80._r.m = 2

    LDAIOn: ->
      Z80._r.a = MMU.rb(0xFF00 + MMU.rb(Z80._r.pc))
      Z80._r.pc++
      Z80._r.m = 3

    LDIOnA: ->
      MMU.wb 0xFF00 + MMU.rb(Z80._r.pc), Z80._r.a
      Z80._r.pc++
      Z80._r.m = 3

    LDAIOC: ->
      Z80._r.a = MMU.rb(0xFF00 + Z80._r.c)
      Z80._r.m = 2

    LDIOCA: ->
      MMU.wb 0xFF00 + Z80._r.c, Z80._r.a
      Z80._r.m = 2

    LDHLSPn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      i += Z80._r.sp
      Z80._r.h = (i >> 8) & 255
      Z80._r.l = i & 255
      Z80._r.m = 3

    SWAPr_b: ->
      tr = Z80._r.b
      Z80._r.b = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.b then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_c: ->
      tr = Z80._r.c
      Z80._r.c = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.c then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_d: ->
      tr = Z80._r.d
      Z80._r.d = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.d then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_e: ->
      tr = Z80._r.e
      Z80._r.e = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.e then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_h: ->
      tr = Z80._r.h
      Z80._r.h = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.h then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_l: ->
      tr = Z80._r.l
      Z80._r.l = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.l then 0 else 0x80)
      Z80._r.m = 1

    SWAPr_a: ->
      tr = Z80._r.a
      Z80._r.a = ((tr & 0xF) << 4) | ((tr & 0xF0) >> 4)
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    
    #--- Data processing ---
    ADDr_b: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.b
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.b ^ a) & 0x10
      Z80._r.m = 1

    ADDr_c: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.c
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.c ^ a) & 0x10
      Z80._r.m = 1

    ADDr_d: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.d
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.d ^ a) & 0x10
      Z80._r.m = 1

    ADDr_e: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.e
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.e ^ a) & 0x10
      Z80._r.m = 1

    ADDr_h: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.h
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.h ^ a) & 0x10
      Z80._r.m = 1

    ADDr_l: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.l
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.l ^ a) & 0x10
      Z80._r.m = 1

    ADDr_a: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.a
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.a ^ a) & 0x10
      Z80._r.m = 1

    ADDHL: ->
      a = Z80._r.a
      m = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a += m
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ a ^ m) & 0x10
      Z80._r.m = 2

    ADDn: ->
      a = Z80._r.a
      m = MMU.rb(Z80._r.pc)
      Z80._r.a += m
      Z80._r.pc++
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ a ^ m) & 0x10
      Z80._r.m = 2

    ADDHLBC: ->
      hl = (Z80._r.h << 8) + Z80._r.l
      hl += (Z80._r.b << 8) + Z80._r.c
      if hl > 65535
        Z80._r.f |= 0x10
      else
        Z80._r.f &= 0xEF
      Z80._r.h = (hl >> 8) & 255
      Z80._r.l = hl & 255
      Z80._r.m = 3

    ADDHLDE: ->
      hl = (Z80._r.h << 8) + Z80._r.l
      hl += (Z80._r.d << 8) + Z80._r.e
      if hl > 65535
        Z80._r.f |= 0x10
      else
        Z80._r.f &= 0xEF
      Z80._r.h = (hl >> 8) & 255
      Z80._r.l = hl & 255
      Z80._r.m = 3

    ADDHLHL: ->
      hl = (Z80._r.h << 8) + Z80._r.l
      hl += (Z80._r.h << 8) + Z80._r.l
      if hl > 65535
        Z80._r.f |= 0x10
      else
        Z80._r.f &= 0xEF
      Z80._r.h = (hl >> 8) & 255
      Z80._r.l = hl & 255
      Z80._r.m = 3

    ADDHLSP: ->
      hl = (Z80._r.h << 8) + Z80._r.l
      hl += Z80._r.sp
      if hl > 65535
        Z80._r.f |= 0x10
      else
        Z80._r.f &= 0xEF
      Z80._r.h = (hl >> 8) & 255
      Z80._r.l = hl & 255
      Z80._r.m = 3

    ADDSPn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.sp += i
      Z80._r.m = 4

    ADCr_b: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.b
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.b ^ a) & 0x10
      Z80._r.m = 1

    ADCr_c: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.c
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.c ^ a) & 0x10
      Z80._r.m = 1

    ADCr_d: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.d
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.d ^ a) & 0x10
      Z80._r.m = 1

    ADCr_e: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.e
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.e ^ a) & 0x10
      Z80._r.m = 1

    ADCr_h: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.h
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.h ^ a) & 0x10
      Z80._r.m = 1

    ADCr_l: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.l
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.l ^ a) & 0x10
      Z80._r.m = 1

    ADCr_a: ->
      a = Z80._r.a
      Z80._r.a += Z80._r.a
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.a ^ a) & 0x10
      Z80._r.m = 1

    ADCHL: ->
      a = Z80._r.a
      m = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a += m
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    ADCn: ->
      a = Z80._r.a
      m = MMU.rb(Z80._r.pc)
      Z80._r.a += m
      Z80._r.pc++
      Z80._r.a += (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a > 255) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    SUBr_b: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.b
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.b ^ a) & 0x10
      Z80._r.m = 1

    SUBr_c: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.c
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.c ^ a) & 0x10
      Z80._r.m = 1

    SUBr_d: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.d
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.d ^ a) & 0x10
      Z80._r.m = 1

    SUBr_e: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.e
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.e ^ a) & 0x10
      Z80._r.m = 1

    SUBr_h: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.h
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.h ^ a) & 0x10
      Z80._r.m = 1

    SUBr_l: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.l
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.l ^ a) & 0x10
      Z80._r.m = 1

    SUBr_a: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.a
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.a ^ a) & 0x10
      Z80._r.m = 1

    SUBHL: ->
      a = Z80._r.a
      m = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a -= m
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    SUBn: ->
      a = Z80._r.a
      m = MMU.rb(Z80._r.pc)
      Z80._r.a -= m
      Z80._r.pc++
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    SBCr_b: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.b
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.b ^ a) & 0x10
      Z80._r.m = 1

    SBCr_c: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.c
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.c ^ a) & 0x10
      Z80._r.m = 1

    SBCr_d: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.d
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.d ^ a) & 0x10
      Z80._r.m = 1

    SBCr_e: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.e
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.e ^ a) & 0x10
      Z80._r.m = 1

    SBCr_h: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.h
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.h ^ a) & 0x10
      Z80._r.m = 1

    SBCr_l: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.l
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.l ^ a) & 0x10
      Z80._r.m = 1

    SBCr_a: ->
      a = Z80._r.a
      Z80._r.a -= Z80._r.a
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.a ^ a) & 0x10
      Z80._r.m = 1

    SBCHL: ->
      a = Z80._r.a
      m = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a -= m
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    SBCn: ->
      a = Z80._r.a
      m = MMU.rb(Z80._r.pc)
      Z80._r.a -= m
      Z80._r.pc++
      Z80._r.a -= (if (Z80._r.f & 0x10) then 1 else 0)
      Z80._r.f = (if (Z80._r.a < 0) then 0x50 else 0x40)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.f |= 0x20  if (Z80._r.a ^ m ^ a) & 0x10
      Z80._r.m = 2

    CPr_b: ->
      i = Z80._r.a
      i -= Z80._r.b
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.b ^ i) & 0x10
      Z80._r.m = 1

    CPr_c: ->
      i = Z80._r.a
      i -= Z80._r.c
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.c ^ i) & 0x10
      Z80._r.m = 1

    CPr_d: ->
      i = Z80._r.a
      i -= Z80._r.d
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.d ^ i) & 0x10
      Z80._r.m = 1

    CPr_e: ->
      i = Z80._r.a
      i -= Z80._r.e
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.e ^ i) & 0x10
      Z80._r.m = 1

    CPr_h: ->
      i = Z80._r.a
      i -= Z80._r.h
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.h ^ i) & 0x10
      Z80._r.m = 1

    CPr_l: ->
      i = Z80._r.a
      i -= Z80._r.l
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.l ^ i) & 0x10
      Z80._r.m = 1

    CPr_a: ->
      i = Z80._r.a
      i -= Z80._r.a
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ Z80._r.a ^ i) & 0x10
      Z80._r.m = 1

    CPHL: ->
      i = Z80._r.a
      m = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i -= m
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ i ^ m) & 0x10
      Z80._r.m = 2

    CPn: ->
      i = Z80._r.a
      m = MMU.rb(Z80._r.pc)
      i -= m
      Z80._r.pc++
      Z80._r.f = (if (i < 0) then 0x50 else 0x40)
      i &= 255
      Z80._r.f |= 0x80  unless i
      Z80._r.f |= 0x20  if (Z80._r.a ^ i ^ m) & 0x10
      Z80._r.m = 2

    DAA: ->
      a = Z80._r.a
      Z80._r.a += 6  if (Z80._r.f & 0x20) or ((Z80._r.a & 15) > 9)
      Z80._r.f &= 0xEF
      if (Z80._r.f & 0x20) or (a > 0x99)
        Z80._r.a += 0x60
        Z80._r.f |= 0x10
      Z80._r.m = 1

    ANDr_b: ->
      Z80._r.a &= Z80._r.b
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_c: ->
      Z80._r.a &= Z80._r.c
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_d: ->
      Z80._r.a &= Z80._r.d
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_e: ->
      Z80._r.a &= Z80._r.e
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_h: ->
      Z80._r.a &= Z80._r.h
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_l: ->
      Z80._r.a &= Z80._r.l
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDr_a: ->
      Z80._r.a &= Z80._r.a
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ANDHL: ->
      Z80._r.a &= MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    ANDn: ->
      Z80._r.a &= MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    ORr_b: ->
      Z80._r.a |= Z80._r.b
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_c: ->
      Z80._r.a |= Z80._r.c
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_d: ->
      Z80._r.a |= Z80._r.d
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_e: ->
      Z80._r.a |= Z80._r.e
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_h: ->
      Z80._r.a |= Z80._r.h
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_l: ->
      Z80._r.a |= Z80._r.l
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORr_a: ->
      Z80._r.a |= Z80._r.a
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    ORHL: ->
      Z80._r.a |= MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    ORn: ->
      Z80._r.a |= MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    XORr_b: ->
      Z80._r.a ^= Z80._r.b
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_c: ->
      Z80._r.a ^= Z80._r.c
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_d: ->
      Z80._r.a ^= Z80._r.d
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_e: ->
      Z80._r.a ^= Z80._r.e
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_h: ->
      Z80._r.a ^= Z80._r.h
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_l: ->
      Z80._r.a ^= Z80._r.l
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORr_a: ->
      Z80._r.a ^= Z80._r.a
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    XORHL: ->
      Z80._r.a ^= MMU.rb((Z80._r.h << 8) + Z80._r.l)
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    XORn: ->
      Z80._r.a ^= MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 2

    INCr_b: ->
      Z80._r.b++
      Z80._r.b &= 255
      Z80._r.f = (if Z80._r.b then 0 else 0x80)
      Z80._r.m = 1

    INCr_c: ->
      Z80._r.c++
      Z80._r.c &= 255
      Z80._r.f = (if Z80._r.c then 0 else 0x80)
      Z80._r.m = 1

    INCr_d: ->
      Z80._r.d++
      Z80._r.d &= 255
      Z80._r.f = (if Z80._r.d then 0 else 0x80)
      Z80._r.m = 1

    INCr_e: ->
      Z80._r.e++
      Z80._r.e &= 255
      Z80._r.f = (if Z80._r.e then 0 else 0x80)
      Z80._r.m = 1

    INCr_h: ->
      Z80._r.h++
      Z80._r.h &= 255
      Z80._r.f = (if Z80._r.h then 0 else 0x80)
      Z80._r.m = 1

    INCr_l: ->
      Z80._r.l++
      Z80._r.l &= 255
      Z80._r.f = (if Z80._r.l then 0 else 0x80)
      Z80._r.m = 1

    INCr_a: ->
      Z80._r.a++
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    INCHLm: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l) + 1
      i &= 255
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (if i then 0 else 0x80)
      Z80._r.m = 3

    DECr_b: ->
      Z80._r.b--
      Z80._r.b &= 255
      Z80._r.f = (if Z80._r.b then 0 else 0x80)
      Z80._r.m = 1

    DECr_c: ->
      Z80._r.c--
      Z80._r.c &= 255
      Z80._r.f = (if Z80._r.c then 0 else 0x80)
      Z80._r.m = 1

    DECr_d: ->
      Z80._r.d--
      Z80._r.d &= 255
      Z80._r.f = (if Z80._r.d then 0 else 0x80)
      Z80._r.m = 1

    DECr_e: ->
      Z80._r.e--
      Z80._r.e &= 255
      Z80._r.f = (if Z80._r.e then 0 else 0x80)
      Z80._r.m = 1

    DECr_h: ->
      Z80._r.h--
      Z80._r.h &= 255
      Z80._r.f = (if Z80._r.h then 0 else 0x80)
      Z80._r.m = 1

    DECr_l: ->
      Z80._r.l--
      Z80._r.l &= 255
      Z80._r.f = (if Z80._r.l then 0 else 0x80)
      Z80._r.m = 1

    DECr_a: ->
      Z80._r.a--
      Z80._r.a &= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    DECHLm: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l) - 1
      i &= 255
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (if i then 0 else 0x80)
      Z80._r.m = 3

    INCBC: ->
      Z80._r.c = (Z80._r.c + 1) & 255
      Z80._r.b = (Z80._r.b + 1) & 255  unless Z80._r.c
      Z80._r.m = 1

    INCDE: ->
      Z80._r.e = (Z80._r.e + 1) & 255
      Z80._r.d = (Z80._r.d + 1) & 255  unless Z80._r.e
      Z80._r.m = 1

    INCHL: ->
      Z80._r.l = (Z80._r.l + 1) & 255
      Z80._r.h = (Z80._r.h + 1) & 255  unless Z80._r.l
      Z80._r.m = 1

    INCSP: ->
      Z80._r.sp = (Z80._r.sp + 1) & 65535
      Z80._r.m = 1

    DECBC: ->
      Z80._r.c = (Z80._r.c - 1) & 255
      Z80._r.b = (Z80._r.b - 1) & 255  if Z80._r.c is 255
      Z80._r.m = 1

    DECDE: ->
      Z80._r.e = (Z80._r.e - 1) & 255
      Z80._r.d = (Z80._r.d - 1) & 255  if Z80._r.e is 255
      Z80._r.m = 1

    DECHL: ->
      Z80._r.l = (Z80._r.l - 1) & 255
      Z80._r.h = (Z80._r.h - 1) & 255  if Z80._r.l is 255
      Z80._r.m = 1

    DECSP: ->
      Z80._r.sp = (Z80._r.sp - 1) & 65535
      Z80._r.m = 1

    
    #--- Bit manipulation ---
    BIT0b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x01) then 0 else 0x80)
      Z80._r.m = 2

    BIT0m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x01) then 0 else 0x80)
      Z80._r.m = 3

    RES0b: ->
      Z80._r.b &= 0xFE
      Z80._r.m = 2

    RES0c: ->
      Z80._r.c &= 0xFE
      Z80._r.m = 2

    RES0d: ->
      Z80._r.d &= 0xFE
      Z80._r.m = 2

    RES0e: ->
      Z80._r.e &= 0xFE
      Z80._r.m = 2

    RES0h: ->
      Z80._r.h &= 0xFE
      Z80._r.m = 2

    RES0l: ->
      Z80._r.l &= 0xFE
      Z80._r.m = 2

    RES0a: ->
      Z80._r.a &= 0xFE
      Z80._r.m = 2

    RES0m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xFE
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET0b: ->
      Z80._r.b |= 0x01
      Z80._r.m = 2

    SET0c: ->
      Z80._r.c |= 0x01
      Z80._r.m = 2

    SET0d: ->
      Z80._r.d |= 0x01
      Z80._r.m = 2

    SET0e: ->
      Z80._r.e |= 0x01
      Z80._r.m = 2

    SET0h: ->
      Z80._r.h |= 0x01
      Z80._r.m = 2

    SET0l: ->
      Z80._r.l |= 0x01
      Z80._r.m = 2

    SET0a: ->
      Z80._r.a |= 0x01
      Z80._r.m = 2

    SET0m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x01
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT1b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x02) then 0 else 0x80)
      Z80._r.m = 2

    BIT1m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x02) then 0 else 0x80)
      Z80._r.m = 3

    RES1b: ->
      Z80._r.b &= 0xFD
      Z80._r.m = 2

    RES1c: ->
      Z80._r.c &= 0xFD
      Z80._r.m = 2

    RES1d: ->
      Z80._r.d &= 0xFD
      Z80._r.m = 2

    RES1e: ->
      Z80._r.e &= 0xFD
      Z80._r.m = 2

    RES1h: ->
      Z80._r.h &= 0xFD
      Z80._r.m = 2

    RES1l: ->
      Z80._r.l &= 0xFD
      Z80._r.m = 2

    RES1a: ->
      Z80._r.a &= 0xFD
      Z80._r.m = 2

    RES1m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xFD
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET1b: ->
      Z80._r.b |= 0x02
      Z80._r.m = 2

    SET1c: ->
      Z80._r.c |= 0x02
      Z80._r.m = 2

    SET1d: ->
      Z80._r.d |= 0x02
      Z80._r.m = 2

    SET1e: ->
      Z80._r.e |= 0x02
      Z80._r.m = 2

    SET1h: ->
      Z80._r.h |= 0x02
      Z80._r.m = 2

    SET1l: ->
      Z80._r.l |= 0x02
      Z80._r.m = 2

    SET1a: ->
      Z80._r.a |= 0x02
      Z80._r.m = 2

    SET1m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x02
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT2b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x04) then 0 else 0x80)
      Z80._r.m = 2

    BIT2m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x04) then 0 else 0x80)
      Z80._r.m = 3

    RES2b: ->
      Z80._r.b &= 0xFB
      Z80._r.m = 2

    RES2c: ->
      Z80._r.c &= 0xFB
      Z80._r.m = 2

    RES2d: ->
      Z80._r.d &= 0xFB
      Z80._r.m = 2

    RES2e: ->
      Z80._r.e &= 0xFB
      Z80._r.m = 2

    RES2h: ->
      Z80._r.h &= 0xFB
      Z80._r.m = 2

    RES2l: ->
      Z80._r.l &= 0xFB
      Z80._r.m = 2

    RES2a: ->
      Z80._r.a &= 0xFB
      Z80._r.m = 2

    RES2m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xFB
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET2b: ->
      Z80._r.b |= 0x04
      Z80._r.m = 2

    SET2c: ->
      Z80._r.c |= 0x04
      Z80._r.m = 2

    SET2d: ->
      Z80._r.d |= 0x04
      Z80._r.m = 2

    SET2e: ->
      Z80._r.e |= 0x04
      Z80._r.m = 2

    SET2h: ->
      Z80._r.h |= 0x04
      Z80._r.m = 2

    SET2l: ->
      Z80._r.l |= 0x04
      Z80._r.m = 2

    SET2a: ->
      Z80._r.a |= 0x04
      Z80._r.m = 2

    SET2m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x04
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT3b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x08) then 0 else 0x80)
      Z80._r.m = 2

    BIT3m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x08) then 0 else 0x80)
      Z80._r.m = 3

    RES3b: ->
      Z80._r.b &= 0xF7
      Z80._r.m = 2

    RES3c: ->
      Z80._r.c &= 0xF7
      Z80._r.m = 2

    RES3d: ->
      Z80._r.d &= 0xF7
      Z80._r.m = 2

    RES3e: ->
      Z80._r.e &= 0xF7
      Z80._r.m = 2

    RES3h: ->
      Z80._r.h &= 0xF7
      Z80._r.m = 2

    RES3l: ->
      Z80._r.l &= 0xF7
      Z80._r.m = 2

    RES3a: ->
      Z80._r.a &= 0xF7
      Z80._r.m = 2

    RES3m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xF7
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET3b: ->
      Z80._r.b |= 0x08
      Z80._r.m = 2

    SET3c: ->
      Z80._r.c |= 0x08
      Z80._r.m = 2

    SET3d: ->
      Z80._r.d |= 0x08
      Z80._r.m = 2

    SET3e: ->
      Z80._r.e |= 0x08
      Z80._r.m = 2

    SET3h: ->
      Z80._r.h |= 0x08
      Z80._r.m = 2

    SET3l: ->
      Z80._r.l |= 0x08
      Z80._r.m = 2

    SET3a: ->
      Z80._r.a |= 0x08
      Z80._r.m = 2

    SET3m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x08
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT4b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x10) then 0 else 0x80)
      Z80._r.m = 2

    BIT4m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x10) then 0 else 0x80)
      Z80._r.m = 3

    RES4b: ->
      Z80._r.b &= 0xEF
      Z80._r.m = 2

    RES4c: ->
      Z80._r.c &= 0xEF
      Z80._r.m = 2

    RES4d: ->
      Z80._r.d &= 0xEF
      Z80._r.m = 2

    RES4e: ->
      Z80._r.e &= 0xEF
      Z80._r.m = 2

    RES4h: ->
      Z80._r.h &= 0xEF
      Z80._r.m = 2

    RES4l: ->
      Z80._r.l &= 0xEF
      Z80._r.m = 2

    RES4a: ->
      Z80._r.a &= 0xEF
      Z80._r.m = 2

    RES4m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xEF
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET4b: ->
      Z80._r.b |= 0x10
      Z80._r.m = 2

    SET4c: ->
      Z80._r.c |= 0x10
      Z80._r.m = 2

    SET4d: ->
      Z80._r.d |= 0x10
      Z80._r.m = 2

    SET4e: ->
      Z80._r.e |= 0x10
      Z80._r.m = 2

    SET4h: ->
      Z80._r.h |= 0x10
      Z80._r.m = 2

    SET4l: ->
      Z80._r.l |= 0x10
      Z80._r.m = 2

    SET4a: ->
      Z80._r.a |= 0x10
      Z80._r.m = 2

    SET4m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x10
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT5b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x20) then 0 else 0x80)
      Z80._r.m = 2

    BIT5m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x20) then 0 else 0x80)
      Z80._r.m = 3

    RES5b: ->
      Z80._r.b &= 0xDF
      Z80._r.m = 2

    RES5c: ->
      Z80._r.c &= 0xDF
      Z80._r.m = 2

    RES5d: ->
      Z80._r.d &= 0xDF
      Z80._r.m = 2

    RES5e: ->
      Z80._r.e &= 0xDF
      Z80._r.m = 2

    RES5h: ->
      Z80._r.h &= 0xDF
      Z80._r.m = 2

    RES5l: ->
      Z80._r.l &= 0xDF
      Z80._r.m = 2

    RES5a: ->
      Z80._r.a &= 0xDF
      Z80._r.m = 2

    RES5m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xDF
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET5b: ->
      Z80._r.b |= 0x20
      Z80._r.m = 2

    SET5c: ->
      Z80._r.c |= 0x20
      Z80._r.m = 2

    SET5d: ->
      Z80._r.d |= 0x20
      Z80._r.m = 2

    SET5e: ->
      Z80._r.e |= 0x20
      Z80._r.m = 2

    SET5h: ->
      Z80._r.h |= 0x20
      Z80._r.m = 2

    SET5l: ->
      Z80._r.l |= 0x20
      Z80._r.m = 2

    SET5a: ->
      Z80._r.a |= 0x20
      Z80._r.m = 2

    SET5m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x20
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT6b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x40) then 0 else 0x80)
      Z80._r.m = 2

    BIT6m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x40) then 0 else 0x80)
      Z80._r.m = 3

    RES6b: ->
      Z80._r.b &= 0xBF
      Z80._r.m = 2

    RES6c: ->
      Z80._r.c &= 0xBF
      Z80._r.m = 2

    RES6d: ->
      Z80._r.d &= 0xBF
      Z80._r.m = 2

    RES6e: ->
      Z80._r.e &= 0xBF
      Z80._r.m = 2

    RES6h: ->
      Z80._r.h &= 0xBF
      Z80._r.m = 2

    RES6l: ->
      Z80._r.l &= 0xBF
      Z80._r.m = 2

    RES6a: ->
      Z80._r.a &= 0xBF
      Z80._r.m = 2

    RES6m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0xBF
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET6b: ->
      Z80._r.b |= 0x40
      Z80._r.m = 2

    SET6c: ->
      Z80._r.c |= 0x40
      Z80._r.m = 2

    SET6d: ->
      Z80._r.d |= 0x40
      Z80._r.m = 2

    SET6e: ->
      Z80._r.e |= 0x40
      Z80._r.m = 2

    SET6h: ->
      Z80._r.h |= 0x40
      Z80._r.m = 2

    SET6l: ->
      Z80._r.l |= 0x40
      Z80._r.m = 2

    SET6a: ->
      Z80._r.a |= 0x40
      Z80._r.m = 2

    SET6m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x40
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    BIT7b: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.b & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7c: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.c & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7d: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.d & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7e: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.e & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7h: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.h & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7l: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.l & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7a: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (Z80._r.a & 0x80) then 0 else 0x80)
      Z80._r.m = 2

    BIT7m: ->
      Z80._r.f &= 0x1F
      Z80._r.f |= 0x20
      Z80._r.f = (if (MMU.rb((Z80._r.h << 8) + Z80._r.l) & 0x80) then 0 else 0x80)
      Z80._r.m = 3

    RES7b: ->
      Z80._r.b &= 0x7F
      Z80._r.m = 2

    RES7c: ->
      Z80._r.c &= 0x7F
      Z80._r.m = 2

    RES7d: ->
      Z80._r.d &= 0x7F
      Z80._r.m = 2

    RES7e: ->
      Z80._r.e &= 0x7F
      Z80._r.m = 2

    RES7h: ->
      Z80._r.h &= 0x7F
      Z80._r.m = 2

    RES7l: ->
      Z80._r.l &= 0x7F
      Z80._r.m = 2

    RES7a: ->
      Z80._r.a &= 0x7F
      Z80._r.m = 2

    RES7m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i &= 0x7F
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    SET7b: ->
      Z80._r.b |= 0x80
      Z80._r.m = 2

    SET7c: ->
      Z80._r.c |= 0x80
      Z80._r.m = 2

    SET7d: ->
      Z80._r.d |= 0x80
      Z80._r.m = 2

    SET7e: ->
      Z80._r.e |= 0x80
      Z80._r.m = 2

    SET7h: ->
      Z80._r.h |= 0x80
      Z80._r.m = 2

    SET7l: ->
      Z80._r.l |= 0x80
      Z80._r.m = 2

    SET7a: ->
      Z80._r.a |= 0x80
      Z80._r.m = 2

    SET7m: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      i |= 0x80
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.m = 4

    RLA: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 1

    RLCA: ->
      ci = (if Z80._r.a & 0x80 then 1 else 0)
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 1

    RRA: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = (Z80._r.a >> 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 1

    RRCA: ->
      ci = (if Z80._r.a & 1 then 0x80 else 0)
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = (Z80._r.a >> 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 1

    RLr_b: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.b & 0x80 then 0x10 else 0)
      Z80._r.b = (Z80._r.b << 1) + ci
      Z80._r.b &= 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_c: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.c & 0x80 then 0x10 else 0)
      Z80._r.c = (Z80._r.c << 1) + ci
      Z80._r.c &= 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_d: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.d & 0x80 then 0x10 else 0)
      Z80._r.d = (Z80._r.d << 1) + ci
      Z80._r.d &= 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_e: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.e & 0x80 then 0x10 else 0)
      Z80._r.e = (Z80._r.e << 1) + ci
      Z80._r.e &= 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_h: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.h & 0x80 then 0x10 else 0)
      Z80._r.h = (Z80._r.h << 1) + ci
      Z80._r.h &= 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_l: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.l & 0x80 then 0x10 else 0)
      Z80._r.l = (Z80._r.l << 1) + ci
      Z80._r.l &= 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLr_a: ->
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLHL: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      ci = (if Z80._r.f & 0x10 then 1 else 0)
      co = (if i & 0x80 then 0x10 else 0)
      i = (i << 1) + ci
      i &= 255
      Z80._r.f = (if (i) then 0 else 0x80)
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 4

    RLCr_b: ->
      ci = (if Z80._r.b & 0x80 then 1 else 0)
      co = (if Z80._r.b & 0x80 then 0x10 else 0)
      Z80._r.b = (Z80._r.b << 1) + ci
      Z80._r.b &= 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_c: ->
      ci = (if Z80._r.c & 0x80 then 1 else 0)
      co = (if Z80._r.c & 0x80 then 0x10 else 0)
      Z80._r.c = (Z80._r.c << 1) + ci
      Z80._r.c &= 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_d: ->
      ci = (if Z80._r.d & 0x80 then 1 else 0)
      co = (if Z80._r.d & 0x80 then 0x10 else 0)
      Z80._r.d = (Z80._r.d << 1) + ci
      Z80._r.d &= 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_e: ->
      ci = (if Z80._r.e & 0x80 then 1 else 0)
      co = (if Z80._r.e & 0x80 then 0x10 else 0)
      Z80._r.e = (Z80._r.e << 1) + ci
      Z80._r.e &= 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_h: ->
      ci = (if Z80._r.h & 0x80 then 1 else 0)
      co = (if Z80._r.h & 0x80 then 0x10 else 0)
      Z80._r.h = (Z80._r.h << 1) + ci
      Z80._r.h &= 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_l: ->
      ci = (if Z80._r.l & 0x80 then 1 else 0)
      co = (if Z80._r.l & 0x80 then 0x10 else 0)
      Z80._r.l = (Z80._r.l << 1) + ci
      Z80._r.l &= 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCr_a: ->
      ci = (if Z80._r.a & 0x80 then 1 else 0)
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RLCHL: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      ci = (if i & 0x80 then 1 else 0)
      co = (if i & 0x80 then 0x10 else 0)
      i = (i << 1) + ci
      i &= 255
      Z80._r.f = (if (i) then 0 else 0x80)
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 4

    RRr_b: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.b & 1 then 0x10 else 0)
      Z80._r.b = (Z80._r.b >> 1) + ci
      Z80._r.b &= 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_c: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.c & 1 then 0x10 else 0)
      Z80._r.c = (Z80._r.c >> 1) + ci
      Z80._r.c &= 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_d: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.d & 1 then 0x10 else 0)
      Z80._r.d = (Z80._r.d >> 1) + ci
      Z80._r.d &= 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_e: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.e & 1 then 0x10 else 0)
      Z80._r.e = (Z80._r.e >> 1) + ci
      Z80._r.e &= 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_h: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.h & 1 then 0x10 else 0)
      Z80._r.h = (Z80._r.h >> 1) + ci
      Z80._r.h &= 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_l: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.l & 1 then 0x10 else 0)
      Z80._r.l = (Z80._r.l >> 1) + ci
      Z80._r.l &= 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRr_a: ->
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = (Z80._r.a >> 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRHL: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      ci = (if Z80._r.f & 0x10 then 0x80 else 0)
      co = (if i & 1 then 0x10 else 0)
      i = (i >> 1) + ci
      i &= 255
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (if (i) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 4

    RRCr_b: ->
      ci = (if Z80._r.b & 1 then 0x80 else 0)
      co = (if Z80._r.b & 1 then 0x10 else 0)
      Z80._r.b = (Z80._r.b >> 1) + ci
      Z80._r.b &= 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_c: ->
      ci = (if Z80._r.c & 1 then 0x80 else 0)
      co = (if Z80._r.c & 1 then 0x10 else 0)
      Z80._r.c = (Z80._r.c >> 1) + ci
      Z80._r.c &= 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_d: ->
      ci = (if Z80._r.d & 1 then 0x80 else 0)
      co = (if Z80._r.d & 1 then 0x10 else 0)
      Z80._r.d = (Z80._r.d >> 1) + ci
      Z80._r.d &= 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_e: ->
      ci = (if Z80._r.e & 1 then 0x80 else 0)
      co = (if Z80._r.e & 1 then 0x10 else 0)
      Z80._r.e = (Z80._r.e >> 1) + ci
      Z80._r.e &= 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_h: ->
      ci = (if Z80._r.h & 1 then 0x80 else 0)
      co = (if Z80._r.h & 1 then 0x10 else 0)
      Z80._r.h = (Z80._r.h >> 1) + ci
      Z80._r.h &= 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_l: ->
      ci = (if Z80._r.l & 1 then 0x80 else 0)
      co = (if Z80._r.l & 1 then 0x10 else 0)
      Z80._r.l = (Z80._r.l >> 1) + ci
      Z80._r.l &= 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCr_a: ->
      ci = (if Z80._r.a & 1 then 0x80 else 0)
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = (Z80._r.a >> 1) + ci
      Z80._r.a &= 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    RRCHL: ->
      i = MMU.rb((Z80._r.h << 8) + Z80._r.l)
      ci = (if i & 1 then 0x80 else 0)
      co = (if i & 1 then 0x10 else 0)
      i = (i >> 1) + ci
      i &= 255
      MMU.wb (Z80._r.h << 8) + Z80._r.l, i
      Z80._r.f = (if (i) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 4

    SLAr_b: ->
      co = (if Z80._r.b & 0x80 then 0x10 else 0)
      Z80._r.b = (Z80._r.b << 1) & 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_c: ->
      co = (if Z80._r.c & 0x80 then 0x10 else 0)
      Z80._r.c = (Z80._r.c << 1) & 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_d: ->
      co = (if Z80._r.d & 0x80 then 0x10 else 0)
      Z80._r.d = (Z80._r.d << 1) & 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_e: ->
      co = (if Z80._r.e & 0x80 then 0x10 else 0)
      Z80._r.e = (Z80._r.e << 1) & 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_h: ->
      co = (if Z80._r.h & 0x80 then 0x10 else 0)
      Z80._r.h = (Z80._r.h << 1) & 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_l: ->
      co = (if Z80._r.l & 0x80 then 0x10 else 0)
      Z80._r.l = (Z80._r.l << 1) & 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLAr_a: ->
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) & 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_b: ->
      co = (if Z80._r.b & 0x80 then 0x10 else 0)
      Z80._r.b = (Z80._r.b << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_c: ->
      co = (if Z80._r.c & 0x80 then 0x10 else 0)
      Z80._r.c = (Z80._r.c << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_d: ->
      co = (if Z80._r.d & 0x80 then 0x10 else 0)
      Z80._r.d = (Z80._r.d << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_e: ->
      co = (if Z80._r.e & 0x80 then 0x10 else 0)
      Z80._r.e = (Z80._r.e << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_h: ->
      co = (if Z80._r.h & 0x80 then 0x10 else 0)
      Z80._r.h = (Z80._r.h << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_l: ->
      co = (if Z80._r.l & 0x80 then 0x10 else 0)
      Z80._r.l = (Z80._r.l << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SLLr_a: ->
      co = (if Z80._r.a & 0x80 then 0x10 else 0)
      Z80._r.a = (Z80._r.a << 1) & 255 + 1
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_b: ->
      ci = Z80._r.b & 0x80
      co = (if Z80._r.b & 1 then 0x10 else 0)
      Z80._r.b = ((Z80._r.b >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_c: ->
      ci = Z80._r.c & 0x80
      co = (if Z80._r.c & 1 then 0x10 else 0)
      Z80._r.c = ((Z80._r.c >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_d: ->
      ci = Z80._r.d & 0x80
      co = (if Z80._r.d & 1 then 0x10 else 0)
      Z80._r.d = ((Z80._r.d >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_e: ->
      ci = Z80._r.e & 0x80
      co = (if Z80._r.e & 1 then 0x10 else 0)
      Z80._r.e = ((Z80._r.e >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_h: ->
      ci = Z80._r.h & 0x80
      co = (if Z80._r.h & 1 then 0x10 else 0)
      Z80._r.h = ((Z80._r.h >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_l: ->
      ci = Z80._r.l & 0x80
      co = (if Z80._r.l & 1 then 0x10 else 0)
      Z80._r.l = ((Z80._r.l >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRAr_a: ->
      ci = Z80._r.a & 0x80
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = ((Z80._r.a >> 1) + ci) & 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_b: ->
      co = (if Z80._r.b & 1 then 0x10 else 0)
      Z80._r.b = (Z80._r.b >> 1) & 255
      Z80._r.f = (if (Z80._r.b) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_c: ->
      co = (if Z80._r.c & 1 then 0x10 else 0)
      Z80._r.c = (Z80._r.c >> 1) & 255
      Z80._r.f = (if (Z80._r.c) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_d: ->
      co = (if Z80._r.d & 1 then 0x10 else 0)
      Z80._r.d = (Z80._r.d >> 1) & 255
      Z80._r.f = (if (Z80._r.d) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_e: ->
      co = (if Z80._r.e & 1 then 0x10 else 0)
      Z80._r.e = (Z80._r.e >> 1) & 255
      Z80._r.f = (if (Z80._r.e) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_h: ->
      co = (if Z80._r.h & 1 then 0x10 else 0)
      Z80._r.h = (Z80._r.h >> 1) & 255
      Z80._r.f = (if (Z80._r.h) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_l: ->
      co = (if Z80._r.l & 1 then 0x10 else 0)
      Z80._r.l = (Z80._r.l >> 1) & 255
      Z80._r.f = (if (Z80._r.l) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    SRLr_a: ->
      co = (if Z80._r.a & 1 then 0x10 else 0)
      Z80._r.a = (Z80._r.a >> 1) & 255
      Z80._r.f = (if (Z80._r.a) then 0 else 0x80)
      Z80._r.f = (Z80._r.f & 0xEF) + co
      Z80._r.m = 2

    CPL: ->
      Z80._r.a ^= 255
      Z80._r.f = (if Z80._r.a then 0 else 0x80)
      Z80._r.m = 1

    NEG: ->
      Z80._r.a = 0 - Z80._r.a
      Z80._r.f = (if (Z80._r.a < 0) then 0x10 else 0)
      Z80._r.a &= 255
      Z80._r.f |= 0x80  unless Z80._r.a
      Z80._r.m = 2

    CCF: ->
      ci = (if Z80._r.f & 0x10 then 0 else 0x10)
      Z80._r.f = (Z80._r.f & 0xEF) + ci
      Z80._r.m = 1

    SCF: ->
      Z80._r.f |= 0x10
      Z80._r.m = 1

    
    #--- Stack ---
    PUSHBC: ->
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.b
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.c
      Z80._r.m = 3

    PUSHDE: ->
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.d
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.e
      Z80._r.m = 3

    PUSHHL: ->
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.h
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.l
      Z80._r.m = 3

    PUSHAF: ->
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.a
      Z80._r.sp--
      MMU.wb Z80._r.sp, Z80._r.f
      Z80._r.m = 3

    POPBC: ->
      Z80._r.c = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.b = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.m = 3

    POPDE: ->
      Z80._r.e = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.d = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.m = 3

    POPHL: ->
      Z80._r.l = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.h = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.m = 3

    POPAF: ->
      Z80._r.f = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.a = MMU.rb(Z80._r.sp)
      Z80._r.sp++
      Z80._r.m = 3

    
    #--- Jump ---
    JPnn: ->
      Z80._r.pc = MMU.rw(Z80._r.pc)
      Z80._r.m = 3

    JPHL: ->
      Z80._r.pc = (Z80._r.h << 8) + Z80._r.l
      Z80._r.m = 1

    JPNZnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x80) is 0x00
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m++
      else
        Z80._r.pc += 2

    JPZnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x80) is 0x80
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m++
      else
        Z80._r.pc += 2

    JPNCnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x10) is 0x00
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m++
      else
        Z80._r.pc += 2

    JPCnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x10) is 0x10
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m++
      else
        Z80._r.pc += 2

    JRn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      Z80._r.pc += i
      Z80._r.m++

    JRNZn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      if (Z80._r.f & 0x80) is 0x00
        Z80._r.pc += i
        Z80._r.m++

    JRZn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      if (Z80._r.f & 0x80) is 0x80
        Z80._r.pc += i
        Z80._r.m++

    JRNCn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      if (Z80._r.f & 0x10) is 0x00
        Z80._r.pc += i
        Z80._r.m++

    JRCn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      if (Z80._r.f & 0x10) is 0x10
        Z80._r.pc += i
        Z80._r.m++

    DJNZn: ->
      i = MMU.rb(Z80._r.pc)
      i = -((~i + 1) & 255)  if i > 127
      Z80._r.pc++
      Z80._r.m = 2
      Z80._r.b--
      if Z80._r.b
        Z80._r.pc += i
        Z80._r.m++

    CALLnn: ->
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc + 2
      Z80._r.pc = MMU.rw(Z80._r.pc)
      Z80._r.m = 5

    CALLNZnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x80) is 0x00
        Z80._r.sp -= 2
        MMU.ww Z80._r.sp, Z80._r.pc + 2
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m += 2
      else
        Z80._r.pc += 2

    CALLZnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x80) is 0x80
        Z80._r.sp -= 2
        MMU.ww Z80._r.sp, Z80._r.pc + 2
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m += 2
      else
        Z80._r.pc += 2

    CALLNCnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x10) is 0x00
        Z80._r.sp -= 2
        MMU.ww Z80._r.sp, Z80._r.pc + 2
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m += 2
      else
        Z80._r.pc += 2

    CALLCnn: ->
      Z80._r.m = 3
      if (Z80._r.f & 0x10) is 0x10
        Z80._r.sp -= 2
        MMU.ww Z80._r.sp, Z80._r.pc + 2
        Z80._r.pc = MMU.rw(Z80._r.pc)
        Z80._r.m += 2
      else
        Z80._r.pc += 2

    RET: ->
      Z80._r.pc = MMU.rw(Z80._r.sp)
      Z80._r.sp += 2
      Z80._r.m = 3

    RETI: ->
      Z80._r.ime = 1
      Z80._ops.rrs()
      Z80._r.pc = MMU.rw(Z80._r.sp)
      Z80._r.sp += 2
      Z80._r.m = 3

    RETNZ: ->
      Z80._r.m = 1
      if (Z80._r.f & 0x80) is 0x00
        Z80._r.pc = MMU.rw(Z80._r.sp)
        Z80._r.sp += 2
        Z80._r.m += 2

    RETZ: ->
      Z80._r.m = 1
      if (Z80._r.f & 0x80) is 0x80
        Z80._r.pc = MMU.rw(Z80._r.sp)
        Z80._r.sp += 2
        Z80._r.m += 2

    RETNC: ->
      Z80._r.m = 1
      if (Z80._r.f & 0x10) is 0x00
        Z80._r.pc = MMU.rw(Z80._r.sp)
        Z80._r.sp += 2
        Z80._r.m += 2

    RETC: ->
      Z80._r.m = 1
      if (Z80._r.f & 0x10) is 0x10
        Z80._r.pc = MMU.rw(Z80._r.sp)
        Z80._r.sp += 2
        Z80._r.m += 2

    RST00: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x00
      Z80._r.m = 3

    RST08: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x08
      Z80._r.m = 3

    RST10: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x10
      Z80._r.m = 3

    RST18: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x18
      Z80._r.m = 3

    RST20: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x20
      Z80._r.m = 3

    RST28: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x28
      Z80._r.m = 3

    RST30: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x30
      Z80._r.m = 3

    RST38: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x38
      Z80._r.m = 3

    RST40: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x40
      Z80._r.m = 3

    RST48: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x48
      Z80._r.m = 3

    RST50: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x50
      Z80._r.m = 3

    RST58: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x58
      Z80._r.m = 3

    RST60: ->
      Z80._ops.rsv()
      Z80._r.sp -= 2
      MMU.ww Z80._r.sp, Z80._r.pc
      Z80._r.pc = 0x60
      Z80._r.m = 3

    NOP: ->
      Z80._r.m = 1

    HALT: ->
      Z80._halt = 1
      Z80._r.m = 1

    DI: ->
      Z80._r.ime = 0
      Z80._r.m = 1

    EI: ->
      Z80._r.ime = 1
      Z80._r.m = 1

    
    #--- Helper functions ---
    rsv: ->
      Z80._rsv.a = Z80._r.a
      Z80._rsv.b = Z80._r.b
      Z80._rsv.c = Z80._r.c
      Z80._rsv.d = Z80._r.d
      Z80._rsv.e = Z80._r.e
      Z80._rsv.f = Z80._r.f
      Z80._rsv.h = Z80._r.h
      Z80._rsv.l = Z80._r.l

    rrs: ->
      Z80._r.a = Z80._rsv.a
      Z80._r.b = Z80._rsv.b
      Z80._r.c = Z80._rsv.c
      Z80._r.d = Z80._rsv.d
      Z80._r.e = Z80._rsv.e
      Z80._r.f = Z80._rsv.f
      Z80._r.h = Z80._rsv.h
      Z80._r.l = Z80._rsv.l

    MAPcb: ->
      i = MMU.rb(Z80._r.pc)
      Z80._r.pc++
      Z80._r.pc &= 65535
      Z80._cbmap[i]()  if Z80._cbmap[i]

    XX: ->
      
      #Undefined map entry
      opc = Z80._r.pc - 1
      Z80._stop = 1

  _map: []
  _cbmap: []

Z80._map = [
  
  # 00
  Z80._ops.NOP
  Z80._ops.LDBCnn
  Z80._ops.LDBCmA
  Z80._ops.INCBC
  Z80._ops.INCr_b
  Z80._ops.DECr_b
  Z80._ops.LDrn_b
  Z80._ops.RLCA
  Z80._ops.LDmmSP
  Z80._ops.ADDHLBC
  Z80._ops.LDABCm
  Z80._ops.DECBC
  Z80._ops.INCr_c
  Z80._ops.DECr_c
  Z80._ops.LDrn_c
  Z80._ops.RRCA
  
  # 10
  Z80._ops.DJNZn
  Z80._ops.LDDEnn
  Z80._ops.LDDEmA
  Z80._ops.INCDE
  Z80._ops.INCr_d
  Z80._ops.DECr_d
  Z80._ops.LDrn_d
  Z80._ops.RLA
  Z80._ops.JRn
  Z80._ops.ADDHLDE
  Z80._ops.LDADEm
  Z80._ops.DECDE
  Z80._ops.INCr_e
  Z80._ops.DECr_e
  Z80._ops.LDrn_e
  Z80._ops.RRA
  
  # 20
  Z80._ops.JRNZn
  Z80._ops.LDHLnn
  Z80._ops.LDHLIA
  Z80._ops.INCHL
  Z80._ops.INCr_h
  Z80._ops.DECr_h
  Z80._ops.LDrn_h
  Z80._ops.DAA
  Z80._ops.JRZn
  Z80._ops.ADDHLHL
  Z80._ops.LDAHLI
  Z80._ops.DECHL
  Z80._ops.INCr_l
  Z80._ops.DECr_l
  Z80._ops.LDrn_l
  Z80._ops.CPL
  
  # 30
  Z80._ops.JRNCn
  Z80._ops.LDSPnn
  Z80._ops.LDHLDA
  Z80._ops.INCSP
  Z80._ops.INCHLm
  Z80._ops.DECHLm
  Z80._ops.LDHLmn
  Z80._ops.SCF
  Z80._ops.JRCn
  Z80._ops.ADDHLSP
  Z80._ops.LDAHLD
  Z80._ops.DECSP
  Z80._ops.INCr_a
  Z80._ops.DECr_a
  Z80._ops.LDrn_a
  Z80._ops.CCF
  
  # 40
  Z80._ops.LDrr_bb
  Z80._ops.LDrr_bc
  Z80._ops.LDrr_bd
  Z80._ops.LDrr_be
  Z80._ops.LDrr_bh
  Z80._ops.LDrr_bl
  Z80._ops.LDrHLm_b
  Z80._ops.LDrr_ba
  Z80._ops.LDrr_cb
  Z80._ops.LDrr_cc
  Z80._ops.LDrr_cd
  Z80._ops.LDrr_ce
  Z80._ops.LDrr_ch
  Z80._ops.LDrr_cl
  Z80._ops.LDrHLm_c
  Z80._ops.LDrr_ca
  
  # 50
  Z80._ops.LDrr_db
  Z80._ops.LDrr_dc
  Z80._ops.LDrr_dd
  Z80._ops.LDrr_de
  Z80._ops.LDrr_dh
  Z80._ops.LDrr_dl
  Z80._ops.LDrHLm_d
  Z80._ops.LDrr_da
  Z80._ops.LDrr_eb
  Z80._ops.LDrr_ec
  Z80._ops.LDrr_ed
  Z80._ops.LDrr_ee
  Z80._ops.LDrr_eh
  Z80._ops.LDrr_el
  Z80._ops.LDrHLm_e
  Z80._ops.LDrr_ea
  
  # 60
  Z80._ops.LDrr_hb
  Z80._ops.LDrr_hc
  Z80._ops.LDrr_hd
  Z80._ops.LDrr_he
  Z80._ops.LDrr_hh
  Z80._ops.LDrr_hl
  Z80._ops.LDrHLm_h
  Z80._ops.LDrr_ha
  Z80._ops.LDrr_lb
  Z80._ops.LDrr_lc
  Z80._ops.LDrr_ld
  Z80._ops.LDrr_le
  Z80._ops.LDrr_lh
  Z80._ops.LDrr_ll
  Z80._ops.LDrHLm_l
  Z80._ops.LDrr_la
  
  # 70
  Z80._ops.LDHLmr_b
  Z80._ops.LDHLmr_c
  Z80._ops.LDHLmr_d
  Z80._ops.LDHLmr_e
  Z80._ops.LDHLmr_h
  Z80._ops.LDHLmr_l
  Z80._ops.HALT
  Z80._ops.LDHLmr_a
  Z80._ops.LDrr_ab
  Z80._ops.LDrr_ac
  Z80._ops.LDrr_ad
  Z80._ops.LDrr_ae
  Z80._ops.LDrr_ah
  Z80._ops.LDrr_al
  Z80._ops.LDrHLm_a
  Z80._ops.LDrr_aa
  
  # 80
  Z80._ops.ADDr_b
  Z80._ops.ADDr_c
  Z80._ops.ADDr_d
  Z80._ops.ADDr_e
  Z80._ops.ADDr_h
  Z80._ops.ADDr_l
  Z80._ops.ADDHL
  Z80._ops.ADDr_a
  Z80._ops.ADCr_b
  Z80._ops.ADCr_c
  Z80._ops.ADCr_d
  Z80._ops.ADCr_e
  Z80._ops.ADCr_h
  Z80._ops.ADCr_l
  Z80._ops.ADCHL
  Z80._ops.ADCr_a
  
  # 90
  Z80._ops.SUBr_b
  Z80._ops.SUBr_c
  Z80._ops.SUBr_d
  Z80._ops.SUBr_e
  Z80._ops.SUBr_h
  Z80._ops.SUBr_l
  Z80._ops.SUBHL
  Z80._ops.SUBr_a
  Z80._ops.SBCr_b
  Z80._ops.SBCr_c
  Z80._ops.SBCr_d
  Z80._ops.SBCr_e
  Z80._ops.SBCr_h
  Z80._ops.SBCr_l
  Z80._ops.SBCHL
  Z80._ops.SBCr_a
  
  # A0
  Z80._ops.ANDr_b
  Z80._ops.ANDr_c
  Z80._ops.ANDr_d
  Z80._ops.ANDr_e
  Z80._ops.ANDr_h
  Z80._ops.ANDr_l
  Z80._ops.ANDHL
  Z80._ops.ANDr_a
  Z80._ops.XORr_b
  Z80._ops.XORr_c
  Z80._ops.XORr_d
  Z80._ops.XORr_e
  Z80._ops.XORr_h
  Z80._ops.XORr_l
  Z80._ops.XORHL
  Z80._ops.XORr_a
  
  # B0
  Z80._ops.ORr_b
  Z80._ops.ORr_c
  Z80._ops.ORr_d
  Z80._ops.ORr_e
  Z80._ops.ORr_h
  Z80._ops.ORr_l
  Z80._ops.ORHL
  Z80._ops.ORr_a
  Z80._ops.CPr_b
  Z80._ops.CPr_c
  Z80._ops.CPr_d
  Z80._ops.CPr_e
  Z80._ops.CPr_h
  Z80._ops.CPr_l
  Z80._ops.CPHL
  Z80._ops.CPr_a
  
  # C0
  Z80._ops.RETNZ
  Z80._ops.POPBC
  Z80._ops.JPNZnn
  Z80._ops.JPnn
  Z80._ops.CALLNZnn
  Z80._ops.PUSHBC
  Z80._ops.ADDn
  Z80._ops.RST00
  Z80._ops.RETZ
  Z80._ops.RET
  Z80._ops.JPZnn
  Z80._ops.MAPcb
  Z80._ops.CALLZnn
  Z80._ops.CALLnn
  Z80._ops.ADCn
  Z80._ops.RST08
  
  # D0
  Z80._ops.RETNC
  Z80._ops.POPDE
  Z80._ops.JPNCnn
  Z80._ops.XX
  Z80._ops.CALLNCnn
  Z80._ops.PUSHDE
  Z80._ops.SUBn
  Z80._ops.RST10
  Z80._ops.RETC
  Z80._ops.RETI
  Z80._ops.JPCnn
  Z80._ops.XX
  Z80._ops.CALLCnn
  Z80._ops.XX
  Z80._ops.SBCn
  Z80._ops.RST18
  
  # E0
  Z80._ops.LDIOnA
  Z80._ops.POPHL
  Z80._ops.LDIOCA
  Z80._ops.XX
  Z80._ops.XX
  Z80._ops.PUSHHL
  Z80._ops.ANDn
  Z80._ops.RST20
  Z80._ops.ADDSPn
  Z80._ops.JPHL
  Z80._ops.LDmmA
  Z80._ops.XX
  Z80._ops.XX
  Z80._ops.XX
  Z80._ops.XORn
  Z80._ops.RST28
  
  # F0
  Z80._ops.LDAIOn
  Z80._ops.POPAF
  Z80._ops.LDAIOC
  Z80._ops.DI
  Z80._ops.XX
  Z80._ops.PUSHAF
  Z80._ops.ORn
  Z80._ops.RST30
  Z80._ops.LDHLSPn
  Z80._ops.XX
  Z80._ops.LDAmm
  Z80._ops.EI
  Z80._ops.XX
  Z80._ops.XX
  Z80._ops.CPn
  Z80._ops.RST38
]
Z80._cbmap = [
  
  # CB00
  Z80._ops.RLCr_b
  Z80._ops.RLCr_c
  Z80._ops.RLCr_d
  Z80._ops.RLCr_e
  Z80._ops.RLCr_h
  Z80._ops.RLCr_l
  Z80._ops.RLCHL
  Z80._ops.RLCr_a
  Z80._ops.RRCr_b
  Z80._ops.RRCr_c
  Z80._ops.RRCr_d
  Z80._ops.RRCr_e
  Z80._ops.RRCr_h
  Z80._ops.RRCr_l
  Z80._ops.RRCHL
  Z80._ops.RRCr_a
  
  # CB10
  Z80._ops.RLr_b
  Z80._ops.RLr_c
  Z80._ops.RLr_d
  Z80._ops.RLr_e
  Z80._ops.RLr_h
  Z80._ops.RLr_l
  Z80._ops.RLHL
  Z80._ops.RLr_a
  Z80._ops.RRr_b
  Z80._ops.RRr_c
  Z80._ops.RRr_d
  Z80._ops.RRr_e
  Z80._ops.RRr_h
  Z80._ops.RRr_l
  Z80._ops.RRHL
  Z80._ops.RRr_a
  
  # CB20
  Z80._ops.SLAr_b
  Z80._ops.SLAr_c
  Z80._ops.SLAr_d
  Z80._ops.SLAr_e
  Z80._ops.SLAr_h
  Z80._ops.SLAr_l
  Z80._ops.XX
  Z80._ops.SLAr_a
  Z80._ops.SRAr_b
  Z80._ops.SRAr_c
  Z80._ops.SRAr_d
  Z80._ops.SRAr_e
  Z80._ops.SRAr_h
  Z80._ops.SRAr_l
  Z80._ops.XX
  Z80._ops.SRAr_a
  
  # CB30
  Z80._ops.SWAPr_b
  Z80._ops.SWAPr_c
  Z80._ops.SWAPr_d
  Z80._ops.SWAPr_e
  Z80._ops.SWAPr_h
  Z80._ops.SWAPr_l
  Z80._ops.XX
  Z80._ops.SWAPr_a
  Z80._ops.SRLr_b
  Z80._ops.SRLr_c
  Z80._ops.SRLr_d
  Z80._ops.SRLr_e
  Z80._ops.SRLr_h
  Z80._ops.SRLr_l
  Z80._ops.XX
  Z80._ops.SRLr_a
  
  # CB40
  Z80._ops.BIT0b
  Z80._ops.BIT0c
  Z80._ops.BIT0d
  Z80._ops.BIT0e
  Z80._ops.BIT0h
  Z80._ops.BIT0l
  Z80._ops.BIT0m
  Z80._ops.BIT0a
  Z80._ops.BIT1b
  Z80._ops.BIT1c
  Z80._ops.BIT1d
  Z80._ops.BIT1e
  Z80._ops.BIT1h
  Z80._ops.BIT1l
  Z80._ops.BIT1m
  Z80._ops.BIT1a
  
  # CB50
  Z80._ops.BIT2b
  Z80._ops.BIT2c
  Z80._ops.BIT2d
  Z80._ops.BIT2e
  Z80._ops.BIT2h
  Z80._ops.BIT2l
  Z80._ops.BIT2m
  Z80._ops.BIT2a
  Z80._ops.BIT3b
  Z80._ops.BIT3c
  Z80._ops.BIT3d
  Z80._ops.BIT3e
  Z80._ops.BIT3h
  Z80._ops.BIT3l
  Z80._ops.BIT3m
  Z80._ops.BIT3a
  
  # CB60
  Z80._ops.BIT4b
  Z80._ops.BIT4c
  Z80._ops.BIT4d
  Z80._ops.BIT4e
  Z80._ops.BIT4h
  Z80._ops.BIT4l
  Z80._ops.BIT4m
  Z80._ops.BIT4a
  Z80._ops.BIT5b
  Z80._ops.BIT5c
  Z80._ops.BIT5d
  Z80._ops.BIT5e
  Z80._ops.BIT5h
  Z80._ops.BIT5l
  Z80._ops.BIT5m
  Z80._ops.BIT5a
  
  # CB70
  Z80._ops.BIT6b
  Z80._ops.BIT6c
  Z80._ops.BIT6d
  Z80._ops.BIT6e
  Z80._ops.BIT6h
  Z80._ops.BIT6l
  Z80._ops.BIT6m
  Z80._ops.BIT6a
  Z80._ops.BIT7b
  Z80._ops.BIT7c
  Z80._ops.BIT7d
  Z80._ops.BIT7e
  Z80._ops.BIT7h
  Z80._ops.BIT7l
  Z80._ops.BIT7m
  Z80._ops.BIT7a
  
  # CB80
  Z80._ops.RES0b
  Z80._ops.RES0c
  Z80._ops.RES0d
  Z80._ops.RES0e
  Z80._ops.RES0h
  Z80._ops.RES0l
  Z80._ops.RES0m
  Z80._ops.RES0a
  Z80._ops.RES1b
  Z80._ops.RES1c
  Z80._ops.RES1d
  Z80._ops.RES1e
  Z80._ops.RES1h
  Z80._ops.RES1l
  Z80._ops.RES1m
  Z80._ops.RES1a
  
  # CB90
  Z80._ops.RES2b
  Z80._ops.RES2c
  Z80._ops.RES2d
  Z80._ops.RES2e
  Z80._ops.RES2h
  Z80._ops.RES2l
  Z80._ops.RES2m
  Z80._ops.RES2a
  Z80._ops.RES3b
  Z80._ops.RES3c
  Z80._ops.RES3d
  Z80._ops.RES3e
  Z80._ops.RES3h
  Z80._ops.RES3l
  Z80._ops.RES3m
  Z80._ops.RES3a
  
  # CBA0
  Z80._ops.RES4b
  Z80._ops.RES4c
  Z80._ops.RES4d
  Z80._ops.RES4e
  Z80._ops.RES4h
  Z80._ops.RES4l
  Z80._ops.RES4m
  Z80._ops.RES4a
  Z80._ops.RES5b
  Z80._ops.RES5c
  Z80._ops.RES5d
  Z80._ops.RES5e
  Z80._ops.RES5h
  Z80._ops.RES5l
  Z80._ops.RES5m
  Z80._ops.RES5a
  
  # CBB0
  Z80._ops.RES6b
  Z80._ops.RES6c
  Z80._ops.RES6d
  Z80._ops.RES6e
  Z80._ops.RES6h
  Z80._ops.RES6l
  Z80._ops.RES6m
  Z80._ops.RES6a
  Z80._ops.RES7b
  Z80._ops.RES7c
  Z80._ops.RES7d
  Z80._ops.RES7e
  Z80._ops.RES7h
  Z80._ops.RES7l
  Z80._ops.RES7m
  Z80._ops.RES7a
  
  # CBC0
  Z80._ops.SET0b
  Z80._ops.SET0c
  Z80._ops.SET0d
  Z80._ops.SET0e
  Z80._ops.SET0h
  Z80._ops.SET0l
  Z80._ops.SET0m
  Z80._ops.SET0a
  Z80._ops.SET1b
  Z80._ops.SET1c
  Z80._ops.SET1d
  Z80._ops.SET1e
  Z80._ops.SET1h
  Z80._ops.SET1l
  Z80._ops.SET1m
  Z80._ops.SET1a
  
  # CBD0
  Z80._ops.SET2b
  Z80._ops.SET2c
  Z80._ops.SET2d
  Z80._ops.SET2e
  Z80._ops.SET2h
  Z80._ops.SET2l
  Z80._ops.SET2m
  Z80._ops.SET2a
  Z80._ops.SET3b
  Z80._ops.SET3c
  Z80._ops.SET3d
  Z80._ops.SET3e
  Z80._ops.SET3h
  Z80._ops.SET3l
  Z80._ops.SET3m
  Z80._ops.SET3a
  
  # CBE0
  Z80._ops.SET4b
  Z80._ops.SET4c
  Z80._ops.SET4d
  Z80._ops.SET4e
  Z80._ops.SET4h
  Z80._ops.SET4l
  Z80._ops.SET4m
  Z80._ops.SET4a
  Z80._ops.SET5b
  Z80._ops.SET5c
  Z80._ops.SET5d
  Z80._ops.SET5e
  Z80._ops.SET5h
  Z80._ops.SET5l
  Z80._ops.SET5m
  Z80._ops.SET5a
  
  # CBF0
  Z80._ops.SET6b
  Z80._ops.SET6c
  Z80._ops.SET6d
  Z80._ops.SET6e
  Z80._ops.SET6h
  Z80._ops.SET6l
  Z80._ops.SET6m
  Z80._ops.SET6a
  Z80._ops.SET7b
  Z80._ops.SET7c
  Z80._ops.SET7d
  Z80._ops.SET7e
  Z80._ops.SET7h
  Z80._ops.SET7l
  Z80._ops.SET7m
  Z80._ops.SET7a
]
