*&---------------------------------------------------------------------*
*& Report ZLH_EX15
*&---------------------------------------------------------------------*
*& 15. Faça uma rotina que receba uma tabela interna e imprima quantos campos estão em branco por linha (o tipo da tabela deve ter no mínimo 4 campos).
* Saída desejada deve ter o template:
* Linha [número da linha] =>[10 caracteres em branco] + [número de campos em branco] + “ campos em branco”.
*&---------------------------------------------------------------------*
REPORT zlh_ex15.

TYPES: BEGIN OF ty_tabela,
         campo1 TYPE string,
         campo2 TYPE string,
         campo3 TYPE string,
         campo4 TYPE string,
       END OF ty_tabela.

DATA: ti_tabela TYPE TABLE OF ty_tabela,
      wa_linha  LIKE LINE OF ti_tabela.

START-OF-SELECTION.
  PERFORM zlh_verifica_campos.

FORM zlh_verifica_campos.

  DATA: lv_vazios      TYPE i,
        lv_espacos(10) TYPE c VALUE ' '.

  APPEND VALUE #( campo1 = 'SAP' campo2 = '' campo3 = 'ABAP' campo4 = '' ) TO ti_tabela.
  APPEND VALUE #( campo1 = 'Martini'    campo2 = '' campo3 = space     campo4 = '' ) TO ti_tabela.

  LOOP AT ti_tabela INTO wa_linha.
    lv_vazios = 0.
    DATA(lv_index) = sy-tabix.

    IF wa_linha-campo1 IS INITIAL. lv_vazios = lv_vazios + 1. ENDIF.
    IF wa_linha-campo2 IS INITIAL. lv_vazios = lv_vazios + 1. ENDIF.
    IF wa_linha-campo3 IS INITIAL. lv_vazios = lv_vazios + 1. ENDIF.
    IF wa_linha-campo4 IS INITIAL. lv_vazios = lv_vazios + 1. ENDIF.

    WRITE: / |Linha { lv_index } =>{ lv_espacos }{ lv_vazios } campos em branco|.
  ENDLOOP.

ENDFORM. "zlh_verifica_campos