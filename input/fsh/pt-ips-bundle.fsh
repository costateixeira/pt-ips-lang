Alias: $BundleUvIps = http://hl7.org/fhir/uv/ips/StructureDefinition/Bundle-uv-ips

Profile: PTIPSBundle
Parent: $BundleUvIps
Id: pt-ips-bundle
Title: "PT IPS Bundle"
Description: "IPS Bundle profile for Portugal. Derived from the IPS Bundle profile without further constraints, except a Portuguese-specific short description on the identifier."
// Only the short text is set here, so that the definition of Bundle.identifier is inherited from IPS.
// The short is translated by this IG's own translation file for this profile;
// the inherited definition is translated by this IG's translation file for the IPS profile.
* identifier ^short = "Persistent identifier for the Portuguese IPS bundle"
