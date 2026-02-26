*&---------------------------------------------------------------------*
*& Report ZLH_ZSD004
*&---------------------------------------------------------------------*
*& Consultar Cliente
*&---------------------------------------------------------------------*
REPORT zlh_zsd004.

TABLES: zlh_cliente.

TYPE-POOLS: vrm.

DATA: ti_valores TYPE vrm_values,
      wa_valores LIKE LINE OF ti_valores.

DATA: ti_saida TYPE STANDARD TABLE OF zlh_cliente,
      wa_saida TYPE zlh_cliente.

DATA: go_salv_table TYPE REF TO cl_salv_table.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: s_cod    FOR zlh_cliente-zclinr,
                  s_nome   FOR zlh_cliente-nome,
                  s_email  FOR zlh_cliente-email,
                  s_cred   FOR zlh_cliente-limite_credito,
                  s_status FOR zlh_cliente-status.

SELECTION-SCREEN END OF BLOCK b1.


INITIALIZATION.
  wa_valores-key = 'A'.
  wa_valores-text = 'A (Atvio)'.
  APPEND wa_valores TO ti_valores.

  wa_valores-key = 'B'.
  wa_valores-text = 'B (Bloqueado)'.
  APPEND wa_valores TO ti_valores.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_STATUS'
      values = ti_valores.

*&---------------------------------------------------------------------*
*&                     CLASSE DE DEFINIÇÃO
*&---------------------------------------------------------------------*
CLASS lcl_events DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS on_user_command
      FOR EVENT added_function OF cl_salv_events
      IMPORTING e_salv_function.

ENDCLASS. "lcl_events DEFINITION

*&---------------------------------------------------------------------*
*&                            EVENTOS
*&---------------------------------------------------------------------*

START-OF-SELECTION.
  PERFORM: zlh_seleciona_dados,
           zlh_exibe_relatorio.

*&---------------------------------------------------------------------*
*&                        SELEÇÃO DE DADOS
*&---------------------------------------------------------------------*

FORM zlh_seleciona_dados.

  SELECT *
    FROM zlh_cliente
    INTO TABLE @ti_saida
    WHERE zclinr       IN @s_cod
    AND limite_credito IN @s_cred
    AND nome           IN @s_nome
    AND email          IN @s_email
    AND status         IN @s_status.

ENDFORM. "zlh_seleciona_dados.

*&---------------------------------------------------------------------*
*&                        EXIBIÇÃO DO RELATÓRIO
*&---------------------------------------------------------------------*

FORM zlh_exibe_relatorio.

  DATA: lo_columns TYPE REF TO cl_salv_columns_table,
        lo_column  TYPE REF TO cl_salv_column.

  DATA: r_events       TYPE REF TO cl_salv_events_table.

  TRY.
      cl_salv_table=>factory(
            IMPORTING
              r_salv_table   = go_salv_table
            CHANGING
              t_table        = ti_saida
          ).
    CATCH cx_salv_msg.
      MESSAGE 'Erro ao criar o ALV SALV!' TYPE 'E'.

  ENDTRY.

  IF go_salv_table IS BOUND.

    DATA(lo_events) = go_salv_table->get_event( ).
    SET HANDLER lcl_events=>on_user_command FOR lo_events.


    go_salv_table->set_screen_status(
      report        = sy-repid
      pfstatus      = 'ZLH_ZSD004'
      set_functions = go_salv_table->c_functions_all ).

    TRY.
        lo_columns = go_salv_table->get_columns( ).
        lo_columns->set_optimize( abap_true ).

      CATCH cx_salv_not_found.

    ENDTRY.

    SORT ti_saida BY zclinr.
    go_salv_table->get_functions( )->set_all( abap_true ).
    go_salv_table->display( ).


  ENDIF.

ENDFORM. "zlh_exibe_relatorio

*&---------------------------------------------------------------------*
*&                        CLASSES
*&---------------------------------------------------------------------*

CLASS lcl_events IMPLEMENTATION.
  METHOD on_user_command.

    DATA: lv_ov     TYPE bapivbeln-vbeln,
          ls_stable TYPE lvc_s_stbl.
    DATA(lt_rows) = go_salv_table->get_selections( )->get_selected_rows( ).

    DATA: lt_bdc TYPE TABLE OF bdcdata.

    IF lt_rows IS INITIAL AND e_salv_function NE '&CRIAR'.
      MESSAGE 'Ao menos uma linha deve ser selecionada' TYPE 'S' DISPLAY LIKE 'W'.
      RETURN.
    ENDIF.

    READ TABLE lt_rows INTO DATA(lv_index) INDEX 1.

    READ TABLE ti_saida INTO wa_saida INDEX lv_index.

    CASE e_salv_function.
      WHEN '&CRIAR'.

        CALL TRANSACTION 'ZLH0001' USING lt_bdc MODE 'E'.

        PERFORM zlh_seleciona_dados.
        SORT ti_saida BY zclinr.
        go_salv_table->refresh( ).

      WHEN '&EDITAR'.

        APPEND VALUE #( program  = 'ZLH_ZSD002'
                        dynpro   = '1000'
                        dynbegin = 'X' ) TO lt_bdc.

        APPEND VALUE #( fnam = 'P_COD'
                        fval = wa_saida-zclinr ) TO lt_bdc.


        APPEND VALUE #( fnam = 'BDC_OKCODE'
                        fval = '/00' ) TO lt_bdc.

        CALL TRANSACTION 'ZLH0002' USING lt_bdc MODE 'E'.

        PERFORM zlh_seleciona_dados.
        SORT ti_saida BY zclinr.
        go_salv_table->refresh( ).

      WHEN '&EXCLUIR'.

        APPEND VALUE #( program  = 'ZLH_ZSD003'
                        dynpro   = '1000'
                        dynbegin = 'X' ) TO lt_bdc.

        APPEND VALUE #( fnam = 'P_COD'
                        fval = wa_saida-zclinr ) TO lt_bdc.


        APPEND VALUE #( fnam = 'BDC_OKCODE'
                fval = 'ONLI' ) TO lt_bdc.


        CALL TRANSACTION 'ZLH0003' USING lt_bdc MODE 'E'.

        PERFORM zlh_seleciona_dados.
        SORT ti_saida BY zclinr.
        go_salv_table->refresh( ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS. "lcl_events