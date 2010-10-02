#import <Foundation/Foundation.h>
#import "BobPage.h"

@interface BobPageImage : BobPage<UIScrollViewDelegate> {
	UIImageView *_imageView;
	UIScrollView *_scrollView;
}

@property (nonatomic, retain) UIImageView *imageView;

@end
