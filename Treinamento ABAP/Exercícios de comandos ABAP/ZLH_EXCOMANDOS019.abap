*&---------------------------------------------------------------------*
*& Report ZLH_EX19
*&---------------------------------------------------------------------*
*& 19. Faça uma rotina que contenha um select-option para um campo numérico e imprimir o resultado da multiplicação de cada número dentro do range por 3.
*&---------------------------------------------------------------------*
REPORT zlh_ex19.

DATA: gv_numero TYPE i.

SELECT-OPTIONS: s_num FOR gv_numero.

START-OF-SELECTION.
  PERFORM zlh_multiplica_range.


FORM zlh_multiplica_range.

  DATA: lv_res TYPE i.

  LOOP AT s_num INTO DATA(ls_range).

    DATA(lv_inicio) = ls_range-low.
    DATA(lv_fim)    = ls_range-high.

    IF lv_fim IS INITIAL.
      lv_fim = lv_inicio.
    ENDIF.

    WHILE lv_inicio <= lv_fim.

      lv_res = lv_inicio * 3.

      WRITE: / |{ lv_inicio } x 3 = { lv_res }|.

      lv_inicio = lv_inicio + 1.
    ENDWHILE.

  ENDLOOP.

  IF sy-subrc <> 0.
    WRITE: / 'Nenhum número informado no range.'.
  ENDIF.

ENDFORM.