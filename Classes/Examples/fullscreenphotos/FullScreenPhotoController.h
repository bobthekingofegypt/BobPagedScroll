#import <UIKit/UIKit.h>
#import "BobPageScrollView.h"


@interface FullScreenPhotoController : UIViewController<BobPageScrollViewDatasource> {
	BobPageScrollView *_bobPageScrollView;
	NSMutableArray *images;
}

@end
