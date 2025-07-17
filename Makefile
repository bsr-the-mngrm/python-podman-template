# Makefile

# Help: Show all make targets
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies using Poetry
	poetry install

lint: ## Run lint checks using ruff
	poetry run ruff check .

format: ## Format code using black
	poetry run black .

test: ## Run tests using pytest
	poetry run pytest

clean: ## Remove Python and build artifacts
	find . -type d -name '__pycache__' -exec rm -rf {} + ;
	find . -type f -name '*.py[cod]' -delete ;
	rm -rf .pytest_cache .mypy_cache .ruff_cache .venv dist build

check: ## Run all quality checks (lint, format check, test)
	poetry run ruff check .
	poetry run black --check .
	poetry run pytest

ci: check ## Alias for CI pipelines (same as check)

coverage: ## Run pytest with coverage report
	poetry run pytest --cov=src --cov-report=term-missing

format-check: ## Check if code is correctly formatted
	poetry run black --check .

security: ## Run bandit for security linting
	poetry run bandit -r src

.PHONY: help lint format format-check test clean check ci coverage security

