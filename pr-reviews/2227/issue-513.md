Add the metadata schema on dataset page to allow other web sites to make link previews of our web site #513
Closed
Closed
Add the metadata schema on dataset page to allow other web sites to make link previews of our web site
#513
@only1chunts
Description
only1chunts
opened on Oct 6, 2020 · edited by rija
User Story
As an operator of a partner website
I want to extract preview metadata from links to GigaDB datasets
So I can present preview information to my visitors interested in those links
example from metatags.io

      <!-- Primary Meta Tags -->
      <title>Meta Tags — Preview, Edit and Generate</title>
      <meta name="title" content="Meta Tags — Preview, Edit and Generate">
      <meta name="description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">

      <!-- Open Graph / Facebook -->
      <meta property="og:type" content="website">
      <meta property="og:url" content="https://metatags.io/">
      <meta property="og:title" content="Meta Tags — Preview, Edit and Generate">
      <meta property="og:description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">
      <meta property="og:image" content="https://metatags.io/assets/meta-tags-16a33a6a8531e519cc0936fbba0ad904e52d35f34a46c97a2c9f6f7dd7d336f2.png">

      <!-- Twitter -->
      <meta property="twitter:card" content="summary_large_image">
      <meta property="twitter:url" content="https://metatags.io/">
      <meta property="twitter:title" content="Meta Tags — Preview, Edit and Generate">
      <meta property="twitter:description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">
      <meta property="twitter:image" content="https://metatags.io/assets/meta-tags-16a33a6a8531e519cc0936fbba0ad904e52d35f34a46c97a2c9f6f7dd7d336f2.png">
example from cell.com
<meta property="og:title" content="Mutations in TMEM260 Cause a Pediatric Neurodevelopmental, Cardiac, and Renal Syndrome" />
    <meta property="og:type" content="Article" />
    <meta property="og:url" content="https://www.cell.com/ajhg/abstract/S0002-9297(17)30074-5" />
    <meta property="og:site_name" content="The American Journal of Human Genetics" />
    <meta property="og:image" content="//els-jbs-prod-cdn.jbs.elsevierhealth.com/cms/attachment/2089506234/2075402522/gr2.jpg" />
    <meta property="og:description" content="Despite the accelerated discovery of genes associated with syndromic traits, the majority
of families affected by such conditions remain undiagnosed. Here, we employed whole-exome
sequencing in two unrelated consanguineous kindreds with central nervous system (CNS),
cardiac, renal, and digit abnormalities. We identified homozygous truncating mutations
in TMEM260, a locus predicted to encode numerous splice isoforms. Systematic expression
analyses across tissues and developmental stages validated two such isoforms, which
differ in the utilization of an internal exon." />
    <meta name="twitter:title" content="Mutations in TMEM260 Cause a Pediatric Neurodevelopmental, Cardiac, and Renal Syndrome" />
    <meta name="twitter:image" content="https://els-jbs-prod-cdn.jbs.elsevierhealth.com/cms/attachment/2089506234/2075402522/gr2.jpg" />
    <meta name="twitter:description" content="Despite the accelerated discovery of genes associated with syndromic traits, the majority
of families affected by such conditions remain undiagnosed. Here, we employed whole-exome
sequencing in two unrelated consanguineous kindreds with central nervous system (CNS),
cardiac, renal, and digit abnormalities. We identified homozygous truncating mutations
in TMEM260, a locus predicted to encode numerous splice isoforms. Systematic expression
analyses across tissues and developmental stages validated two such isoforms, which
differ in the utilization of an internal exon." />
Additional Infos
The second example uses a "name" attribute for Twitter meta-tags. It's not exactly incorrect, but for consistency we should use "property" for both Twitter and OGP meta-tags like the first example.
However, We use "name" attribute for HTML meta-tags for non-namespaced title and description because that's the HTML spec and search engine based preview tools relies on the web page to have these HTML meta-tags.
FYI, Twitter and Facebook use "property" because they parse RDFa whose specification make "property" a valid attribute on "meta" elements
We use the dataset thumbnail as the value for the image predicate
How to test, how do we know the work is done
Acceptance scenarios:

