*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_CORRESPONDING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlh_old_vs_new_corresponding.

TYPES: BEGIN OF flight,
         carrid   TYPE spfli-carrid,
         connid   TYPE spfli-connid,
         cityfrom TYPE spfli-cityfrom,
         cityto   TYPE spfli-cityto,
       END OF flight,

       flights TYPE SORTED TABLE OF flight WITH UNIQUE KEY carrid connid.

SELECT *
  FROM spfli
  INTO TABLE @DATA(ti_spfli).

*&---------------------------------------------------------------------*
*&                          ANTIGO
*&---------------------------------------------------------------------*
DATA flights TYPE flights.
MOVE-CORRESPONDING ti_spfli TO flights.

cl_demo_output=>write( flights ).


*&---------------------------------------------------------------------*
*&                          NOVO
*&---------------------------------------------------------------------*

cl_demo_output=>display( CORRESPONDING flights( ti_spfli ) ).