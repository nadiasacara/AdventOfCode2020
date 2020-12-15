TYPES: BEGIN OF ty_game,
         number      TYPE i,
         last        TYPE i,
         before_last TYPE i,
       END OF ty_game.
TYPES tt_game TYPE HASHED TABLE OF ty_game WITH UNIQUE KEY number.
