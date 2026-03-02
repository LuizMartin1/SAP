*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS008
*&---------------------------------------------------------------------*
*& 7. Faça uma rotina que receba dois números e retorne o maior deles (caso os números sejam iguais retorne o próprio número).
*&---------------------------------------------------------------------------------------------------------------------------------*

REPORT zlh_excomandos008.

DATA: num1  TYPE i VALUE '6',
      num2  TYPE i VALUE '4',
      maior TYPE i VALUE '0'.

START-OF-SELECTION.
  PERFORM zlh_retorna_maior USING num1 num2 CHANGING maior.

  WRITE: 'Maior numero: ', maior.

FORM zlh_retorna_maior USING num1 num2 CHANGING maior.

  IF num1 > num2.
    maior = num1.
  ELSEIF num2 > num1.
    maior = num2.
  ELSE.
    maior = num1.

  ENDIF.

ENDFORM. "zlh_retorna_maior