CLASS zcl_day2_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns.

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_passwords
      RETURNING VALUE(result) TYPE tt_password.
ENDCLASS.



CLASS zcl_day2_ns IMPLEMENTATION.
  METHOD zif_aoc_ns~first.
    LOOP AT me->fill_passwords( ) REFERENCE INTO DATA(pw).
      DATA(count) = count( val = pw->password sub = pw->letter ).
      result += COND #( WHEN count BETWEEN pw->pos1 AND pw->pos2 THEN 1 ).
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    LOOP AT me->fill_passwords( ) REFERENCE INTO DATA(pw).
      DATA(count1) = count( val = pw->password sub = pw->letter off = pw->pos1 len = 1 ).
      DATA(count2) = count( val = pw->password sub = pw->letter off = pw->pos2 len = 1 ).
      result += COND #( WHEN count1 + count2 = 1 THEN 1 ).
    ENDLOOP.
  ENDMETHOD.

  METHOD fill_passwords.
    LOOP AT input REFERENCE INTO DATA(policy).
      SPLIT policy->* AT ':' INTO DATA(rule) DATA(password).
      SPLIT rule AT space INTO DATA(positions) DATA(letter).
      SPLIT positions AT '-' INTO DATA(pos1) DATA(pos2).
      INSERT VALUE #( pos1 = pos1 pos2 = pos2 letter = letter password = password ) INTO TABLE result.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
