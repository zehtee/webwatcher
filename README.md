# webwatcher
Get informed if a website has changed since the last check
start watcher.sh <url> to create a sha256 hash from this site.
the next time you start watcher.sh, the new hash value is written to the existing .watch-file and both values are compared. 
You get a result if both values are not equal. 

watcher.cfg contains characters from urls, that should be removed to create a filename from the url
