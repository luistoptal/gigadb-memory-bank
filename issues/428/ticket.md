Link previews E597 #428
Open
Listed in
#597
Open
Link previews E597
#428
Listed in
#597
@only1chunts
Description
only1chunts
opened on May 22, 2020 · edited by rija
User Story
As a website user
I want to see a preview of any link on the dataset pages
So that I have an idea of what that link's website is about

Acceptance Criteria
Given I have three non-GigaDB links associated to a dataset
When I navigate to the dataset pages
Then I should see metadata from the metatags, Open Graph and twitter card (thumbnail, site summary,...) of the target links

Addtional infos
Is your feature request related to a problem? Please describe.
Currently any links to additional info get added to GigaDB as basic URL links with no descriptions or anything. The addition of description is in another ticket (#61 ) It would be very nice to have a "preview" of the website its linking to, similar to the sort of thing that appears in facebook
, twitter etc when you add a URL to a comment there.

Describe the solution you'd like
On a dataset page (e.g. http://gigadb.org/dataset/100482) there are often "Additional information" links, in this example there are 4:
https://pypi.org/project/ANNOgesic/
http://annogesic.readthedocs.io/en/latest/subcommands.html
http://annogesic.readthedocs.io/en/latest/required.html
https://hub.docker.com/r/silasysh/annogesic/

It would be nice to arrange these into square preview panels to look something like this:
NB two of the additional links are to different pages in the "read the docs" so I've just added it once here.
link-previews-mockup

Maybe this https://metatags.io/ could be useful ?

Additional context
Whatever solution is found here, it may also be useful for the GitHub preview widget ticket? (#266 )
In the above example there is also a GitHub link: for example
https://github.com/gigascience/gigadb-website , using metatag.io looks like this:
github-preview

This Story is part of Epic #597

Activity
only1chunts
added
enhancement
 on May 22, 2020
kencho51
kencho51 commented on Sep 29, 2020
kencho51
on Sep 29, 2020
Member
Hi @pli888 and @rija ,

I have done some background research on how to implement a link preview , which requires either installing different tools and modules or using API. But I am not sure these are the correct way to implement this feature. Please have a look and advise.

pli888
added
Ken
 on Oct 5, 2020
rija
rija commented on Oct 5, 2020
rija
on Oct 5, 2020
Member
Hi @only1chunts

Reading the requirements raises these questions:

Is it more useful the preview reflects the current state of the linked web site or should it reflects what the link looked like when it was added initially?

Do we want to preview all the links at the same time (as seen on your mockup), or only preview the link a user is interested in?

Is there a potential for similar requirements for other types of links in the future?

Being interested in original state and wanting to show previews for all additional info links implies we will have to store the previews in GigaDB (and figure out how to store these previews) with change to the schema so the link can locate where the preview is.

Being interested in current state and wanting that for all additional info links will cause the dataset view page to be slow to load because the page will have to calculate the current preview for all the additional info links.

All use cases I've seen of link previews only load the previews when one particular link is becoming the focus of the user (by hovering over the link, or sharing the link)

So for us, a more efficient UX would be to have a "preview" button next to each link or enable preview upon hovering.

Preview on hovering will be slow if the preview has to be calculated in realtime.

only1chunts
only1chunts commented on Oct 5, 2020
only1chunts
on Oct 5, 2020
Member
Author
Hi @rija ,

I had assumed the preview would be dynamic and show "now" rather than old, however, I'd estimate that >90% of them will likely be the same as they were when originally added anyway, so I guess it's not particularly important that it shows current.
Aesthetically I would like them all to be present on the page at the point of loading the page rather than just having a text URL that users would need to know to hover over to see the preview.
Yes there is potential for all "additional information" and "external links" to have a preview function. For the "Additional information" links being discussed in this thread, I would like the page to include the preview immediately on page loading (as shown in the original post of this thread/ticket), for "External Links" (things like links out to BioProjects and those things stored in the EXTERNAL_LINKS table) there is a related ticket on a desire to hold descriptions for those sorts of links Add a description to the “Links” #61 which might also be relevant here if this sort of behaviour requires the storage of that sort of information.
If storing the preview image is problematic or slows loading times too much then we could forgo the images and just use the google search-results style previews that have the link and short description. (see example previews on https://metatags.io/)

If we store the information for a preview-link would there be any provision for updates of those details either at fixed time points or as an admin-user induced refresh?

rija
rija commented on Oct 6, 2020
rija
on Oct 6, 2020
Member
Thanks @only1chunts for the clarification.

Generating a preview image yields different set of problems whether we store them or calculate them on the fly.
And indeed if they are stored, it would make sense to be able to update these details.

However from looking at metatags.io, I've just realised that Facebook and Twitter do not necessarily generate preview images. They rely on semantic markup in the HTML of the target web site to pull out the preview information including the preview image.

Would it work for you if we take a similar approach:

In order to assess what the links are about without leaving the page, when a researcher loads a dataset page, for each link we fetch the preview metadata (if semantic markup is missing we fetch the meta-title and meta-description tags so we get at least the title and description) which will have the url of a preview image if the target web site has defined the semantic markup for it and we display them according to the mockup you've supplied.

Because we don't generate any images on the fly, there's no huge hit on dataset page loading performance.
Because we don't store anything, there's no additional tooling or infrastructure to devise and deploy.

The connection to the target web sites could still impact a bit the loading time of the dataset page, especially if there are many links, but we could alleviate this with server-side caching of the preview metadata if it's a problem.

only1chunts
only1chunts commented on Oct 6, 2020
only1chunts
on Oct 6, 2020
Member
Author
using the metatags would be fine I think.
With the use of metatags in mind can we check that our datasets have all the appropriate metadata to enable others to generate nice previews of our pages? i.e. can we use the thumbnail images in each page to populate the relevant metatag field in the HTML code of the site?

rija
rija commented on Oct 6, 2020
rija
on Oct 6, 2020 · edited by rija
Member
@only1chunts,

It should be feasible to add the image path of the main image (is that what you call thumbnail? ) in a set of semantic markups on each page. That would be a separate piece of work though.

What I was wondering is what is the value of #61 now? Couldn't we just use the same link preview feature for external link too ?
Surely how a web site describe itself (and meta-description should always be there otherwise websites would rank badly on Google search results) is more accurate than whatever description we'd add manually?

@pli888,

I think this task is not small but it shouldn't be too difficult (i.e I don't see traps or dragons in there). Now that requirement is clearer, approach is clear and there are good precedents and examples in GigaDB.

This is about fetching and parsing medata information from other websites into a data layer, caching it, and doing formatting on the presentation layer. It's probably best that we divide the story in three tasks/tickets/PRs along the layers boundaries.
It would then be easier to review constructively and merge, and It reduces the mental scope to something manageable for each task.

For example, first task could be to implement a StoredLinkPreview.php, second one to implement CachedLinkPreview.php, and third one to implement FormattedLinkPreview.php and the dataset/view.php changes.

@kencho51,

Great initiative! That blog post has indeed some good info as it alludes to why we can't do this on the frontend (in the browser) in general for arbitrary links (keywords here are CORS and WCP), and what metadata languages (HTML, OGP) we are dealing with.

The linkpreview API is not the right approach for a couple of reasons, chiefly because for each our additional information link, our page will need to make one connection to their API, which in turn will make another connection to the target web site. That's a lot of connections per link. Not even counting the time to generate previews, this will slow down the page heavily. The dataset page is one of the most important page of the site, it needs to load as fast as possible.
Additionally, we do not control that API, we don't know the quality of their code or the stability and performance of their operations nor whether they respect their data policy. For all we know they could go out of business any moment or get hacked or be prone to bad quality connection. In order to alleviate some of the risks, we'd probably need a professional level subscription with guarantees, which mean we would need to pay a regular fee.

If you go to https://packagist.org (which list all PHP libraries available through Composer), and search for "meta-tags", "link preview", "microdata", "microformats", "schema" or "OGP", you will get a few results that may or may not be helpful to us in reducing the amount of code we need to implement. We would need to evaluate them.

only1chunts
only1chunts commented on Oct 6, 2020
only1chunts
on Oct 6, 2020
Member
Author
@rija to save confusion about which image I mean i've put a red box around the image on an example page below:
image
For External Links (#61) having the same sort of preview but on a pop-up rather than a constant view should be fine, i just noticed that GitHub does this for ticket links !

image

I dont know if it makes any difference to anything, but maybe something to be aware of is that some external links get rendered into their own iframe tab.

only1chunts
mentioned this on Oct 6, 2020
manuscript link not showing on dataset pages? #512
rija
rija commented on Oct 6, 2020
rija
on Oct 6, 2020
Member
@only1chunts

Yes, that's the image I was thinking of as well. I was hesitant calling it thumbnail because it's not exactly thumb-sized and doesn't perform the function of a thumbnail image. We probably should find a better name for it at some point.
Anyway, it's still a different user story from this ticket, feel free to file a new ticket, it's quite a small task.

Re #61, its seems then that ticket should just be updated to de-emphasize adding description and add mention of a pop-up link preview.
(by the way when I was writing about "hovering", that's the behaviour I tried to describe)
Re the iframe rendering, I don't know what does that imply, let's just add that info on the ticket so it can be investigated whenever that ticket is about to be worked on.

only1chunts
only1chunts commented on Oct 6, 2020
only1chunts
on Oct 6, 2020
Member
Author
I've split the part about making our pages preview nicely in external tools like facebook & google to a new ticket #513

rija
rija commented on Oct 8, 2020
rija
on Oct 8, 2020
Member
Thanks @only1chunts.

Now that #85 and #513 have been updated and created respectively, I'd recommend for @kencho51 to work on them before this ticket: They are small and self-contained to the presentation layer and are good introduction to linked data applications. By the time this ticket is ready to be worked on, the domain will already be familiar.

kencho51
kencho51 commented on Oct 8, 2020
kencho51
on Oct 8, 2020
Member
Hi @rija
Ok I will work on #85 and #513 first.

rija
rija commented on Oct 18, 2020
rija
on Oct 18, 2020 · edited by kencho51
Member
@only1chunts @kencho51

User Story and acceptance tests:
Feature: Adding preview information for the links listed on dataset page under "Additional information"
As a researcher
I want to see preview information of links to additional information when I visit a dataset page
So that I can assess what all the links are about without leaving the dataset page


Background:
Given there are "Additional information" links associated with datasets:
| dataset | url | comment |
| 100002 | https://pypi.org/project/ANNOgesic/  | has all metadata  |
| 100002 | https://www.cell.com/ajhg/fulltext/S0002-9297(17)30074-5  | has all metadata  |
| 100002 | https://metatags.io/  | has all metadata |
| 100002| https://biocontainers.pro/#/registry  | has title, description |
| 100002 | http://annogesic.readthedocs.io/en/latest/subcommands.html  | has title |


Scenario: All links with title, description and image
Given I am not logged in
When I go to "/dataset/100002"
Then I should see all metadata for links under "Additional information"
| links |
| https://pypi.org/project/ANNOgesic/ |
| https://www.cell.com/ajhg/fulltext/S0002-9297(17)30074-5 |
| https://metatags.io/ |

Scenario: Show preview information for links with title and description only
Given I am not logged in
When I go to "/dataset/100002"
Then I should see the title for url "https://biocontainers.pro/#/registry" under  "Additional information"
Then I should see the description for url "https://biocontainers.pro/#/registry" under  "Additional information"

Scenario: Show preview information for links with title only
Given I am not logged in
When I go to "/dataset/100002"
Then I should see the title  for url "http://annogesic.readthedocs.io/en/latest/subcommands.html" under  "Additional information"

Implementation Notes
The implementation code will be organised using onion architecture patterns already used extensively in DatasetPageAssembly.php (used by DatasetController.php).

Here is an example from that class you can emulate as the flow and the nature of source (external web site) is similar:

/**
	 * Create a connections dataset component to be use in a dataset page
	 *
	 * @return DatasetPageAssembly
	 */
	public function setDatasetConnections(): DatasetPageAssembly
	{
		$this->_connections = new FormattedDatasetConnections(
                            $this->_app->getController(),
                        new CachedDatasetConnections (
                            $this->_app->getCache(),
                            $this->_cacheDependency,
                            new StoredDatasetConnections(
                                $this->_dataset->id,
                                $this->_app->getDb(),
                                new \GuzzleHttp\Client()
                            )
                    )
                );
		return $this;
	}
which is setup in DatasetController.php as such:


        // Assembling page components and page settings

        $assembly = DatasetPageAssembly::assemble($model, Yii::app(),$srv);
        $assembly->setDatasetSubmitter()
...
                    ->setDatasetConnections()
...
and is then used in dataset/view.php as such:

<div class="subsection">
                    <div class="underline-title">
                        <div>
                            <h4>Additional details</h4>
                        </div>
                    </div>
                    <?php
                    $publications = $connections->getPublications();
                    if (!empty($publications)) { ?>
                        <h5><strong><?= Yii::t('app' , 'Read the peer-reviewed publication(s):')?></strong></h5>
                        <p>
                            <? foreach ($publications as $publication){
                                echo $publication['citation'].$publication['pmurl'];
                                echo "<br/>";
                            }
                            ?>
                        </p>
                    <?php } ?>
The implementation can be divided in five parts:


Implement protected/components/StoredDatasetLinksPreview.php

Implement protected/components/CachedDatasetLinksPreview.php

Implement protected/components/FormattedDatasetLinksPreview.php

Implement acceptance tests

Update of DatasetPageAssembly.php, DatasetController.php and dataset/view.php
18 remaining items
only1chunts
mentioned this on Mar 5
Improve external links experience #597
rija
added
freelance
 on Mar 11
rija
mentioned this in 2 issues on Mar 11
github widget E597 #266
we need ability to store and display bioXriv links E597 #331
only1chunts
mentioned this 3 weeks ago
Display pre-print manuscript on dataset page #2236
alli83
alli83 commented 2 weeks ago
alli83
2 weeks ago
Member
@luistoptal are you working on it?

luistoptal
luistoptal commented 2 weeks ago
luistoptal
2 weeks ago
Member
Hi @alli83 it doesn't sound familiar, I think I missed it

I will take a look at it next week

only1chunts
only1chunts commented 2 weeks ago
only1chunts
2 weeks ago
Member
Author
i maybe mistaken, but I think @kencho51 was looking into something related to metatags too, but I think that was about making GigaDB dataset pages include all the relevant metatags to have them display properly (related but distinct to this, but maybe worth discussing overlaps?).

rija
rija commented 2 weeks ago
rija
2 weeks ago · edited by rija
Member
@only1chunts

@kencho51's work is about allowing other websites to easily preview links to Gigadb.org, by augmenting gigadb.org's HTML source code with schema.org meta-tags.

It is not related to the external links epics @alli83 (backend and admin) and @luistoptal (fancy previews on dataset pages) are working on

