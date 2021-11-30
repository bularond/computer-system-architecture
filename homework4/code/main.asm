global distance
global perimeterRectangle
global perimeterTriangle
global perimeterCircle
global perimeterShape
global perimeterContainer
global sortContainer
global randomPoint
global randomRectangle
global randomTriangle
global randomCircle
global randomColor
global randomShape
global randomContainer
global readInt
global readRectangle
global readTriangle
global readCircle
global readShape
global readContainer
global printRectangle
global printTriangle
global printCircle
global printColor
global printShape
global printContainer
global printHelp
global main

extern srand
extern time
extern atoi
extern fopen
extern strcmp
extern exit
extern puts
extern fwrite
extern fprintf
extern getc
extern feof
extern fgetc
extern rand

extern sqrt


SECTION .text

distance:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax]
        mov     rax, qword [rbp-10H]
        mov     eax, dword [rax]
        sub     edx, eax
        mov     rax, qword [rbp-8H]
        mov     ecx, dword [rax]
        mov     rax, qword [rbp-10H]
        mov     esi, dword [rax]
        mov     eax, ecx
        sub     eax, esi
        mov     esi, edx
        imul    esi, eax
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax+4H]
        mov     rax, qword [rbp-10H]
        mov     eax, dword [rax+4H]
        sub     edx, eax
        mov     rax, qword [rbp-8H]
        mov     ecx, dword [rax+4H]
        mov     rax, qword [rbp-10H]
        mov     edi, dword [rax+4H]
        mov     eax, ecx
        sub     eax, edi
        imul    eax, edx
        add     eax, esi
        vcvtsi2sd xmm1, xmm1, eax
        vmovq   rax, xmm1
        vmovq   xmm0, rax
        call    sqrt
        vmovq   rax, xmm0
        vmovq   xmm0, rax
        leave
        ret


perimeterRectangle:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax+8H]
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax]
        mov     ecx, edx
        sub     ecx, eax
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax+0CH]
        mov     rax, qword [rbp-8H]
        mov     esi, dword [rax+4H]
        mov     eax, edx
        sub     eax, esi
        add     eax, ecx
        add     eax, eax
        vcvtsi2sd xmm0, xmm0, eax
        vmovq   rax, xmm0
        vmovq   xmm0, rax
        pop     rbp
        ret


perimeterTriangle:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 24
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+8H]
        mov     rax, qword [rbp-18H]
        mov     rsi, rdx
        mov     rdi, rax
        call    distance
        vmovq   rbx, xmm0
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+8H]
        mov     rax, qword [rbp-18H]
        mov     rsi, rdx
        mov     rdi, rax
        call    distance
        vmovq   rax, xmm0
        vmovq   xmm2, rbx
        vmovq   xmm3, rax
        vaddsd  xmm1, xmm2, xmm3
        vmovsd  qword [rbp-20H], xmm1
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+10H]
        mov     rax, qword [rbp-18H]
        add     rax, 8
        mov     rsi, rdx
        mov     rdi, rax
        call    distance
        vmovq   rax, xmm0
        vmovq   xmm4, rax
        vaddsd  xmm0, xmm4, qword [rbp-20H]
        vmovq   rax, xmm0
        vmovq   xmm0, rax
        mov     rbx, qword [rbp-8H]
        leave
        ret


perimeterCircle:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+8H]
        vcvtsi2sd xmm0, xmm0, eax
        vmovsd  xmm1, qword [rel doublePi]
        vmulsd  xmm0, xmm0, xmm1
        vmovq   rax, xmm0
        vmovq   xmm0, rax
        pop     rbp
        ret


perimeterShape:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 1
        jnz     perimeterShapeTriangle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    perimeterRectangle
        vmovq   rax, xmm0
        jmp     PerimeterShapeOut
perimeterShapeTriangle:
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 2
        jnz     perimeterShapeCircle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    perimeterTriangle
        vmovq   rax, xmm0
        jmp     PerimeterShapeOut
perimeterShapeCircle:
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    perimeterCircle
        vmovq   rax, xmm0
PerimeterShapeOut:
        vmovq   xmm0, rax
        leave
        ret


perimeterContainer:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        vxorpd  xmm0, xmm0, xmm0
        vmovsd  qword [rbp-8H], xmm0
        mov     dword [rbp-0CH], 0
        jmp     perimeterContainerEndLoop
