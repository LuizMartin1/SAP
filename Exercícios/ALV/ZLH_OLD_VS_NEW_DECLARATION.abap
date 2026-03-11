*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_DECLARATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlh_old_vs_new_declaration.



*&---------------------------------------------------------------------*
*&                            ANTIGO
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_str,
         nome    TYPE scarr-carrname,
         conexao TYPE spfli-connid,
       END OF ty_str.

DATA resultado TYPE STANDARD TABLE OF ty_str WITH EMPTY KEY.

SELECT scarr~carrname AS nome
       spfli~connid   AS conexao
  FROM spfli
  INNER JOIN scarr
  ON spfli~carrid = scarr~carrid
  INTO TABLE resultado
  ORDER BY nome conexao.


*&---------------------------------------------------------------------*
*&                            NOVO
*&---------------------------------------------------------------------*
SELECT FROM spfli
    INNER JOIN scarr
      ON spfli~carrid = scarr~carrid
 FIELDS  scarr~carrname AS nome,
         spfli~connid   AS conexao
  ORDER BY nome, conexao
  INTO TABLE @DATA(resultado_novo).


ASSERT resultado = resultado_novo.

cl_demo_output=>display( resultado_novo ).