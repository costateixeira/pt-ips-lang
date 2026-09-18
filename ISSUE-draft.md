# Translation files for resources from a dependency are generated and packaged, but never rendered

**Publisher:** 2.3.4 (Git# 7ae92f79415a, built 2026-09-04)
**Reproduction:** https://github.com/costateixeira/pt-ips-lang (a minimal IG derived from hl7-be/empty-ig-custom)

## What I am trying to do

Translate text that my IG inherits from a dependency, without waiting for a new release of that
dependency. Concretely: a Portuguese IPS Bundle profile derived from `Bundle-uv-ips`, where the
inherited `Bundle.identifier` definition should render in Portuguese on the pt pages of my profile.

## Setup

- `i18n-default-lang: en`, `i18n-lang: pt`, `translation-sources: input/translations/pt`
- Dependency `hl7.fhir.uv.ips#2.0.0`, template `fhir2.base.template#current`
- Profile `pt-ips-bundle`, parent `Bundle-uv-ips`, differential sets only `Bundle.identifier.short`
- `input/translations/pt/StructureDefinition-pt-ips-bundle.po` translating the short
- `input/translations/pt/StructureDefinition-Bundle-uv-ips.po` translating the IPS definition of `Bundle.identifier`

## What happens

1. Seeding `StructureDefinition-Bundle-uv-ips.po` as an empty file works: the build generates
   `translations/pt/{po,xliff,json}/StructureDefinition-Bundle-uv-ips.*` with all IPS strings.
2. The build accepts the translated file (no "Ignoring file" message) and produces
   `CodeSystem-cs-en-Bundle-uv-ips.json`, a supplement of `Bundle-uv-ips`, with the Portuguese text
   as the display of code `Bundle.identifier`.
3. On `output/pt/StructureDefinition-pt-ips-bundle.html` the short (my own profile's text) is in
   Portuguese, but the definition inherited from IPS is still in English.

## Why, as far as I can tell from the source

- `PublisherIGLoader.makeSupplement` builds the supplement id and `language` from
  `i18n-default-lang` (`cs-en-...`, language `en`), not from the language of the translation folder.
  That is correct for a language pack, whose default language is the target language, and wrong for
  an ordinary IG translating into a second language.
- The supplement is not marked `lang-pack` (that requires the `lang-pack` IG parameter), so
  `BaseWorkerContext.fetchSupplementedCodeSystem` would ignore it anyway.
- More fundamentally, `fetchSupplementedCodeSystem` is the only consumer of supplements in the
  core library, and it is used for value set rendering, expansion and validation. Nothing applies a
  StructureDefinition (or Questionnaire) supplement to element text when a profile is rendered, so
  inherited definitions cannot be translated this way even by a correctly built language pack.

## What I would expect

- A translation file for a dependency resource in `translation-sources` yields a supplement in the
  translation's language, applied when that resource's text is rendered in my IG.
- The same for supplements shipped by a language pack for that dependency.

Either would let a specification be translated by a translation source released on its own
schedule, which is the stated purpose of language packs.
