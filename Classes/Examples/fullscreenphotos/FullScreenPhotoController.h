#import <UIKit/UIKit.h>
#import "BobPageScrollView.h"


@interface FullScreenPhotoController : UIViewController<BobPageScrollViewDatasource> {
	BobPageScrollView *bobPageScrollView;
}

@end
