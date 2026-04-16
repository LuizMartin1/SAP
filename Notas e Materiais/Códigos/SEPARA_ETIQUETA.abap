*&-----------------------------------------------------------------------------*
*& Estrutura pra separação de etiqueta coletor
*&-----------------------------------------------------------------------------*

*&-----------------------------------------------------------------------------------*
*& Exemplo de etiqueta: (18)material(10)lote(11)maquina_deposito(14)quantidade(10)ud
*&-----------------------------------------------------------------------------------*

FORM zlh_separa_etiqueta.

  DATA: t_etiqueta TYPE TABLE OF string,
        w_etiqueta TYPE string,
        v_num1     TYPE string,
        v_num2     TYPE string,
        v_index    TYPE sy-index.

  SPLIT v_etiqueta AT '(' INTO TABLE t_etiqueta.

  LOOP AT t_etiqueta INTO w_etiqueta.

    v_index = sy-tabix.

    SPLIT w_etiqueta AT ')' INTO v_num1 v_num2.
    CASE v_index.
      WHEN 2.
        v_material   = v_num2.
      WHEN 3.
        v_lote       = v_num2.
      WHEN 4.
        v_maquina    = v_num2.
      WHEN 5.
        v_quantidade = v_num2.
      WHEN 6.
        v_ud         = v_num2.
    ENDCASE.
    
  ENDLOOP.
  
ENDFORM.