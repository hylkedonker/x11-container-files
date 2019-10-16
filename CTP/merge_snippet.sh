#!/bin/bash
# Usage: merge_snippet.sh snippet_file /path/to/config.xml
# Merge contents of configsnippet.xml and config.xml.

# Note that we use the number of lines from configsnippet.xml since there is a
# missing newline at the end of the file.
n=$(wc -l ${2} | cut --delimiter=" " --fields=1)
head --lines=${n} "${2}"
cat $1
tail --lines=1 ${2}