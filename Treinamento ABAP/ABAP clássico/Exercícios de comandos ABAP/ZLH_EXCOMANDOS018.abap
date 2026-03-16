*&---------------------------------------------------------------------*
*& Report ZLH_EX18
*&---------------------------------------------------------------------*
*& 18. Faça uma rotina que receba uma string e um número (Z) menor ou igual a 20. 
*  O programa deve imprimir a string Z vezes com a seguinte saída conforme exemplo:
*    a. String = “Good Food, Good Life”. Z = 20. Saída:
*    b. Linha [sy-?????]: G
*    c. Linha [sy-?????]:Go
*    d. Linha [sy-?????]:Goo
*    e. Linha [sy-?????]:Good
*    f. Linha [sy-?????]:Good (aqui tem um espaço)
*    g. Linha [sy-?????]:Good F
*    h. (...)
*    i. Linha [Z]: Good Food, Good Life
*    Caso Z seja maior que 20 imprimir uma mensagem de erro usando o comando WRITE.
*&---------------------------------------------------------------------*
REPORT zlh_ex18.

PARAMETERS: p_string TYPE string DEFAULT 'Good Food, Good Life',
            p_z      TYPE i.

START-OF-SELECTION.

  IF p_z > 20.
    WRITE: / 'Erro: O valor de Z não pode ser maior que 20.'.
  ELSEIF p_z <= 0.
    WRITE: / 'Erro: O valor de Z deve ser maior que 0.'.
  ELSE.
    PERFORM zlh_imprime_escada USING p_string p_z.
  ENDIF.

FORM zlh_imprime_escada USING texto TYPE string
                                   z TYPE i.

  DATA: lv_tamanho TYPE i.
  lv_tamanho = strlen( texto ).

  DO z TIMES.

    IF sy-index <= lv_tamanho.
      DATA(lv_saida) = texto+0(sy-index).
    ELSE.

      lv_saida = texto.
    ENDIF.

    WRITE: / |Linha [{ sy-index }]: { lv_saida }|.
  ENDDO.

ENDFORM." zlh_imprime_escada