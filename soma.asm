.386                                                                           ; define o conjunto de instruções suportados pelo teu programa. O mínimo pra um EXE de 32-bits é .386, mas o MASM tem suporte à vários outros conjuntos de instruções (.386, .486, .586, .686, .mmx, etc).
.model flat, stdcall                                                           ; flat diz respeito ao modelo de endereçamento de memória linear e vai fazer o compilador gerar EXE de 32-bits.Já stdcall, diz respeito à calling convention (como o Assembler vai gerar o código para chamadas de função, limpeza da pilha, passagem de argumentos, etc). 
option casemap: none 		                                               ; Ativa o case sensitive, necessário para chamar as funções da API do Windows já que seus nomes são sensíveis ao caso.


include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

.data         
    inputHandle dd 0
    outputHandle dd 0

    numa db 'Numero 1: '
    numb db 'Numero 2: '
    
    A dd ?
    B dd ?
    tamanho dd 0
    console_count dd 0   

.code ;Inicia uma seção de código.
    start:
        ;Inicia a entrada e saida                                                                     ;marca o início dela (o MASM requer o end start no fim).
        invoke GetStdHandle, STD_INPUT_HANDLE ; obter HANDLE de entrada 
        mov inputHandle, eax

        invoke GetStdHandle, STD_OUTPUT_HANDLE  ;obter HANDLE de entrada
        mov outputHandle, eax

        ;Digitar o Primeiro numero
        invoke WriteConsole, outputHandle, addr numa, sizeof numa, addr console_count, NULL  ;imprime no console
    
        invoke ReadConsole, inputHandle, addr A, sizeof A, addr console_count, NULL ;Le o numero

        ;Processamento do numero por causa do ENTER
        mov esi, offset A
        proximo:
            mov al, [esi]
            inc esi
            cmp al, 48
            jl terminar
            cmp al, 58
            jl proximo
        terminar:
            dec esi
            xor al, al
            mov [esi], al

        ;Transformo em binario (em numero)
        invoke atodw, addr A
        mov A, eax
        


        ;Digitar o Segundo numero
        invoke WriteConsole, outputHandle, addr numb, sizeof numa, addr console_count, NULL  ;imprime no console
    
        invoke ReadConsole, inputHandle, addr B, sizeof B, addr console_count, NULL ;Le o numero

        ;Processamento do numero por causa do ENTER
        mov esi, offset B
        proximo1:
            mov al, [esi]
            inc esi
            cmp al, 48
            jl terminar1
            cmp al, 58
            jl proximo1
        terminar1:
            dec esi
            xor al, al
            mov [esi], al

        ;Transformo em binario (em numero)
        invoke atodw, addr B
        mov B, eax

        ;conta (tem que colocar em um registrador para depois somar)            
        mov eax, A
        add B, eax

        ;Transforma de volta para String
        invoke dwtoa, B, addr B ;transforma A em String e adiciona em A (primeiro A para o segundo)
 
        invoke StrLen, addr B ;pega o tamanho da String para imprimir
        mov tamanho, eax

        ;mostrar na tela        
        invoke WriteConsole, outputHandle, addr B, sizeof tamanho, addr console_count, NULL
    
        invoke ExitProcess, 0   
                    
    end start