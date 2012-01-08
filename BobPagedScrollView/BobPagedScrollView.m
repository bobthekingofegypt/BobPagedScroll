//
//  BobPagedScrollView.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobPagedScrollView.h"
#import "BobPage.h"

#define kDefaultPadding 0

@interface BobPagedScrollView()

@property (nonatomic, assign) NSUInteger currentIndex;

-(NSUInteger) numberOfPages;
-(CGRect) calculateFrameSize;
-(CGSize) calculateContentSize:(NSUInteger) pageCount;
-(BobPage *) pageForIndex:(NSUInteger)index;
-(BOOL) isDisplayingPageForIndex:(NSUInteger) index;
-(void) layoutPages;
-(void) setUpPage:(BobPage *)page forIndex:(NSUInteger)index;
-(void) removePageForIndex:(NSUInteger) index;
-(void) resetPageFrameForIndex:(NSUInteger) index;
-(void) settledOnPage:(NSUInteger) page;
@end


@implementation BobPagedScrollView

@synthesize datasource = datasource_;
@synthesize delegate = delegate_;
@synthesize padding = padding_;
@synthesize currentIndex;
@synthesize pagedScrollView;


-(id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		padding_ = kDefaultPadding;
        originalFrame = frame;
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
        pagedScrollView = [[UIScrollView alloc] initWithFrame:frame];
        pagedScrollView.userInteractionEnabled = YES;
		pagedScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		pagedScrollView.pagingEnabled = YES;
		pagedScrollView.showsVerticalScrollIndicator = NO;
		pagedScrollView.showsHorizontalScrollIndicator = NO;
		pagedScrollView.delegate = self;
		pagedScrollView.backgroundColor = [UIColor blackColor];
		
		[self addSubview:pagedScrollView];
		
		reusablePages = [[NSMutableDictionary alloc] init];
		visiblePages = [[NSMutableDictionary alloc] init];
		
		firstShowingPageIndex = 0;
		lastShowingPageIndex = 0;
		
		currentIndex = 0;
    }
    return self;
}

-(void) dealloc {
	datasource_ = nil;
    
	[pagedScrollView release];
	[reusablePages release];
	[visiblePages release];
	
    [super dealloc];
}

-(void) setFrame:(CGRect)frame {
    settingFrame = YES;
    [super setFrame:frame];
    
    pagedScrollView.contentSize = [self calculateContentSize:numberOfPages];
    pagedScrollView.contentOffset = CGPointMake(currentIndex * pagedScrollView.bounds.size.width, 0.0f);
    settingFrame = NO;
    [self layoutPages];
    
}

#pragma mark -
#pragma mark BobPagedScrollView methods

-(void) reloadData {
	numberOfPages = [self numberOfPages];
	pagedScrollView.frame = [self calculateFrameSize];
	pagedScrollView.contentSize = [self calculateContentSize:numberOfPages];
	
	if (!pagedScrollView.dragging) {
		pagedScrollView.contentOffset = CGPointMake(currentIndex * pagedScrollView.frame.size.width, 0.0f);
	}
	
	[self layoutPages];
}

-(CGRect) calculateFrameSize {
	return CGRectMake(originalFrame.origin.x - self.padding, 
					  originalFrame.origin.y, 
					  self.bounds.size.width + (self.padding * 2), 
					  self.bounds.size.height);
}

-(CGSize) calculateContentSize:(NSUInteger) pageCount {
	return CGSizeMake((self.bounds.size.width + (2 * self.padding)) * pageCount, 
                      self.bounds.size.height);
}

