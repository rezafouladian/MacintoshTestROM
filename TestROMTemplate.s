; Machine definitions 
    IFND MacPlus
MacPlus     EQU     0
    ENDIF

    IFND PreMacPlus
PreMacPlus  EQU     0
    ENDIF

    IFND MacSE
MacSE     EQU     0
    ENDIF

    IFND Portable
Portable  EQU     0
    ENDIF

    IFND MacII
MacII  EQU     0
    ENDIF

    IFND SE30
SE30  EQU     0
    ENDIF

    IF MacPlus
VIAOverlay  EQU     1
Proc68000   EQU     1
VBase       EQU     $EFE1FE
    ENDIF

    IF PreMacPlus
VIAOverlay  EQU     1
Proc68000   EQU     1
VBase       EQU     $EFE1FE
    ENDIF

    IF MacSE
VIAOverlay  EQU     0
Proc68000   EQU     1
VBase       EQU     $EFE1FE
    ENDIF

    IF Portable
VIAOverlay  EQU     0
Proc68000   EQU     1
VBase       EQU     $F70000
    ENDIF

    IF MacII
VIAOverlay  EQU     1
Proc68000   EQU     0
VBase       EQU     $50F00000
    ENDIF

    IF SE30
VIAOverlay  EQU     1
Proc68000   EQU     0
VBase       EQU     $50F00000
    ENDIF

    IFND VIAOverlay
VIAOverlay  EQU     1
    ENDIF

    IFND Proc68000
Proc68000   EQU     1
    ENDIF

    IF Proc68000
TROMCode    EQU     $55AAAA55
    ELSE
TROMCode    EQU     $AAAA5555
    ENDIF

vDIRA       EQU     $600
vBufA       EQU     $1E00

    org     $F80000
    dc.l    TROMCode
    dc.l    ColdEntry

    org     $F80080
    dc.l    TROMCode
    dc.l    WarmEntry

; ColdEntry
; Called early in ROM, usually before any startup tests or setup is done.
;
; Inputs    A1  Return address from caller
;
; Note: The return address is not provided in the Macintosh Plus and below.
ColdEntry:
    ; On systems that control the overlay with the VIA, we need to clear the
    ; overlay bit to gain access to RAM.
    IF VIAOverlay
    movea.l #VBase,A0
    move.b  #%01101111,(vBufA,A0)   ; Clear the overlay bit
    move.b  #%01111111,(vDIRA,A0)   ; Set outputs
    ENDIF

    ; Your code here

    bra     ExitToROM

; WarmEntry
; Called later in ROM, usually after initial tests have run.
;
; Inputs    A1  Return address from caller
WarmEntry:

    ; Your code here

    bra     ExitToROM

; ExitToROM
ExitToROM:
    IF MacPlus
    movea.l #$400062,A1
    ENDIF
    IF PreMacPlus
    movea.l #$400044,A1
    ENDIF

    jmp     (A1)                    ; Return to the original ROM