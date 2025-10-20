install:
	curl -LsSf https://astral.sh/uv/install.sh | sh

init: install
	uv tool install ruff
	uv sync

clean:
	rm -rf .venv

update: countries copy-resume

qc:
# 	ruff check --fix --diff src/
	ruff check --fix src/
	ruff format src/
# 	uvx isort src/
# 	uvx black src/
# 	uvx flake8 --ignore=E501 src/
# 	uvx mypy src/

countries:
	uv run src/update_countries.py

RESUME_FILE := ../website/resume/resume.pdf

copy-resume:
	@if [ -f $(RESUME_FILE) ]; then \
		mkdir -p files; \
		cp $(RESUME_FILE) files/; \
	else \
		echo "File not found: $(RESUME_FILE)"; \
	fi
