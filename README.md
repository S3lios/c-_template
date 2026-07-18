# XXX

![CI](https://github.com/<USER>/<PROJECT>/actions/workflows/ci.yml/badge.svg)

Projet C++ moderne basé sur CMake, avec support de :

- compilation Debug / Release ;
- tests unitaires GoogleTest ;
- documentation API avec Doxygen ;
- documentation architecture avec LaTeX ;
- installation et packaging ;
- intégration CI/CD.

---

## Sommaire

- [Prérequis](#prérequis)
- [Configuration](#configuration)
- [Compilation](#compilation)
- [Tests](#tests)
- [Documentation](#documentation)
- [Installation](#installation)
- [Structure du projet](#structure-du-projet)
- [Versionnement](#versionnement)
- [CI/CD](#cicd)

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

- CMake >= 3.25
- Ninja ou Make

### Tests

- GoogleTest

### Documentation

- Doxygen
- Graphviz
- LaTeX (pdflatex)

Installation Debian/Ubuntu :

```bash
sudo apt install \
    cmake \
    ninja-build \
    doxygen \
    graphviz \
    texlive-latex-extra
```

---

# Configuration

Le projet utilise `CMakePresets.json`.

Lister les configurations disponibles :

```bash
cmake --list-presets
```

Exemple :

```text
debug
test
release
docs
```

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

Compilation optimisée :

```bash
cmake --workflow --preset release
```

---

# Tests

Compiler avec les tests :

```bash
cmake --workflow --preset test
```

Lancer uniquement les tests :

```bash
ctest --preset test
```

Avec affichage des erreurs :

```bash
ctest --preset test --output-on-failure
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
│
└── latex/
    └── architecture.pdf
```

Ouvrir la documentation :

```bash
xdg-open build/docs/doxygen/html/index.html
```

---

# Installation

Configurer une installation :

```bash
cmake --preset release \
    -DCMAKE_INSTALL_PREFIX=/usr/local
```

Compiler :

```bash
cmake --build --preset release
```

Installer :

```bash
cmake --install build/release
```

Installation typique :

```text
/usr/local/

├── bin/
├── lib/
└── include/
```

---

# Structure du projet

```text
.
├── CMakeLists.txt
├── CMakePresets.json
│
├── cmake/
│   └── GitVersion.cmake
│
├── include/
│   └── XXX/
│
├── src/
│   ├── CMakeLists.txt
│   └── *.cpp
│
├── tests/
│   ├── CMakeLists.txt
│   └── *
│
├── docs/
│   ├── doxygen/
│   └── latex/
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── cd.yml
```

---

# Options CMake

Les options principales :

| Option | Description | Défaut |
|---|---|---|
| `BUILD_TESTING` | Compiler les tests | OFF |
| `BUILD_EXAMPLES` | Compiler les exemples | OFF |
| `BUILD_DOCS` | Générer la documentation | OFF |
| `BUILD_SHARED_LIBS` | Construire des bibliothèques partagées | ON |

Exemple :

```bash
cmake \
    -DBUILD_TESTING=ON \
    -DBUILD_DOCS=ON \
    ..
```

---

# Versionnement

La version est automatiquement récupérée depuis Git.

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

Sans Git ou sans commit :

```text
Tag  : N/A
Hash : N/A
```

---

# CI/CD

La CI vérifie automatiquement :

- compilation Debug ;
- compilation Release ;
- tests unitaires ;
- génération documentation.

La CD est déclenchée lors de la création d'un tag :

```bash
git tag v1.0.0
git push --tags
```

Elle génère :

- une release GitHub ;
- les binaires ;
- les archives ;
- la documentation.

---

# Licence

À compléter :

```text
Copyright YYYY XXX

License : MIT
```