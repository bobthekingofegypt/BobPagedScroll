#import "BobPageScrollViewTest.h"
#import "BobPageScrollView.h"
#import "BobPage.h"

int PAGE_COUNT = 0;

@interface TestBobPageScrollViewDatasource : NSObject<BobPageScrollViewDatasource> {
	NSInteger pageCallCount;
	NSInteger pageReuseCount;
	NSMutableArray *indexes;
}

@property (nonatomic, assign) NSInteger pageCallCount;
@property (nonatomic, assign) NSInteger pageReuseCount;
@property (nonatomic, readonly) NSMutableArray *indexes;

-(void) resetMetrics;

@end

@implementation TestBobPageScrollViewDatasource

@synthesize pageCallCount, pageReuseCount, indexes;

-(id) init {
	if (self = [super init]) {
		pageCallCount = 0;
		pageReuseCount = 0;
		indexes = [[NSMutableArray alloc] init];
	}
	
	return self;
}


-(BobPage *) bobPageScrollView:(BobPageScrollView *)bobPageScrollView pageForIndex:(NSUInteger)index {
	++pageCallCount;
	[indexes addObject:[NSNumber numberWithInt:index]];
	BobPage *page = [bobPageScrollView dequeueReusablePageWithIdentifier:@"TestIdentifier"];
	if (page) {
		++pageReuseCount;
	} else {
		page = [[[BobPage alloc] initWithFrame:CGRectZero andReuseIdentifier:@"TestIdentifier"] autorelease];
	}
	return page;
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


@implementation BobPageScrollViewTest


-(void) testInitialDraw {
	TestBobPageScrollViewDatasource *bobPageScrollViewDatasource = [[[TestBobPageScrollViewDatasource alloc] init] autorelease];
	BobPageScrollView *bobPageScrollView = [[[BobPageScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)] autorelease];
	bobPageScrollView.datasource = bobPageScrollViewDatasource;
	
	PAGE_COUNT = 70;
	
	[bobPageScrollView reloadData];
	
	GHAssertEquals(1, bobPageScrollViewDatasource.pageCallCount, @"Check correct number of pages requested");
}

//test scrolling

@end
