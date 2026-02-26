*&---------------------------------------------------------------------*
*& Report ZLH_ZSD003
*&---------------------------------------------------------------------*
*& Excluir Cliente
*&---------------------------------------------------------------------*
REPORT zlh_zsd003.

DATA: v_answer TYPE char01.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_cod TYPE zlh_cliente-zclinr.

SELECTION-SCREEN END OF BLOCK b1.


AT SELECTION-SCREEN ON p_cod.
  SELECT zclinr
  FROM zlh_cliente
  INTO @DATA(v_cod)
  WHERE zclinr EQ @p_cod.
  ENDSELECT.

  IF sy-subrc EQ 0 AND p_cod IS NOT INITIAL.

    CALL FUNCTION 'POPUP_TO_CONFIRM_STEP_2_BUTTON'
      EXPORTING
        defaultoption  = 'Y'
        textline1      = 'Tem certeza que deseja excluir esse cliente ?'
*       textline2      = space
        titel          = 'Excluir cliente'
        start_column   = 25
        start_row      = 6
        cancel_display = 'X'
      IMPORTING
        answer         = v_answer.

    IF v_answer EQ 'J'.

      DELETE FROM zlh_cliente WHERE zclinr = p_cod.
      COMMIT WORK.
      MESSAGE 'Cliente excluído com sucesso!' TYPE 'S'.

    ELSE.
      MESSAGE 'Operação cancelada.' TYPE 'E'.

    ENDIF.

  ELSE.

    MESSAGE 'Informe um código válido' TYPE 'E'.
  ENDIF.