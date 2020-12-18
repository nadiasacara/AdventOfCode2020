CLASS zcl_day17_ns2_multidim_input DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_result_cube
      RETURNING VALUE(result) TYPE char_cube.

    METHODS add_inactive_neighbours
      IMPORTING cube          TYPE char_cube
      RETURNING VALUE(result) TYPE char_cube.

    METHODS calculate_new_values
      IMPORTING cube          TYPE char_cube
      RETURNING VALUE(result) TYPE char_cube.

    METHODS count_active_neighbours
      IMPORTING coord         TYPE ty_coord
                cube          TYPE char_cube
      RETURNING VALUE(result) TYPE i.

    METHODS get_neighbours
      IMPORTING coord         TYPE ty_coord
                cube          TYPE char_cube
      RETURNING VALUE(result) TYPE tt_coord.



    METHODS get_result_cube2
      RETURNING VALUE(result) TYPE char_cube4.

    METHODS add_inactive_neighbours2
      IMPORTING cube4         TYPE char_cube4
      RETURNING VALUE(result) TYPE char_cube4.

    METHODS calculate_new_values2
      IMPORTING cube4         TYPE char_cube4
      RETURNING VALUE(result) TYPE char_cube4.

    METHODS count_active_neighbours2
      IMPORTING coord         TYPE ty_coord4
                cube4         TYPE char_cube4
      RETURNING VALUE(result) TYPE i.

    METHODS get_neighbours2
      IMPORTING coord         TYPE ty_coord4
                cube4         TYPE char_cube4
      RETURNING VALUE(result) TYPE tt_coord4.
ENDCLASS.



