*&-----------------------------------------------------------------------------*
*& Estrutura CALL FUNCTION 'L_TO_CONFIRM' - Two steps confirmation

  Usei em um coletor de devolução de produção.
*&-----------------------------------------------------------------------------*

FORM zlh_armazena_palete.

  DATA: w_ltap      TYPE ltap,
        w_ltap_conf TYPE ltap_conf.

  FREE t_ltap_conf[].

  LOOP AT t_ltap INTO w_ltap.

    w_ltap_conf-tanum = w_ltap-tanum. "Número da Ordem de Transferência
    w_ltap_conf-tapos = w_ltap-tapos. "Item da Ordem de Transferência
    w_ltap_conf-altme = w_ltap-meins. "Unidade de Medida Alternativa
    w_ltap_conf-lenum = abap_false.   "Número da Unidade de Depósito
    w_ltap_conf-vquit = abap_false.   "Confirmar Retirada
    w_ltap_conf-squit = abap_true.    "Confirmar Destino
    APPEND w_ltap_conf TO t_ltap_conf.

    CLEAR: w_ltap,
           w_ltap_conf.
  ENDLOOP.

  CALL FUNCTION 'L_TO_CONFIRM'
    EXPORTING
      i_lgnum     = w_ltap-lgnum
      i_tanum     = w_ltap-tanum
      i_quknz     = '1' "Confirma retirada - Pick
    TABLES
      t_ltap_conf = t_ltap_conf
    EXCEPTIONS
      OTHERS      = 53.

  IF sy-subrc EQ 0.
    CALL FUNCTION 'L_TO_CONFIRM'
      EXPORTING
        i_lgnum     = w_ltap-lgnum
        i_tanum     = w_ltap-tanum
        i_squit     = 'X'
        i_quknz     = '2' "Confirmar Destino - Transfer
      TABLES
        t_ltap_conf = t_ltap_conf
      EXCEPTIONS
        OTHERS      = 53.
  ENDIF.

ENDFORM.