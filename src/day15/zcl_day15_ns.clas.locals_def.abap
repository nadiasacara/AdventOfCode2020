TYPES: BEGIN OF ty_game,
         number           TYPE i,
         last_turn        TYPE i,
         before_last_turn TYPE i,
       END OF ty_game.
TYPES tt_game TYPE SORTED TABLE OF ty_game WITH UNIQUE KEY number.
