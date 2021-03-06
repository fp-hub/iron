
# -- Config ---------------------------------------------------------
# Coq binaries to use when building
COQDEP		= coqdep
COQC		= coqc
THREADS		= 1


# -- Roots ----------------------------------------------------------
root_lib \
 = 	lib/Base/Class/Functor.vo \
 	lib/Base/Class/Monoid.vo

root_done \
 =	done/Iron/Language/Calc.vo \
 	done/Iron/Language/Simple.vo \
 	done/Iron/Language/SimplePCF.vo \
 	done/Iron/Language/SimpleRef.vo \
 	done/Iron/Language/SimpleData.vo \
 	done/Iron/Language/SystemF.vo \
 	done/Iron/Language/SystemF2.vo \
 	done/Iron/Language/SystemF2Data.vo \
 	done/Iron/Language/SystemF2Store.vo \
 	done/Iron/Language/SystemF2Effect.vo \
 	done/Iron/Language/DelayedSimple.vo \
 	done/Iron/Language/DelayedSimpleUS.vo

root_devel \
 = 

# -------------------------------------------------------------------
.PHONY : all
all:
	@$(MAKE) deps
	@$(MAKE) proof -j $(THREADS)


# Build the Coq proofs.
.PHONY: proof
proof: $(root_done)

.PHONY: lib
libf:  $(root_lib)

.PHONY: done
proof: $(root_done)

.PHONY: devel
proof: $(root_devel)

# Start the Coq ide
.PHONY: start
start: 
	coqide -R done/Iron   Iron \
	       -R  devel/Iron Iron \
	       -R  lib/Base   Base &

# Build dependencies for Coq proof scripts.
.PHONY: deps
deps: make/proof.deps

# Find Coq proof scripts
src_coq_v \
 =  	$(shell find lib   -name "*.v" -follow) \
 	$(shell find done  -name "*.v" -follow) \
 	$(shell find devel -name "*.v" -follow)

# Coqc makes a .vo and a .glob from each .v file.
src_coq_vo	= $(patsubst %.v,%.vo,$(src_coq_v))
	
make/proof.deps : $(src_coq_v)
	@echo "* Building proof dependencies"
	@$(COQDEP) -R done/Iron  Iron \
	           -R devel/Iron Iron \
	           -R lib/Base   Base \
 	           $(src_coq_v) > make/proof.deps
	@cp make/proof.deps make/proof.deps.inc


# Clean up generated files.
.PHONY: clean
clean : 
	@rm -f make/proof.deps
	@rm -f make/proof.deps.inc

	@find .    -name "*.vo" \
		-o -name "*.glob" \
		-follow | xargs -n 1 rm -f

# Rules 
%.vo %.glob : %.v
	@echo "* Checking $<"
	@$(COQC) -R done/Iron  Iron \
	         -R devel/Iron Iron \
	         -R lib/Base   Base \
	         $<


# Include the dependencies.
-include make/proof.deps.inc

