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
