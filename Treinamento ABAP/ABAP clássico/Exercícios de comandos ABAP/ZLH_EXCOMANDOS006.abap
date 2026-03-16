*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS006
*&-------------------------------------------------------------------------------------------------------------------------------------*
*& 6. Faça uma rotina (FORM) que imprima o username de todas as pessoas de do treinamento (Veja a tabela USR04 na SE11 e seu conteúdo)
*&-------------------------------------------------------------------------------------------------------------------------------------*
REPORT zlh_excomandos006.

START-OF-SELECTION.
  PERFORM zlh_imprime_username.

FORM zlh_imprime_username.

  DATA: lv_nome(12) TYPE c.

  SELECT bname
    FROM usr04
    INTO TABLE @DATA(ti_nomes).

  LOOP AT ti_nomes INTO DATA(wa_nomes).

    WRITE: / wa_nomes-bname.

  ENDLOOP.

ENDFORM.