*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_MATCHING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLH_OLD_VS_NEW_MATCHING.

DATA email TYPE string VALUE 'martiniluiz@sap.com'.

cl_demo_input=>request( CHANGING field = email ).

*&---------------------------------------------------------------------*
*&                            ANTIGO
*&---------------------------------------------------------------------*
DATA(matcher) = cl_abap_matcher=>create(
    pattern = `\w+(\.\w+)*@(\w+\.)+(\w{2,4})`
    ignore_case = abap_true
    text = email ).

DATA(match) = matcher->match( ).

IF match = abap_true.
  cl_demo_output=>write( 'Sim' ).
  ELSE.
    cl_demo_output=>write( 'Não' ).
ENDIF.

*&---------------------------------------------------------------------*
*&                            NOVO
*&---------------------------------------------------------------------*

cl_demo_output=>write(
  COND #( WHEN matches( val = email
                         regex = `\w+(\.\w+)*@(\w+\.)+(\w{2,4})`
                         case  = abap_false )
           THEN 'Sim'
           ELSE 'Não' ) ).

cl_demo_output=>display( ).