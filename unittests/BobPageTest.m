//
//  BobPageTest.m
//  BobPagedScrollView
//
//  Created by Richard Martin on 06/01/2012.
//  Copyright (c) 2012 Richard Martin. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "BobPage.h"

@interface BobPageTest : GHTestCase 
-(void) testReuseIdentifier;
@end

@implementation BobPageTest


-(void) testReuseIdentifier {
    BobPage *page = [[[BobPage alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 20.0f, 20.0f) andReuseIdentifier:@"Test"] autorelease];
    
    GHAssertEqualStrings(@"Test", [page reuseIdentifier], @"Reuse identifier should be set");
}
@end
