.386                                                                           ; define o conjunto de instru��es suportados pelo teu programa. O m�nimo pra um EXE de 32-bits � .386, mas o MASM tem suporte � v�rios outros conjuntos de instru��es (.386, .486, .586, .686, .mmx, etc).
.model flat, stdcall                                                           ; flat diz respeito ao modelo de endere�amento de mem�ria linear e vai fazer o compilador gerar EXE de 32-bits.J� stdcall, diz respeito � calling convention (como o Assembler vai gerar o c�digo para chamadas de fun��o, limpeza da pilha, passagem de argumentos, etc). 
option casemap: none 		                                               ; Ativa o case sensitive, necess�rio para chamar as fun��es da API do Windows j� que seus nomes s�o sens�veis ao caso.


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

.code ;Inicia uma se��o de c�digo.
    start:
        ;Inicia a entrada e saida                                                                     ;marca o in�cio dela (o MASM requer o end start no fim).
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