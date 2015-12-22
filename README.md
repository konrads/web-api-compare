web-api-compare
===============
Runs comparison on presumably comparable REST endpoints. Eg.
* fetches content and status code (at the moment no headers) on url1, url2
* normalizes content, ie. if json - sort content
* records both raw and normalized version
* diffs normalized version

to run
------
```bash
> bin/test.sh <optional_stage_dir>
```

todo
----
* compare request types other than GET
* enable header comparison?
