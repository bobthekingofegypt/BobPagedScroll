#import <Foundation/Foundation.h>
#import "BobPage.h"
#import "TapDetectingImageView.h"

@interface BobPageImage : BobPage<UIScrollViewDelegate, TapDetectingImageViewDelegate> {
	TapDetectingImageView *_imageView;
	UIScrollView *_scrollView;
}

//@property (nonatomic, retain) UIImageView *imageView;
-(void)setImage:(UIImage *) image;

@end
