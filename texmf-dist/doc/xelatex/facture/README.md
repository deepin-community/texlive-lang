# Classe XeLaTeX de facture

The `facture` document class allows one to easily typeset invoices or quotes,
with or without VAT, by automatically computing due amounts. Different
addresses for delivery and for billing are permitted.

This class follows tax laws from France and thus only targets people from
France. That’s why all default labels and the documentation are currently
written in french only.

---

La class `facture` permet de rédiger factures et devis, avec ou sans TVA, en
calculant automatiquement les sommes dûes. Différentes adresses pour la
livraison et la facturation peuvent être utilisées… ou pas.

Plutôt orienté pour la France (taux de TVA en vigueur ou rappel aux textes de
loi en l’absence de TVA), les libellés utilisés par défaut et la documentation
ne sont disponibles qu’en français. Les libellés sont néanmoins modifiables si
nécessaires (par exemple pour générer des factures bilingues).

Cette classe est conçue pour ne fonctionner qu’avec XeLaTeX. Elle ne
fonctionne donc pas avec LaTeX (ou pdflatex) ou LuaLaTeX.

Elle est disponible sous licence Créative Commons -- partage des conditions
initiales à l'identique -- Paternité.

http://creativecommons.org/licenses/by-sa/2.0/fr/

## Documentation

La documentation est disponible [ici en PDF](facture.pdf).

## Corrections ou améliorations

Pour tout demande de corrections ou d'améliorations, merci d'ouvrir un ticket
sur Gitlab : https://framagit.org/gutenberg/facture/-/issues

## Installation

### Généralités

La classe `facture` est intégrée à la distribution TexLive dans sa collection
« collection-langfrench ». Vous pouvez vous rapporter à la documentation de
votre système pour savoir comment installer cette collection particulière.

Elle est également disponible dans la distribution MiKTeX.

### Debian

Voici les packets nécessaires au fonctionnement de la classe sous Debian :

- `texlive-lang-french`
- `texlive-xetex`
- `texlive-latex-extra`
- `texlive-plain-generic`
- `texlive-latex-recommended`
- `texlive-fonts-extra`

### Archlinux

Voici les packets nécessaires au fonctionnement de la classe sous Archlinux :

- `texlive-langfrench`
- `texlive-xetex`
- `texlive-latexextra`
- `texlive-plaingeneric`
- `texlive-latexrecommended`
- `texlive-fontsextra`

## Génération et compilation

### Généralités

Pour lancer la génération de la classe et la compilation de la documentation
et des fichiers d’exemple fournis, il suffit de lancer la commande `make`
seule. Quatre fichiers sont alors générés : `exemple.pdf`,
`exemplesansremise.pdf`, `exemplesansTVA.pdf` et `facture.pdf` (la
documentation).

### Extraction simple de la classe elle-même

    make facture.cls

### Extraction simple de la documentation

    make facture.pdf

### Génération d’une archive compatible CTAN

    make facture.zip
