# PT IPS language test

Minimal IG that reproduces a gap in translating content inherited from a dependency.

- `pt-ips-bundle`: a profile derived from the IPS `Bundle-uv-ips`, setting only `Bundle.identifier.short`.
- `input/translations/pt/StructureDefinition-pt-ips-bundle.po`: Portuguese translation of that short. Renders.
- `input/translations/pt/StructureDefinition-Bundle-uv-ips.po`: Portuguese translation of the IPS
  definition of `Bundle.identifier`. Generated and packaged as a CodeSystem supplement, but never rendered.

See `ISSUE-draft.md` for the analysis. Build with `_genonce`; the publisher runs SUSHI itself. The first
build generates `translations/pt/` from an empty seed file; the committed files are the filled-in result.
