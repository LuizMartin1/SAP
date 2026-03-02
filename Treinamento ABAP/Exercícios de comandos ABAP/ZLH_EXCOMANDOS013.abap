*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS013
*&---------------------------------------------------------------------*
*& 13. Faça uma rotina que receba uma workarea e some todos os seus campos numéricos (a workarea deve conter no mínimo 3 campos deste tipo)
*&---------------------------------------------------------------------*
REPORT zlh_excomandos013.

TYPES: BEGIN OF ty_wk,
         campo1 TYPE i,
         campo2 TYPE i,
         campo3 TYPE i,
         campo4 TYPE char01,
         campo5 TYPE string,
       END OF ty_wk.

START-OF-SELECTION.
  PERFORM zlh_soma_campos.

FORM zlh_soma_campos.

  DATA: wa      TYPE ty_wk,
        sum     TYPE i,
        lv_tipo TYPE c.

  FIELD-SYMBOLS: <fs_campo> TYPE any.

  wa-campo1 = 2.
  wa-campo2 = 10.
  wa-campo3 = 5.
  wa-campo4 = 'X'.
  wa-campo5 = 'Martini de Souza'.

  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE wa TO <fs_campo>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.


    DESCRIBE FIELD <fs_campo> TYPE lv_tipo.


    IF lv_tipo EQ 'I' OR lv_tipo EQ 'F'. "No momento apenas testar esses dois tipos numéricos.

      sum += <fs_campo>.

    ENDIF.
  ENDDO.

  WRITE: 'Resultado da soma dos campos numericos: ', sum.

ENDFORM. "zlh_soma_campos.