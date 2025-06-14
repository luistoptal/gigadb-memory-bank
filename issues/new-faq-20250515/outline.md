# Task Outline for New and Updated FAQs

## 1. Add New FAQ: "What is involved in data curation?"
**Q: What is involved in data curation?**

**A:**
GigaDB biocurators will enhance metadata about your submitted data files by inclusion of a dataset title, author list, description and keywords. The following actions, checks and enhancements are undertaken during the curation process:
- Check the consistency and completeness of data provided, with respect to the associated manuscript
- Carry out file integrity checks
- Ensure accessibility of data to end users
- Ensure transparency of data files including file descriptions and where appropriate additional metadata.
- Extract sample metadata to be hosted in GigaDB
- Check for presence of sensitive or identifying information
- Check methodology is complete and discoverable
- Recommend appropriate external repositories and appropriate details to include with those data
- Provide assistance with data upload to GigaDB repository (with up to 1TB free storage)
- Organise files into a logical structure and collections
- Content assigned to appropriate SRAO categories
- A Digital Object Identifier (DOI) is generated for each dataset
- Pre-publication embargoes with private, anonymous access can be enabled
- Link and synchronize dataset release to associated publications

## 2. Add New FAQ: "Who can use GigaDB's data support services?"
**Q: Who can use GigaDB's data support services?**

**A:**
The scope of GigaDB is all of the life sciences, so as long as your research is Open, and involves life sciences in some way and is in a state that forms a complete unit-of-work*, then contact us to discuss how we can help. By unit-of-work we just mean something that could be written up a scientific paper, that could be a data-note, technical-note or a research article.

## 3. Update FAQ(s) regarding CNGB relationship

### a. Update FAQ question and answer:
**Q: What's the relationship between GigaScience Press and GigaDB?**

**A:**
GigaScience Press currently publishes two journal; _[GigaScience](www.gigasciencejournal.com)_ and _[GigaByte](www.gigabytejournal.com)_, as well as one data archive; GigaDB. The GigaDB platform has been created with the intention of hosting all the data associated with articles published in GigaScience Press journals to ensure full transparency and reproducibility of those scientific articles and promote data sharing and data reuse in line with the FAIR sharing principles. It should be noted that GigaScience Press is a part of the BGI Group, who provided the start up funding for the journal and GigaDB development.

### b. Update answer to long term preservation plan:
**Q: What is the long term preservation plan for GigaDB?**

**A:**
The fact that BGI covers the majority of the costs of running GigaDB means that it will be actively maintained for the foreseeable future. In the longer term, it is envisaged that the article (and/or) data processing charges levied on submitters will cover storage and curation costs to enable the maintenance and sustained growth of GigaDB.

### c. Confirm any other mentions of CNGB in FAQs are removed or updated as per the new relationship (if any exist).

## 4. Remove FAQ: "How do I download a large dataset with my slow internet connection?"
- Delete this FAQ and its answer from the FAQ section.

## 5. Update FAQ: "How do I submit data?"
**Q: How do I submit data?**

**A:**
At present we only accept data submissions associated with _GigaScience_ and _GigaByte_ articles. The workflow is to prepare and submit your manuscript to one of those journals, if it is within scope we will reach out to the contact author to assist with the dataset preparation.

## Codebase Review for FAQ Update Task

### Relevant Files and Line Numbers

- **protected/views/site/faq.php**
  - Lines 1-100: FAQ structure and start of questions.
  - Line 164: "How do I submit data?" (to be updated)
  - Line 277: "How do I download a large dataset with my slow internet connection?" (to be removed)
  - Lines 561-581: "What curation do you carry out?" (existing curation FAQ, to be updated/expanded)
  - Lines 605-640: CNGB and storage/preservation FAQs (to be updated for new relationship and long-term plan)
  - Line 41x: "What is the long term preservation plan for GigaDB?" (to be updated)
  - Line 40x: "What's the relationship between GigaScience and GigaDB?" (to be updated)
  - No existing FAQ found: "Who can use GigaDB's data support services?" (to be added as new)

- **Other files with CNGB mentions (not FAQ, for consistency check):**
  - protected/views/site/guide.php (Line 26)
  - protected/views/site/term.php (Lines 142-157)

### Why These Files Are Relevant

- `protected/views/site/faq.php` is the main FAQ page for all user-facing FAQ content.
- CNGB mentions in other files are for general site information, not FAQ, but may need review for consistency.

### Summary Table

| File                                 | Line(s)   | Description                                                                 |
|-------------------------------------- |-----------|-----------------------------------------------------------------------------|
| protected/views/site/faq.php          | 1-100     | FAQ structure, add new FAQs here                                            |
| protected/views/site/faq.php          | 164       | "How do I submit data?" (update answer)                                     |
| protected/views/site/faq.php          | 277       | "How do I download a large dataset..." (remove this FAQ)                    |
| protected/views/site/faq.php          | 561-581   | "What curation do you carry out?" (update/expand for new curation FAQ)      |
| protected/views/site/faq.php          | 605-640   | CNGB, storage, and preservation FAQs (update for new relationship/plan)     |
| protected/views/site/faq.php          | 41x, 40x  | Relationship and preservation plan FAQs (update as per outline)              |
| protected/views/site/faq.php          | N/A       | Add new FAQ: "Who can use GigaDB's data support services?"                  |
| protected/views/site/guide.php        | 26        | General CNGB mention (not FAQ, check for consistency if needed)             |
| protected/views/site/term.php         | 142-157   | CNGB, BGI, hosting details (not FAQ, check for consistency if needed)       |