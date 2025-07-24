# Makefile

# Colors
CYAN=\033[36m
RESET=\033[0m

# Help: Show all make targets
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "$(CYAN)%-20s$(RESET) %s\n", $$1, $$2}'

requirements: ## Export requirements.txt for use with uv
	poetry export --without-hashes --with-credentials --all-extras --dev -f requirements.txt --output requirements.txt

lint: ## Run lint checks using Ruff
	ruff check .

format: ## Format code using Black
	black .

format-check: ## Check if code is correctly formatted
	black --check .

test: ## Run tests using Pytest
	pytest

type-check: ## Run static type checks using Pyright
	pyright

security: ## Run Bandit for security linting
	bandit -r src

pre-commit: ## Run all pre-commit hooks
	pre-commit run --all-files

check: ## Run all quality checks (lint, format, type-check, test)
	ruff check .
	black --check .
	pyright
	pytest

ci: check ## Alias for CI pipelines (same as check)

coverage: ## Run tests with coverage report
	pytest --cov=src --cov-report=term-missing

clean: ## Remove Python and build artifacts
	find . -type d -name '__pycache__' -exec rm -rf {} +
	find . -type f -name '*.py[cod]' -delete
	rm -rf .pytest_cache .ruff_cache dist build

.PHONY: help requirements lint format format-check test type-check \
        security osv pre-commit check ci coverage clean