perimeterContainerLoop:
        mov     eax, dword [rbp-0CH]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-18H]
        add     rax, rdx
        add     rax, 4
        mov     rdi, rax
        call    perimeterShape
        vmovq   rax, xmm0
        vmovsd  xmm0, qword [rbp-8H]
        vmovq   xmm1, rax
        vaddsd  xmm0, xmm0, xmm1
        vmovsd  qword [rbp-8H], xmm0
        add     qword [rbp-18H], 320004
perimeterContainerEndLoop:
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]
        cmp     dword [rbp-0CH], eax
        jl      perimeterContainerLoop
        vmovsd  xmm0, qword [rbp-8H]
        vmovq   rax, xmm0
        vmovq   xmm0, rax
        leave
        ret


sortContainer:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 72
        mov     qword [rbp-48H], rdi
        mov     dword [rbp-14H], 0
        jmp     sortContainerLoopOneOut
sortContainerLoopOne:
        mov     eax, dword [rbp-14H]
        mov     dword [rbp-1CH], eax
        mov     eax, dword [rbp-14H]
        inc     eax
        mov     dword [rbp-18H], eax
        jmp     sortContainerLoopTwoOut
sortContainerLoopTwo:
        mov     eax, dword [rbp-18H]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-48H]
        add     rax, rdx
        add     rax, 4
        mov     rdi, rax
        call    perimeterShape
        vmovq   rbx, xmm0
        mov     eax, dword [rbp-1CH]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-48H]
        add     rax, rdx
        add     rax, 4
        mov     rdi, rax
        call    perimeterShape
        vmovq   rax, xmm0
        vmovq   xmm1, rbx
        vmovq   xmm2, rax
        vcomisd xmm1, xmm2
        jbe     sortContainerSwap
        mov     eax, dword [rbp-18H]
        mov     dword [rbp-1CH], eax
sortContainerSwap:
        inc     dword [rbp-18H]
sortContainerLoopTwoOut:
        mov     rax, qword [rbp-48H]
        mov     eax, dword [rax]
        cmp     dword [rbp-18H], eax
        jl      sortContainerLoopTwo
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-14H]
        cdqe
        shl     rax, 5
        lea     rcx, [rdx+rax]
        mov     rax, qword [rcx+4H]
        mov     rdx, qword [rcx+0CH]
        mov     qword [rbp-40H], rax
        mov     qword [rbp-38H], rdx
        mov     rax, qword [rcx+14H]
        mov     rdx, qword [rcx+1CH]
        mov     qword [rbp-30H], rax
        mov     qword [rbp-28H], rdx
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-14H]
        cdqe
        shl     rax, 5
        lea     rcx, [rdx+rax]
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-1CH]
        cdqe
        shl     rax, 5
        lea     rsi, [rdx+rax]
        mov     rax, qword [rsi+4H]
        mov     rdx, qword [rsi+0CH]
        mov     qword [rcx+4H], rax
        mov     qword [rcx+0CH], rdx
        mov     rax, qword [rsi+14H]
        mov     rdx, qword [rsi+1CH]
        mov     qword [rcx+14H], rax
        mov     qword [rcx+1CH], rdx
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-1CH]
        cdqe
        shl     rax, 5
        lea     rcx, [rdx+rax]
        mov     rax, qword [rbp-40H]
        mov     rdx, qword [rbp-38H]
        mov     qword [rcx+4H], rax
        mov     qword [rcx+0CH], rdx
        mov     rax, qword [rbp-30H]
        mov     rdx, qword [rbp-28H]
        mov     qword [rcx+14H], rax
        mov     qword [rcx+1CH], rdx
        inc     dword [rbp-14H]
sortContainerLoopOneOut:
        mov     rax, qword [rbp-48H]
        mov     eax, dword [rax]
        cmp     dword [rbp-14H], eax
        jl      sortContainerLoopOne
        nop
        nop
        mov     rbx, qword [rbp-8H]
        leave
        ret


