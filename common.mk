DIR_ROOT_REAL=$(realpath $(DIR_ROOT))

DIR_INCLUDES:=$(DIR_ROOT)/include
DIR_STATIC_LIB:=$(DIR_ROOT)/lib64/static
DIR_DYNAMIC_DDL:=$(DIR_ROOT)/lib64/dynamic
DIR_CURDIR:=$(subst $(DIR_ROOT_REAL),,$(CURDIR))

NAME_MODULE := $(notdir $(CURDIR))

DIR_OUT:=$(DIR_ROOT)/out
DIR_BIN:=$(DIR_OUT)/bin
DIR_OBJ:=$(DIR_OUT)/obj

DIR_OBJ_MODULE:=$(DIR_OBJ)$(DIR_CURDIR)
DIR_SUB_LIST:=$(addprefix  $(CURDIR)/,$(DIR_SUB_LIST))
DIR_SUB_LIST_OBJ:=$(FILE_LIST_C:%.c=%.o)
DIR_SUB_LIST_OBJ+=$(FILE_LIST_CPP:%.cpp=%.o)
DIR_SUB_LIST_OBJ:=$(addprefix $(DIR_OBJ_MODULE)/,$(DIR_SUB_LIST_OBJ))

# -------------------------------------------
DLL_DYNAMIC_NAME:=$(addsuffix .so, $(addprefix lib, $(FILE_DYNAMIC_NAME)))
LIB_STATIC_NAME:=$(addsuffix .a, $(addprefix lib, $(FILE_STATIC_NAME)))

DLL_SRC = $(wildcard $(DIR_DYNAMIC_DDL)/*.so)
DLL_TARGETS = $(patsubst $(DIR_DYNAMIC_DDL)/lib%.so, -l %, $(DLL_SRC))

LIB_SRC = $(wildcard $(DIR_STATIC_LIB)/*.a)
LIB_TARGETS = $(patsubst $(DIR_STATIC_LIB)/lib%.a, -l %, $(LIB_SRC))

# ------------------------------------------- exe
EXEC_APP:= $(DIR_BIN)/main.bin
# ------------------------------------------- shell command set
RM = rm -f
MV = mv -f
MKDIR = mkdir -pv
RMDIR = rm -rf  

# ------------------------------------------- echo print screen css
ECHO_END:=\033[0m"
ECHO_GREEN:=echo "\033[32m
ECHO_RED:=echo "\033[31m
ECHO_YELLOW:=echo "\033[33m
ECHO_BLUE:=echo "\033[34m
ECHO_GREEN_YELLOW:=echo "\033[42;30m

# ------------------------------------------- gcc g++ command set
CXX = g++
CC = gcc
WARN = -Wall -g
OPT ?=0

CXXFLAGS+= $(WARN) \
-O$(OPT) 

CFLAGS+= $(WARN) \
-O$(OPT) 

SHARED = -shared

LINKS = \
$(addprefix -I, $(DIR_INCLUDES)) 		\
$(addprefix -L, $(DIR_STATIC_LIB)) 		\
$(addprefix -L, $(DIR_DYNAMIC_DDL)) 	\
$(LIB_TARGETS)							\
$(DLL_TARGETS)							\

# -------------------------------------------
make_frame:mk_start mk_sub_dir mk_end
	@echo $(SUB_OBJ_LIST)

mk_start: 
	@$(ECHO_BLUE)\t-----------------------------$(ECHO_END)
	@$(ECHO_BLUE)\t--------[Compile Start]--------$(ECHO_END)
	@$(ECHO_BLUE)\t-----------------------------$(ECHO_END)
	@$(ECHO_BLUE)[OPT]$(OPT)  $(ECHO_END)

make_show:
	@$(ECHO_GREEN_YELLOW)[DIR_CURDIR] $(DIR_CURDIR) $(ECHO_END)
	@$(ECHO_GREEN)[FILE_LIST_C] $(FILE_LIST_C) $(ECHO_END)
	@$(ECHO_GREEN)[FILE_LIST_CPP] $(FILE_LIST_CPP) $(ECHO_END)
	@$(ECHO_GREEN)[FILE_DYNAMIC_NAME] $(FILE_DYNAMIC_NAME) $(ECHO_END)
	@$(ECHO_GREEN)[FILE_DFILE_STATIC_NAMEYNAMIC_NAME] $(FILE_STATIC_NAME) $(ECHO_END)
	@$(ECHO_GREEN)[DIR_LIST_INCLUDE] $(DIR_INCLUDES) $(ECHO_END)

mk_end: 
	@$(ECHO_BLUE)\t-----------------------------$(ECHO_END)
	@$(ECHO_BLUE)\t--------[Compile End]--------$(ECHO_END)
	@$(ECHO_BLUE)\t-----------------------------$(ECHO_END)
  

mk_sub_dir:
	@for list in $(DIR_SUB_LIST);\
	do\
		cd $$list && make all||exit 1;\
	done

mk_libstatic:mk_obj
	@if [ -d $(DIR_STATIC_LIB) ];\
	then\
		echo "exist";\
	else\
		mkdir -pv $(DIR_STATIC_LIB);\
	fi
	@echo "generate static lib" $(LIB_STATIC_NAME)
	@$(ECHO_YELLOW)[ar] -crsv $(DIR_STATIC_LIB)/$(LIB_STATIC_NAME) $(FILE_LIST_OBJ)$(ECHO_END)
	ar -crsv $(DIR_STATIC_LIB)/$(LIB_STATIC_NAME) $(FILE_LIST_OBJ)

.PHONY:clean all
make_clean:
	rm -rf $(DIR_STATIC_LIB) $(DIR_DYNAMIC_DDL) $(DIR_OUT)

mk_main:mk_obj mk_bin 


mk_libdynamic:mk_obj
	@if [ -d $(DIR_DYNAMIC_DDL) ];\
	then\
		echo "exist";\
	else\
		mkdir -pv $(DIR_DYNAMIC_DDL);\
	fi
	@echo "generate dynamic lib" $(DLL_DYNAMIC_NAME)
	@$(ECHO_YELLOW)[$(CC)] $(SHARED) $(DIR_SUB_LIST_OBJ) -o $(DIR_DYNAMIC_DDL)/$(DLL_DYNAMIC_NAME)  $(ECHO_END)
	$(CC) $(SHARED) $(DIR_SUB_LIST_OBJ) -o $(DIR_DYNAMIC_DDL)/$(DLL_DYNAMIC_NAME)

mk_bin:mk_obj
	@$(MKDIR) $(DIR_BIN)
	@$(ECHO_YELLOW)[$(CC)] $(DIR_OBJ_MODULE)/main.o $(CFLAGS) -o $(EXEC_APP) $(ECHO_END)
	$(CC)  $(DIR_OBJ_MODULE)/main.o $(LINKS) -o $(EXEC_APP)
	
mk_obj:$(DIR_SUB_LIST_OBJ)

$(DIR_OBJ_MODULE)/%.o: %.c
	@$(MKDIR) `dirname $@`
	@$(ECHO_YELLOW)[$(CC)] -c $(CFLAGS) $< -o $@ $(ECHO_END)
	$(CC) -c $(CFLAGS) $< -o $@
