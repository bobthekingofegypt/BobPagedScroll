//
//  BPSVTestController.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BPSVTestController.h"
#import "KIFTestScenario+BPSVAdditions.h"

@implementation BPSVTestController

- (void)initializeScenarios {
    [self addScenario:[KIFTestScenario scenarioToLogIn]];
}

@end