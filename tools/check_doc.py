#!/usr/bin/env python3

from pathlib import Path
import re
import sys


ROOT = Path(".")


# Détection simple des déclarations de fonctions dans les headers
FUNCTION_PATTERN = re.compile(
    r"""
    ^\s*
    (?:
        (?:inline|static|constexpr|virtual|explicit|friend)\s+
    )*
    (?:
        [\w:<>~*&\s]+
    )
    \s+
    \w+
    \s*\([^;{}]*\)
    \s*;
    """,
    re.MULTILINE | re.VERBOSE
)


missing = []


for header in ROOT.rglob("*.hpp"):

    # Ignore les dossiers de build
    if "build" in header.parts:
        continue

    content = header.read_text(encoding="utf-8")

    for match in FUNCTION_PATTERN.finditer(content):

        before = content[:match.start()]

        # Cherche le dernier bloc avant la déclaration
        previous = before.rstrip()

        documented = previous.endswith("*/")

        if not documented:
            line = content[:match.start()].count("\n") + 1

            missing.append(
                f"{header}:{line}: missing doxygen comment"
            )


if missing:
    print("Missing documentation:")
    print()

    for item in missing:
        print(f"  {item}")

    sys.exit(1)


print("All header functions are documented.")