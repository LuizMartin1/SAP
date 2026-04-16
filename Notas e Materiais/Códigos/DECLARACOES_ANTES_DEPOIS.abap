*&---------------------------------------------------------------------*
*& Report ZLH_DECLARACOES
*&---------------------------------------------------------------------*
*& Declarações Inline - Antes e Depois do ABAP 7.40
*&---------------------------------------------------------------------*
REPORT ZLH_DECLARACOES.

*&---------------------------------------------------------------------*
*& Declarações com valor
*&---------------------------------------------------------------------*

" ANTES
DATA v_teste TYPE string.
v_teste = 'ABC'.

" DEPOIS
DATA(v_teste) = 'ABC'.

*&---------------------------------------------------------------------*
*& Loop com estrutura
*&---------------------------------------------------------------------*
" ANTES
DATA wa LIKE LINE OF itab.
LOOP AT itab INTO wa.
...
ENDLOOP.

" DEPOIS
LOOP AT itab INTO DATA(wa).
...
ENDLOOP.

*&---------------------------------------------------------------------*
*& Chamar método
*&---------------------------------------------------------------------*
" ANTES
DATA: a1 TYPE char,
      a2 TYPE char.
oref->meth( IMPORTING p1 = a1
                      p2 = a2 ).


" DEPOIS
oref->meth( IMPORTING p1 = DATA(a1)
                      p2 = DATA(a2) ).

*&---------------------------------------------------------------------*
*& Loop assigning
*&---------------------------------------------------------------------*
" ANTES
FIELD-SYMBOLS: <fs> TYPE any.
LOOP AT itab ASSIGNING <fs>.
...
ENDLOOP.

" DEPOIS
LOOP AT itab ASSIGNING FIELD-SYMBOL(<fs>).
...
ENDLOOP.

*&---------------------------------------------------------------------*
*& Read assigning
*&---------------------------------------------------------------------*
" ANTES
FIELD-SYMBOLS: <fs> TYPE any.
READ TABLE itab ASSIGNING <fs>...

" DEPOIS
READ TABLE itab ASSIGNING FIELD-SYMBOL(<fs>)...

*&---------------------------------------------------------------------*
*& Select into table
*&---------------------------------------------------------------------*
" ANTES
DATA itab TYPE TABLE OF dbtab.
SELECT *
  FROM dbtab
  INTO TABLE itab
  WHERE fld1 = lv_fld1.

" DEPOIS
SELECT *
  FROM dbtab
  INTO TABLE @DATA(itab)
  WHERE fld1 = lv_fld1.
  
*&---------------------------------------------------------------------*
*& Select single into
*&---------------------------------------------------------------------*
" ANTES
SELECT SINGLE f1 f2
  FROM dbtab
  INTO (lv_f1, lv_f2)
  WHERE ... 
  
  
" DEPOIS
SELECT SINGLE f1 AS my_f1, f2 AS abc
  FROM dbtab
  INTO @DATA(ls_structure)
  WHERE ...
  
  WRITE: / ls_structure-my_f1, ls_structure-abc.