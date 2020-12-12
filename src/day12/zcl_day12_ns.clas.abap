CLASS zcl_day12_ns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_ns .

  PUBLIC SECTION.
    METHODS zif_aoc_ns~first REDEFINITION.
    METHODS zif_aoc_ns~second REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS move
      IMPORTING step  TYPE string
      CHANGING  point TYPE ty_coord.

    METHODS turn
      IMPORTING step      TYPE string
      CHANGING  direction TYPE c.

    METHODS rotate
      IMPORTING step     TYPE string
      CHANGING  waypoint TYPE ty_coord.
ENDCLASS.



CLASS zcl_day12_ns IMPLEMENTATION.

  METHOD zif_aoc_ns~first.
    DATA(direction) = 'E'.
    DATA(position) = VALUE ty_coord( x = 0 y = 0 ).
    LOOP AT input INTO DATA(step).
      step = SWITCH #( step(1) WHEN 'F' THEN replace( val = step off = 0 len = 1 with = direction ) ELSE step ).
      move( EXPORTING step  = step
            CHANGING point  = position ).
      turn( EXPORTING step  = step
            CHANGING  direction = direction ).
    ENDLOOP.
    result = abs( position-x ) + abs( position-y ).
  ENDMETHOD.

  METHOD zif_aoc_ns~second.
    DATA(position) = VALUE ty_coord( x = 0 y = 0 ).
    DATA(waypoint) = VALUE ty_coord( x = 10 y = 1 ).

    LOOP AT input INTO DATA(step).
      DATA(old_position) = position.
      position = SWITCH #( step(1) WHEN 'F'
        THEN VALUE ty_coord( x = old_position-x + waypoint-x * step+1 y = old_position-y + waypoint-y * step+1 )
        ELSE old_position ).
      move( EXPORTING step  = step
            CHANGING  point = waypoint ).
      rotate( EXPORTING step     = step
              CHANGING  waypoint = waypoint ).
    ENDLOOP.
    result = abs( position-x ) + abs( position-y ).
  ENDMETHOD.

  METHOD move.
    DATA(new_position) = SWITCH ty_coord( step(1)
        WHEN 'N' THEN VALUE #( x = point-x          y = point-y + step+1 )
        WHEN 'S' THEN VALUE #( x = point-x          y = point-y - step+1 )
        WHEN 'E' THEN VALUE #( x = point-x + step+1 y = point-y )
        WHEN 'W' THEN VALUE #( x = point-x - step+1 y = point-y )
        ELSE point ).
    point = new_position.
  ENDMETHOD.

  METHOD turn.
    IF step(1) = 'L' OR step(1) = 'R'.
      DATA(cardinals) = VALUE tt_cardinal_points(
          ( point = 'N' left_point = 'W' )
          ( point = 'E' left_point = 'N' )
          ( point = 'S' left_point = 'E' )
          ( point = 'W' left_point = 'S' )
      ).
      DO step+1 / 90 TIMES.
        direction = SWITCH #( step(1)
            WHEN 'L' THEN cardinals[ point = direction ]-left_point
            WHEN 'R' THEN cardinals[ left_point = direction ]-point ).
      ENDDO.
    ENDIF.
  ENDMETHOD.

  METHOD rotate.
    IF step(1) = 'L' OR step(1) = 'R'.
      DO step+1 / 90 TIMES.
        DATA(new_waypoint) = SWITCH ty_coord( step(1)
            WHEN 'L' THEN VALUE #( x = - waypoint-y y = waypoint-x )
            WHEN 'R' THEN VALUE #( x = waypoint-y   y = - waypoint-x ) ).
        waypoint = new_waypoint.
      ENDDO.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