randomPoint:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        call    rand
        mov     edx, eax
        movsxd  rax, edx
        imul    rax, rax, -2004318071
        shr     rax, 32
        add     eax, edx
        sar     eax, 4
        mov     ecx, edx
        sar     ecx, 31
        sub     eax, ecx
        imul    ecx, eax, 30
        mov     eax, edx
        sub     eax, ecx
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx], eax
        call    rand
        mov     edx, eax
        movsxd  rax, edx
        imul    rax, rax, -2004318071
        shr     rax, 32
        add     eax, edx
        sar     eax, 4
        mov     ecx, edx
        sar     ecx, 31
        sub     eax, ecx
        imul    ecx, eax, 30
        mov     eax, edx
        sub     eax, ecx
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+4H], eax
        nop
        leave
        ret


randomRectangle:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 24
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        mov     rdi, rax
        call    randomPoint
        mov     rax, qword [rbp-18H]
        mov     ebx, dword [rax]
        call    rand
        mov     edx, eax
        movsxd  rax, edx
        imul    rax, rax, 1717986919
        shr     rax, 32
        sar     eax, 3
        mov     esi, edx
        sar     esi, 31
        sub     eax, esi
        mov     ecx, eax
        mov     eax, ecx
        shl     eax, 2
        add     eax, ecx
        shl     eax, 2
        mov     ecx, edx
        sub     ecx, eax
        lea     eax, [rbx+rcx]
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-18H]
        mov     dword [rax+8H], edx
        mov     rax, qword [rbp-18H]
        mov     ebx, dword [rax+4H]
        call    rand
        mov     edx, eax
        movsxd  rax, edx
        imul    rax, rax, 1717986919
        shr     rax, 32
        sar     eax, 3
        mov     esi, edx
        sar     esi, 31
        sub     eax, esi
        mov     ecx, eax
        mov     eax, ecx
        shl     eax, 2
        add     eax, ecx
        shl     eax, 2
        sub     edx, eax
        mov     ecx, edx
        lea     eax, [rbx+rcx]
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-18H]
        mov     dword [rax+0CH], edx
        nop
        mov     rbx, qword [rbp-8H]
        leave
        ret


randomTriangle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    randomPoint
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    randomPoint
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax]
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+8H]
        add     edx, eax
        mov     rax, qword [rbp-8H]
        mov     dword [rax+10H], edx
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax+4H]
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+0CH]
        add     edx, eax
        mov     rax, qword [rbp-8H]
        mov     dword [rax+14H], edx
        nop
        leave
        ret


randomCircle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    randomPoint
        call    rand
        mov     edx, eax
        movsxd  rax, edx
        imul    rax, rax, -1840700269
        shr     rax, 32
        add     eax, edx
        sar     eax, 2
        mov     ecx, edx
        sar     ecx, 31
        sub     eax, ecx
        mov     ecx, eax
        shl     ecx, 3
        sub     ecx, eax
        mov     eax, edx
        sub     eax, ecx
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-8H]
        mov     dword [rax+8H], edx
        nop
        leave
        ret


randomColor:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        call    rand
        movsxd  rdx, eax
        imul    rdx, rdx, -1840700269
        shr     rdx, 32
        add     edx, eax
        sar     edx, 2
        mov     ecx, eax
        sar     ecx, 31
        sub     edx, ecx
        mov     dword [rbp-4H], edx
        mov     ecx, dword [rbp-4H]
        mov     edx, ecx
        shl     edx, 3
        sub     edx, ecx
        sub     eax, edx
        mov     dword [rbp-4H], eax
        cmp     dword [rbp-4H], 0
        jnz     randomColorOrange
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 114
        jmp     randomColorOut
randomColorOrange:
        cmp     dword [rbp-4H], 1
        jnz     randomColorYellow
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 111
        jmp     randomColorOut
randomColorYellow:
        cmp     dword [rbp-4H], 2
        jnz     randomColorGreen
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 121
        jmp     randomColorOut
randomColorGreen:
        cmp     dword [rbp-4H], 3
        jnz     randomColorBlue
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 103
        jmp     randomColorOut
randomColorBlue:
        cmp     dword [rbp-4H], 4
        jnz     randomColorIndigo
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 98
        jmp     randomColorOut
randomColorIndigo:
        cmp     dword [rbp-4H], 5
        jnz     randomColorViolet
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 105
        jmp     randomColorOut
randomColorViolet:
        cmp     dword [rbp-4H], 6
        jnz     randomColorOut
        mov     rax, qword [rbp-18H]
        mov     byte [rax], 118
randomColorOut:
        nop
        leave
        ret


