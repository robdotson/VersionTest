//
//  VersionTestAppDelegate.m
//  VersionTest
//
//  Created by Rob Dotson on 10/22/10.
//  Copyright (c) 2010 New York University. All rights reserved.
//

#import "VersionTestAppDelegate.h"

@implementation VersionTestAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
}

- (void)dealloc {

	[window release];
    [super dealloc];
}

@end
