//
//  AppDelegate.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "AppDelegate.h"
#import "BobPage.h"

#import "ExampleSelectionController.h"

#if RUN_KIF_TESTS
#import "BPSVTestController.h"
#endif

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc {
    [exampleSelectionController release];
    [navigationController release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    exampleSelectionController = [[ExampleSelectionController alloc] initWithStyle:UITableViewStyleGrouped];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:exampleSelectionController];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self.window addSubview:navigationController.view];
    
    [self.window makeKeyAndVisible];
    
#if RUN_KIF_TESTS
    [[BPSVTestController sharedInstance] startTestingWithCompletionBlock:^{
        // Exit after the tests complete so that CI knows we're done
        exit([[BPSVTestController sharedInstance] failureCount]);
    }];
#endif
    
    return YES;
}

@end
