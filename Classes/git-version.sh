#!/bin/sh

#  git-version.sh
#  VersionTest
#
#  Created by Rob Dotson on 10/22/10.
#  Copyright (c) 2010 New York University. All rights reserved.

set PLIST = ${INFOPLIST_PATH}

echo $INFOPLIST_PATH
echo $PLIST

BUNDLE_VERSION = `defaults read $PLIST CFBundleVersion`

# Check if the bundle version exists or is zero, if so, set it to one
if [ -z $BUNDLE_VERSION ] or [ $BUNDLE_VERSION -eq 0 ]; then
	BUNDLE_VERSION = 1;
fi

# Find the default git on this system, this could be made more robust
# by iterating through the files returned by whereis or using an
# environment variable.
# If git cannot be found, try subversion. If that fails, just increment
# the build version.
if [ -f `which git` ]; then
	VERSION = `git rev-list --all | wc -l | sed "s/[ \t]//g"`
#	if [ $BUNDLE_VERSION -ge $VERSION ]; then
#		VERSION = $BUNDLE_VERSION;
#	fi
elif [ -f `which svn` ]; then
	VERSION = `svn info -r NUMBER`
else
	VERSION = BUNDLE_VERSION + 1;
fi

# Check if the final version exists or is zero, if so, set it to one
if [ -z $VERSION ] or [ $VERSION -eq 0 ]; then
	VERSION = 1;
fi

defaults write $PLIST CFBundleVersion $VERSION

echo $VERSION
