TIMER =
  _div: 0
  _tma: 0
  _tima: 0
  _tac: 0
  _clock:
    main: 0
    sub: 0
    div: 0

  reset: ->
    TIMER._div = 0
    TIMER._sdiv = 0
    TIMER._tma = 0
    TIMER._tima = 0
    TIMER._tac = 0
    TIMER._clock.main = 0
    TIMER._clock.sub = 0
    TIMER._clock.div = 0

  step: ->
    TIMER._tima++
    TIMER._clock.main = 0
    if TIMER._tima > 255
      TIMER._tima = TIMER._tma
      MMU._if |= 4

  inc: ->
    oldclk = TIMER._clock.main
    TIMER._clock.sub += Z80._r.m
    if TIMER._clock.sub > 3
      TIMER._clock.main++
      TIMER._clock.sub -= 4
      TIMER._clock.div++
      if TIMER._clock.div is 16
        TIMER._clock.div = 0
        TIMER._div++
        TIMER._div &= 255
    if TIMER._tac & 4
      switch TIMER._tac & 3
        when 0
          TIMER.step()  if TIMER._clock.main >= 64
        when 1
          TIMER.step()  if TIMER._clock.main >= 1
        when 2
          TIMER.step()  if TIMER._clock.main >= 4
        when 3
          TIMER.step()  if TIMER._clock.main >= 16

  rb: (addr) ->
    switch addr
      when 0xFF04
        TIMER._div
      when 0xFF05
        TIMER._tima
      when 0xFF06
        TIMER._tma
      when 0xFF07
        TIMER._tac

  wb: (addr, val) ->
    switch addr
      when 0xFF04
        TIMER._div = 0
      when 0xFF05
        TIMER._tima = val
      when 0xFF06
        TIMER._tma = val
      when 0xFF07
        TIMER._tac = val & 7