CLASS zcl_day17_ns2_multidim_input IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    result = REDUCE #( INIT sum = 0
                FOR matrix IN me->get_result_cube( )
                    FOR line IN matrix
                        FOR char IN line WHERE ( table_line = '#' )
                NEXT sum += 1 ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = REDUCE #( INIT sum = 0
                FOR cube IN me->get_result_cube2( )
                    FOR matrix IN cube
                        FOR line IN matrix
                            FOR char IN line WHERE ( table_line = '#' )
                NEXT sum += 1 ).
  ENDMETHOD.

  METHOD get_result_cube.
    result = VALUE #( ( VALUE char_matrix( FOR line IN input
                            ( VALUE #( FOR i = 0 WHILE i < strlen( line ) ( CONV #( line+i(1) ) ) ) ) ) ) ).
    DO 6 TIMES.
      result =  me->calculate_new_values( me->add_inactive_neighbours( result ) ).
    ENDDO.
  ENDMETHOD.

  METHOD add_inactive_neighbours.
    DATA(initial_matrix) = VALUE char_matrix( FOR i = 1 WHILE i <= lines( cube[ 1 ] ) + 2
                            ( VALUE #( FOR j = 1 WHILE j <= lines( cube[ 1 ][ 1 ] ) + 2 ( '.' ) ) ) ).

    DATA(initial_line) = VALUE tt_chartab( FOR i = 1 WHILE i <= lines( cube[ 1 ][ 1 ] ) + 2 ( '.' ) ).

    result = VALUE #(
        ( initial_matrix )
        ( LINES OF VALUE #( FOR matrix IN cube ( VALUE #(
                ( initial_line )
                ( LINES OF VALUE #( FOR line IN matrix ( VALUE #( ( '.' ) ( LINES OF line ) ( '.' ) ) ) ) )
                ( initial_line ) )
             ) ) )
        ( initial_matrix ) ).
  ENDMETHOD.

  METHOD calculate_new_values.
    result = VALUE #( FOR matrix IN cube INDEX INTO z
                      ( VALUE #( FOR line IN matrix INDEX INTO y
                        ( VALUE #( FOR c IN line INDEX INTO x (
                            SWITCH #( me->count_active_neighbours( coord = VALUE #( x = x y = y z = z ) cube = cube )
                                WHEN 2 THEN SWITCH #( c WHEN '#' THEN '#' ELSE '.' )
                                WHEN 3 THEN '#' ELSE '.' ) ) ) ) ) ) ).
  ENDMETHOD.

  METHOD count_active_neighbours.
    result = REDUCE #( INIT sum = 0
        FOR n IN me->get_neighbours( coord = coord cube  = cube )
        NEXT sum += SWITCH #( cube[ n-z ][ n-y ][ n-x ] WHEN '#' THEN 1 ) ).
  ENDMETHOD.

  METHOD get_neighbours.
    DATA(end_x) = nmin( val1 = coord-x + 1 val2 = lines( cube[ coord-z ][ coord-y ] ) ).

    result = VALUE tt_coord(
        FOR k = nmax( val1 = 1 val2 = coord-z - 1 ) WHILE k <= nmin( val1 = coord-z + 1 val2 = lines( cube ) )
            FOR j =  nmax( val1 = 1 val2 = coord-y - 1 ) WHILE j <= nmin( val1 = coord-y + 1 val2 = lines( cube[ coord-z ] ) )
                FOR i = nmax( val1 = 1 val2 = coord-x - 1 ) WHILE i <= end_x
                    ( z = k y = j x = i ) ).
    DELETE result WHERE x = coord-x AND y = coord-y AND z = coord-z.
  ENDMETHOD.

  METHOD get_result_cube2.
    result = VALUE #( ( VALUE #( ( VALUE char_matrix( FOR line IN input
                            ( VALUE #( FOR i = 0 WHILE i < strlen( line ) ( CONV #( line+i(1) ) ) ) ) ) ) ) ) ).
    DO 6 TIMES.
      result =  me->calculate_new_values2( me->add_inactive_neighbours2( result ) ).
    ENDDO.
  ENDMETHOD.

  METHOD add_inactive_neighbours2.
    DATA(initial_cube) = VALUE char_cube( FOR k = 1 WHILE k <= lines( cube4[ 1 ] ) + 2 (
                             VALUE #( FOR j = 1 WHILE j <= lines( cube4[ 1 ][ 1 ] ) + 2
                                ( VALUE #( FOR i = 1 WHILE i <= lines( cube4[ 1 ][ 1 ][ 1 ] ) + 2 ( '.' ) ) ) ) ) ).

    DATA(initial_matrix) = VALUE char_matrix( FOR i = 1 WHILE i <= lines( cube4[ 1 ][ 1 ] ) + 2
                            ( VALUE #( FOR j = 1 WHILE j <= lines( cube4[ 1 ][ 1 ][ 1 ] ) + 2 ( '.' ) ) ) ).

    DATA(initial_line) = VALUE tt_chartab( FOR i = 1 WHILE i <= lines( cube4[ 1 ][ 1 ][ 1 ] ) + 2 ( '.' ) ).

    result = VALUE #(
        ( initial_cube )
        ( LINES OF VALUE #( FOR cube IN cube4 ( VALUE #(
            ( initial_matrix )
            ( LINES OF VALUE #( FOR matrix IN cube ( VALUE #(
                    ( initial_line )
                    ( LINES OF VALUE #( FOR line IN matrix ( VALUE #( ( '.' ) ( LINES OF line ) ( '.' ) ) ) ) )
                    ( initial_line ) )
                 ) ) )
            ( initial_matrix ) ) ) ) )
        ( initial_cube ) ).
  ENDMETHOD.

  METHOD calculate_new_values2.
    result = VALUE #( FOR cube IN cube4 INDEX INTO w (
                         VALUE #( FOR matrix IN cube INDEX INTO z
                          ( VALUE #( FOR line IN matrix INDEX INTO y
                            ( VALUE #( FOR c IN line INDEX INTO x (
                                SWITCH #( me->count_active_neighbours2( coord = VALUE #( x = x y = y z = z w = w ) cube4 = cube4 )
                                    WHEN 2 THEN SWITCH #( c WHEN '#' THEN '#' ELSE '.' )
                                    WHEN 3 THEN '#' ELSE '.' ) ) ) ) ) ) ) ) ).
  ENDMETHOD.

  METHOD count_active_neighbours2.
    result = REDUCE #( INIT sum = 0
        FOR n IN me->get_neighbours2( coord = coord cube4  = cube4 )
        NEXT sum += SWITCH #( cube4[ n-w ][ n-z ][ n-y ][ n-x ] WHEN '#' THEN 1 ) ).
  ENDMETHOD.

  METHOD get_neighbours2.
    DATA(end_x) = nmin( val1 = coord-x + 1 val2 = lines( cube4[ coord-w ][ coord-z ][ coord-y ] ) ).

    result = VALUE tt_coord4(
        FOR l = nmax( val1 = 1 val2 = coord-w - 1 ) WHILE l <= nmin( val1 = coord-w + 1 val2 = lines( cube4 ) )
            FOR k = nmax( val1 = 1 val2 = coord-z - 1 ) WHILE k <= nmin( val1 = coord-z + 1 val2 = lines( cube4[ coord-w ] ) )
                FOR j =  nmax( val1 = 1 val2 = coord-y - 1 ) WHILE j <= nmin( val1 = coord-y + 1 val2 = lines( cube4[ coord-w ][ coord-z ] ) )
                    FOR i = nmax( val1 = 1 val2 = coord-x - 1 ) WHILE i <= end_x
                        ( w = l z = k y = j x = i ) ).
    DELETE result WHERE x = coord-x AND y = coord-y AND z = coord-z AND w = coord-w.
  ENDMETHOD.


ENDCLASS.
