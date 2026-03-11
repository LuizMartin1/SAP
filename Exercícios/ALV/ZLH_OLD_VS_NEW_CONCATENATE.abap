*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_CONCATENATE
*&---------------------------------------------------------------------*
*& Exemplo de CONCATENATE
*&---------------------------------------------------------------------*
REPORT ZLH_OLD_VS_NEW_CONCATENATE.

DATA: nome TYPE sy-datum,
      data TYPE c LENGTH 10,
      hora TYPE sy-uzeit,
      hr_format type char8,
      resultado type string.

*&---------------------------------------------------------------------*
*&                          ANTIGO
*&---------------------------------------------------------------------*

nome = sy-uname.
hora = sy-uzeit.

WRITE sy-datlo TO data.
WRITE hora TO hr_format.

TRANSLATE nome TO LOWER CASE.
TRANSLATE nome(1) TO UPPER CASE.

CONCATENATE '---Versão Antiga---' cl_abap_char_utilities=>newline
            'Olá' nome '!' cl_abap_char_utilities=>newline
            'Hoje é' data cl_abap_char_utilities=>newline
            'Hora:' hr_format
INTO resultado SEPARATED BY ' '.

"WRITE comum não interpreta a função de newline.
cl_demo_output=>write( resultado ).

*&---------------------------------------------------------------------*
*&                          NOVO
*&---------------------------------------------------------------------*

cl_demo_output=>write(
        |---Versão Nova---\n| &&
       |Olá { nome }!\n| &&
       |Hoje é { data }\n| &&
       |Hora: { hr_format }\n|
).

"Exibe a função cl_demo_output().
cl_demo_output=>display( ).