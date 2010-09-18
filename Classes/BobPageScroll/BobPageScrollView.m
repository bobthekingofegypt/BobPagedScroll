#import "BobPageScrollView.h"

#define kDefaultPadding 0

@interface BobPageScrollView(Private)
-(NSUInteger) numberOfPages;
-(CGRect) calculateFrameSize;
-(CGSize) calculateContentSize:(NSUInteger) pageCount;
@end


@implementation BobPageScrollView

@synthesize datasource = _datasource, padding = _padding;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.padding = kDefaultPadding;
		originalFrame = frame;
		
        pagedScrollView = [[UIScrollView alloc] initWithFrame:originalFrame];
		pagedScrollView.pagingEnabled = YES;
		pagedScrollView.backgroundColor = [UIColor blackColor];
		pagedScrollView.showsVerticalScrollIndicator = NO;
		pagedScrollView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)dealloc {
	_datasource = nil;
	[pagedScrollView release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark BobPageScrollView methods

-(void) reloadData {
	NSUInteger pageCount = [self numberOfPages];
	pagedScrollView.frame = [self calculateFrameSize];
	pagedScrollView.contentSize = [self calculateContentSize:pageCount];
}

-(CGRect) calculateFrameSize {
	return CGRectMake(originalFrame.origin.x - self.padding, 
					  originalFrame.origin.y, 
					  originalFrame.size.width + (self.padding * 2), 
					  originalFrame.size.height);
}

-(CGSize) calculateContentSize:(NSUInteger) pageCount {
	return CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
}


#pragma mark -
#pragma mark BobPageScrollDatasource methods

-(NSUInteger) numberOfPages {
	return [self.datasource numberOfPages];
}

-(UIView *) viewForPageNumber:(NSUInteger) page {
	return [self.datasource viewForPage:page];
}


@end
