#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
######################################  MAKEFILE  ###########################################
#---- File Name     : Makefile
#---- Description   : Automates compilation and simulation with parameter overrides
#---- Toolchain     : QuestaSim (vlib, vlog, vsim)
#---- Usage Example : make testcase=my_test seed=123 wave=1
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# ==============================
# Source & Directory Definitions
# ==============================

RTL_MODULE := ../RTL/apb_dut.v
PKG_FILES := ../TOP/apb_pkg.sv
TB_PATH   := ../TOP/apb_top.sv
SIM_DIR   := ../SIM/sim_log
TOP_MODULE := apb_top

# Files to archive after sim
#LOG_FILES := *.vcd transcript *.wlf

# =================================
# Default Simulation Configuration
# (Can be overridden via command line)
# =================================

override testcase          ?= reg_mirror_test
override seed              ?= 123
override wave              ?= 0
override freq              ?= 250

# Log directory is auto-named based on simulation parameters
LOG_DIR := $(SIM_DIR)/testcase$(testcase)_seed$(seed)

# ==============================
# Targets
# ==============================

.PHONY: all compile simulate run_sim clean clean_all help

## Default target: compile and simulate
all: compile simulate

## Compile step
compile:
	@echo "\n==> Compiling Design & Testbench..."
	@vlib work
	@vlog +acc=rn -coveropt 3 -cover bcest $(RTL_MODULE) $(PKG_FILES) $(TB_PATH)

## Simulation step with conditional waveform logging
simulate: run_sim

ifeq ($(wave),1)
run_sim:
	@echo "\n==> Simulating WITH WAVES (testcase=$(testcase), seed=$(seed))"
	@vopt work.$(TOP_MODULE) -o $(TOP_MODULE)_opt +acc=rn
	@mkdir -p $(LOG_DIR)
	@vsim -voptargs=+acc -coverage $(TOP_MODULE) \
	    +clk_freq=$(freq) +init_rst	+UVM_TESTNAME=$(testcase) +sv_seed=$(seed) \
		-do "add wave -r /*; run -all;"
#	@mv $(LOG_FILES) $(LOG_DIR)
else
run_sim:
	@echo "\n==> Simulating WITHOUT WAVES (testcase=$(testcase), seed=$(seed))"
	@vopt work.$(TOP_MODULE) -o $(TOP_MODULE)_opt +acc=rn
	@mkdir -p $(LOG_DIR)
	@vsim -c -assertdebug -fsmdebug -coverage -msgmode both work.$(TOP_MODULE)_opt \
		+clk_freq=$(freq) +init_rst +UVM_TESTNAME=$(testcase) +sv_seed=$(seed) \
		-do "run -all; quit"
#	@mv $(LOG_FILES) $(LOG_DIR)
endif

## Clean compiled library only
clean:
	@echo "Cleaning compiled library..."
	@rm -rf work

## Clean all including simulation logs
clean_all:
	@echo "Cleaning everything including simulation logs..."
	@rm -rf work
	@rm -rf $(SIM_DIR)

## Help menu
help:
	@echo ""
	@echo "================ Makefile Help =================="
	@echo "make                  : Compile and simulate"
	@echo "make compile          : Compile sources only"
	@echo "make simulate         : Run simulation"
	@echo "make clean            : Clean compiled library"
	@echo "make clean_all        : Remove work dir and logs"
	@echo ""
	@echo "Optional overrides:"
	@echo "  testcase=TEST       : Specify test name (default: sanity)"
	@echo "  seed=N              : Random seed (default: 123)"
	@echo "  wave=1              : Enable waveform dumping"
	@echo "================================================="
