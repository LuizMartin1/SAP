*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_FIELD_SYMBOL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLH_OLD_VS_NEW_FIELD_SYMBOL.

SELECT *
  FROM scarr
  INTO TABLE @DATA(ti_scarr).
  
*&---------------------------------------------------------------------*
*&                          ANTIGO
*&---------------------------------------------------------------------*
FIELD-SYMBOLS <scarr_old> LIKE LINE OF scarr.
  
LOOP AT  scarr ASSIGNING <fs_scarr>.
 "Lógica qualquer dentro do loop.
ENDLOOP.

*&---------------------------------------------------------------------*
*&                          NOVO
*&---------------------------------------------------------------------*
LOOP AT scarr ASSIGNING FIELD-SYMBOL(<fs_scarr_novo>).
  "Lógica qualquer dentro do loop.
ENDLOOP.