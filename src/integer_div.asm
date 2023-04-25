global IntegerDiv_

IntegerDiv_:
    ; Arguments 1-6 are passed via registers RDI, RSI, RDX, RCX, R8, R9 respectively
    ; Arguments 7 and above are pushed on to the stack.

    mov     rax, rcx
    mov     rcx, [rsp + 32]
    mov     r10, [rsp + 24]

    ; умножение
    ; (a * b * c * d)
    imul    edi, esi ; a * b
    imul    eax, edx ; c * d
    imul    eax, edi ; a * b * c * d

    ; сложение, проверка, что не равно нулю
    ; (e + f + g + h)
    add     r8d, r9d ; e + f
    add     r8d, [rsp + 8] ; e + f + g
    add     r8d, [rsp + 16] ; e + f + g + h
    jz error

    ; знаковое расширение eax
    cdq
    ; деление eax на r8d
    idiv    r8d
    ; в результате в eax хранится целая часть
    ; а в edx хранится остаток

    ; расширение eax в 64 бит
    cdqe
    ; запись по указателю
    mov     [r10], rax

    ; расширение edx в 64 бит, перемещение в rax 
    movsxd  rax, edx
    ; запись по указателю
    mov     [rcx], rax

    ; успешный код возврата
    xor     eax, eax
    ret
error:
    ; код возврата для ошибки
    mov eax, 1
    ret