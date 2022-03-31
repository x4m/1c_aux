CREATE EXTENSION mchar;
CREATE EXTENSION yndx_1c_aux;

select binrowver(x::integer) from generate_series(1,100,7) x;