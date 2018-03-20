cwlVersion: v1.0
class: CommandLineTool

label: "InterProScan: protein sequence classifier"

doc: |
      Releases can be downloaded from:
      ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/
      
      Documentation on how to run InterProScan 5 can be found here:
      https://github.com/ebi-pf-team/interproscan/wiki/HowToRun

requirements:
  ResourceRequirement:
    ramMin: 10240
    coresMin: 3
  SchemaDefRequirement:
    types: 
      - $import: InterProScan-apps.yaml
      - $import: InterProScan-protein_formats.yaml
hints:
  SoftwareRequirement:
    packages:
      interproscan:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_005829" ]
        version: ["5.21-60", "5.22-61.0", "5.23-62.0", "5.24-63.0", "5.25-64.0", "5.26-65.0", "5.27-66.0", "5.28-67.0"]

inputs:
  proteinFile:
    type: File
    inputBinding:
      prefix: --input
  # outputFileType:
  #   type: InterProScan-protein_formats.yaml#protein_formats
  #   inputBinding:
  #     prefix: --formats
  applications:
    type: InterProScan-apps.yaml#apps[]?
    inputBinding:
      itemSeparator: ','
      prefix: --applications

baseCommand: java --version

arguments:
 - valueFrom: $(inputs.proteinFile.nameroot).i5_annotations
   prefix: --outfile
 - valueFrom: TSV
   prefix: --formats
 - --disable-precalc
 - --goterms
 - --pathways
 - valueFrom: $(runtime.tmpdir)
   prefix: --tempdir


outputs:
  i5Annotations:
    type: File
    format: iana:text/tab-separated-values
    outputBinding:
      glob: $(inputs.proteinFile.nameroot).i5_annotations

$namespaces:
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/
$schemas:
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"
