//
//  BobPagedScrollViewTest.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <GHUnitIOS/GHUnit.h> 
#import "BobPagedScrollView.h"
#import "BobPage.h"

#define kNOTSETTLED -1

int PAGE_COUNT = 0;

@interface TestBobPagedScrollViewDatasource : NSObject<BobPagedScrollViewDatasource> {
	NSInteger pageCallCount;
	NSInteger pageReuseCount;
	NSMutableArray *indexes;
}

@property (nonatomic, assign) NSInteger pageCallCount;
@property (nonatomic, assign) NSInteger pageReuseCount;
@property (nonatomic, readonly) NSMutableArray *indexes;

-(void) resetMetrics;

@end

@implementation TestBobPagedScrollViewDatasource

@synthesize pageCallCount;
@synthesize pageReuseCount;
@synthesize indexes;

-(id) init {
	if (self = [super init]) {
		pageCallCount = 0;
		pageReuseCount = 0;
		indexes = [[NSMutableArray alloc] init];
	}
    
	return self;
}

-(BobPage *) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView pageForIndex:(NSUInteger)index {
	++pageCallCount;
	[indexes addObject:[NSNumber numberWithInt:index]];
	BobPage *page = [bobPagedScrollView dequeueReusablePageWithIdentifier:@"TestIdentifier"];
	if (page) {
		++pageReuseCount;
	} else {
		page = [[[BobPage alloc] initWithFrame:CGRectZero andReuseIdentifier:@"TestIdentifier"] autorelease];
	}
	return page;
}

-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) index {
    //no-op
}

-(NSUInteger) numberOfPages {
	return PAGE_COUNT;
} 

-(void) resetMetrics {
	self.pageCallCount = 0;
	self.pageReuseCount = 0;
	[indexes removeAllObjects];
}

-(void) dealloc {
	[indexes release];
	[super dealloc];
}

@end

@interface TestBobPagedScrollViewDelegate : NSObject<BobPagedScrollViewDelegate> {
	NSInteger settledIndex;
}

@property (nonatomic, assign) NSInteger settledIndex;

-(void) resetMetrics;

@end

@implementation TestBobPagedScrollViewDelegate

@synthesize settledIndex;

-(id) init {
    self = [super init];
    if (self) {
        settledIndex = kNOTSETTLED;
    }
    return self;
}

-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) index {
    settledIndex = index;
}

-(void) resetMetrics {
    settledIndex = kNOTSETTLED;
}

@end

@interface BobPagedScrollViewTest : GHTestCase { }
@end

@implementation BobPagedScrollViewTest

-(void) testInitialDraw {
    TestBobPagedScrollViewDatasource *bobPagedScrollViewDatasource = [[[TestBobPagedScrollViewDatasource alloc] init] autorelease];
    TestBobPagedScrollViewDelegate *bobPagedScrollViewDelegate = [[[TestBobPagedScrollViewDelegate alloc] init] autorelease];
    
    BobPagedScrollView *bobPagedScrollView = [[[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)] autorelease];
    bobPagedScrollView.datasource = bobPagedScrollViewDatasource;
    bobPagedScrollView.delegate = bobPagedScrollViewDelegate;
    
    PAGE_COUNT = 70;
    
	[bobPagedScrollView reloadData];
    
	GHAssertEquals(1, bobPagedScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
    GHAssertEquals(0, [[bobPagedScrollViewDatasource.indexes objectAtIndex:0] integerValue], @"Check correct page index requested");
    GHAssertEquals(kNOTSETTLED, bobPagedScrollViewDelegate.settledIndex, @"Check correct index settled on");
}

-(void) testScrollOne {
    TestBobPagedScrollViewDatasource *bobPagedScrollViewDatasource = [[[TestBobPagedScrollViewDatasource alloc] init] autorelease];
    TestBobPagedScrollViewDelegate *bobPagedScrollViewDelegate = [[[TestBobPagedScrollViewDelegate alloc] init] autorelease];
    
    BobPagedScrollView *bobPagedScrollView = [[[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)] autorelease];
    bobPagedScrollView.datasource = bobPagedScrollViewDatasource;
    bobPagedScrollView.delegate = bobPagedScrollViewDelegate;
    
    PAGE_COUNT = 70;
    
	[bobPagedScrollView reloadData];
    [bobPagedScrollViewDatasource resetMetrics];
	
    [bobPagedScrollView.pagedScrollView scrollRectToVisible:CGRectMake(320.0f, 0.0f, 1.0f, 1.0f) animated:NO];
    
    GHAssertEquals(1, bobPagedScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
    GHAssertEquals(1, [[bobPagedScrollViewDatasource.indexes objectAtIndex:0] integerValue], @"Check correct page index requested");
    GHAssertEquals(kNOTSETTLED, bobPagedScrollViewDelegate.settledIndex, @"Check correct index settled on");
}

-(void) testScrollTwo {
    TestBobPagedScrollViewDatasource *bobPagedScrollViewDatasource = [[[TestBobPagedScrollViewDatasource alloc] init] autorelease];
    
    BobPagedScrollView *bobPagedScrollView = [[[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)] autorelease];
    bobPagedScrollView.datasource = bobPagedScrollViewDatasource;
    
    PAGE_COUNT = 70;
    
	[bobPagedScrollView reloadData];
    [bobPagedScrollViewDatasource resetMetrics];
	
    [bobPagedScrollView.pagedScrollView scrollRectToVisible:CGRectMake(740.0f, 0.0f, 1.0f, 1.0f) animated:NO];
    
    GHAssertEquals(2, bobPagedScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
    GHAssertEquals(1, [[bobPagedScrollViewDatasource.indexes objectAtIndex:0] integerValue], @"Check correct page index requested");
    GHAssertEquals(2, [[bobPagedScrollViewDatasource.indexes objectAtIndex:1] integerValue], @"Check correct page index requested");
}

-(void) testScrollOneWithPaddingNotFarEnough {
    TestBobPagedScrollViewDatasource *bobPagedScrollViewDatasource = [[[TestBobPagedScrollViewDatasource alloc] init] autorelease];
    
    BobPagedScrollView *bobPagedScrollView = [[[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)] autorelease];
    bobPagedScrollView.datasource = bobPagedScrollViewDatasource;
    bobPagedScrollView.padding = 20.0f;
    
    PAGE_COUNT = 70;
    
	[bobPagedScrollView reloadData];
    [bobPagedScrollViewDatasource resetMetrics];
	
    [bobPagedScrollView.pagedScrollView scrollRectToVisible:CGRectMake(320.0f, 0.0f, 1.0f, 1.0f) animated:NO];
    
    GHAssertEquals(0, bobPagedScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
}

-(void) testScrollOneWithPadding {
    TestBobPagedScrollViewDatasource *bobPagedScrollViewDatasource = [[[TestBobPagedScrollViewDatasource alloc] init] autorelease];
    
    BobPagedScrollView *bobPagedScrollView = [[[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)] autorelease];
    bobPagedScrollView.datasource = bobPagedScrollViewDatasource;
    bobPagedScrollView.padding = 20.0f;
    
    PAGE_COUNT = 70;
    
	[bobPagedScrollView reloadData];
    [bobPagedScrollViewDatasource resetMetrics];
	
    [bobPagedScrollView.pagedScrollView scrollRectToVisible:CGRectMake(360.0f, 0.0f, 1.0f, 1.0f) animated:NO];
    
    GHAssertEquals(1, bobPagedScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
    GHAssertEquals(1, [[bobPagedScrollViewDatasource.indexes objectAtIndex:0] integerValue], @"Check correct page index requested");
}

@end
