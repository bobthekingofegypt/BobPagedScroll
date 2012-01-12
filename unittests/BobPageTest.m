//
//  BobPageTest.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
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
