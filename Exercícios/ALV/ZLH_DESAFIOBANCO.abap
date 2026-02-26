*&---------------------------------------------------------------------*
*& Report ZLH_DESAFIOBANCO
*&---------------------------------------------------------------------------------*
*&  CRIAR ALV DE BANCO - MOSTRAR DADOS DAS DUAS TABELAS + DESCRIÇÃO TIPO DE CONTA
*&---------------------------------------------------------------------------------*
REPORT zlh_desafiobanco.



CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.

    TYPES: BEGIN OF ty_banco,
             cpf        TYPE zlh_cliente-cpf,
             nome       TYPE zlh_cliente-nome,
             endereco   TYPE zlh_cliente-endereco,
             tipo_conta TYPE zlh_conta-tipo_conta,
             desc_conta TYPE string,
             saldo      TYPE zlh_conta-saldo,
             moeda      TYPE zlh_conta-moeda,
           END OF ty_banco.

    "*Variaveis Globais
    CLASS-DATA: gt_banco      TYPE TABLE OF ty_banco,
                gv_cpf        TYPE zlh_cliente-cpf,
                gv_tipo_conta TYPE zlh_conta-tipo_conta.

  PRIVATE SECTION.
    "* Métodos e atributos para o processamento do programa
    CLASS-METHODS: get_data, set_data.
ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_cpf FOR lcl_main=>gv_cpf,
                  s_tconta FOR lcl_main=>gv_tipo_conta.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main IMPLEMENTATION.
  METHOD main.
    get_data( ).
    set_data( ).
  ENDMETHOD.

  METHOD get_data.

    SELECT *
      FROM zlh_cliente AS cliente
      INNER JOIN zlh_conta AS conta
      ON cliente~cpf EQ conta~cpf
      INTO CORRESPONDING FIELDS OF TABLE @gt_banco
      WHERE cliente~cpf IN @s_cpf
      AND conta~tipo_conta IN @s_tconta
      ORDER BY conta~saldo.
    "Primeiro Sort feito só pra apagar um dado duplicado.
    SORT gt_banco BY cpf.

    DELETE ADJACENT DUPLICATES FROM gt_banco COMPARING cpf.

    SORT gt_banco BY tipo_conta.

    IF sy-subrc NE 0.
      MESSAGE 'Nenhum registro encontrado' TYPE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.


    LOOP AT gt_banco ASSIGNING FIELD-SYMBOL(<fs_banco>).

      CASE <fs_banco>-tipo_conta.
        WHEN 1.
          <fs_banco>-desc_conta = 'Conta Corrente'.
        WHEN 2.
          <fs_banco>-desc_conta = 'Conta Poupança'.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.

  METHOD set_data.

    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
          lo_column  TYPE REF TO cl_salv_column.

    TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table   = DATA(lo_salv_table)
        CHANGING
          t_table        = gt_banco
      ).

    CATCH cx_salv_msg.
      MESSAGE 'Erro ao criar instância do ALV' TYPE 'E'.
    ENDTRY.

    IF lo_salv_table IS BOUND.

      TRY.
        lo_columns = lo_salv_table->get_columns( ).

        lo_column = lo_columns->get_column( 'DESC_CONTA' ).

        lo_column->set_short_text( 'Desc.Conta' ).
        lo_column->set_medium_text( 'Desc. Tipo Conta' ).
        lo_column->set_long_text( 'Descrição do Tipo de Conta' ).

        lo_columns->set_optimize( abap_true ).

      CATCH cx_salv_not_found.

      ENDTRY.

      lo_salv_table->get_functions( )->set_all( ).
      lo_salv_table->display( ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>main( ).