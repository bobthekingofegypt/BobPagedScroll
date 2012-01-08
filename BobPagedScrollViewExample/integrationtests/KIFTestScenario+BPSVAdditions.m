//
//  KIFTestScenario+BPSVAdditions.m
//  BobPagedScrollViewExample
//
//  Created by Richard Martin on 07/01/2012.
//  Copyright (c) 2012 Richard Martin. All rights reserved.
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
