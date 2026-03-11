*&---------------------------------------------------------------------*
*& Report ZLH_OLD_VS_NEW_VALUE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlh_old_vs_new_value.

DATA: BEGIN OF animal,
        categoria TYPE string,
        especies  TYPE SORTED TABLE OF string WITH UNIQUE KEY table_line, "O table_line diz ao SAP: "Use o conteúdo da própria linha como a chave".
      END OF animal,

      animais_antigo LIKE SORTED TABLE OF animal WITH UNIQUE KEY categoria,
      animais_novo   LIKE SORTED TABLE OF animal WITH UNIQUE KEY categoria.

*&---------------------------------------------------------------------*
*&                          ANTIGO
* OBS: Em vez de aspas simples (' '), use a crase. Ela define o texto como tipo string nativamente.
*&---------------------------------------------------------------------*
animal-categoria = `Herbivoro`.
INSERT `Elefante` INTO TABLE animal-especies.
INSERT `Girafa`   INTO TABLE animal-especies.
INSERT `Coelho`   INTO TABLE animal-especies.
INSERT animal     INTO TABLE animais_antigo.
CLEAR animal.

animal-categoria = `Carnivoro`.
INSERT `Leão`    INTO TABLE animal-especies.
INSERT `Tubarão` INTO TABLE animal-especies.
INSERT `Tigre`   INTO TABLE animal-especies.
INSERT animal    INTO TABLE animais_antigo.
CLEAR animal.

animal-categoria = `Onivoro`.
INSERT `Urso-pardo` INTO TABLE animal-especies.
INSERT `Porco`      INTO TABLE animal-especies.
INSERT `Chimpanzé`  INTO TABLE animal-especies.
INSERT animal       INTO TABLE animais_antigo.

*&---------------------------------------------------------------------*
*&                          NOVO
*&---------------------------------------------------------------------*

animais_novo = VALUE #(
 ( categoria = `Herbivoro`
   especies = VALUE #( ( `Elefante` )
                        ( `Girafa`   )
                        ( `Coelho`   ) ) )
 ( categoria = `Carnivoro`
   especies = VALUE #( ( `Leão`    )
                        ( `Tubarão` )
                        ( `Tigre`   ) ) )
  ( categoria = `Onivoro`
    especies = VALUE #( ( `Urso-pardo` )
                         ( `Porco`      )
                         ( `Chimpanzé`  ) ) ) ).

ASSERT animais_novo = animais_antigo.