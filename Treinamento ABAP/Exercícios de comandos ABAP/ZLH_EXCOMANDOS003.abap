*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS003
*&---------------------------------------------------------------------*
*& 3. Leia a data atual do sistema e escreva em português a data por extenso.
*&---------------------------------------------------------------------*
REPORT zlh_excomandos003.

DATA: data_atual TYPE sy-datum,
      v_dia(2)   TYPE c,
      v_ano(4)   TYPE c,
      v_mes      TYPE string.

v_dia = sy-datum+6(2).
v_mes = sy-datum+4(2).
v_ano = sy-datum+0(4).

SELECT ltx
  FROM t247
  INTO v_mes
  WHERE spras = sy-langu
  AND mnr = v_mes.

ENDSELECT.

WRITE: v_dia, ' de ', v_mes, ' de ', v_ano.