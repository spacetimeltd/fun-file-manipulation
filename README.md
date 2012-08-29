# So here's what this is about
## So our Migration Tool script (aka the MT) tries to automatically download
>> all the associated product images so they can be uploaded with the rest of
>> the data during the migration.
## Problem is it doesn't work very well, and many of the files did not download
### completely, and then for some reason it tried to download them all again
### - with more success - but as duplicate files with (1) appended to the
### filename.
>> To top it off I deleted some of the files by accident, but I knew I still
>> had them in among the duplicates.
# So, this script sorts through all the files, compares the duplicates to the
# originals to determine which ones are corrupted or missing and then replace
them. It's rough, but I like it.
