.386                                                                           ; define o conjunto de instru��es suportados pelo teu programa. O m�nimo pra um EXE de 32-bits � .386, mas o MASM tem suporte � v�rios outros conjuntos de instru��es (.386, .486, .586, .686, .mmx, etc).
.model flat, stdcall                                                           ; flat diz respeito ao modelo de endere�amento de mem�ria linear e vai fazer o compilador gerar EXE de 32-bits.J� stdcall, diz respeito � calling convention (como o Assembler vai gerar o c�digo para chamadas de fun��o, limpeza da pilha, passagem de argumentos, etc). 
option casemap: none 		                                               ; Ativa o case sensitive, necess�rio para chamar as fun��es da API do Windows j� que seus nomes s�o sens�veis ao caso.

include \masm32\include\windows.inc                                            ; 'include' Ativa o case sensitive, necess�rio para chamar as fun��es da API do Windows j� que seus nomes s�o sens�veis ao caso.
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib                                              ; 'includelib' Inclui o c�digo compilado necess�rio para chamar tais bibliotecas da maneira que o MASM chama. � que quem desenvolve o MASM j� escreveu e deixou tudo isso pronto para uso.
includelib \masm32\lib\kernel32.lib

.data                                                                          ; Cria uma nova se��o de dados no arquivo.
    nomePagina   db  'Hello', 0                                                 ; O db define um ou mais bytes.  � esquerda dele � o nome (como se fosse o nome de uma vari�vel) que voc� escolhe e � direita os dados em si, no caso, uma sequ�ncia de bytes representando uma string terminada em NULL (byte 0x00). H� tamb�m o dw (para dword), dd (para double word), etc.
    texto      db  'Hello, World!', 0

.code ;Inicia uma se��o de c�digo.
    start:                                                                     ;marca o in�cio dela (o MASM requer o end start no fim).
            invoke MessageBox, NULL, offset texto, offset nomePagina, MB_OK    ;'invoke' Sendo parte da linguagem de alto n�vel do MASM, permite chamar as fun��es de acordo com a calling convention definida sem se preocupar em como os par�metros ser�o passados, quem vai limpar a pilha, etc. Basicamente te permite programar em Assembly no estilo do C (o compilador trata das conven��es). Os par�metros s�o passados para a fun��o depois do nome delas, separados por v�rgula.
            invoke ExitProcess, NULL        
    end start