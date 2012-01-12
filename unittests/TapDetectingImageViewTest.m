//
//  TapDetectingImageViewTest.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <GHUnitIOS/GHUnit.h>
#import <OCMock/OCMock.h>
#import "TapDetectingImageView.h"

@interface TapDetectingImageViewDelegateTest : NSObject <TapDetectingImageViewDelegate> {
    BOOL singleTap;
    BOOL doubleTap;
}

@property (nonatomic, assign) BOOL singleTap;
@property (nonatomic, assign) BOOL doubleTap;

- (void)tapDetectingImageView:(TapDetectingImageView *)view singleTapAtPoint:(CGPoint)tapPoint;
- (void)tapDetectingImageView:(TapDetectingImageView *)view doubleTapAtPoint:(CGPoint)tapPoint;
@end

@implementation TapDetectingImageViewDelegateTest

@synthesize singleTap;
@synthesize doubleTap;

- (void)tapDetectingImageView:(TapDetectingImageView *)view singleTapAtPoint:(CGPoint)tapPoint {
    singleTap = YES;
}

- (void)tapDetectingImageView:(TapDetectingImageView *)view doubleTapAtPoint:(CGPoint)tapPoint {
    doubleTap = YES;
}

@end

@interface TapDetectingImageViewTest : GHTestCase 

@end

@implementation TapDetectingImageViewTest

-(void) testDoubleTap {
    TapDetectingImageViewDelegateTest *delegate = [[[TapDetectingImageViewDelegateTest alloc] init] autorelease];
    TapDetectingImageView *tapDetectingImageView = [[[TapDetectingImageView alloc] init] autorelease];
    tapDetectingImageView.delegate = delegate;
    
    NSUInteger returnValue = 1;
    id setMock = [OCMockObject mockForClass:NSSet.class];
    [[[setMock stub] andReturnValue:OCMOCK_VALUE(returnValue)] count];
    
    id eventMock = [OCMockObject mockForClass:UIEvent.class];
    [[[eventMock stub] andReturn:setMock] touchesForView:tapDetectingImageView];    
    
    [tapDetectingImageView touchesBegan:nil withEvent:eventMock];
    
    NSMutableSet *touches = [NSMutableSet set];
    id touch = [OCMockObject mockForClass:UITouch.class];
    [touches addObject:touch];
    
    returnValue = 1;
    [[[setMock stub] andReturnValue:OCMOCK_VALUE(returnValue)] count];
    [[[touch stub] andReturnValue:[NSValue valueWithCGPoint:CGPointMake(1.0f, 1.0f)]] locationInView:tapDetectingImageView];
    returnValue = 2;
    [[[touch stub] andReturnValue:OCMOCK_VALUE(returnValue)] tapCount];
    
    [tapDetectingImageView touchesEnded:touches withEvent:eventMock];
    
    GHAssertTrue(delegate.doubleTap, @"double tap should be true");
}
@end
