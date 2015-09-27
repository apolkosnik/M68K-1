;===================================================================
; ASM Test : Bitfields - BFEXTS
; S C:\Users\FORMATION\Desktop\output12.txt 402821b2 1800
;===================================================================

nvalues EQU 96
noffset EQU 16

assert_zero EQU $00D0000C   ; magical register

;===================================================================
; Main
;===================================================================

Start:
    clr.l  d0               ; loopValues counter
    clr.l  d1               ; loopOffset counter
    clr.l  d2               ; value
    clr.l  d3               ; bitfield offset
    clr.l  d4               ; result of bfffo value{offset,width}
    clr.l  d5               ; bitfield width
    clr.l  d6               ; total counter
    clr.l  d7               ; error counter

Test:
    lea    precalc,a3       ; addr of precalculated values
    lea    calc,a2          ; addr of calculated values
    lea    values,a0        ; addr of values
    move.l #nvalues-1,d0    ; init loopValues
.LoopValues
    lea    offsets,a1       ; addr of bitfield offsets
    move.l #noffset-1,d1    ; init loopOffset
    move.l (a0)+,d2         ; read value
.LoopOffset
    move.l (a1)+,d3         ; read offset
    bfffo  d2{d3:d3},d4     ; bitfield operation
    move.l d4,(a2)+         ; store calculated value
    sub.l  (a3)+,d4         ; compare with precalculated value
    beq    .Continue        ; if d4=0, continue
    addi.l #1,d7            ; else, increment error counter
.Continue
    move.l d4,assert_zero   ; raise error if d1!=0
    addi.l #1,d6            ; increment total counter
    dbf    d1,.LoopOffset   ; continue next offset
    dbf    d0,.LoopValues   ; continue next value
    stop   #-1              ; stop execution

;===================================================================
; Data Section
;===================================================================

offsets:
    dc.l $00000000,$00000001,$00000010,$0000001F,$00000020,$00000064,$00007FFF,$00008000
    dc.l $F0000001,$F000000F,$7F000001,$00007FFF,$F0000001,$F000000F,$7F000001,$FFFFFFFF

values:
    dc.l $00F4935E,$566A2A6F,$7A000039,$80000000,$5971EA00,$6B12A274,$D64AF24E,$9CE17300
    dc.l $0000111F,$64B61101,$E0000003,$88000000,$5D89DEB5,$864BC620,$42FE4169,$E7F40000
    dc.l $00000026,$F546BB18,$F000000F,$88880000,$C7F335F0,$8578D728,$01EDE38F,$30000000
    dc.l $D5544B00,$5091947B,$FF0000FF,$80000001,$7D597244,$84F55AE1,$56CAC740,$00DF7EB6
    dc.l $1ECE0000,$512AFB69,$10000001,$8000000F,$13CDC29C,$3BB4E0D6,$6B6EF26D,$00007019
    dc.l $48000000,$9DE5939E,$11000011,$800000FF,$62F2F116,$9923656B,$1199FD45,$000000DF
    dc.l $00FF0406,$E1636604,$11000000,$780000AA,$9F6E424C,$614F83C9,$9595D7E0,$D1AEC200
    dc.l $0000066D,$084F4FF7,$00000011,$70CEA72F,$8F76FFFF,$5AB4712D,$12980239,$59860000
    dc.l $00000079,$919F31D9,$7F000000,$C1342722,$6420A82D,$E469F0FE,$412D1C1B,$45000000
    dc.l $B4295F98,$9BD1116E,$7FFF0000,$7FFFFF00,$74444444,$7FFFFFFF,$0000000F,$10101010
    dc.l $61ABA155,$55A569F4,$0000007F,$016321F7,$B1AF6E4A,$97085A57,$00C00001,$24E8A34A
    dc.l $FFFFFFFF,$66666666,$EEEEEEEE,$44444444,$33333333,$BBBBBBBB,$11111111,$00000000

calc:
    ds.l nvalues*noffset