randomShape:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        call    rand
        mov     ecx, eax
        movsxd  rax, ecx
        imul    rax, rax, 1431655766
        shr     rax, 32
        mov     edx, ecx
        sar     edx, 31
        sub     eax, edx
        mov     edx, eax
        add     edx, edx
        add     edx, eax
        mov     eax, ecx
        sub     eax, edx
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-8H]
        mov     dword [rax+4H], edx
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    randomColor
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 1
        jnz     randomShapeTriangle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    randomRectangle
        jmp     randomShapeOut
randomShapeTriangle:
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 2
        jnz     randomShapeCircle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    randomTriangle
        jmp     randomShapeOut
randomShapeCircle:
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdi, rax
        call    randomCircle
randomShapeOut:  nop
        leave
        ret


randomContainer:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     dword [rbp-1CH], esi
        mov     rax, qword [rbp-18H]
        mov     edx, dword [rbp-1CH]
        mov     dword [rax], edx
        mov     dword [rbp-4H], 0
        jmp     randomContainerLoopEnd
randomContainerLoop:
        mov     eax, dword [rbp-4H]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-18H]
        add     rax, rdx
        add     rax, 4
        mov     rdi, rax
        call    randomShape
        inc     dword [rbp-4H]
randomContainerLoopEnd:
        mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-1CH]
        jl      randomContainerLoop
        nop
        nop
        leave
        ret


readInt:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     dword [rbp-4H], 0
readIntLoop:
        mov     rax, qword [rbp-18H]
        mov     rdi, rax
        call    fgetc
        mov     byte [rbp-5H], al
        mov     rax, qword [rbp-18H]
        mov     rdi, rax
        call    feof
        test    eax, eax
        jnz     readIntIf
        cmp     byte [rbp-5H], 32
        jz      readIntIf
        cmp     byte [rbp-5H], 10
        jnz     readIntContinue
readIntIf:
        mov     eax, dword [rbp-4H]
        jmp     readIntOut
readIntContinue:
        mov     edx, dword [rbp-4H]
        mov     eax, edx
        shl     eax, 2
        add     eax, edx
        add     eax, eax
        mov     dword [rbp-4H], eax
        movsx   eax, byte [rbp-5H]
        sub     eax, 48
        add     dword [rbp-4H], eax
        jmp     readIntLoop
readIntOut:
        leave
        ret


readRectangle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+4H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+8H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+0CH], eax
        nop
        leave
        ret


readTriangle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+4H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+8H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+0CH], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+10H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+14H], eax
        nop
        leave
        ret


readCircle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+4H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+8H], eax
        nop
        leave
        ret


readShape:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    readInt
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+4H], eax
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    getc
        mov     edx, eax
        mov     rax, qword [rbp-8H]
        mov     byte [rax], dl
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    getc
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 1
        jnz     readShapeTriangle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    readRectangle
        jmp     readShapeOut
readShapeTriangle:
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 2
        jnz     readShapeCircle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    readTriangle
        jmp     readShapeOut
readShapeCircle:
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    readCircle
readShapeOut:
        nop
        leave
        ret


readContainer:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        jmp     readContainerLoopEnd
readContainerLoop:
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-8H]
        add     rax, rdx
        add     rax, 4
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    readShape
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax]
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-8H]
        mov     dword [rax], edx
readContainerLoopEnd:
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    feof
        test    eax, eax
        jz      readContainerLoop
        nop
        leave
        ret


printRectangle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    perimeterRectangle
        vmovq   rax, xmm0
        mov     rdx, qword [rbp-8H]
        mov     r8d, dword [rdx+0CH]
        mov     rdx, qword [rbp-8H]
        mov     esi, dword [rdx+8H]
        mov     rdx, qword [rbp-8H]
        mov     ecx, dword [rdx+4H]
        mov     rdx, qword [rbp-8H]
        mov     edx, dword [rdx]
        mov     rdi, qword [rbp-10H]
        vmovq   xmm0, rax
        mov     r9d, r8d
        mov     r8d, esi
        lea     rax, [rel rectangleOutText]
        mov     rsi, rax
        mov     eax, 1
        call    fprintf
        nop
        leave
        ret


