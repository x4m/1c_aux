-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION yndx_1c_aux" to load this file. \quit

CREATE FUNCTION state_max_bytea(st bytea, inp bytea) RETURNS bytea
    LANGUAGE plpgsql
    AS $$
    BEGIN
         if st is null
         then
            return inp;
         elseif st<inp then
            return inp;
         else
            return st;
         end if;
    END;$$;


CREATE FUNCTION state_min_bytea(st bytea, inp bytea) RETURNS bytea
    LANGUAGE plpgsql
    AS $$
    BEGIN
         if st is null
         then
            return inp;
         elseif st>inp then
            return inp;
         else
            return st;
         end if;
    END;$$;

CREATE OR REPLACE AGGREGATE max (
	BASETYPE	= 	bytea,
	SFUNC 		= 	state_max_bytea,
	STYPE		= 	bytea,
	SORTOP		= 	'>'
);

CREATE OR REPLACE AGGREGATE min (
	BASETYPE	= 	bytea,
	SFUNC 		= 	state_min_bytea,
	STYPE		= 	bytea,
	SORTOP		= 	'>'
);