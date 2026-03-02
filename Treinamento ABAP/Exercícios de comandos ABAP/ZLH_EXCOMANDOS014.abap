*&---------------------------------------------------------------------*
*& Report ZLH_EX14
*&---------------------------------------------------------------------*
*& 14. Faça uma rotina que receba uma workarea com 3 campos string ou caracteres e 3 campos numéricos (usar 3 tipos numéricos diferentes)
* e limpe o conteúdo de seus campos de acordo com as seguintes regras:
* a. Limpar somente os campos texto caso a soma dos campos numéricos for ímpar (desconsiderar possíveis casas decimais);
* b. Limpar somente campos numéricos caso a soma de vogais dos 3 campos texto for par;
*&---------------------------------------------------------------------*
REPORT zlh_ex14.

TYPES: BEGIN OF ty_workarea,
         campo1 TYPE string,
         campo2 TYPE string,
         campo3 TYPE string,
         campo4 TYPE i,
         campo5 TYPE f,
         campo6 TYPE p DECIMALS 2,
       END OF ty_workarea.

DATA: wa TYPE ty_workarea.

START-OF-SELECTION.
  PERFORM limpa_campos USING wa.

FORM limpa_campos USING c TYPE ty_workarea.

  DATA: soma        TYPE i VALUE 0,
        soma_vogais TYPE i VALUE 0.

  c-campo1 = 'a'.
  c-campo2 = 'e'.
  c-campo3 = 't'.
  c-campo4 = 2.
  c-campo5 = 2.
  c-campo6 = 2.

  soma = c-campo4 + c-campo5 + c-campo6.

  "Lógica para limpar os campos de texto
  IF soma MOD 2 NE 0.

    CLEAR: c-campo1, c-campo2, c-campo3.

  ENDIF.

  DATA(palavra) = |{ c-campo1 }{ c-campo2 }{ c-campo3 }|.

  DATA(lv_tamanho) = strlen( palavra ).

  DO lv_tamanho TIMES.

    DATA(lv_pos) = sy-index - 1.

    IF palavra+lv_pos(1) CA 'AEIOUaeiou'.

      soma_vogais = soma_vogais + 1.

    ENDIF.
  ENDDO.

  "Lógica para limpar os campos numéricos
  IF soma_vogais MOD 2 EQ 0.

    CLEAR: c-campo4, c-campo5, c-campo6.

  ENDIF.

  WRITE:   |Campo 1: { c-campo1 }|.
  WRITE: / |Campo 2: { c-campo2 }|.
  WRITE: / |Campo 3: { c-campo3 }|.
  WRITE: / |Campo 4: { c-campo4 }|.
  WRITE: / |Campo 5: { c-campo5 }|.
  WRITE: / |Campo 6: { c-campo6 }|.

ENDFORM.