printTriangle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    perimeterTriangle
        vmovq   rax, xmm0
        mov     rdx, qword [rbp-8H]
        mov     r8d, dword [rdx+14H]
        mov     rdx, qword [rbp-8H]
        mov     esi, dword [rdx+10H]
        mov     rdx, qword [rbp-8H]
        mov     r9d, dword [rdx+0CH]
        mov     rdx, qword [rbp-8H]
        mov     r10d, dword [rdx+8H]
        mov     rdx, qword [rbp-8H]
        mov     ecx, dword [rdx+4H]
        mov     rdx, qword [rbp-8H]
        mov     edx, dword [rdx]
        mov     rdi, qword [rbp-10H]
        push    r8
        push    rsi
        vmovq   xmm0, rax
        mov     r8d, r10d
        lea     rax, [rel triangleTextOut]
        mov     rsi, rax
        mov     eax, 1
        call    fprintf
        add     rsp, 16
        nop
        leave
        ret


printCircle:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    perimeterCircle
        vmovq   rax, xmm0
        mov     rdx, qword [rbp-8H]
        mov     esi, dword [rdx+8H]
        mov     rdx, qword [rbp-8H]
        mov     ecx, dword [rdx+4H]
        mov     rdx, qword [rbp-8H]
        mov     edx, dword [rdx]
        mov     rdi, qword [rbp-10H]
        vmovq   xmm0, rax
        mov     r8d, esi
        lea     rax, [rel circleTextOut]
        mov     rsi, rax
        mov     eax, 1
        call    fprintf
        nop
        leave
        ret


