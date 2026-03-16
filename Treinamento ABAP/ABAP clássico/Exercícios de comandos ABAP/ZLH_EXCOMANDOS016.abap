*&---------------------------------------------------------------------*
*& Report ZLH_EX16
*&---------------------------------------------------------------------*
*& 16. Faça uma rotina que receba dois números (via parameters). O primeiro representa um número a ser impresso e o segundo representa o número de casas a serem impressas. Coloque zeros a esquerda caso necessário. Exemplos:
*  a. p_numero = 15 p_casas = 2. Saída = 15
*  b. p_numero = 15 p_casas = 4. Saída = 0015
*  c. p_numero = 15 p_casas = 6. Saída = 000015
*  d. p_numero = 2011 p_casas = 2. Saída = 20
*  e. p_numero = 123456789 p_casas = 10. Saída = 0123456789
*  f. p_numero = 123456789 p_casas = 4. Saída = 1234
*&---------------------------------------------------------------------*
REPORT ZLH_EX16.

PARAMETERS: p_numero TYPE i,
            p_casas  TYPE i.

START-OF-SELECTION.
  PERFORM zlh_formata_numero USING p_numero p_casas.

*&---------------------------------------------------------------------*
*& FORM zlh_formata_numero
*&---------------------------------------------------------------------*
FORM zlh_formata_numero USING pv_num   TYPE i
                              pv_casas TYPE i.

  DATA: lv_texto   TYPE string,
        lv_zeros   TYPE i.

  lv_texto = |{ pv_num }|.
  CONDENSE lv_texto NO-GAPS.

  DATA(lv_tam_atual) = strlen( lv_texto ).

  IF lv_tam_atual < pv_casas.
    lv_zeros = pv_casas - lv_tam_atual.

    DO lv_zeros TIMES.
      lv_texto = |0{ lv_texto }|.
    ENDDO.

  ELSEIF lv_tam_atual > pv_casas.

    lv_texto = lv_texto+0(pv_casas).

  ENDIF.

  WRITE: / |Saída: { lv_texto }|.

ENDFORM.