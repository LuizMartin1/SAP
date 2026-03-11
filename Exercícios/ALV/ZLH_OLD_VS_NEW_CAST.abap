*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_CAST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlh_old_vs_new_cast.

*&---------------------------------------------------------------------*
*&                           ANTIGO
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_voos,
         carrid      TYPE sflight-carrid,
         connid      TYPE sflight-connid,
         price       TYPE sflight-price,
         currency    TYPE sflight-currency,
         preco_moeda TYPE char20,
       END OF ty_voos.

DATA: ti_voos_antigo TYPE TABLE OF ty_voos,
      wa_voos_antigo TYPE ty_voos,
      lv_price_char  TYPE char20.

SELECT carrid connid price currency
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE ti_voos_antigo.

LOOP AT ti_voos_antigo INTO wa_voos_antigo.
  lv_price_char = wa_voos_antigo-price.

  CONDENSE lv_price_char NO-GAPS. "Tirar os zero a esquerda que estão sendo preenchidos.

  CONCATENATE lv_price_char wa_voos_antigo-currency INTO wa_voos_antigo-preco_moeda SEPARATED BY ' '.

  MODIFY ti_voos_antigo FROM wa_voos_antigo.
ENDLOOP.
*&---------------------------------------------------------------------*
*&                            NOVO
*&---------------------------------------------------------------------*

SELECT carrid, connid, price, currency, concat_with_space( CAST( price AS CHAR ), currency, 1 ) AS preco_moeda
  FROM sflight
  INTO TABLE @DATA(ti_voos_novo).

cl_demo_output=>next_section( '---ANTIGO---' ).
cl_demo_output=>write( ti_voos_antigo ).

cl_demo_output=>next_section( '---NOVO---' ).
cl_demo_output=>write( ti_voos_novo ).

cl_demo_output=>display( ).