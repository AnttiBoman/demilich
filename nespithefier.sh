#!/usr/bin/env bash

# Encode any string Nespithe-way. Requires Bash shell (https://www.gnu.org/software/bash/)
# Example:
#     echo "no lyrics here" | nespithefier.sh
#
# Updates can be found at https://github.com/AnttiBoman/demilich/blob/main/nespithefier.sh
#
# Licensed under the GNU General Public License v3.0 (https://github.com/AnttiBoman/demilich/blob/main/LICENSE)

while read line ; do
    line=$(tr -d '[:space:]' <<< $line)
    final=""
    while [ "$line" != "" ] ; do
        final=${line:0:3}"$final"
        line=${line:3}
    done
    echo $final
done < "${1:-/dev/stdin}"
