CLASS zcl_day4_ns DEFINITION
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
    DATA rules TYPE tt_pass_fields.

    METHODS fill_passes
      RETURNING VALUE(result) TYPE tt_pass.

    METHODS has_all_fields
      IMPORTING passfields    TYPE tt_pass_fields
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS has_all_fields_valid
      IMPORTING passfields    TYPE tt_pass_fields
      RETURNING VALUE(result) TYPE abap_bool.
ENDCLASS.



CLASS zcl_day4_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    LOOP AT me->fill_passes( ) INTO DATA(pass).
      result += SWITCH #( me->has_all_fields( pass ) WHEN abap_true THEN 1 ).
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    result = REDUCE #( INIT sum = 0
                FOR pass IN me->fill_passes( )
                NEXT sum += SWITCH #( me->has_all_fields_valid( pass ) WHEN abap_true THEN 1 ) ).
  ENDMETHOD.

  METHOD has_all_fields.
    DATA(missing_fields) = FILTER #( rules EXCEPT IN passfields WHERE field = field ).
    result = xsdbool( lines( missing_fields ) = 0 ).
  ENDMETHOD.

  METHOD has_all_fields_valid.
    result = abap_true.
    LOOP AT rules INTO DATA(rule).
      DATA(passfield) = VALUE #( passfields[ field = rule-field ]-value OPTIONAL ).
      IF  passfield IS INITIAL OR NOT matches( val = passfield regex = rule-value ).
        result = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( input ).
    rules = VALUE #(
        ( field = |byr| value = '^19[2-9][0-9]$|^200[0-2]$' )
        ( field = |iyr| value = '^201[0-9]$|^2020$')
        ( field = |eyr| value = '^202[0-9]$|^2030$' )
        ( field = |hgt| value = '^((1[5-8][0-9]|19[0-3])cm)$|^((59|6[0-9]|7[0-6])in)$' )
        ( field = |hcl| value = '^#[0-9a-f]{6}$' )
        ( field = |ecl| value = '^amb$|^blu$|^brn$|^gry$|^grn$|^hzl$|^oth$')
        ( field = |pid| value = '^\d{9}$' ) ).
  ENDMETHOD.

  METHOD fill_passes.
    DATA pass TYPE tt_pass_fields.
    LOOP AT input INTO DATA(passline).
      IF passline IS NOT INITIAL.
        SPLIT passline AT space INTO TABLE DATA(fields).
        LOOP AT fields INTO DATA(field).
          SPLIT field AT ':' INTO DATA(name) DATA(value).
          INSERT VALUE #( field = name value = value ) INTO TABLE pass.
        ENDLOOP.
      ENDIF.
      IF passline IS INITIAL OR sy-tabix = lines( input ).
        APPEND pass TO result.
        CLEAR pass[].
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
