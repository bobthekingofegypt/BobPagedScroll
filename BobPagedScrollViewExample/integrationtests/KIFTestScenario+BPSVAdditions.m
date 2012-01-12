//
//  KIFTestScenario+BPSVAdditions.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "KIFTestScenario+BPSVAdditions.h"
#import "KIFTestStep.h"


@implementation KIFTestScenario (BPSVAdditions)

+ (id)scenarioToLogIn {
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a user can successfully log in."];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Bob photo example"]];    
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"just waiting"]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"right"]];
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"right"]];
     
    return scenario;
}

@end
