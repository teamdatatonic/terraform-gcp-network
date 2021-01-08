
ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: help  lint test _pre_commit  _lint_files _lint_fmt 

CURRENT_DIR     = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TF_EXAMPLES     = $(sort $(dir $(wildcard $(CURRENT_DIR)examples/*/)))
TF_MODULES      = $(sort $(dir $(wildcard $(CURRENT_DIR)modules/*/)))

TF_VERSION      = 0.14.3
TF_DOCS_VERSION = 0.6.0

help:
	@echo "lint       Static source code analysis"
	@echo "test       Integration tests"  

pre-checks: ## Runs the pre-commit over entire repo and kubeval on deployment folder
	@pre-commit run --all-files

lint: _pull-tf
	@$(MAKE) --no-print-directory _lint_files
	@$(MAKE) --no-print-directory _lint_fmt 

test: _pull-tf  ## terraform examples TODO
	@$(foreach example,\
		$(TF_EXAMPLES),\
		DOCKER_PATH="/t/examples/$(notdir $(patsubst %/,%,$(example)))"; \
		echo "################################################################################"; \
		echo "# examples/$$( basename $${DOCKER_PATH} )"; \
		echo "################################################################################"; \
		echo; \
		echo "------------------------------------------------------------"; \
		echo "# Terraform init"; \
		echo "------------------------------------------------------------"; \
		if docker run -it --rm -v "$(CURRENT_DIR):/t" --workdir "$${DOCKER_PATH}" hashicorp/terraform:$(TF_VERSION) \
			init \
				-verify-plugins=true \
				-lock=false \
				-upgrade=true \
				-reconfigure \
				-input=false \
				-get-plugins=true \
				-get=true \
				.; then \
			echo "OK"; \
		else \
			echo "Failed"; \
			docker run -it --rm -v "$(CURRENT_DIR):/t" --workdir "$${DOCKER_PATH}" --entrypoint=rm hashicorp/terraform:$(TF_VERSION) -rf .terraform/ || true; \
			exit 1; \
		fi; \
		echo; \
		echo "------------------------------------------------------------"; \
		echo "# Terraform validate"; \
		echo "------------------------------------------------------------"; \
		if docker run -it --rm -v "$(CURRENT_DIR):/t" --workdir "$${DOCKER_PATH}" hashicorp/terraform:$(TF_VERSION) \
			validate \
				$(ARGS) \
				.; then \
			echo "OK"; \
			docker run -it --rm -v "$(CURRENT_DIR):/t" --workdir "$${DOCKER_PATH}" --entrypoint=rm hashicorp/terraform:$(TF_VERSION) -rf .terraform/ || true; \
		else \
			echo "Failed"; \
			docker run -it --rm -v "$(CURRENT_DIR):/t" --workdir "$${DOCKER_PATH}" --entrypoint=rm hashicorp/terraform:$(TF_VERSION) -rf .terraform/ || true; \
			exit 1; \
		fi; \
		echo; \
	)


_lint_files:
	@# Lint all non-binary files for trailing spaces
	@echo "################################################################################"
	@echo "# Lint files"
	@echo "################################################################################"
	@echo
	@echo "------------------------------------------------------------"
	@echo "# Trailing spaces"
	@echo "------------------------------------------------------------"
	find . -type f -not \( -path "*/.git/*" -o -path "*/.github/*" -o -path "*/.terraform/*" \) -print0 \
		| xargs -0 -n1 grep -Il '' \
		| tr '\n' '\0' \
		| xargs -0 -n1 \
		sh -c 'if [ -f "$${1}" ]; then if LC_ALL=C grep --color=always -inHE "^.*[[:blank:]]+$$" "$${1}";then false; else true; fi; fi' --
	@echo
	@echo "------------------------------------------------------------"
	@echo "# Windows line feeds (CRLF)"
	@echo "------------------------------------------------------------"
	find . -type f -not \( -path "*/.git/*" -o -path "*/.github/*" -o -path "*/.terraform/*" \) -print0 \
		| xargs -0 -n1 grep -Il '' \
		| tr '\n' '\0' \
		| xargs -0 -n1 \
		sh -c 'if [ -f "$${1}" ]; then if file "$${1}" | grep --color=always -E "[[:space:]]CRLF[[:space:]].*line"; then false; else true; fi; fi' --
	@echo
	@echo "------------------------------------------------------------"
	@echo "# Single trailing newline"
	@echo "------------------------------------------------------------"
	find . -type f -not \( -path "*/.git/*" -o -path "*/.github/*" -o -path "*/.terraform/*" \) -print0 \
		| xargs -0 -n1 grep -Il '' \
		| tr '\n' '\0' \
		| xargs -0 -n1 \
		sh -c 'if [ -f "$${1}" ]; then if ! (tail -c 1 "$${1}" | grep -Eq "^$$" && tail -c 2 "$${1}" | grep -Eqv "^$$"); then echo "$${1}"; false; else true; fi; fi' --
	@echo

_lint_fmt:
	@# Lint all Terraform files
	@echo "################################################################################"
	@echo "# Terraform fmt"
	@echo "################################################################################"
	@echo
	@echo "------------------------------------------------------------"
	@echo "# *.tf files"
	@echo "------------------------------------------------------------"
	@if docker run --rm -v "$(CURRENT_DIR):/t:ro" --workdir "/t" hashicorp/terraform:$(TF_VERSION) \
		fmt -check=true -diff=true -write=false -list=true /t; then \
		echo "OK"; \
	else \
		echo "Failed"; \
		exit 1; \
	fi;
	@echo
	@echo "------------------------------------------------------------"
	@echo "# *.tfvars files"
	@echo "------------------------------------------------------------"
	@if docker run --rm --entrypoint=/bin/sh -v "$(CURRENT_DIR)/terraform:/t:ro" hashicorp/terraform:$(TF_VERSION) \
		-c "find . -name '*.tfvars' -type f -print0 | xargs -0 -n1 terraform fmt -check=true -write=false -diff=true -list=true"; then \
		echo "OK"; \
	else \
		echo "Failed"; \
		exit 1; \
	fi;
	@echo

_pull-tf:
	docker pull hashicorp/terraform:$(TF_VERSION)
