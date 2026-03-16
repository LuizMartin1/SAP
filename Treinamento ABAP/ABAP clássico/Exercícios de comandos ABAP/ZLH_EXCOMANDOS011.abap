*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS011
*&---------------------------------------------------------------------*
*& 11. Faça uma rotina que deve conter uma workarea com 5 campos de tipos diferentes ou mais,
* esta deve ser populada e os seus campos devem ser impressos um em cada linha,
* separados por duas linhas horizontais.
*&---------------------------------------------------------------------*
REPORT ZLH_EXCOMANDOS011.

START-OF-SELECTION.
  PERFORM zlh_imprime_campos.


FORM zlh_imprime_campos.

  DATA: campo1 TYPE char01,
        campo2 TYPE string,
        campo3 TYPE i,
        campo4 TYPE f,
        campo5 TYPE d.

  campo1 = 'X'.
  campo2 = 'Luiz Henrique'.
  campo3 = 23.
  campo4 = '2.3'.
  campo5 = '20260321'.

  WRITE: 'Campo 1: ', campo1, / '-------------', / '-------------', / 'Campo 2: ', campo2, / '-------------', / '-------------', / 'Campo 3: ', campo3, / '-------------', / '-------------', / 'Campo 4: ', campo4 DECIMALS 2, / '-------------', /
'-------------', /
'Campo 5: ', campo5.

ENDFORM. "zlh_imprime_campos