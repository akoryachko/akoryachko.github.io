SHELL := /bin/bash

BLOG_POSTS_PATH = ../blog_posts

install:
	curl -LsSf https://astral.sh/uv/install.sh | sh
	brew install pandoc

init: install
	uv tool install ruff
	uv sync

clean:
	rm -rf .venv

update: countries copy-resume blog-posts

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

blog-posts:
# visualizations
	pandoc $(BLOG_POSTS_PATH)/fast_visualizations/post_fast_vis.ipynb -f ipynb -t html \
		-o blog_posts/fast_visualizations.html -s \
		--highlight-style=zenburn \
		--standalone \
		-H <(echo '<style>body{max-width:900px}</style>')
	cp -rf $(BLOG_POSTS_PATH)/fast_visualizations/pics/ blog_posts/pics/
# pyspark_to_production
	pandoc $(BLOG_POSTS_PATH)/pyspark_to_production/blogpost.md -f markdown -t html \
		-o blog_posts/pyspark_to_production.html \
		--highlight-style=zenburn \
		--standalone \
		-H <(echo '<style>body{max-width:900px}</style>')