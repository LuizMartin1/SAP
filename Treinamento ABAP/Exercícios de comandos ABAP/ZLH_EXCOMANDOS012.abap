*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS012
*&---------------------------------------------------------------------*
*& 12. Faça uma rotina que receba uma workarea contendo 5 tipos de dados diferentes
* e conte quantos campos não estão preenchidos. Imprimir resultado.
*&---------------------------------------------------------------------*
REPORT zlh_excomandos012.

TYPES: BEGIN OF ty_workarea,
         campo1 TYPE char01,
         campo2 TYPE string,
         campo3 TYPE i,
         campo4 TYPE f,
         campo5 TYPE d,
       END OF ty_workarea.


START-OF-SELECTION.
  PERFORM zlh_conta_campos_vazios.

FORM zlh_conta_campos_vazios.

  DATA: cont TYPE i VALUE 0,
        wa   TYPE ty_workarea.

  FIELD-SYMBOLS: <fs_campo> TYPE any.

  wa-campo1 = 'X'.
  wa-campo2 = 'Martini'.

  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE wa TO <fs_campo>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    IF <fs_campo> IS INITIAL.

      cont += 1.

    ENDIF.
  ENDDO.

  WRITE: 'Número de campos vazios: ', cont.

ENDFORM. "zlh_conta_campos_vazios