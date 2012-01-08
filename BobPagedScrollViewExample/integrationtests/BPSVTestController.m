//
//  BPSVTestController.m
//  BobPagedScrollViewExample
//
//  Created by Richard Martin on 07/01/2012.
//  Copyright (c) 2012 Richard Martin. All rights reserved.
//

#import "BPSVTestController.h"
#import "KIFTestScenario+BPSVAdditions.h"

@implementation BPSVTestController

- (void)initializeScenarios {
    [self addScenario:[KIFTestScenario scenarioToLogIn]];
}

@end