printColor:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 9
        mov     esi, 1
        lea     rax, [rel colorIsText]
        mov     rdi, rax
        call    fwrite
        mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 114
        jnz     printColorOrange
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 4
        mov     esi, 1
        lea     rax, [rel redText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorOrange:
        mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 111
        jnz     printColorYellow
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 7
        mov     esi, 1
        lea     rax, [rel orangeText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorYellow:
        mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 121
        jnz     printColorGreen
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 7
        mov     esi, 1
        lea     rax, [rel yellowText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorGreen:  mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 103
        jnz     printColorBlue
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 6
        mov     esi, 1
        lea     rax, [rel greenText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorBlue:
        mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 98
        jnz     printColorIndigo
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 5
        mov     esi, 1
        lea     rax, [rel blueText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorIndigo:
        mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        cmp     al, 105
        jnz     printColorViolet
        mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 7
        mov     esi, 1
        lea     rax, [rel indigoText]
        mov     rdi, rax
        call    fwrite
        jmp     printColorOut
printColorViolet:  mov     rax, qword [rbp-10H]
        mov     rcx, rax
        mov     edx, 7
        mov     esi, 1
        lea     rax, [rel violetText]
        mov     rdi, rax
        call    fwrite
printColorOut:  nop
        leave
        ret


printShape:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        mov     rdx, qword [rbp-10H]
        mov     rax, qword [rbp-8H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printColor
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 1
        jnz     printShapeTriangle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printRectangle
        jmp     printShapeOut
printShapeTriangle:
        mov     rax, qword [rbp-8H]
        mov     eax, dword [rax+4H]
        cmp     eax, 2
        jnz     printShapeCircle
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printTriangle
        jmp     printShapeOut
printShapeCircle:
        mov     rax, qword [rbp-8H]
        add     rax, 8
        mov     rdx, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printCircle
printShapeOut:
        nop
        leave
        ret


printContainer:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        mov     dword [rbp-4H], 0
        jmp     printContainerEndLoop
printContainerLoop:  mov     eax, dword [rbp-4H]
        cdqe
        shl     rax, 5
        mov     rdx, rax
        mov     rax, qword [rbp-18H]
        add     rax, rdx
        add     rax, 4
        mov     rdx, qword [rbp-20H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printShape
        inc     dword [rbp-4H]
printContainerEndLoop:  mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]
        cmp     dword [rbp-4H], eax
        jl      printContainerLoop
        nop
        nop
        leave
        ret


printHelp:
        push    rbp
        mov     rbp, rsp
        lea     rax, [rel incorrctCommandText]
        mov     rdi, rax
        call    puts
        nop
        pop     rbp
        ret


main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 320064
        mov     dword [rbp-4E234H], edi
        mov     qword [rbp-4E240H], rsi
        cmp     dword [rbp-4E234H], 5
        jz      mainReadContainer
        mov     eax, 0
        call    printHelp
        mov     edi, 1
        call    exit
mainReadContainer:
        mov     rax, qword [rbp-4E240H]
        add     rax, 8
        mov     rax, qword [rax]
        lea     rdx, [rel readFromFileFlag]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcmp
        test    eax, eax
        jnz     mainRandomFill
        mov     rax, qword [rbp-4E240H]
        add     rax, 16
        mov     rax, qword [rax]
        lea     rdx, [rel openReadFileFlag]
        mov     rsi, rdx
        mov     rdi, rax
        call    fopen
        mov     qword [rbp-10H], rax
        mov     rdx, qword [rbp-10H]
        lea     rax, [rbp-4E230H]
        mov     rsi, rdx
        mov     rdi, rax
        call    readContainer
        jmp     mainWriteResult
mainRandomFill:
        mov     rax, qword [rbp-4E240H]
        add     rax, 8
        mov     rax, qword [rax]
        lea     rdx, [rel randomFillFlag]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcmp
        test    eax, eax
        jnz     mainWriteResult
        mov     rax, qword [rbp-4E240H]
        add     rax, 16
        mov     rax, qword [rax]
        mov     rdi, rax
        call    atoi
        mov     dword [rbp-4H], eax
        cmp     dword [rbp-4H], 0
        jle     mainWrongCountItems
        cmp     dword [rbp-4H], 10000
        jle     mainWrongCountItemsContinue
mainWrongCountItems:
        lea     rax, [rel incorrectSizeText]
        mov     rdi, rax
        call    puts
        mov     edi, 1
        call    exit
mainWrongCountItemsContinue:
        mov     edi, 0
        call    time
        mov     edi, eax
        call    srand
        mov     edx, dword [rbp-4H]
        lea     rax, [rbp-4E230H]
        mov     esi, edx
        mov     rdi, rax
        call    randomContainer
mainWriteResult:
        lea     rax, [rbp-4E230H]
        mov     rdi, rax
        call    sortContainer
        mov     rax, qword [rbp-4E240H]
        add     rax, 24
        mov     rax, qword [rax]
        lea     rdx, [rel openWriteFileFlag]
        mov     rsi, rdx
        mov     rdi, rax
        call    fopen
        mov     qword [rbp-18H], rax
        mov     rdx, qword [rbp-18H]
        lea     rax, [rbp-4E230H]
        mov     rsi, rdx
        mov     rdi, rax
        call    printContainer
        mov     rax, qword [rbp-4E240H]
        add     rax, 32
        mov     rax, qword [rax]
        lea     rdx, [rel openWriteFileFlag]
        mov     rsi, rdx
        mov     rdi, rax
        call    fopen
        mov     qword [rbp-20H], rax
        lea     rax, [rbp-4E230H]
        mov     rdi, rax
        call    perimeterContainer
        vmovq   rax, xmm0
        mov     rdx, qword [rbp-20H]
        vmovq   xmm0, rax
        lea     rax, [rel informationFileText]
        mov     rsi, rax
        mov     rdi, rdx
        mov     eax, 1
        call    fprintf
        mov     edi, 0
        call    exit



SECTION .rodata

rectangleOutText:
        db "Rectangle, A = (%i, %i), B = (%i, %i). Perimeter = %f", 10, 00

triangleTextOut:
        db "Triangle, A = (%i, %i), B = (%i, %i), C = (%i, %i). Perimeter = %f", 10, 00

circleTextOut:
        db "Circle, S = (%i, %i), R = %i. Perimeter = %f", 10, 00

colorIsText:
        db "Color is ", 00

redText:
        db "red ", 00

orangeText:
        db "orange ", 00

yellowText:
        db "yellow ", 00

greenText:
        db "green ", 00

blueText:
        db "blue ", 00

indigoText:
        db "indigo ", 00

violetText:
        db "violet ", 00

incorrctCommandText:
        db "Incorrect command line!", 10
        db "  Waited:", 10
        db "     command -f infile outfile01 outfile02", 10
        db "  Or:", 10
        db "     command -n number outfile01 outfile02", 10, 00

readFromFileFlag:
        db "-f", 00

openReadFileFlag:
        db "r", 00

randomFillFlag:
        db "-n", 00

incorrectSizeText:
        db "Incorrect size. Size must be 0 < size <= 10000", 10, 00

openWriteFileFlag:
        db "w", 00

informationFileText:
        db "Sum of perimeters is %f", 00

doublePi:  dq 401921FB54442D18H


