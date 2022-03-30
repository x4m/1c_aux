
MODULE_big = yndx_1c_aux

OBJS = yndx_1c_aux.o $(WIN32RES)

EXTENSION = yndx_1c_aux
DATA = yndx_1c_aux--1.0.sql yndx_1c_aux--1.0--1.1.sql yndx_1c_aux--1.1--1.2.sql
REGRESS = yndx_1c_aux

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
