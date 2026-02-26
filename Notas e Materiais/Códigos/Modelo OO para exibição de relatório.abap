FORM zlh_exibe_relatorio.

  DATA: lo_columns TYPE REF TO cl_salv_columns_table,
        lo_column  TYPE REF TO cl_salv_column.

  DATA: r_events       TYPE REF TO cl_salv_events_table.

  TRY.
      cl_salv_table=>factory(
            IMPORTING
              r_salv_table   = DATA(lo_salv_table)
            CHANGING
              t_table        = ti_saida
          ).
    CATCH cx_salv_msg.
      MESSAGE 'Erro ao criar o ALV SALV!' TYPE 'E'.

  ENDTRY.

  IF lo_salv_table IS BOUND.

    TRY.
        lo_columns = lo_salv_table->get_columns( ).
		
		"Exemplo de configurar nome da coluna que será exibida no ALV.
        lo_column = lo_columns->get_column( 'TIPO' ).

        lo_column->set_short_text( 'Tipo' ).
        lo_column->set_medium_text( 'Tipo' ).
        lo_column->set_long_text( 'Tipo' ).

        lo_columns->set_optimize( abap_true ).

      CATCH cx_salv_not_found.

    ENDTRY.

    lo_salv_table->get_functions( )->set_all( abap_true ).
    lo_salv_table->display( ).

  ENDIF.
ENDFORM. "zlh_exibe_relatorio