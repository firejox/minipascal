PROGRAM feature;

VAR n:integer;

BEGIN
    n:=1;
    case n of
        0 : write('0');
        1,2,3 : write('other')
    end;
END.
