# XXX

![CI](https://github.com/S3lios/c-_template/actions/workflows/ci.yml/badge.svg)
![CD](https://github.com/S3lios/c-_template/actions/workflows/cd.yml/badge.svg)

Projet C++ moderne basé sur CMake, avec support de :

- compilation Debug / Release ;
- tests unitaires GoogleTest ;
- documentation API avec Doxygen et documentation architecture avec LaTeX ;
- installation via `cmake --install` ;
- packaging et publication automatique des releases GitHub ;
- vérifications qualité (clang-format, clang-tidy, couverture Doxygen) ;
- versionnement automatique depuis Git ;
- conventions de commit (Commitizen) ;
- intégration CI/CD (GitHub Actions).

---

## Sommaire

- [Prérequis](#prérequis)
- [Démarrage rapide](#démarrage-rapide)
- [Configuration](#configuration)
- [Compilation](#compilation)
- [Tests](#tests)
- [Qualité du code](#qualité-du-code)
- [Documentation](#documentation)
- [Installation](#installation)
- [Structure du projet](#structure-du-projet)
- [Options CMake](#options-cmake)
- [Versionnement](#versionnement)
- [Conventions de commit](#conventions-de-commit)
- [CI/CD](#cicd)
- [Licence](#licence)

---

# Prérequis

## Compilateur

Un compilateur C++ supportant C++23 :

- GCC >= 13
- Clang >= 16
- MSVC >= 2022

Vérification :

```bash
g++ --version
```

---

## Outils

### Compilation

- CMake >= 3.28
- Make (ou tout générateur CMake compatible)

### Tests

- GoogleTest (`libgtest-dev`)

### Qualité

- clang-format
- clang-tidy
- Python 3 (vérification des commentaires Doxygen)

### Documentation

- Doxygen
- Graphviz
- LaTeX (pdflatex)

### Conventions de commit

- Commitizen (`pipx install commitizen`)

---

## Installation des dépendances

Un script est fourni pour Ubuntu/Debian et installe l'ensemble des outils
ci-dessus :

```bash
./tools/install_dependencies.sh
```

Installation manuelle équivalente :

```bash
sudo apt install \
    build-essential \
    cmake \
    git \
    doxygen \
    graphviz \
    texlive-latex-extra \
    libgtest-dev \
    clang-format \
    clang-tidy \
    python3
```

---

# Démarrage rapide

```bash
git clone https://github.com/S3lios/c-_template.git
cd c-_template

cmake --workflow --preset test
```

Cette dernière commande configure, compile et exécute les tests unitaires en
une seule étape.

---

# Configuration

Le projet utilise `CMakePresets.json`.

Lister les configurations disponibles :

```bash
cmake --list-presets
```

Workflows disponibles (`cmake --workflow --preset <nom>`) :

| Preset | Description |
|---|---|
| `debug` | Build de développement (assertions, symboles de debug) |
| `test` | Build + exécution des tests unitaires |
| `release` | Build optimisé, sans tests ni documentation |
| `install` | Build release puis installation (voir [Installation](#installation)) |
| `docs` | Génération de la documentation API et architecture |
| `quality` | Vérification format / lint / documentation (sans modification) |
| `format` | Application automatique du formatage clang-format |

---

# Compilation

## Debug

Configuration développeur :

```bash
cmake --workflow --preset debug
```

Équivalent :

```bash
cmake --preset debug
cmake --build --preset debug
```

---

## Release

Compilation optimisée (sans tests, sans documentation) :

```bash
cmake --workflow --preset release
```

---

# Tests

Compiler et exécuter les tests :

```bash
cmake --workflow --preset test
```

Lancer uniquement les tests (après compilation) :

```bash
ctest --preset test
```

Avec affichage des erreurs :

```bash
ctest --preset test --output-on-failure
```

---

# Qualité du code

## Vérification

Contrôle du formatage, de l'analyse statique et de la documentation des en-têtes,
sans rien modifier :

```bash
cmake --workflow --preset quality
```

Cette commande exécute trois cibles :

| Cible | Rôle |
|---|---|
| `check-format` | `clang-format --dry-run --Werror` sur les sources |
| `check-tidy` | `clang-tidy` avec les avertissements traités comme des erreurs |
| `check-doc` | Vérifie que chaque fonction déclarée dans un en-tête est documentée (`tools/check_doc.py`) |

## Correction automatique

Reformate les sources en place avec clang-format :

```bash
cmake --workflow --preset format
```

---

# Documentation

La documentation est composée de deux parties.

## Documentation API

Générée avec Doxygen :

- classes ;
- fonctions ;
- dépendances ;
- diagrammes.

## Documentation architecture

Générée avec LaTeX :

- architecture logicielle ;
- choix techniques ;
- diagrammes ;
- conception.

---

Génération complète :

```bash
cmake --workflow --preset docs
```

Résultat :

```text
build/docs/
├── doxygen/
│   └── html/
│       └── index.html
└── latex/
    └── XXX_Architecture.pdf
```

Ouvrir la documentation :

```bash
xdg-open build/docs/doxygen/html/index.html
```

---

# Installation

Compiler et installer en une seule commande :

```bash
cmake --workflow --preset install
```

Par défaut, les binaires sont installés dans `build/bin/` (et non dans un
répertoire système), afin de ne rien installer en dehors du projet sans
action explicite.

Pour installer ailleurs, la commande `cmake --workflow` n'acceptant pas
d'argument, le répertoire cible se définit via la variable d'environnement
`INSTALL_DIR` :

```bash
INSTALL_DIR=/usr/local cmake --workflow --preset install
```

Résultat : `/usr/local/bin/XXX`.

Méthode manuelle équivalente, utile pour installer dans un préfixe différent
sans reconfigurer (utilisée par la CD pour le packaging) :

```bash
cmake --preset release
cmake --build --preset release
cmake --install build/release --prefix /chemin/personnalisé
```

> Seul l'exécutable `XXX` est installé pour l'instant (`bin/`). L'ajout de
> règles `install()` pour la bibliothèque `math` et les en-têtes publics
> (`lib/`, `include/`) est laissé à l'utilisateur du template.

---

# Structure du projet

```text
.
├── CMakeLists.txt
├── CMakePresets.json
│
├── cmake/
│   ├── gitversion.cmake     # Version depuis Git
│   ├── options.cmake        # Options du projet (BUILD_*, ENABLE_*)
│   ├── format.cmake         # Cibles check-format / apply-format
│   ├── tidy.cmake           # Cible check-tidy
│   ├── doccheck.cmake       # Cible check-doc
│   └── summary.cmake        # Résumé de configuration affiché par CMake
│
├── include/
│   └── XXX/
│       └── version.hpp.in
│
├── src/
│   ├── CMakeLists.txt
│   ├── main.cpp
│   └── math/                # Exemple de bibliothèque interne
│       ├── include/math/add.hpp
│       └── src/add.cpp
│
├── tests/
│   ├── CMakeLists.txt
│   └── math/
│       └── test_math.cpp
│
├── examples/
│   └── CMakeLists.txt
│
├── docs/
│   ├── doxygen/
│   │   └── Doxyfile.in
│   └── latex/
│       ├── main.tex
│       └── chapters/
│
├── tools/
│   ├── install_dependencies.sh
│   └── check_doc.py
│
├── .clang-format
├── .clang-tidy
├── .cz.toml
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── cd.yml
```

---

# Options CMake

Les options principales, définies dans `cmake/options.cmake` :

| Option | Description | Défaut |
|---|---|---|
| `BUILD_TESTING` | Compiler les tests | ON |
| `BUILD_EXAMPLES` | Compiler les exemples | OFF |
| `BUILD_DOCS` | Générer la documentation | OFF |
| `BUILD_SHARED_LIBS` | Construire des bibliothèques partagées | ON |
| `ENABLE_CHECK_DOC` | Activer la cible `check-doc` | OFF |
| `ENABLE_CLANG_FORMAT` | Activer les cibles `check-format` / `apply-format` | OFF |
| `ENABLE_CLANG_TIDY` | Activer la cible `check-tidy` | OFF |

Chaque preset de `CMakePresets.json` fixe ces variables selon son usage
(par exemple `release` désactive les tests et la documentation).

Exemple de configuration manuelle :

```bash
cmake -B build \
    -DBUILD_TESTING=ON \
    -DBUILD_DOCS=ON
```

---

# Versionnement

La version est automatiquement récupérée depuis Git (`cmake/gitversion.cmake`).

Informations intégrées :

- dernier tag ;
- hash du commit ;
- état du dépôt.

Exemples :

Dépôt propre :

```text
Tag  : v1.0.0
Hash : a12bc34
```

Après plusieurs commits :

```text
Tag  : v1.0.0+
Hash : b56de78
```

Avec modifications locales :

```text
Tag  : v1.0.0+
Hash : b56de78+
```

Sans Git ou sans tag :

```text
Tag  : N/A
Hash : N/A
```

Ces informations sont exposées dans le code via `include/XXX/version.hpp.in`
(macros `VERSION`, `VERSION_TAG`, `VERSION_HASH`).

---

# Conventions de commit

Le projet suit les [Conventional Commits](https://www.conventionalcommits.org/),
appliqués via [Commitizen](https://commitizen-tools.github.io/commitizen/)
(configuration dans `.cz.toml`).

Types acceptés : `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
`build`, `ci`, `chore`, `revert`.

```text
feat: add new feature
fix: correct rounding error in add()
```

Créer un commit en suivant le format interactivement :

```bash
cz commit
```

Vérifier que l'historique respecte la convention :

```bash
cz check --rev-range <base>..HEAD
```

La CI rejette automatiquement les commits non conformes (job `commit-check`).

---

# CI/CD

## CI (`ci.yml`)

Déclenchée sur chaque push et pull request vers `master` ou `develop`.
Vérifie en parallèle :

| Job | Rôle |
|---|---|
| `build-debug` | Compilation en configuration Debug |
| `tests` | Compilation et exécution des tests unitaires |
| `documentation` | Génération de la documentation (artefact téléchargeable) |
| `release-build` | Compilation en configuration Release |
| `commit-check` | Validation des messages de commit (Commitizen) |
| `clang-format` | Vérification du formatage |
| `clang-tidy` | Analyse statique |

## CD (`cd.yml`)

Déclenchée à la création d'un tag `v*` :

```bash
git tag v1.0.0
git push --tags
```

Elle compile en Release, installe le binaire dans une archive, puis publie
une release GitHub contenant :

- l'archive `XXX-<tag>.tar.gz` ;
- les notes de release générées automatiquement.

---

# Licence

À compléter :

```text
Copyright YYYY XXX

License : MIT
```
