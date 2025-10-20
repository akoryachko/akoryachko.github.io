from pathlib import Path

TOP_FOLDER_PATH = Path(__file__).resolve().parent.parent

TA_HTML_PATH = TOP_FOLDER_PATH / "travel_achievements.html"


def read_html_to_lines(path: Path = TA_HTML_PATH) -> list[str]:
    with path.open("r", encoding="utf8") as f:
        lines_html = f.readlines()
    return lines_html


def write_lines_to_html(lines_html: list[str], path: Path = TA_HTML_PATH) -> None:
    with path.open("w", encoding="utf8") as f:
        f.writelines(lines_html)


def insert_section(original_lines: str, section_lines: str, tag: str) -> str:
    n_start = 0
    n_end = 0

    for n, line in enumerate(original_lines):
        if f'<section id="{tag}">' in line:
            n_start = n
            n_end = 0
        if "</section>" in line:
            n_end = n
        if n_start and n_end:
            break

    new_lines = original_lines[: n_start + 1] + section_lines + original_lines[n_end:]

    return new_lines
