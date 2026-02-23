# List available recipes
default:
    @just --list

# Setup pre-commit
setup:
    pre-commit install
    @echo "Pre-commit hooks installed successfully"

# Lint the repo
lint:
    pre-commit run --all-files