#import "BobPageImage.h"


@implementation BobPageImage

@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		_scrollView = [[UIScrollView alloc] initWithFrame:frame];
		_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_scrollView.maximumZoomScale = 6.0f;
		_scrollView.delegate = self;
		_scrollView.bouncesZoom = YES;
		
		_imageView = [[TapDetectingImageView alloc] initWithFrame:frame];
		_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.delegate = self;
		_imageView.userInteractionEnabled = YES;
		
		[_scrollView addSubview:_imageView];
		
		[self addSubview:_scrollView];
    }
    return self;
}

-(void) dealloc {
	[_imageView release];
	[_scrollView release];
	[super dealloc];
}


#pragma mark -
#pragma mark BobPage Methods

-(void) prepareForReuse {
	[_scrollView zoomToRect:self.frame animated:NO];
}


#pragma mark -
#pragma mark ScrollView Delegate methods

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}
				
-(void)tapDetectingImageView:(TapDetectingImageView *)view singleTapAtPoint:(CGPoint)tapPoint {
	//inform the scroll view to show chrome
}

-(void)tapDetectingImageView:(TapDetectingImageView *)view doubleTapAtPoint:(CGPoint)tapPoint {
	if (_scrollView.zoomScale != 1.0) {
		[_scrollView zoomToRect:self.frame animated:YES];
	} else {
		CGRect zoomRect;
		
		zoomRect.size.height = [_scrollView frame].size.height / _scrollView.maximumZoomScale;
		zoomRect.size.width = [_scrollView frame].size.width  / _scrollView.maximumZoomScale;
		
		zoomRect.origin.x = tapPoint.x - (zoomRect.size.width  / 2.0);
		zoomRect.origin.y = tapPoint.y - (zoomRect.size.height / 2.0);
		[_scrollView zoomToRect:zoomRect animated:YES];
	}
}

@end
