CLASS zcl_day1_ns_loop DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_day1_ns_loop IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    DATA(numbers) = lines( input ).
    LOOP AT input INTO DATA(i) FROM 1 TO numbers - 1.
      LOOP AT input INTO DATA(j) FROM sy-tabix + 1.
        IF i + j = 2020.
          result = i * j.
          RETURN.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(lines) = lines( input ).
    LOOP AT input INTO DATA(i) FROM 1 TO lines - 2.
      LOOP AT input INTO DATA(j) FROM sy-tabix + 1 TO lines - 1.
        LOOP AT input INTO DATA(m) FROM sy-tabix + 1 TO lines.
          IF i + j + m = 2020.
            result = i * j * m.
            RETURN.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
