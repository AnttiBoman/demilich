#!/usr/bin/env bash

# Encode/decode any string Nespithe-way. Requires Bash shell (https://www.gnu.org/software/bash/)
#
# Examples:
#   echo "no lyrics here" | nespithefier.sh
#   nespithefier.sh file-to-be-mangled.txt
#   echo "nespithe" | nespithefier.sh --reverse
#
# Updates can be found at https://github.com/AnttiBoman/demilich/blob/main/nespithefier.sh
#
# Licensed under the GNU General Public License v3.0 (https://github.com/AnttiBoman/demilich/blob/main/LICENSE)

# Argument handling stolen from https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
PARAMS=""
REVERSE=0
while (( "$#" )); do
  case "$1" in
    -r|--reverse)
      REVERSE=1
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

# Let's manglererify!!!
while IFS= read -r line ; do
    line=$(tr -d '[:space:]' <<< $line)
    final=""
    while [ "$line" != "" ] ; do
        if [ $REVERSE = 0 ] ; then
            final=${line:0:3}"$final"
            line=${line:3}
        else
            if (( ${#line} >= 3 )) ; then
                final="$final"${line: -3}
                line=${line: 0: $(( ${#line} - 3 )) }
            else
                final="$final"${line}
                line=""
            fi
        fi
    done
    echo $final
done < "${1:-/dev/stdin}"
