*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_REDUCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLH_OLD_VS_NEW_REDUCE.

DATA: lv_soma_antiga TYPE sflight-price.

DATA: ti_voos_antigo TYPE TABLE OF sflight,
      wa_voos_antigo TYPE sflight.


*&---------------------------------------------------------------------*
*&                            ANTIGO
*&---------------------------------------------------------------------*
SELECT *
  FROM sflight
  INTO TABLE ti_voos_antigo.

LOOP AT ti_voos_antigo INTO wa_voos_antigo.
  lv_soma_antiga = lv_soma_antiga + wa_voos_antigo-price.
ENDLOOP.

cl_demo_output=>write( lv_soma_antiga ).
*&---------------------------------------------------------------------*
*&                            NOVO
*&---------------------------------------------------------------------*
SELECT *
  FROM sflight
  INTO TABLE @DATA(ti_voos_novo).

DATA(lv_soma_nova) = REDUCE sflight-price(
  INIT soma = 0
  FOR wa IN ti_voos_novo
  NEXT soma = soma + wa-price
).

cl_demo_output=>write( lv_soma_nova ).
cl_demo_output=>display(  ).