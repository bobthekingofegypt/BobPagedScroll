#import <UIKit/UIKit.h>
#import "BobPageScrollView.h"


@interface FullScreenNumberController : UIViewController<BobPageScrollViewDatasource> {
	BobPageScrollView *bobPageScrollView;
}

@end