-(void) layoutPages {
    if (settingFrame || !pagedScrollView) {
        return;
    }
	CGRect visibleBounds = pagedScrollView.bounds;
    
	int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
	int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
	firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
	lastNeededPageIndex  = MIN(lastNeededPageIndex, [self numberOfPages] - 1);
	
	for (NSUInteger index = firstShowingPageIndex; index < firstNeededPageIndex; index++) {
		[self removePageForIndex:index];
	}
	
	for (NSUInteger index = lastShowingPageIndex; index > lastNeededPageIndex; index--) {
		[self removePageForIndex:index];
	}
	
	int overlap = (int)CGRectGetMinX(visibleBounds) % (int)CGRectGetWidth(visibleBounds);
	if (overlap < (CGRectGetWidth(visibleBounds) / 2.0f)) {
		currentIndex = firstNeededPageIndex;
	} else {
		currentIndex = lastNeededPageIndex;
	}
	
	for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {		
		if (![self isDisplayingPageForIndex:index]) {
			BobPage *page = [self pageForIndex:index];
			[self setUpPage:page forIndex:index];
			[pagedScrollView addSubview:page];
			[visiblePages setObject:page forKey:[NSNumber numberWithInt:index]];
		} else {
			[self resetPageFrameForIndex:index];
		}
	}
	
	firstShowingPageIndex = firstNeededPageIndex;
	lastShowingPageIndex = lastNeededPageIndex;
}

-(void) removePageForIndex:(NSUInteger) index {
	NSNumber *indexNumber = [NSNumber numberWithInt:index];
	BobPage *page = [visiblePages objectForKey:indexNumber];
	
	if (page) {
		NSString *entryKey = [[page.reuseIdentifier copy] autorelease];
		NSMutableSet *set = [reusablePages objectForKey:entryKey];
		if (set == nil) {
			set = [[[NSMutableSet alloc] init] autorelease];
		}
		[set addObject:page];
        
		[reusablePages setObject:set forKey:entryKey];
		[page removeFromSuperview];
		[visiblePages removeObjectForKey:indexNumber];
	}
}

-(BOOL) isDisplayingPageForIndex:(NSUInteger) index {
	BobPage *page = [visiblePages objectForKey:[NSNumber numberWithInt:index]];
	if (page) {
		return YES;
	} 
	
	return NO;
}

-(void) setUpPage:(BobPage *)page forIndex:(NSUInteger)index {
	//page.index = index;
	page.frame = CGRectMake((pagedScrollView.frame.size.width * index) + self.padding, 
							0.0f, 
							pagedScrollView.frame.size.width - (2 * self.padding), 
							pagedScrollView.frame.size.height);
}

-(void) resetPageFrameForIndex:(NSUInteger) index {
	BobPage *page = [visiblePages objectForKey:[NSNumber numberWithInt:index]];
	if (page) {
		[self setUpPage:page forIndex:index];
	}
}

-(BobPage *) dequeueReusablePageWithIdentifier:(NSString *)reuseIdentifier {
	NSMutableSet *set = [reusablePages objectForKey:reuseIdentifier];
	if (set != nil) {
		BobPage *page = [set anyObject];
		if (page != nil) {
			[[page retain] autorelease];
			[set removeObject:page];
		}
		[page prepareForReuse];
		return page;
	}
	
	return nil;
}


#pragma mark -
#pragma mark BobPageScrollDatasource methods

-(NSUInteger) numberOfPages {
	return [self.datasource numberOfPages];
}


-(BobPage *) pageForIndex:(NSUInteger)index {
	return [self.datasource bobPagedScrollView:self pageForIndex:index];
}

-(void) settledOnPage:(NSUInteger) page {
    [self.delegate bobPagedScrollView:self settledOnPage:currentIndex];
}

#pragma mark -
#pragma mark Position view methods


-(void) scrollToPage:(NSUInteger)page animated:(BOOL)animated {
    CGSize pageSize = CGSizeMake((self.bounds.size.width + (2 * self.padding)), self.bounds.size.height);
    NSInteger x = page * pageSize.width;
    [pagedScrollView scrollRectToVisible:CGRectMake(x, 0, pageSize.width, pageSize.height) animated:animated];
}


#pragma mark -
#pragma mark ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self layoutPages];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self settledOnPage:currentIndex];
}



@end
