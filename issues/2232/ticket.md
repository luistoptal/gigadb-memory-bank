extend 3d viewer capabilities to VR #2232
Open
Open
extend 3d viewer capabilities to VR
#2232
@only1chunts
Description
only1chunts
opened on Mar 6 · edited by rija
User story
As a website user
I want to be able to view VR 3d models
So that I be more immersed in the data

Acceptance criteria
Given there is a dataset with associated 3D models files meant for VR
When I navigate to the dataset page from a WebXR capable device
and I switch to the 3D models tab
Then I can the object in VR

Additional Info
One feature that Sketchfab offer is to view the 3d images in "VR"

for example see: https://sketchfab.com/models/71ceee228fff4c02bbd99df462eb16a5/embed?autostart=1&cardboard=1&internal=1&tracking=0&ui_ar=0&ui_infos=0&ui_snapshots=1&ui_stop=0&ui_theatre=1&ui_watermark=0

@luistoptal Is that something that can be added to our 3d viewer?
If the answer is yes, we can expand this ticket and plan it into future work. If its a flat no, then we can close this ticket now!

Product Backlog Item Ready Checklist

Business value is clearly articulated

Item is understood enough by the IT team so it can make an informed decision as to whether it can complete this item

Dependencies are identified and no external dependencies would block this item from being completed

At the time of the scheduled sprint, the IT team has the appropriate composition to complete this item

This item is estimated and small enough to comfortably be completed in one sprint

Acceptance criteria are clear and testable

Performance criteria, if any, are defined and testable

The Scrum team understands how to demonstrate this item at the sprint review
Product Backlog Item Done Checklist

Item(s) in increment pass all Acceptance Criteria

Code is refactored to best practices and coding standards

Documentation is updated as needed

Data security has not been compromised (with particular reference to the personal information we hold in GigaDB)

No deviation from the team technology stack and software architecture has been introduced

The product is in a releasable state (i.e. the increment has not broken anything)
Activity
only1chunts
added
backlog:Story

freelance

frontend
 on Mar 6
only1chunts
added this to  Backlog: GigaDB Databaseon Mar 6
luistoptal
luistoptal commented on Mar 6
luistoptal
on Mar 6
Member
Hi @only1chunts In principle it should be possible because the library we use to implement the 3D viewer (three.js) is compatible with webXR (augmented reality tech used in VR devices)

It might be compatible out of the box or it might require additional work, I would need to look into it

only1chunts
added this to the K. integration of new features in public facing GigaDB pages, e.g. widgets milestone on Mar 7
only1chunts
only1chunts commented on Mar 7
only1chunts
on Mar 7
Member
Author
thanks @luistoptal we will scope this ticket at a future product refinement workshop and let you know when its ready to work on.

only1chunts
moved this to Needs changes in  Backlog: GigaDB Database2 weeks ago
only1chunts
moved this from Needs changes to No status in  Backlog: GigaDB Database2 weeks ago
rija
rija commented 2 weeks ago
rija
2 weeks ago
Member
I'll test it with Safari for Vision Pro witch is webXR capable and report that wether it works or whether more work is needed

rija
moved this to Needs changes in  Backlog: GigaDB Database2 weeks ago
rija
rija commented 5 days ago
rija
5 days ago · edited by rija
Member
Hi @luistoptal,

After some testing, I observed the following

Sketchfab has a function that seems to take an existing regular 3D model (STL) and create a stereoscopic version to be used specifically in Google Cardboard (long discontinued) and the link @only1chunts added in description is exactly that.

In my WebXR browser (Safari on VisionOS), in Sketchfab there is only partial support. Movement control is recognised, but the immersion isn't (i.e: I see two copies in their own vignetted window of the model like someone who click that link on a regular web browser, but my head movement is recognised and change the POV in the those vignetted windows).

In my WebXR browser (Safari on VisionOS), from the 3D models tab on the dataset page corresponding to the same DOI as the Sketchfab example, nothing happens.

So even if Three.js supports WebXR, I reckon there is still work to do to:

Make the model accessible through WebXR context
Negotiate with the WebXR browser(s) the protocol for the control and UI (capabilities, hooks,...)
As a baseline, the following WebXR examples work perfectly for me:

https://threejs.org/manual/#en/webxr-basics
https://immersive-web.github.io/webxr-samples/
https://webkit.org/demos/webxr-chess/
https://aframe.glitch.me
