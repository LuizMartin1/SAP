*&---------------------------------------------------------------------*
*& Report ZLH_ALVVOOS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlh_alvvoos.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.

    "SCARR - carrid carrname
    "SFLIGHT - *

    TYPES: BEGIN OF ty_voos,
             carrid     TYPE scarr-carrid,
             carrname   TYPE scarr-carrname,
             connid     TYPE sflight-connid,
             fldate     TYPE sflight-fldate,
             price      TYPE sflight-price,
             currency   TYPE sflight-currency,
             planetype  TYPE sflight-planetype,
             seatsmax   TYPE sflight-seatsmax,
             seatsocc   TYPE sflight-seatsocc,
             paymentsum TYPE sflight-paymentsum,
             seatsmax_b TYPE sflight-seatsmax_b,
             seatsocc_b TYPE sflight-seatsocc_b,
             seatsmax_f TYPE sflight-seatsmax_f,
             seatsocc_f TYPE sflight-seatsocc_f,
           END OF ty_voos.

    "*Variaveis Globais
    CLASS-DATA: gt_voos   TYPE TABLE OF ty_voos,
                gv_carrid TYPE scarr-carrid,
                gv_fldate TYPE sflight-fldate.

  PRIVATE SECTION.
    "* Métodos e atributos para o processamento do programa
    CLASS-METHODS: get_data, set_data.
ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_carrid FOR lcl_main=>gv_carrid,
                  s_fldate FOR lcl_main=>gv_fldate.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main IMPLEMENTATION.
  METHOD main.
    get_data( ).
    set_data( ).  " Code here
  ENDMETHOD.

  METHOD get_data. " Another method

    SELECT *
      FROM scarr AS scarr
      INNER JOIN sflight AS sflight
      ON scarr~carrid EQ sflight~carrid
      INTO CORRESPONDING FIELDS OF TABLE @gt_voos
      WHERE scarr~carrid IN @s_carrid
      AND sflight~fldate IN @s_fldate.

  ENDMETHOD.

  METHOD set_data. " Another method


    TRY.
        cl_salv_table=>factory(
              IMPORTING
                r_salv_table   = DATA(lo_salv_table)
              CHANGING
                t_table        = gt_voos
            ).
      CATCH cx_salv_msg.

    ENDTRY.

    IF lo_salv_table IS BOUND.

      lo_salv_table->get_functions( )->set_all( ).
      lo_salv_table->display( ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>main( ).