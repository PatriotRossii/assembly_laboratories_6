global IntegerDiv_

IntegerDiv_:
    mov     rax, rcx
    mov     rcx, [rsp + 32]
    mov     r10, [rsp + 24]

    ; умножение
    imul    edi, esi
    imul    eax, edx
    imul    eax, edi

    ; сложение, проверка, что не равно нулю
    add     r8d, r9d
    add     r8d, [rsp + 8]
    add     r8d, [rsp + 16]
    jz error

    ; деление
    cdq
    idiv    r8d

    ; расширение и запись по указателю
    cdqe
    mov     [r10], rax

    ; расширение и запись по указателю
    movsxd  rax, edx
    mov     [rcx], rax

    ; успешный код возврата
    xor     eax, eax
    ret
error:
    ; код возврата для ошибки
    mov eax, 1
    ret