*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_COND
*&---------------------------------------------------------------------*
*& Exemplo do comando COND
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------*
* IF:   Quando precisar executar AÇÕES (Métodos, Mensagens, Telas).
* COND: Quando precisar decidir um VALOR para uma variável.
*--------------------------------------------------------------------*
REPORT zlh_old_vs_new_cond.

DATA: html TYPE string,
      ola  TYPE string.

*&---------------------------------------------------------------------*
*&                          ANTIGO
*&---------------------------------------------------------------------*
IF sy-langu = 'F'.

  ola = 'Bonjour le monde'.
ELSE.
  ola = 'Hello World!'.
ENDIF.

CONCATENATE '<html>'
            '<body>'
            ola
            '</body>'
            '</html>' INTO html.

*&---------------------------------------------------------------------*
*&                          NOVO
*&---------------------------------------------------------------------*

DATA(html_novo) = '<html>'
               && '<body>'
               && COND #( WHEN sy-langu = 'F' THEN 'Bonjour le monde'
                                              ELSE 'Hello World!' )
               && '</body>'
               && '</html>'.

ASSERT html = html_novo."Comando de segurança para garantir que seja verdadeiro, se não, interrompe o programa.

cl_demo_output=>display_html( html_novo ). "Sem o display_html é exibido exatamente como está no comando CONCATENATE.