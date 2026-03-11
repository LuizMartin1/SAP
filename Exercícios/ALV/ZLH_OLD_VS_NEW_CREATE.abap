*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_CREATE
*&---------------------------------------------------------------------*
*& Exemplo de CREATE
*&---------------------------------------------------------------------*
REPORT zlh_old_vs_new_create.

CLASS classe DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING texto TYPE string,
      acao.
  PRIVATE SECTION.
    DATA texto TYPE string.
ENDCLASS.

CLASS classe IMPLEMENTATION.
  METHOD constructor.
    me->texto = texto.
  ENDMETHOD.

  METHOD acao.
    cl_demo_output=>write( 'Ação: ' && me->texto ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
*&---------------------------------------------------------------------*
*&                            ANTIGO
*&---------------------------------------------------------------------*
  DATA referencia TYPE REF TO classe.

  CREATE OBJECT referencia
    EXPORTING
      texto = '---Versão Antiga---'.

  referencia->acao( ).
*&---------------------------------------------------------------------*
*&                           NOVO
*&---------------------------------------------------------------------*

  NEW classe( '---Versão Nova---' )->acao( ).

  cl_demo_output=>display( ).