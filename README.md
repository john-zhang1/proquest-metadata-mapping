# Mapping ETD Metadata from ProQuest to DSpace using SWORDv1

This repository provides resources and code modifications for correctly ingesting Electronic Theses and Dissertations (ETDs) from ProQuest into DSpace using the SWORDv1 protocol. The challenge addressed here is that ProQuest's `mets.xml` file contains two `<dmdSec>` sections—one of type `EPDCX` and another of type `PROQUEST`. By default, DSpace only reads the first `<dmdSec>`, resulting in the loss of the actual ProQuest metadata.

## Repository Contents

- `mets.xml`: The original `mets.xml` file from ProQuest.
- `sword-proquest-ingest.xsl`: XSLT used to transform and extract metadata from the `mets.xml`.
- `dspace.cfg`: A modified configuration file that supports the custom ingest behavior.
- `DSpaceMETSIngester.java`: A modified algorithm for ingesting the correct metadata from `mets.xml`.

## Problem Statement

The standard DSpace METS ingester reads only the first `<dmdSec>` element in the `mets.xml` file. In ProQuest submissions, this is usually of type `EPDCX`, while the actual useful metadata is stored in the second `<dmdSec>` section of type `PROQUEST`. This results in incomplete metadata ingestion.

## Solution: Modify DSpace Ingest Process

To ingest the correct ProQuest metadata:

1. Use the provided `sword-proquest-ingest.xsl` to process the `mets.xml`.
2. Update your `dspace.cfg` using the provided version in this repo.
3. Replace your existing `DSpaceMETSIngester.java` with the modified version provided here.
4. Rebuild and redeploy your DSpace instance.

This approach ensures that the metadata from the `PROQUEST` section is used instead of the default `EPDCX` section.

## Compatibility

- Designed for **DSpace 7.x** environments using the **SWORDv1** protocol.
- Should be compatible with standard ProQuest metadata packages.

## Contributing

Feel free to fork this repository, submit pull requests, or open issues for suggestions and improvements.

## License

This repository is released under the [MIT License](LICENSE).
