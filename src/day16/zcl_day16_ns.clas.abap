CLASS zcl_day16_ns DEFINITION
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
    DATA valid_ranges TYPE tt_check_range.
    DATA nearby_tickets TYPE tt_ticket.
    DATA my_ticket TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS delete_invalid_tickets
      RETURNING VALUE(result) TYPE tt_ticket.

    METHODS get_all_valid_checks_for_flds
      RETURNING VALUE(result) TYPE tt_pos_checks.

    METHODS get_right_field_check_pair
      RETURNING VALUE(result) TYPE tt_found_fields.
ENDCLASS.



CLASS zcl_day16_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    result = REDUCE #( INIT sum = 0
                FOR ticket IN nearby_tickets
                    FOR wa IN ticket
                NEXT sum += COND #( WHEN wa NOT IN valid_ranges THEN wa ) ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    me->delete_invalid_tickets( ).
    result = REDUCE #( INIT produce = CONV int8( 1 )
                FOR wa IN me->get_right_field_check_pair( ) TO 6
                NEXT produce *= my_ticket[ wa-field_nr ] ).
  ENDMETHOD.

  METHOD constructor.

    super->constructor( input ).
    LOOP AT input INTO DATA(line) TO line_index( input[ table_line = '' ] ) - 1.
      SPLIT line AT ': ' INTO DATA(name) DATA(value).
      SPLIT value AT ' or ' INTO DATA(range1) DATA(range2).
      SPLIT range1 AT '-' INTO DATA(min) DATA(max).
      APPEND VALUE #( sign = 'I' option = 'BT' low = min high = max ) TO valid_ranges.
      SPLIT range2 AT '-' INTO min max.
      APPEND VALUE #( sign = 'I' option = 'BT' low = min high = max ) TO valid_ranges.
    ENDLOOP.

    LOOP AT input INTO line FROM line_index( input[ table_line = 'nearby tickets:' ] ) + 1.
      SPLIT line AT ',' INTO TABLE DATA(values).
      APPEND values TO nearby_tickets.
    ENDLOOP.

    SPLIT input[ line_index( input[ table_line = 'your ticket:' ] ) + 1 ] AT ',' INTO TABLE values.
    APPEND LINES OF values TO my_ticket.
  ENDMETHOD.

  METHOD delete_invalid_tickets.

    LOOP AT nearby_tickets INTO DATA(ticket).
      DATA(ticket_index) = sy-tabix.
      LOOP AT ticket INTO DATA(field).
        IF field NOT IN valid_ranges.
          DELETE nearby_tickets INDEX ticket_index.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_right_field_check_pair.

    DATA(field_checks) = me->get_all_valid_checks_for_flds( ).

    DO 20 TIMES.
      LOOP AT field_checks INTO DATA(field).
        IF lines( field-valid_checks ) = 1.

          INSERT VALUE #( field_nr = field-position check_nr = field-valid_checks[ 1 ] ) INTO TABLE result.

          LOOP AT field_checks REFERENCE INTO DATA(field_ref).
            DELETE field_ref->valid_checks WHERE table_line = field-valid_checks[ 1 ].
          ENDLOOP.
          EXIT.

        ENDIF.
      ENDLOOP.
    ENDDO.
  ENDMETHOD.

  METHOD get_all_valid_checks_for_flds.

    DO lines( my_ticket ) TIMES.
      APPEND VALUE #( position = sy-index ) TO result REFERENCE INTO DATA(field).

      DO 20 TIMES.
        DATA(current_check) = VALUE tt_check_range( ( valid_ranges[ sy-index * 2 - 1 ] ) ( valid_ranges[ sy-index * 2 ] ) ).

        DATA(field_is_in_check_range) = abap_true.
        LOOP AT nearby_tickets INTO DATA(ticket).
          IF NOT ticket[ field->position ] IN current_check.
            field_is_in_check_range = abap_false. EXIT.
          ENDIF.
        ENDLOOP.

        IF field_is_in_check_range = abap_true.
          APPEND sy-index TO field->valid_checks.
        ENDIF.
      ENDDO.
    ENDDO.

  ENDMETHOD.

ENDCLASS.
