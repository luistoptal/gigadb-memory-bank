# File attribute's unit is not displayed in the file tab

**Describe the bug**
> As a user
>When I am on a dataset page
>And I look at the file tab
>Then I do not see the unit associated with a file's attribute if this attribute has a non-empty unit value

**To Reproduce**
Steps to reproduce the behavior:
1. As admin, go to the file edit page of a file (e.g https://staging.gigadb.org/adminFile/update/id/549208)
2. Add a new attribute (e.g. 'Estimated genome size'), put any value and select a unit (e.g. MegaBasePair)
3. Go to the dataset page, file tab
4. See the updated file attribute is missing the unit

**Expected behavior**
When a unit is filled with a file's attribute, I want this unit to be displayed along with the attribute's value.

**Screenshots**

![Image](https://github.com/user-attachments/assets/f128336f-f7e6-48de-b1a3-2afab68e82fc)


**Additional context**
Minor bug, as we can add the unit with the value ('618.1' --> '618.1 Mb'), but it would still be great to fix it