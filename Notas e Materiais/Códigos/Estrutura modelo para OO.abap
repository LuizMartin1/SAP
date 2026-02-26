CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.

  "*Variaveis Globais
  CLASS-DATA: ...

  PRIVATE SECTION.
    "* Métodos e atributos para o processamento do programa
    CLASS-METHODS: ...
ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS p_... TYPE char1 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main IMPLEMENTATION.
  METHOD main.
    ... " Code here
  ENDMETHOD.

  METHOD ... " Another method
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_main=>main( ).