global IntegerDiv_

IntegerDiv_:
    ; Arguments 1-6 are passed via registers RDI, RSI, RDX, RCX, R8, R9 respectively
    ; Arguments 7 and above are pushed on to the stack.

    mov     rax, rcx
    mov     rcx, [rsp + 32]
    mov     r10, [rsp + 24]

    ; умножение
    ; (a * b * c * d)
    imul    rdi, rsi ; a * b
    imul    rax, rdx ; c * d
    imul    rax, rdi ; a * b * c * d

    ; сложение, проверка, что не равно нулю
    ; (e + f + g + h)
    add     r8, r9 ; e + f
    add     r8, [rsp + 8] ; e + f + g
    add     r8, [rsp + 16] ; e + f + g + h
    jz error

    ; знаковое расширение
    cdq
    ; деление rax на r8
    idiv    r8
    ; в результате в rax хранится целая часть
    ; а в rdx хранится остаток

    ; запись целой части по указателю
    mov     [r10], rax
    ; запись остатка по указателю
    mov     [rcx], rdx

    ; успешный код возврата
    xor     eax, eax
    ret
error:
    ; код возврата для ошибки
    mov eax, 1
    ret