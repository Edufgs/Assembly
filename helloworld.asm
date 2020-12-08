.386                                                                           ; define o conjunto de instruções suportados pelo teu programa. O mínimo pra um EXE de 32-bits é .386, mas o MASM tem suporte à vários outros conjuntos de instruções (.386, .486, .586, .686, .mmx, etc).
.model flat, stdcall                                                           ; flat diz respeito ao modelo de endereçamento de memória linear e vai fazer o compilador gerar EXE de 32-bits.Já stdcall, diz respeito à calling convention (como o Assembler vai gerar o código para chamadas de função, limpeza da pilha, passagem de argumentos, etc). 
option casemap: none 		                                               ; Ativa o case sensitive, necessário para chamar as funções da API do Windows já que seus nomes são sensíveis ao caso.

include \masm32\include\windows.inc                                            ; 'include' Ativa o case sensitive, necessário para chamar as funções da API do Windows já que seus nomes são sensíveis ao caso.
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib                                              ; 'includelib' Inclui o código compilado necessário para chamar tais bibliotecas da maneira que o MASM chama. É que quem desenvolve o MASM já escreveu e deixou tudo isso pronto para uso.
includelib \masm32\lib\kernel32.lib

.data                                                                          ; Cria uma nova seção de dados no arquivo.
    nomePagina   db  'Hello', 0                                                 ; O db define um ou mais bytes.  À esquerda dele é o nome (como se fosse o nome de uma variável) que você escolhe e à direita os dados em si, no caso, uma sequência de bytes representando uma string terminada em NULL (byte 0x00). Há também o dw (para dword), dd (para double word), etc.
    texto      db  'Hello, World!', 0

.code ;Inicia uma seção de código.
    start:                                                                     ;marca o início dela (o MASM requer o end start no fim).
            invoke MessageBox, NULL, offset texto, offset nomePagina, MB_OK    ;'invoke' Sendo parte da linguagem de alto nível do MASM, permite chamar as funções de acordo com a calling convention definida sem se preocupar em como os parâmetros serão passados, quem vai limpar a pilha, etc. Basicamente te permite programar em Assembly no estilo do C (o compilador trata das convenções). Os parâmetros são passados para a função depois do nome delas, separados por vírgula.
            invoke ExitProcess, NULL        
    end start