features/dataset-metadata-link-preview.feature

Feature: Add the metadata schema on dataset page to allow other web sites to make link previews of our web site
As an operator of a partner website
I want to extract preview metadata from links to GigaDB datasets
So I can present preview information to my visitors interested in those links

Scenario: can be parsed by preview tools that use OGP (e.g: Facebook)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see Open Graph meta-tags
| property | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| url | http://gigadb.dev/dataset/100002 |
| image | http://gigadb.org/images/data/cropped/100006_Pygoscelis_adeliae.jpg |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

Scenario: can be parsed by preview tools that use Twitter/OGP (e.g:Twitter)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see Twitter meta-tags
| property | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| url | http://gigadb.dev/dataset/100002 |
| image | http://gigadb.org/images/data/cropped/100006_Pygoscelis_adeliae.jpg |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

Scenario: can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see HTML meta-tags
| name | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

(please check you're happy with this acceptance tests @only1chunts)

(it's provisional, it may vary slightly to cater for implementation constraints or formatting)

Is your feature request related to a problem? Please describe.
We would like external sites like Google, twitter and Facebook to be able to show appropriate link previews. To do that they rely on specific meta tags within the HTML code of web-pages.

Describe the solution you'd like
From looking at Facebook it appears to already work, i.e. when i try to write a post and copy a GigaDB dataset URL facebook is clever enough to pull in the correct image, title and description to create the preview. However, it doesn't appear to work in twitter.
I've not been able to check in Google search results because it appears we're no longer being indexed by google search so none of our datasets are appearing in search results even when I use a dataset title to search with?!

Rija suggested "exposing metadata using the generic HTML meta-tags, OGP and twitter schemas".

Activity

only1chunts
added
enhancement
 on Oct 6, 2020

only1chunts
mentioned this on Oct 6, 2020
Link previews E597 #428
rija
rija commented on Oct 9, 2020
rija
on Oct 9, 2020
Member
@only1chunts

For the issue with Google indexing, I recommend creating a new ticket as bug and ping Peter and Jesse. it could be related to the state of the code on production

only1chunts
only1chunts commented on Oct 9, 2020
only1chunts
on Oct 9, 2020
Member
Author
thanks @rija I have created ticket #515 for the google search thing

rija
rija commented on Oct 10, 2020
rija
on Oct 10, 2020
Member
@kencho51, here are the details to help implement this work

User Story
As an operator of a partner website
I want to extract preview metadata from links to GigaDB datasets
So I can present preview information to my visitors interested in those links
example from metatags.io

      <!-- Primary Meta Tags -->
      <title>Meta Tags — Preview, Edit and Generate</title>
      <meta name="title" content="Meta Tags — Preview, Edit and Generate">
      <meta name="description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">

      <!-- Open Graph / Facebook -->
      <meta property="og:type" content="website">
      <meta property="og:url" content="https://metatags.io/">
      <meta property="og:title" content="Meta Tags — Preview, Edit and Generate">
      <meta property="og:description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">
      <meta property="og:image" content="https://metatags.io/assets/meta-tags-16a33a6a8531e519cc0936fbba0ad904e52d35f34a46c97a2c9f6f7dd7d336f2.png">

      <!-- Twitter -->
      <meta property="twitter:card" content="summary_large_image">
      <meta property="twitter:url" content="https://metatags.io/">
      <meta property="twitter:title" content="Meta Tags — Preview, Edit and Generate">
      <meta property="twitter:description" content="With Meta Tags you can edit and experiment with your content then preview how your webpage will look on Google, Facebook, Twitter and more!">
      <meta property="twitter:image" content="https://metatags.io/assets/meta-tags-16a33a6a8531e519cc0936fbba0ad904e52d35f34a46c97a2c9f6f7dd7d336f2.png">
example from cell.com
<meta property="og:title" content="Mutations in TMEM260 Cause a Pediatric Neurodevelopmental, Cardiac, and Renal Syndrome" />
    <meta property="og:type" content="Article" />
    <meta property="og:url" content="https://www.cell.com/ajhg/abstract/S0002-9297(17)30074-5" />
    <meta property="og:site_name" content="The American Journal of Human Genetics" />
    <meta property="og:image" content="//els-jbs-prod-cdn.jbs.elsevierhealth.com/cms/attachment/2089506234/2075402522/gr2.jpg" />
    <meta property="og:description" content="Despite the accelerated discovery of genes associated with syndromic traits, the majority
of families affected by such conditions remain undiagnosed. Here, we employed whole-exome
sequencing in two unrelated consanguineous kindreds with central nervous system (CNS),
cardiac, renal, and digit abnormalities. We identified homozygous truncating mutations
in TMEM260, a locus predicted to encode numerous splice isoforms. Systematic expression
analyses across tissues and developmental stages validated two such isoforms, which
differ in the utilization of an internal exon." />
    <meta name="twitter:title" content="Mutations in TMEM260 Cause a Pediatric Neurodevelopmental, Cardiac, and Renal Syndrome" />
    <meta name="twitter:image" content="https://els-jbs-prod-cdn.jbs.elsevierhealth.com/cms/attachment/2089506234/2075402522/gr2.jpg" />
    <meta name="twitter:description" content="Despite the accelerated discovery of genes associated with syndromic traits, the majority
of families affected by such conditions remain undiagnosed. Here, we employed whole-exome
sequencing in two unrelated consanguineous kindreds with central nervous system (CNS),
cardiac, renal, and digit abnormalities. We identified homozygous truncating mutations
in TMEM260, a locus predicted to encode numerous splice isoforms. Systematic expression
analyses across tissues and developmental stages validated two such isoforms, which
differ in the utilization of an internal exon." />
Notes
The second example uses a "name" attribute for Twitter meta-tags. It's not exactly incorrect, but for consistency we should use "property" for both Twitter and OGP meta-tags like the first example.
However, We use "name" attribute for HTML meta-tags for non-namespaced title and description because that's the HTML spec and search engine based preview tools relies on the web page to have these HTML meta-tags.
FYI, Twitter and Facebook use "property" because they parse RDFa whose specification make "property" a valid attribute on "meta" elements
We use the dataset thumbnail as the value for the image predicate
How to test, how do we know the work is done
Acceptance scenarios:

features/dataset-metadata-link-preview.feature

Feature: Add the metadata schema on dataset page to allow other web sites to make link previews of our web site
As an operator of a partner website
I want to extract preview metadata from links to GigaDB datasets
So I can present preview information to my visitors interested in those links

Scenario: can be parsed by preview tools that use OGP (e.g: Facebook)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see Open Graph meta-tags
| property | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| url | http://gigadb.dev/dataset/100002 |
| image | http://gigadb.org/images/data/cropped/100006_Pygoscelis_adeliae.jpg |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

Scenario: can be parsed by preview tools that use Twitter/OGP (e.g:Twitter)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see Twitter meta-tags
| property | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| url | http://gigadb.dev/dataset/100002 |
| image | http://gigadb.org/images/data/cropped/100006_Pygoscelis_adeliae.jpg |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

Scenario: can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
Given I am not logged in to Gigadb web site
When I go to "/dataset/100002"
And I view the page source
Then I should see HTML meta-tags
| name | value |
| title | GigaDB Dataset - DOI 10.5524/100002 - Genomic data from Adelie penguin (Pygoscelis adeliae). |
| description | The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb. |

(please check you're happy with this acceptance tests @only1chunts)

(it's provisional, it may vary slightly to cater for implementation constraints or formatting)