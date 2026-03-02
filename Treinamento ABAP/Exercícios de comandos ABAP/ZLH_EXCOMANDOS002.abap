*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS002
*&---------------------------------------------------------------------*
*& 2. Concatene duas palavras e o mês atual, unindo por “-“ e escreva o resultado.
*&---------------------------------------------------------------------*
REPORT zlh_excomandos002.

DATA: p1  TYPE string VALUE 'mes',
      p2  TYPE string VALUE 'atual',
      mes TYPE sy-datum,
      res TYPE char20.

mes = sy-datum+4(2).

CONCATENATE p1 p2 mes INTO res SEPARATED BY '-'.

WRITE: res.