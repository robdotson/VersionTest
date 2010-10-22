#!/bin/tcsh
#  git-version.sh
#  VersionTest
#
#  Created by Rob Dotson on 10/22/10.
#  Copyright (c) 2010 New York University. All rights reserved.

# Get the path to the plist file
setenv MY_PLIST `echo ${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH} | sed 's/\(.*\)\..*/\1/'`
setenv MY_BUNDLE_VERSION `defaults read $MY_PLIST CFBundleVersion`

# Check if the bundle version exists or is zero, if so, set it to one
if( $MY_BUNDLE_VERSION == "" || $MY_BUNDLE_VERSION == 0 ) then
setenv MY_BUNDLE_VERSION 1
endif

# Find the default git on this system, this could be made more robust
# by iterating through the files returned by whereis or using an
# environment variable.
# If git cannot be found, try subversion. If that fails, just increment
# the build version.
if( -e `which git` ) then
setenv MY_VERSION `git rev-list --all | wc -l | sed "s/[ \t]//g"`
#	if [ $BUNDLE_VERSION -ge $MY_VERSION ]; then
#		MY_VERSION = $BUNDLE_VERSION;
#	fi
else
setenv MY_VERSION `expr $MY_BUNDLE_VERSION + 1`
endif

# Check if the final version exists or is zero, if so, set it to one
if( $MY_VERSION == "" || $MY_VERSION == 0 ) then
setenv MY_VERSION 1
endif

defaults write $MY_PLIST CFBundleVersion $MY_VERSION

echo $MY_VERSION
