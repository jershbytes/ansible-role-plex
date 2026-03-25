# List available recipes
default:
    @just --list

# Setup pre-commit
setup:
    uv sync
    uv run pre-commit install
    @echo "Pre-commit hooks installed successfully"

# Lint the repo
lint:
    uv run pre-commit run --all-files