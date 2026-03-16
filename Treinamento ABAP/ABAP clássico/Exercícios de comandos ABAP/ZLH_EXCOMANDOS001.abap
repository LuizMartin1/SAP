*&---------------------------------------------------------------------*
*& Report ZLH_EXCOMANDOS001
*&---------------------------------------------------------------------*
*& 1. Concatene duas palavras e escreva o resultado.
*&---------------------------------------------------------------------*
REPORT zlh_excomandos001.

DATA: p1  TYPE string VALUE 'Auto',
      p2  TYPE string VALUE 'estudo',
      res TYPE string.

CONCATENATE p1 p2 INTO res.

WRITE: res.