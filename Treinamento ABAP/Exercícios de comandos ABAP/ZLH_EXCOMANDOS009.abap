*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS009
*&---------------------------------------------------------------------*
*& 9. Faça uma rotina que receba dois números e retorne um flag (caracter de tamanho 1).
*  Caso os números sejam iguais a flag retornada será ‘X’ e caso contrário a flag será igual a ‘ ‘ (space)
*&------------------------------------------------------------------------------------------------------------------*
REPORT zlh_excomandos009.

DATA: num1 TYPE i VALUE '3',
      num2 TYPE i VALUE '3',
      flag TYPE char1.

START-OF-SELECTION.
  PERFORM zlh_retorna_flag USING num1 num2 CHANGING flag.

  WRITE: 'FLAG: ', flag.

FORM zlh_retorna_flag USING num1 num2 CHANGING flag.

  IF num1 EQ num2.
    flag = 'X'.
  ELSE.
    flag = space.
  ENDIF.

ENDFORM. "zlh_retorna_flag