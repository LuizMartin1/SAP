*&---------------------------------------------------------------------*
*& Report ZLH_ZSD001
*&---------------------------------------------------------------------*
*& Programa para cadastro dos clientes
*&---------------------------------------------------------------------*
REPORT zlh_zsd001.

TYPE-POOLS: vrm.

DATA: wa_cliente TYPE zlh_cliente.

DATA: ti_valores TYPE vrm_values,
      wa_valores LIKE LINE OF ti_valores.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_cod    TYPE zlh_cliente-zclinr,
              p_nome   TYPE zlh_cliente-nome,
              p_email  TYPE zlh_cliente-email,
              p_cred   TYPE zlh_cliente-limite_credito,
              p_status TYPE zlh_cliente-status AS LISTBOX VISIBLE LENGTH 15 DEFAULT 'A'.


SELECTION-SCREEN END OF BLOCK b1.

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

AT SELECTION-SCREEN.
  SELECT zclinr
  FROM zlh_cliente
  INTO @DATA(v_check)
  WHERE zclinr = @p_cod.
  ENDSELECT.

  IF sy-subrc EQ 0.

    MESSAGE 'Cliente já cadastrado com esse código.' TYPE 'E'.

  ENDIF.

START-OF-SELECTION.
  wa_cliente-zclinr         = p_cod.
  wa_cliente-nome           = p_nome.
  wa_cliente-email          = p_email.
  wa_cliente-limite_credito = p_cred.
  wa_cliente-erdat          = sy-datum.
  wa_cliente-erzet          = sy-uzeit.
  wa_cliente-status         = p_status.

  INSERT zlh_cliente FROM wa_cliente.

  IF sy-subrc EQ 0.
    MESSAGE 'Cliente cadastrado com sucesso!' TYPE 'S'.
    COMMIT WORK.

  ELSE.
    MESSAGE 'Erro ao cadastrar cliente.' TYPE 'E'.
    ROLLBACK WORK.
  ENDIF.