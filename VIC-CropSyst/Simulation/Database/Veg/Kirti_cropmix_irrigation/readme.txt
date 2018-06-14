Hi Min,
Attached is information for you based on the 2008 cdl you sent today. This is not in irrigation parameter file format yet (sorry ran out of time) but can be done quickly.  I can get to it tomorrow night, if you don't get to it.

File has two sheets for the 18 crops we selected plus one "generic crop" to make up rest of crop acres (from the read me you sent, I moved "other hay" and "seed sod grass" to the "crop list".  Generic crop fraction is (sum of fractions of all crops - fallow fraction)  - (sum of fractions of 18 crops we selected).

I assumes some crops to be always irrigated, and then adjusted barley, spring and winter wheat, and hay fractions such that total irrigated extent in sub area 32 is in the ball park of irrigation extent our products gave us. After these adjustments, there was no room to adjust dry beans, canola, and chamile irrigated acres (so they are not irrigated in any cell).  This is partly because I assumed that the full fraction of a specific crop is either irrigated or not (ie, one grid does not have half spring wheat irrigated and half not irrigated). We can change this assumption later and spread irrigation across all crops as needed.

In sub area 32, we are at about 250,000 irrigated acres. Per Ozdogan it is 260,000 acres, per new modis product it is 220,000 acres, and per 2010 modified flow it is 160,000 acres.

Ill be on the road most of tomorrow. So feel free to call me.

Regarding irrigation types.

Apples and Cherries - predominat type in WA is sprinkler, some grip.
All other crops in out 18 crop list, dominant is center pivot.
Barley is the only crop for which both center pivot and "wheel line" are dominant. I think we can simulate all but trees as center pivot and trees as sprinkler.

--Kirti