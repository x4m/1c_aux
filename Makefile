
MODULE_big = yndx_1c_aux

EXTENSION = yndx_1c_aux
DATA = yndx_1c_aux--1.0.sql yndx_1c_aux--1.0--1.1.sql yndx_1c_aux--1.1--1.2.sql
REGRESS = yndx_1c_aux

# Disable LLVM bitcode install - otherwise with with_llvm=yes install_llvm_module
# is called with empty OBJS, causing "mkdir: missing operand" error
override with_llvm = no

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/yndx_1c_aux
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
