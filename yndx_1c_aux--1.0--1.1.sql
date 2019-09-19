-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION yndx_1c_aux" to load this file. \quit

CREATE OR REPLACE FUNCTION datediff(character varying, timestamp without time zone, timestamp without time zone)
RETURNS integer AS
$BODY$
DECLARE
arg_mode alias for $1;
arg_d2 alias for $2;
arg_d1 alias for $3;
BEGIN
        if arg_mode = 'SECOND' then
                return date_part('epoch', arg_d1) - date_part('epoch', arg_d2);
        elsif arg_mode = 'MINUTE' then
                return ceil((date_part('epoch', arg_d1) - date_part('epoch', arg_d2)) / 60);
        elsif arg_mode = 'HOUR' then
                return ceil((date_part('epoch', arg_d1) - date_part('epoch', arg_d2)) / 3600);
        elsif arg_mode = 'DAY' then
                return cast(arg_d1 as date) - cast(arg_d2 as date);
        elsif arg_mode = 'WEEK' then
                return ceil( ( cast(arg_d1 as date) - cast(arg_d2 as date) ) / 7.0);
        elsif arg_mode = 'MONTH' then
                return 12 * (date_part('year', arg_d1) - date_part('year', arg_d2))
                        + date_part('month', arg_d1) - date_part('month', arg_d2);
        elsif arg_mode = 'QUARTER' then
                return 4 * (date_part('year', arg_d1) - date_part('year', arg_d2))
                        + date_part('quarter', arg_d1) - date_part('quarter', arg_d2);
        elsif arg_mode = 'YEAR' then
                return (date_part('year', arg_d1) - date_part('year', arg_d2));
        end if;
END
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

CREATE OR REPLACE FUNCTION plpgsql_call_handler()
RETURNS language_handler
AS '$libdir/plpgsql', 'plpgsql_call_handler'
LANGUAGE 'c';
);