*&---------------------------------------------------------------------*
*& Report ZLH_EX17
*&---------------------------------------------------------------------*
*& 17. Faça uma rotina que receba dois números (base e expoente) obrigatórios (via parameters). Imprima o resultado da exponenciação.
*&---------------------------------------------------------------------*
REPORT ZLH_EX17.

PARAMETERS: p_base TYPE i,
            p_expo TYPE i.

START-OF-SELECTION.
  PERFORM zlh_operacao USING p_base p_expo.

FORM zlh_operacao USING base expoente.

  DATA: lv_res TYPE i.

  lv_res = base ** expoente.

  WRITE: |{ base }^{ expoente } = { lv_res }|.

ENDFORM. "zlh_operacao