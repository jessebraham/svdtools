#!/bin/bash

# The -e flag causes the script to exit as soon as one command returns a
# non-zero exit code. This will cause the Travis build to fail as soon as a
# single difference is found in any of generated SVD files.
set -e

# For each known-good patched SVD file, generate its counterpart using the
# current build of svdtools and search for any differences between the two
# files to ensure there have been no regressions. If any differences are found,
# the script will immediately exit due to the -e flag being set above.
for old in tests/svds/*.svd.patched; do
  # Flags:
  #  -q  report only when files differ
  #  -E  ignore changes due to tab expansion
  #  -b  ignore changes in the amount of white space
  #  -B  ignore changes where lines are all blank
  #  -s  report when two files are the same
  diff -qEbBs $old tests/stm32-rs/svd/$(basename $old)
done
