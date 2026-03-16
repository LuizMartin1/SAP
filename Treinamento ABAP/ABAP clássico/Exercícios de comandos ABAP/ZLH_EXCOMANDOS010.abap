*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS010
*&------------------------------------------------------------------------------------------------------------*
*& 10. Faça uma rotina que recebe dois números e escreve o resultado da operação [maior_numero / menor_numero]
*  caso os números sejam diferentes e escreva o resultado de [número ^ 2] caso sejam iguais.
*&------------------------------------------------------------------------------------------------------------*
REPORT zlh_excomandos010.

DATA: maior_num TYPE i VALUE 4,
      menor_num TYPE i VALUE 0,
      res       TYPE i.

START-OF-SELECTION.
  PERFORM zlh_operacao.


FORM zlh_operacao.

  IF maior_num EQ menor_num.

    res = maior_num ** 2.

    WRITE: maior_num, ' ^ 2 = ', res.

  ELSE.

    IF menor_num NE 0.

      res = maior_num / menor_num.

      WRITE: maior_num, ' / ', menor_num, ' = ', res.

    ELSE.

      WRITE: 'Menor numero precisa ser diferente de zero.'.

    ENDIF.

  ENDIF.

ENDFORM.