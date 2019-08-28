-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION yndx_1c_aux" to load this file. \quit

CREATE FUNCTION BINROWVER(p1 integer) RETURNS bytea
        LANGUAGE plpgsql
        AS $$
     DECLARE
     bytearea BYTEA;
     BEGIN
     bytearea := SET_BYTE('\\000\\000\\000\\000\\000\\000\\000\\000'::bytea, 4, MOD(P1 / 16777216, 256));
     bytearea := SET_BYTE(bytearea, 5, MOD(P1 / 65536, 256));
     bytearea := SET_BYTE(bytearea, 6, MOD(P1 / 256, 256));
     bytearea := SET_BYTE(bytearea, 7, MOD(P1, 256));
     RETURN bytearea;
     END;$$;

CREATE FUNCTION mchar_smaller(bytea, bytea)
RETURNS bytea
AS 'mchar'
LANGUAGE C IMMUTABLE RETURNS NULL ON NULL INPUT;
CREATE AGGREGATE min (
BASETYPE= bytea,
SFUNC = mchar_smaller,
STYPE= bytea,                                   
SORTOP= '<'
);

CREATE FUNCTION mchar_larger(bytea, bytea)
RETURNS bytea
AS 'mchar'
LANGUAGE C IMMUTABLE RETURNS NULL ON NULL INPUT;

CREATE AGGREGATE max (
	BASETYPE	= 	bytea,
	SFUNC 		= 	mchar_larger,
	STYPE		= 	bytea,
	SORTOP		= 	'>'
);

CREATE FUNCTION bool_smaller(boolean,boolean)
RETURNS boolean 
AS 'SELECT COALESCE($1 and $2, $1, $2)' LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE min (
BASETYPE= bool,
SFUNC = bool_smaller,
STYPE= bool,                                   
SORTOP= '<'
);

CREATE FUNCTION bool_larger(boolean,boolean)
RETURNS boolean 
AS 'SELECT COALESCE($1 or $2, $1, $2)' LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE max (
	BASETYPE	= 	bool,
	SFUNC 		= 	bool_larger,
	STYPE		= 	bool,
	SORTOP		= 	'>'
);