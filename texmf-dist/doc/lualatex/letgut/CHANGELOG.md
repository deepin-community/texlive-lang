# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic
Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.9.7] - 2023-05-21

### Changed
Announcement's title and toc entry possibly different (backward compatibility broken!)

### Fixed
`tabularray`'s needed library added.

## [0.9.6] - 2023-01-14

### Fixed
Hot fix for the attachment to the Lettre's PDF of its source files.

## [0.9.5] - 2023-01-13

### Added
- Files (`.tex` source, images files, bibliographic files, etc.) used to typeset
  an article possibly attached to the Lettre's PDF.
- Starred version of `\inputarticle` that prevents the previous feature.
- Boolean option that (un)forces the previous feature.
- Plural forms `\lettres` and `\lettresgut` of `\lettre` and `\lettregut`.
- Shortcuts for “(a|A)ssociation GUTenberg”.
- Starred versions of `\person` and `\author` that sort the lists of
  persons/authors in alphabetic order.
- Environment for announcements.
- Environments and commands for rebus and their solutions.

### Changed
- `⅛` replaced by `™` as a short equivalent of ~\lstinline~ (the former is
  considered as math if ~unicode-math~ is loaded).
- Documentation updated.

### Fixed
Several bugs and sub-optimalities.

## [0.9.4] - 2022-10-03

### Added
- Command `\lettrenumber` that displays various Lettre numbers related to the
  one of the current issue.
- Options of `\lettre` and `\lettregut` that add various Lettre numbers related
  to the one of the current issue.
- Command `\Ucode` for points and names of Unicode characters.

### Changed
- Documentation improved.

## [0.9.3] - 2022-09-02

### Changed
- Local conf. file doesn't require anymore to start with \ExplSyntaxOff in some
  instances.
- Documentation improved.

## [0.9.2] - 2022-06-18

### Added
- Listings for commands in terminals.
- Aliases of frequently used commands.
- New commands for frequently used terms or expressions.
- Command for specifying LaTeX packages that benefit from syntax highlighting.
- Own ~listings~' language driver file for LaTeX packages syntax highlighting.
- Commands for keyboard keys of accentuated characters.
- ~detailedtoc~ option for Lettre's structure checking.
- Mimic the multiple option of the footmisc package.
- Command ~\inputarticle~ (instead of ~\input~) for the input of articles.
- ⅛ as a short equivalent of ~\lstinline~.
- Some tweaks and improvements.

### Changed
- Last names of persons and authors not in small caps anymore.
- \tl isn't an acronym anymore and now typesets “TeX Live”.
- All the acronyms reset at the beginning of each ~\inputarticle~-ed article.
- All options now possibly load-time ones.
- Unlikely to change input files searched:
  1. in the parent directory if not in the current one,
  2. in the TDS.
- Right ISSN in case of “paper” version of la Lettre.

### Fixed
Several bugs.

## [0.9.1] - 2022-03-22

### Changed
File renamed (Karl Berry request).

## [0.9] - 2022-03-18

### Added
First public testing release.
