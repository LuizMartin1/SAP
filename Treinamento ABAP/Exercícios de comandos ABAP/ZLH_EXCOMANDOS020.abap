*&---------------------------------------------------------------------*
*& Report ZLH_EX20
*&---------------------------------------------------------------------*
*& 20. Faça uma rotina que contenha um select-option para um campo numérico sem o botão de seleção de ranges múltiplos e,
*  que imprima os números deste range separados por “, “.
*&---------------------------------------------------------------------*
REPORT ZLH_EX20.

DATA: gv_num TYPE i.

" 1. O NO-EXTENSION remove o botão de ranges múltiplos (o botão no canto direito)
SELECT-OPTIONS: s_num FOR gv_num NO-EXTENSION.

START-OF-SELECTION.
  PERFORM zlh_imprime_sequencia.

*&---------------------------------------------------------------------*
*& FORM zlh_imprime_sequencia
*&---------------------------------------------------------------------*
FORM zlh_imprime_sequencia.

  DATA: lv_primeiro TYPE abap_bool VALUE abap_true,
        lv_atual    TYPE i.

  READ TABLE s_num INDEX 1 INTO DATA(ls_range).

  IF sy-subrc = 0.
    lv_atual = ls_range-low.

    DATA(lv_fim) = ls_range-high.
    IF lv_fim IS INITIAL.
      lv_fim = lv_atual.
    ENDIF.

    WHILE lv_atual <= lv_fim.

      IF lv_primeiro = abap_true.
        WRITE: lv_atual.
        lv_primeiro = abap_false.
      ELSE.
        WRITE: |, { lv_atual }|.
      ENDIF.

      lv_atual = lv_atual + 1.
    ENDWHILE.

  ELSE.
    WRITE: 'Nenhum valor informado.'.
  ENDIF.

ENDFORM."zlh_imprime_sequencia.