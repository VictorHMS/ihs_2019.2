;Jogo da Velha: ULTRA
org 0x7E00
jmp 0x0000:start
 
data:
    mostra db "SISTEMA DE REGISTRO DE CONTAS BANCARIAS", 13
    instr1 db "Nome (20 caracteres) --- CPF (11 caracteres) --- Conta Bancaria (6 caracteres)", 13
    registro_nome db "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", 13
    registro_cpf db "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", 13
    registro_cc db "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", 13
    mostrapergunta db "Qual operacao voce deseja realizar?", 13
    mostrapergunta1 db "1 - Cadastro", 13
    mostrapergunta2 db "2 - Busca Cadastro", 13
    mostrapergunta3 db "3 - Editar Conta", 13
    mostrapergunta4 db "4 - Deletar Conta", 13
    mostrapergunta5 db "5 - Sair", 13
    cad db "Cadastro:",13
    nome db "12345678901234567890", 13
    cpf db "12345678901", 13
    cc db "123456", 13
    mostranome db "Digite o seu nome:", 13
    mostracpf db "Digite o seu cpf:", 13
    mostracb db "Digite o numero da conta bancaria:", 13
    instrucao db "                                      " ,13,0
    ;tami db 0
    ocup db '000000000000000000000',13
    index db 0;
 
start:
    ; Modo vídeo.
    mov ah, 0
    mov al, 12h
    int 10h
 
    call telaInicial
 
    jmp exit
 
getchar:
    mov ah, 0
    int 16h
    ret
 
putchar:
    mov ah, 0xe
    mov bx, 0x7
    mov bh, 0
    int 10h
    ret
 
telaInicial:
    .loop_infinito: ;loop que so termina quando o usuario digita 5 para poder sair do programa
        ; chamar o modo video para limpar a tela
        mov ah, 0
        mov al, 12h
        int 10h
 
        mov si, mostrapergunta
        mov dh, 00h
        mov dl, 00h
        call printarString
 
        mov si, mostrapergunta1
        mov dh, 01h
        mov dl, 00h
        call printarString
 
        mov si, mostrapergunta2
        mov dh, 02h
        mov dl, 00h
        call printarString
 
        mov si, mostrapergunta3
        mov dh, 03h
        mov dl, 00h
        call printarString
 
        mov si, mostrapergunta4
        mov dh, 04h
        mov dl, 00h
        call printarString
 
        mov si, mostrapergunta5
        mov dh, 05h
        mov dl, 00h
        call printarString
        mov si, instrucao
        mov dh, 06h
        mov dl, 00h
        call printarString
        call getchar
        cmp al, '1'
        je cadastro
        ;cmp al, '2'
        ;je busca3
        ;cmp al, '3'
        ;je editar
        ;cmp al, '4'
        ;je deletar
        ;cmp al, '5'
        ;je exit
        call putchar
        call getchar
        cmp al, 13
        jmp .loop_infinito
 
getstring:
    loop12:
        call getchar
        call putchar
        mov byte[si], al
        inc si
        cmp al, 13
        je finale
    jmp loop12
 
    finale:
    ret
 
val_index:
    mov byte[index], cl
    dec si;
    mov byte[si], '1';
    ret

 find_ind:
    lodsb;
    cmp al,'0';
    je retornar; salvar no index
    inc cl
    jmp find_ind;
    retornar:
        call val_index;
        ret;
    
cadastro:
    xor cx,cx
    mov si, ocup;
    call find_ind ;encontrar o indice que eu procuro
    
    ; Limpando a tela
    mov ah, 0
    mov al, 12h
    int 10h
    ;mostrar ocup
    mov si, ocup;
    mov dh, 10h
    mov dl, 00h;
    call printarString
    
    mov si, cad
    mov dh, 00h
    mov dl, 00h
    call printarString
    mov dh, 01h
    mov dl, 00h
    mov si, instr1
    call printarString
    ;movendo o ponteiro si para a string nome
   
    mov si, instrucao
    mov dh, 02h
    mov dl, 00h
    call printarString
 
    mov si, nome
    call getstring
 
    mov si, instrucao
    mov dh, 02h
    mov dl, 00h
    call printarString
 
    mov si, cpf
    call getstring
 
    mov si, instrucao
    mov dh, 02h
    mov dl, 00h
    call printarString
 
    mov si, cc
    call getstring
 
    mov si, instrucao
    mov dh, 02h
    mov dl, 00h
    call printarString
 
    mov si, nome
    mov dh, 2h
    mov dl, 00h
    call printarString
 
    mov si, cpf
    mov dh, 3h
    mov dl, 00h
    call printarString
 
    mov si, cc
    mov dh, 4h
    mov dl, 00h
    call printarString


 
    call getchar
    jmp telaInicial
 
busca:
    ; Limpando a tela
    mov ah, 0
    mov al, 12h
    int 10h
 
    jmp telaInicial
 
editar:
    ; Limpando a tela
    mov ah, 0
    mov al, 12h
    int 10h
 
    jmp telaInicial
 
deletar:
    ; Limpando a tela
    mov ah, 0
    mov al, 12h
    int 10h
   
    jmp telaInicial
 
 
 
printDelayStr:
    lodsb
 
    mov ah, 0xe
    mov bh, 0
    int 10h
 
    call delay
 
    cmp al, 13
    jne printDelayStr
ret
 
printDelayStrTitle:
    lodsb
 
    mov ah, 0xe
    mov bh, 0
    int 10h
 
    call delay_fast
 
    cmp al, 13
    jne printDelayStrTitle
ret
 
printAux:
    lodsb
 
    mov ah, 0xe
    mov bh, 0
    mov bl, 0xf
    int 10h
 
    cmp al, 13
    jne printAux
ret
 
printarString:
    mov ah, 02h
    mov bh, 00h
    int 10h
    call printAux
 
    ret
 
delay:
    mov bp, 350
    mov dx, 350
    delay2:
        dec bp
        nop
        jnz delay2
    dec dx
    jnz delay2
 
ret
 
delay_fast:
    mov bp, 75
    mov dx, 75
    delay2_fast:
        dec bp
        nop
        jnz delay2_fast
    dec dx
    jnz delay2_fast
 
ret
 
delay_window:
    mov bp, 700
    mov dx, 700
    delay2_window:
        dec bp
        nop
        jnz delay2_window
    dec dx
    jnz delay2_window
 
ret
 
jogo:
;Setando a posição do disco onde kernel.asm foi armazenado(ES:BX = [0x500:0x0])
    mov ax,0x860        ;0x50<<1 + 0 = 0x500
    mov es,ax
    xor bx,bx       ;Zerando o offset
 
;Setando a posição da Ram onde o jogo será lido
    mov ah, 0x02    ;comando de ler setor do disco
    mov al,8        ;quantidade de blocos ocupados por jogo
    mov dl,0        ;drive floppy
 
;Usaremos as seguintes posições na memoria:
    mov ch,0        ;trilha 0
    mov cl,7        ;setor 2
    mov dh,0        ;cabeca 0
    int 13h
    jc jogo ;em caso de erro, tenta de novo
 
break: 
    jmp 0x8600      ;Pula para a posição carregada
 
 
exit:
