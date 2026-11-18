# Third-party notices

## Libertinus Sans 7.051

The unmodified OpenType files in `fonts/` come from the
[Libertinus 7.051 release](https://github.com/alerque/libertinus/releases/tag/v7.051).
They are distributed under the SIL Open Font License 1.1. The complete license
and upstream copyright notices are included in `fonts/OFL.txt`.

## Historical sources

The former AltaCV class and Org-mode sources have been removed from the current
build. Their original notices remain with the historical files in Git history.
The new Typst layout does not incorporate AltaCV code.

## Grotesk CV

`src/vendor/grotesk-cv/` adapts [Grotesk CV](https://github.com/AsiSkarp/grotesk-cv)
commit `2e7e3f05d028f8c895c57b2b13b3245ef7db4a90` (version 1.0.5),
by Ásbjörn Skarphéðinsson, under the Unlicense included alongside the source.
Local changes remove the empty photo decoration and unused text-injection helper,
use two contact columns, and pin the Font Awesome import.

## Brilliant CV

`src/vendor/brilliant-cv/` contains the unmodified package source from
[Brilliant CV](https://github.com/yunanwg/brilliant-CV), commit
`b2e794d5906012ed77406ced3217b0eeb33af85f`, by Yunan Wang, under Apache 2.0.
Its license is included alongside the source. The configuration disables section
heading highlights and uses named style overrides from that revision.

## Comparison fonts

Hanken Grotesk, Roboto, and Source Sans 3 are bundled unmodified from
[Google Fonts](https://github.com/google/fonts) under the SIL Open Font License
1.1. Each font directory contains its upstream license and copyright notice.
