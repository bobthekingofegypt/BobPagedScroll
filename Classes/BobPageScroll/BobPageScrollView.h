#import <UIKit/UIKit.h>
#import "BobPage.h"

@protocol BobPageScrollViewDatasource;

@interface BobPageScrollView : UIView<UIScrollViewDelegate> {
	UIScrollView *pagedScrollView;
	id<BobPageScrollViewDatasource> _datasource;
	NSUInteger _padding;
	CGRect originalFrame;
	
	NSUInteger firstShowingPageIndex;
	NSUInteger lastShowingPageIndex;
	
	NSMutableDictionary *reusablePages;
	NSMutableDictionary *visiblePages;
	
	NSUInteger currentIndex;
}

@property (nonatomic, assign) id<BobPageScrollViewDatasource> datasource;
@property (nonatomic, assign) NSUInteger padding;

-(void) reloadData;
-(BobPage *) dequeueReusablePageWithIdentifier:(NSString *)identifier;

@end

@protocol BobPageScrollViewDatasource<NSObject>
-(NSUInteger) numberOfPages;
-(BobPage *) bobPageScrollView:(BobPageScrollView *)bobPageScrollView pageForIndex:(NSUInteger)index;
@end
