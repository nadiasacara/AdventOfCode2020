CLASS zcl_day14_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

    METHODS constructor
      IMPORTING input TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA program TYPE tt_program.

    METHODS convert_to_binary
      IMPORTING i             TYPE int8
      RETURNING VALUE(result) TYPE tt_int.

    METHODS convert_from_binary
      IMPORTING binary        TYPE tt_int
      RETURNING VALUE(result) TYPE int8.

    METHODS apply_mask_to_value
      IMPORTING mask          TYPE tt_char
                number        TYPE int8
      RETURNING VALUE(result) TYPE int8.

    METHODS apply_mask_to_position
      IMPORTING mask          TYPE tt_char
                number        TYPE int8
      RETURNING VALUE(result) TYPE tt_int.
ENDCLASS.



CLASS zcl_day14_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    DATA memory TYPE tt_memory_sorted.

    LOOP AT me->program REFERENCE INTO DATA(line).
      LOOP AT line->operations REFERENCE INTO DATA(operation).
        READ TABLE memory WITH TABLE KEY position = operation->position REFERENCE INTO DATA(mem).
        IF sy-subrc IS NOT INITIAL.
          INSERT VALUE #( position = operation->position ) INTO TABLE memory REFERENCE INTO mem.
        ENDIF.
        mem->value = apply_mask_to_value( mask = CONV #( line->mask ) number = operation->value ).
      ENDLOOP.
    ENDLOOP.

    result = REDUCE #( INIT sum = CONV int8( 0 )
                       FOR wa IN memory
                       NEXT sum += wa-value ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA memory TYPE tt_memory_sorted.

    LOOP AT me->program REFERENCE INTO DATA(line).
      LOOP AT line->operations REFERENCE INTO DATA(operation).
        LOOP AT me->apply_mask_to_position( mask = CONV #( line->mask ) number = CONV #( operation->position ) ) INTO DATA(pos).

          READ TABLE memory WITH TABLE KEY position = pos REFERENCE INTO DATA(mem).
          IF sy-subrc IS NOT INITIAL.
            INSERT VALUE #( position = pos ) INTO TABLE memory REFERENCE INTO mem.
          ENDIF.
          mem->value = operation->value.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    result = REDUCE #( INIT sum = CONV int8( 0 )
                       FOR wa IN memory
                       NEXT sum += wa-value ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).

    LOOP AT input INTO DATA(line).
      IF line(4) = |mask|.
        APPEND VALUE ty_program( mask = VALUE #( FOR i = 7 WHILE i < 43 ( CONV #( line+i(1) ) ) ) )
            TO me->program REFERENCE INTO DATA(prog_line).
      ELSE.
        SPLIT line+4 AT '] = ' INTO DATA(position) DATA(value).
        APPEND VALUE #( position = position value = value ) TO prog_line->operations.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD convert_to_binary.
    DATA(nr) = i.
    DO 36 TIMES.
      DATA(bit) = SWITCH i( nr
          WHEN 0 THEN 0
          ELSE nr MOD 2 ).
      INSERT bit INTO result INDEX 1.
      nr = nr DIV 2.
    ENDDO.
  ENDMETHOD.

  METHOD convert_from_binary.
    result = REDUCE #( INIT val = CONV int8( 0 )
                       FOR wa IN binary INDEX INTO i
                       NEXT val += wa * ipow( base = 2 exp = 36 - i ) ).
  ENDMETHOD.

  METHOD apply_mask_to_value.
    DATA(binary) = me->convert_to_binary( number ).
    LOOP AT mask INTO DATA(char) WHERE table_line <> 'X'.
      binary[ sy-tabix ] = char.
    ENDLOOP.
    result = me->convert_from_binary( binary ).
  ENDMETHOD.

  METHOD apply_mask_to_position.

    DATA(binary) = me->convert_to_binary( number ).
    LOOP AT mask INTO DATA(char) WHERE table_line = '1' OR table_line = 'X'.
      binary[ sy-tabix ] = SWITCH #( char WHEN '1' THEN 1 ).
    ENDLOOP.
    APPEND me->convert_from_binary( binary ) TO result.

    DATA(addresses) = VALUE tt_binary_adrs( ( binary ) ).

    LOOP AT mask INTO char WHERE table_line = 'X'.
      DATA(tabix) = sy-tabix.
      LOOP AT addresses INTO DATA(address) TO lines( addresses ).
        address[ tabix ] = 1.
        APPEND me->convert_from_binary( address ) TO result.
        APPEND address TO addresses.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
