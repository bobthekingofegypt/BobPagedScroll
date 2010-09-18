#import <UIKit/UIKit.h>

@protocol BobPageScrollViewDatasource<NSObject>
-(NSUInteger) numberOfPages;
-(UIView *) viewForPage:(NSUInteger) page;
@end


@interface BobPageScrollView : UIView {
	UIScrollView *pagedScrollView;
	id<BobPageScrollViewDatasource> _datasource;
	NSUInteger _padding;
	CGRect originalFrame;
}

@property (nonatomic, assign) id<BobPageScrollViewDatasource> datasource;
@property (nonatomic, assign) NSUInteger padding;

-(void) reloadData;

@end