precalc:
    dc.l $00000008,$00000002,$00000010,$00000028,$00000008,$00000008,$00000028,$00000008
    dc.l $00000002,$00000010,$00000002,$00000028,$00000002,$00000010,$00000002,$00000028
    dc.l $00000001,$00000001,$00000012,$0000001F,$00000001,$00000005,$0000001F,$00000001
    dc.l $00000001,$00000012,$00000001,$0000001F,$00000001,$00000012,$00000001,$0000001F
    dc.l $00000001,$00000001,$0000001A,$0000001F,$00000001,$00000004,$0000001F,$00000001
    dc.l $00000001,$0000001A,$00000001,$0000001F,$00000001,$0000001A,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000020,$00000020,$00000000,$00000008,$00000020,$00000000
    dc.l $00000002,$0000001E,$00000002,$00000020,$00000002,$0000001E,$00000002,$00000020
    dc.l $00000001,$00000001,$00000010,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000000F,$00000001,$00000021,$00000001,$0000000F,$00000001,$00000021
    dc.l $00000001,$00000001,$00000010,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$00000010,$00000001,$00000021,$00000001,$00000010,$00000001,$00000021
    dc.l $00000000,$00000001,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$00000010,$00000001,$00000020,$00000001,$00000010,$00000001,$00000020
    dc.l $00000000,$00000002,$00000011,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000013,$00000002,$00000013,$0000001F,$00000013,$00000008,$0000001F,$00000013
    dc.l $00000002,$00000013,$00000002,$0000001F,$00000002,$00000013,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000013,$0000001F,$00000001,$00000005,$0000001F,$00000001
    dc.l $00000001,$00000013,$00000001,$0000001F,$00000001,$00000013,$00000001,$0000001F
    dc.l $00000000,$00000001,$0000001E,$0000001F,$00000000,$00000008,$0000001F,$00000000
    dc.l $00000001,$0000001E,$00000001,$0000001F,$00000001,$0000001E,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000020,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$0000001E,$00000002,$00000020,$00000002,$0000001E,$00000002,$00000020
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000004,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000001,$00000001,$00000011,$0000001F,$00000001,$00000006,$0000001F,$00000001
    dc.l $00000001,$00000011,$00000001,$0000001F,$00000001,$00000011,$00000001,$0000001F
    dc.l $00000000,$00000001,$00000020,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$0000001E,$00000001,$00000020,$00000001,$0000001E,$00000001,$00000020
    dc.l $0000001A,$00000002,$0000001A,$0000003A,$0000001A,$00000008,$0000003A,$0000001A
    dc.l $00000002,$0000001A,$00000002,$0000003A,$00000002,$0000001A,$00000002,$0000003A
    dc.l $00000000,$00000001,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$00000010,$00000001,$00000020,$00000001,$00000010,$00000001,$00000020
    dc.l $00000000,$00000001,$0000001C,$0000001F,$00000000,$00000008,$0000001F,$00000000
    dc.l $00000001,$0000001C,$00000001,$0000001F,$00000001,$0000001C,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000020,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$0000001E,$00000002,$00000020,$00000002,$0000001E,$00000002,$00000020
    dc.l $00000000,$00000001,$00000012,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$0000000F,$00000001,$00000020,$00000001,$0000000F,$00000001,$00000020
    dc.l $00000000,$00000002,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000002,$00000010,$00000002,$00000020,$00000002,$00000010,$00000002,$00000020
    dc.l $00000007,$00000002,$00000010,$0000001F,$00000007,$00000007,$0000001F,$00000007
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000002,$00000002,$00000020,$00000022,$00000002,$00000008,$00000022,$00000002
    dc.l $00000002,$0000001E,$00000002,$00000022,$00000002,$0000001E,$00000002,$00000022
    dc.l $00000000,$00000001,$00000011,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$00000011,$00000001,$00000020,$00000001,$00000011,$00000001,$00000020
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000008,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000000,$00000001,$00000018,$0000001F,$00000000,$00000004,$0000001F,$00000000
    dc.l $00000001,$00000018,$00000001,$0000001F,$00000001,$00000018,$00000001,$0000001F
    dc.l $00000000,$00000002,$0000001F,$0000001F,$00000000,$00000008,$0000001F,$00000000
    dc.l $00000002,$0000001E,$00000002,$0000001F,$00000002,$0000001E,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000011,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000000F,$00000001,$00000021,$00000001,$0000000F,$00000001,$00000021
    dc.l $00000000,$00000002,$00000011,$0000001F,$00000000,$00000005,$0000001F,$00000000
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000010,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$00000010,$00000001,$00000021,$00000001,$00000010,$00000001,$00000021
    dc.l $00000008,$00000002,$00000011,$00000028,$00000008,$00000008,$00000028,$00000008
    dc.l $00000002,$0000000F,$00000002,$00000028,$00000002,$0000000F,$00000002,$00000028
    dc.l $00000003,$00000002,$00000020,$00000023,$00000003,$00000004,$00000023,$00000003
    dc.l $00000002,$0000001E,$00000002,$00000023,$00000002,$0000001E,$00000002,$00000023
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000007,$0000001F,$00000001
    dc.l $00000001,$00000010,$00000001,$0000001F,$00000001,$00000010,$00000001,$0000001F
    dc.l $00000003,$00000002,$0000001F,$0000001F,$00000003,$00000008,$0000001F,$00000003
    dc.l $00000002,$0000001E,$00000002,$0000001F,$00000002,$0000001E,$00000002,$0000001F
    dc.l $00000000,$00000002,$0000001C,$0000001F,$00000000,$00000008,$0000001F,$00000000
    dc.l $00000002,$0000001C,$00000002,$0000001F,$00000002,$0000001C,$00000002,$0000001F
    dc.l $00000003,$00000002,$00000010,$00000023,$00000003,$00000006,$00000023,$00000003
    dc.l $00000002,$0000000F,$00000002,$00000023,$00000002,$0000000F,$00000002,$00000023
    dc.l $00000002,$00000002,$00000010,$00000022,$00000002,$00000004,$00000022,$00000002
    dc.l $00000002,$00000010,$00000002,$00000022,$00000002,$00000010,$00000002,$00000022
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000004,$0000001F,$00000001
    dc.l $00000001,$00000010,$00000001,$0000001F,$00000001,$00000010,$00000001,$0000001F
    dc.l $00000011,$00000002,$00000011,$0000001F,$00000011,$00000008,$0000001F,$00000011
    dc.l $00000002,$00000011,$00000002,$0000001F,$00000002,$00000011,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000020,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000001E,$00000001,$00000021,$00000001,$0000001E,$00000001,$00000021
    dc.l $00000000,$00000002,$00000010,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000003,$00000002,$0000001B,$0000001F,$00000003,$00000007,$0000001F,$00000003
    dc.l $00000002,$0000001B,$00000002,$0000001F,$00000002,$0000001B,$00000002,$0000001F
    dc.l $00000000,$00000002,$00000018,$0000001F,$00000000,$00000008,$0000001F,$00000000
    dc.l $00000002,$00000018,$00000002,$0000001F,$00000002,$00000018,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000010,$00000021,$00000001,$00000006,$00000021,$00000001
    dc.l $00000001,$00000010,$00000001,$00000021,$00000001,$00000010,$00000001,$00000021
    dc.l $00000000,$00000002,$00000011,$0000001F,$00000000,$00000004,$0000001F,$00000000
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000003,$00000002,$00000010,$0000001F,$00000003,$00000007,$0000001F,$00000003
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000018,$00000002,$00000018,$0000001F,$00000018,$00000008,$0000001F,$00000018
    dc.l $00000002,$00000018,$00000002,$0000001F,$00000002,$00000018,$00000002,$0000001F
    dc.l $00000008,$00000002,$00000015,$00000028,$00000008,$00000008,$00000028,$00000008
    dc.l $00000002,$0000000F,$00000002,$00000028,$00000002,$0000000F,$00000002,$00000028
    dc.l $00000000,$00000001,$00000011,$00000020,$00000000,$00000007,$00000020,$00000000
    dc.l $00000001,$0000000F,$00000001,$00000020,$00000001,$0000000F,$00000001,$00000020
    dc.l $00000003,$00000002,$00000020,$00000023,$00000003,$00000007,$00000023,$00000003
    dc.l $00000002,$0000001E,$00000002,$00000023,$00000002,$0000001E,$00000002,$00000023
    dc.l $00000001,$00000001,$00000018,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$00000018,$00000001,$00000021,$00000001,$00000018,$00000001,$00000021
    dc.l $00000000,$00000002,$00000011,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$00000011,$00000002,$00000020,$00000002,$00000011,$00000002,$00000020
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000007,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000000,$00000001,$00000010,$00000020,$00000000,$00000007,$00000020,$00000000
    dc.l $00000001,$00000010,$00000001,$00000020,$00000001,$00000010,$00000001,$00000020
    dc.l $00000015,$00000002,$00000015,$0000001F,$00000015,$00000008,$0000001F,$00000015
    dc.l $00000002,$00000015,$00000002,$0000001F,$00000002,$00000015,$00000002,$0000001F
    dc.l $00000004,$00000002,$00000011,$0000001F,$00000004,$00000004,$0000001F,$00000004
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $0000001B,$00000002,$0000001B,$0000001F,$0000001B,$00000008,$0000001F,$0000001B
    dc.l $00000002,$0000001B,$00000002,$0000001F,$00000002,$0000001B,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000008,$0000001F,$00000001
    dc.l $00000001,$00000010,$00000001,$0000001F,$00000001,$00000010,$00000001,$0000001F
    dc.l $00000000,$00000002,$00000010,$0000001F,$00000000,$00000004,$0000001F,$00000000
    dc.l $00000002,$00000010,$00000002,$0000001F,$00000002,$00000010,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000011,$0000001F,$00000001,$00000004,$0000001F,$00000001
    dc.l $00000001,$00000011,$00000001,$0000001F,$00000001,$00000011,$00000001,$0000001F
    dc.l $00000003,$00000002,$00000016,$0000001F,$00000003,$00000006,$0000001F,$00000003
    dc.l $00000002,$00000016,$00000002,$0000001F,$00000002,$00000016,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000020,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000001E,$00000001,$00000021,$00000001,$0000001E,$00000001,$00000021
    dc.l $00000019,$00000002,$00000019,$0000001F,$00000019,$00000008,$0000001F,$00000019
    dc.l $00000002,$00000019,$00000002,$0000001F,$00000002,$00000019,$00000002,$0000001F
    dc.l $00000000,$00000002,$00000012,$0000001F,$00000000,$00000007,$0000001F,$00000000
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000001,$00000001,$00000020,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000001E,$00000001,$00000021,$00000001,$0000001E,$00000001,$00000021
    dc.l $00000000,$00000001,$00000012,$00000020,$00000000,$00000007,$00000020,$00000000
    dc.l $00000001,$00000012,$00000001,$00000020,$00000001,$00000012,$00000001,$00000020
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000005,$0000001F,$00000001
    dc.l $00000001,$00000010,$00000001,$0000001F,$00000001,$00000010,$00000001,$0000001F
    dc.l $00000000,$00000001,$00000010,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000001,$0000000F,$00000001,$00000020,$00000001,$0000000F,$00000001,$00000020
    dc.l $00000001,$00000001,$00000013,$0000001F,$00000001,$00000007,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000001,$00000001,$00000020,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$0000001E,$00000001,$00000021,$00000001,$0000001E,$00000001,$00000021
    dc.l $00000000,$00000002,$00000011,$00000020,$00000000,$00000005,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000000,$00000002,$00000013,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000001,$00000001,$00000020,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000000F,$00000001,$00000021,$00000001,$0000000F,$00000001,$00000021
    dc.l $00000001,$00000001,$00000010,$00000021,$00000001,$00000004,$00000021,$00000001
    dc.l $00000001,$0000000F,$00000001,$00000021,$00000001,$0000000F,$00000001,$00000021
    dc.l $00000001,$00000001,$00000011,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$00000011,$00000001,$00000021,$00000001,$00000011,$00000001,$00000021
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000004,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $0000001C,$00000002,$0000001C,$0000001F,$0000001C,$00000008,$0000001F,$0000001C
    dc.l $00000002,$0000001C,$00000002,$0000001F,$00000002,$0000001C,$00000002,$0000001F
    dc.l $00000003,$00000002,$00000013,$00000023,$00000003,$00000008,$00000023,$00000003
    dc.l $00000002,$00000013,$00000002,$00000023,$00000002,$00000013,$00000002,$00000023
    dc.l $00000001,$00000001,$00000010,$0000001F,$00000001,$00000007,$0000001F,$00000001
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000001,$00000001,$00000011,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$0000000F,$00000001,$00000021,$00000001,$0000000F,$00000001,$00000021
    dc.l $00000019,$00000002,$00000019,$0000001F,$00000019,$00000008,$0000001F,$00000019
    dc.l $00000002,$00000019,$00000002,$0000001F,$00000002,$00000019,$00000002,$0000001F
    dc.l $00000007,$00000002,$00000012,$0000001F,$00000007,$00000007,$0000001F,$00000007
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000000,$00000002,$00000011,$00000020,$00000000,$00000007,$00000020,$00000000
    dc.l $00000002,$0000000F,$00000002,$00000020,$00000002,$0000000F,$00000002,$00000020
    dc.l $00000000,$00000002,$00000011,$0000001F,$00000000,$00000005,$0000001F,$00000000
    dc.l $00000002,$00000011,$00000002,$0000001F,$00000002,$00000011,$00000002,$0000001F
    dc.l $00000008,$00000002,$0000001F,$0000001F,$00000008,$00000008,$0000001F,$00000008
    dc.l $00000002,$0000001E,$00000002,$0000001F,$00000002,$0000001E,$00000002,$0000001F
    dc.l $00000002,$00000002,$00000010,$00000022,$00000002,$00000005,$00000022,$00000002
    dc.l $00000002,$00000010,$00000002,$00000022,$00000002,$00000010,$00000002,$00000022
    dc.l $00000000,$00000001,$00000010,$0000001F,$00000000,$00000004,$0000001F,$00000000
    dc.l $00000001,$0000000F,$00000001,$0000001F,$00000001,$0000000F,$00000001,$0000001F
    dc.l $00000001,$00000001,$00000011,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$00000011,$00000001,$00000021,$00000001,$00000011,$00000001,$00000021
    dc.l $00000000,$00000001,$00000010,$00000020,$00000000,$00000004,$00000020,$00000000
    dc.l $00000001,$00000010,$00000001,$00000020,$00000001,$00000010,$00000001,$00000020
    dc.l $00000001,$00000001,$00000011,$00000021,$00000001,$00000005,$00000021,$00000001
    dc.l $00000001,$00000011,$00000001,$00000021,$00000001,$00000011,$00000001,$00000021
    dc.l $00000002,$00000002,$00000012,$0000001F,$00000002,$00000006,$0000001F,$00000002
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000000,$00000002,$00000010,$0000001F,$00000000,$00000004,$0000001F,$00000000
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000003,$00000002,$00000013,$0000001F,$00000003,$00000007,$0000001F,$00000003
    dc.l $00000002,$0000000F,$00000002,$0000001F,$00000002,$0000000F,$00000002,$0000001F
    dc.l $00000020,$00000002,$00000020,$0000003E,$00000020,$00000008,$0000003E,$00000020
    dc.l $00000002,$0000001E,$00000002,$0000003E,$00000002,$0000001E,$00000002,$0000003E

;===================================================================
; End of program
;===================================================================