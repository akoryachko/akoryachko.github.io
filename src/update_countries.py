from pathlib import Path

import pycountry

from utils import (
    TOP_FOLDER_PATH,
    insert_section,
    read_html_to_lines,
    write_lines_to_html,
)

COUNTRIES_PATH = TOP_FOLDER_PATH / "src/data/countries.txt"


def read_countries(path: Path = COUNTRIES_PATH) -> list[str]:
    with path.open() as f:
        countries = f.read().splitlines()
    return countries


class NoCountryNameError(Exception):
    pass


def generate_countries(countries: list[str]) -> list[str]:
    html_countries = []

    for country_name in countries:
        country = None
        for lib_country in pycountry.countries:
            if country_name in lib_country.name:
                country = lib_country
                break
        if not country:
            raise NoCountryNameError(f'Country "{country_name}" was no found')
        s = f"    <li>{country.flag} {country_name}</li>"
        html_countries.append(f"{s}\n")

    return html_countries


if __name__ == "__main__":
    lines_html = read_html_to_lines()
    countries = read_countries()
    html_countries = generate_countries(countries)
    lines_html = insert_section(lines_html, html_countries, "countries")
    write_lines_to_html(lines_html)
    print("Countries Updated!")
