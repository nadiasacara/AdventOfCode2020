CLASS zcl_day17_ns1_linear_input DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns .

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

    METHODS constructor
      IMPORTING input TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA cubes TYPE tt_char.
    DATA dimensions TYPE tt_int.
    DATA nr_cubes_in_dim TYPE tt_int.

    METHODS add_inactive_neighbours
      IMPORTING cubes         TYPE tt_char
      RETURNING VALUE(result) TYPE tt_char.

    METHODS calculate_new_values
      IMPORTING cubes         TYPE tt_char
      RETURNING VALUE(result) TYPE tt_char.

    METHODS count_active_neighbours
      IMPORTING VALUE(pos)    TYPE i
                cubes         TYPE tt_char
      RETURNING VALUE(result) TYPE i.

    METHODS get_neighbours_pos
      IMPORTING pos           TYPE i
                cubes         TYPE tt_char
      RETURNING VALUE(result) TYPE tt_int.
    METHODS get_result_cubes
      IMPORTING
        cubes         TYPE tt_char
      RETURNING
        VALUE(result) TYPE tt_char.
    METHODS convert_position_to_coords
      IMPORTING pos           TYPE i
      RETURNING VALUE(result) TYPE tt_int.

    METHODS convert_coords_to_position
      IMPORTING coords        TYPE tt_int
      RETURNING VALUE(result) TYPE i.
    METHODS get_neighbours_coords
      IMPORTING
        my_coords     TYPE tt_int
      RETURNING
        VALUE(result) TYPE tt_coords_list.

ENDCLASS.



CLASS zcl_day17_ns1_linear_input IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    dimensions = VALUE #( ( strlen( input[ 1 ] ) ) ( lines( input ) ) ( 1 ) ).
    result = REDUCE #( INIT sum = 0
                       FOR char IN me->get_result_cubes( cubes ) WHERE ( table_line = '#' )
                       NEXT sum += 1 ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    dimensions = VALUE #( ( strlen( input[ 1 ] ) ) ( lines( input ) ) ( 1 ) ( 1 ) ).
    result = REDUCE #( INIT sum = 0
                       FOR char IN me->get_result_cubes( cubes ) WHERE ( table_line = '#' )
                       NEXT sum += 1 ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    cubes = VALUE #( FOR line IN input
                        FOR i = 0 WHILE i < strlen( line )
                            ( CONV #( line+i(1) ) ) ).
  ENDMETHOD.

  METHOD get_result_cubes.
    result = cubes.
    DO 6 TIMES.
      result = me->calculate_new_values( me->add_inactive_neighbours( result ) ).
    ENDDO.
  ENDMETHOD.

  METHOD add_inactive_neighbours.
    DATA(dim_len) = 1.
    result = cubes.

    LOOP AT dimensions REFERENCE INTO DATA(dim).

      DATA(initial_values) = VALUE tt_char( FOR i = 1 WHILE i <= dim_len ( '.' ) ).
      DATA(new_result) = VALUE tt_char( ).
      DATA(old_dimension_len) = dim_len.
      dim_len *= dim->*.

      DO lines( result ) / dim_len TIMES.
        new_result = VALUE tt_char( BASE new_result
                ( LINES OF initial_values )
                ( LINES OF VALUE #( FOR wa IN result FROM 1 + dim_len * ( sy-index - 1 ) TO dim_len * sy-index ( wa ) ) )
                ( LINES OF initial_values ) ).
      ENDDO.

      dim->* += 2.
      dim_len = old_dimension_len * dim->*.
      result = new_result.
    ENDLOOP.

    nr_cubes_in_dim = VALUE tt_int( ). DATA(last_dim) = 1.
    LOOP AT dimensions INTO DATA(dimension).
      last_dim *= dimension.
      APPEND last_dim TO nr_cubes_in_dim.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculate_new_values.
    LOOP AT cubes INTO DATA(cube).
      DATA(actives) = me->count_active_neighbours( pos = sy-tabix cubes = cubes ).
      APPEND SWITCH #( cube
                WHEN '.' THEN SWITCH #( actives WHEN 3 THEN '#' ELSE '.' )
                WHEN '#' THEN SWITCH #( actives WHEN 2 OR 3 THEN '#' ELSE '.' ) ) TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD count_active_neighbours.
    result = REDUCE #( INIT sum = 0
      FOR p IN me->get_neighbours_pos( pos = pos cubes  = cubes )
      NEXT sum += SWITCH #( cubes[ p ] WHEN '#' THEN 1 ) ).
  ENDMETHOD.


  METHOD get_neighbours_pos.
    DATA(coords) = me->convert_position_to_coords( pos ).

    DATA(neighbr_coords) = me->get_neighbours_coords( coords ).

    result = VALUE #( FOR pos_coord IN neighbr_coords ( me->convert_coords_to_position( pos_coord ) ) ).
  ENDMETHOD.

  METHOD convert_position_to_coords.
    DATA(index) = lines( nr_cubes_in_dim ).
    DATA(lv_pos) = pos.
    DO lines( nr_cubes_in_dim ) TIMES.
      INSERT SWITCH i( index WHEN 1
                        THEN ( lv_pos - 1 ) MOD nr_cubes_in_dim[ index ] + 1
                        ELSE ( lv_pos - 1 ) DIV nr_cubes_in_dim[ index - 1 ] + 1 ) INTO result INDEX 1.
      lv_pos = COND #( WHEN index > 1 THEN ( lv_pos - 1 ) MOD nr_cubes_in_dim[ index - 1 ] + 1 ).
      index -= 1.
    ENDDO.
  ENDMETHOD.

  METHOD convert_coords_to_position.
    result = coords[ 1 ].
    LOOP AT coords INTO DATA(coord) FROM 2.
      result += ( coord - 1 ) * nr_cubes_in_dim[ sy-tabix - 1 ].
    ENDLOOP.
  ENDMETHOD.

  METHOD get_neighbours_coords.
    result = VALUE #( ( my_coords ) ).

    LOOP AT my_coords INTO DATA(coord).

      DATA(index) = sy-tabix.

      LOOP AT result INTO DATA(np) TO lines( result ).

        DATA(new_coord) = np.
        IF new_coord[ index ] > 1.
          new_coord[ index ] -= 1.
          APPEND new_coord TO result.
        ENDIF.

        new_coord = np.
        IF new_coord[ index ] < dimensions[ index ].
          new_coord[ index ] += 1.
          APPEND new_coord TO result.
        ENDIF.

      ENDLOOP.
    ENDLOOP.

    DELETE result INDEX 1.
  ENDMETHOD.

ENDCLASS.
