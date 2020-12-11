TYPES: BEGIN OF ty_password,
         pos1   TYPE i,
         pos2   TYPE i,
         letter TYPE c LENGTH 1,
         password     TYPE string,
       END OF ty_password.
TYPES tt_password TYPE STANDARD TABLE OF ty_password WITH EMPTY KEY.
