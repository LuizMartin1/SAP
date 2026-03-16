*&---------------------------------------------------------------------*
*& Report ZLH_EX5
*&---------------------------------------------------------------------*
*& 5. Conte quantas vogais há no nome do usuário executando o programa e imprima o resultado.
*&---------------------------------------------------------------------*
REPORT ZLH_EX5.

START-OF-SELECTION.

  DATA(lv_vogais) = count_any_of( val = sy-uname sub = 'AEIOUaeiou' ).

  WRITE:   |Usuário Logado: { sy-uname }|.
  WRITE: / |Total de vogais no nome: { lv_vogais }|.