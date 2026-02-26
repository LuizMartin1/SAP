*&---------------------------------------------------------------------*
*& Report ZLH_ZSD002
*&---------------------------------------------------------------------*
*& Modificar Cliente
*&---------------------------------------------------------------------*
REPORT zlh_zsd002.

TYPE-POOLS: vrm.

DATA: wa_cliente TYPE zlh_cliente,
      flag       TYPE char01.

DATA: ti_valores TYPE vrm_values,
      wa_valores LIKE LINE OF ti_valores.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_cod TYPE zlh_cliente-zclinr.

SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: P_cod2   TYPE zlh_cliente-zclinr,
              p_nome   TYPE zlh_cliente-nome,
              p_email  TYPE zlh_cliente-email,
              p_cred   TYPE zlh_cliente-limite_credito,
              p_data   TYPE zlh_cliente-erdat,
              p_hora   TYPE zlh_cliente-erzet,
              p_status TYPE zlh_cliente-status AS LISTBOX VISIBLE LENGTH 15.


SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  wa_valores-key = 'A'.
  wa_valores-text = 'A (Ativo)'.
  APPEND wa_valores TO ti_valores.

  wa_valores-key = 'B'.
  wa_valores-text = 'B (Bloqueado)'.
  APPEND wa_valores TO ti_valores.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_STATUS'
      values = ti_valores.

AT SELECTION-SCREEN OUTPUT.

  IF p_cod IS NOT INITIAl AND p_cod <> p_cod2.

    SELECT SINGLE *
    FROM zlh_cliente
    INTO wa_cliente
    WHERE zclinr EQ p_cod.

    IF sy-subrc EQ 0.

      p_cod2    = wa_cliente-zclinr.
      p_nome   = wa_cliente-nome.
      p_email  = wa_cliente-email.
      p_cred   = wa_cliente-limite_credito.
      p_status = wa_cliente-status.
      p_data   = wa_cliente-erdat.
      p_hora   = wa_cliente-erzet.

      flag = 'X'.

    ENDIF.

  ENDIF.

  LOOP AT SCREEN.
    IF screen-name = 'P_COD2'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

    IF screen-name = 'P_DATA'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

    IF screen-name = 'P_HORA'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.
  IF p_cod IS INITIAL.
    MESSAGE 'Informe um código válido.' TYPE 'S' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

  wa_cliente-nome           = p_nome.
  wa_cliente-email          = p_email.
  wa_cliente-limite_credito = p_cred.
  wa_cliente-status         = p_status.
  MODIFY zlh_cliente FROM wa_cliente.

  IF sy-subrc EQ 0.
    COMMIT WORK.
    MESSAGE 'Alterações realizadas com sucesso!' TYPE 'S'.

  ELSE.
    ROLLBACK WORK.
    MESSAGE 'Erro ao relaizar alterações.' TYPE 'E'.
  ENDIF.