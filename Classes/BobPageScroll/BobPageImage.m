#import "BobPageImage.h"


@implementation BobPageImage

//@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		_scrollView = [[UIScrollView alloc] initWithFrame:frame];
		_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight;
		_scrollView.delegate = self;
		_scrollView.bouncesZoom = YES;
		_scrollView.clipsToBounds = YES;
		
		_imageView = [[TapDetectingImageView alloc] initWithFrame:CGRectZero];
		//_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		//_imageView.contentMode = UIViewContentModeCenter;
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
	_scrollView.zoomScale =1.0f;
	[self setNeedsLayout];
	//[_imageView setFrame:self.frame];
}


#pragma mark -
#pragma mark BobPageImage Methods

-(void) setImage:(UIImage *)image {
	CGSize imageSize = image.size;
	_imageView.image = image;
	_imageView.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
	
	CGSize boundsSize = [self bounds].size;
	currentBounds = self.bounds;
	
    // set up our content size and min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
    CGFloat maxScale = 1.0;// / [[UIScreen mainScreen] scale];
	
    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.) 
    if (minScale > maxScale) {
        minScale = maxScale;
    }
	
    _scrollView.contentSize = imageSize;
    _scrollView.maximumZoomScale = maxScale;
    _scrollView.minimumZoomScale = minScale;
    _scrollView.zoomScale = minScale;
	
	//NSLog(@"Correct zoom scale = %f, xscale : %f, yscale : %f, bounds size : %f, imagesize : %f", minScale, xScale, yScale, boundsSize.width, imageSize.width);
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
		
	//NSLog(@"Layout the subviews");
	//NSLog(@"Self.bounds : %@", NSStringFromCGRect(self.bounds));
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _imageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    _imageView.frame = frameToCenter;
}

-(void) setFrame:(CGRect)theFrame {
	[super setFrame:theFrame];
	//NSLog(@"T");
	BOOL isMin = (_scrollView.zoomScale == _scrollView.minimumZoomScale);
	float old = _scrollView.zoomScale;
	_scrollView.zoomScale =1.0f;
	_imageView.frame = CGRectMake(0.0f, 0.0f, _imageView.image.size.width, _imageView.image.size.height);
	CGSize imageSize = _imageView.image.size;
	CGSize boundsSize = theFrame.size;
	currentBounds = self.bounds;
	
	_scrollView.frame = CGRectMake(0.0f,0.0f,theFrame.size.width, theFrame.size.height);
	
    // set up our content size and min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);    
	//NSLog(@"Min scale : %f", minScale);// use minimum of these to allow the image to become fully visible
    
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
    CGFloat maxScale = 1.0;// / [[UIScreen mainScreen] scale];
	
    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.) 
    if (minScale > maxScale) {
        minScale = maxScale;
    }
	
	//NSLog(@"frame zoom scale = %f, xscale : %f, yscale : %f, bounds size : %f, imagesize : %f", minScale, xScale, yScale, boundsSize.width, imageSize.width);
    //_scrollView.contentSize = imageSize;
    _scrollView.maximumZoomScale = maxScale;
    _scrollView.minimumZoomScale = minScale;
	
	if (isMin) {
		_scrollView.zoomScale = minScale;
	} else {
		_scrollView.zoomScale = old;
	}
	//[self setNeedsLayout];
	//[_scrollView setZoomScale:minScale animated:YES];
	/*
    _scrollView.zoomScale = minScale;
	CGRect zoomRect;
	
	zoomRect.size.height = [_scrollView frame].size.height / _scrollView.minimumZoomScale;
	zoomRect.size.width = [_scrollView frame].size.width  / _scrollView.minimumZoomScale;
	
	zoomRect.origin = _scrollView.bounds.origin; //tapPoint.x - (zoomRect.size.width  / 2.0);
	//zoomRect.origin.y = //tapPoint.y - (zoomRect.size.height / 2.0);
	[_scrollView zoomToRect:zoomRect animated:NO];
	 */
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
	if (_scrollView.zoomScale == _scrollView.maximumZoomScale) {
		CGRect zoomRect;
		
		zoomRect.size.height = [_scrollView frame].size.height / _scrollView.minimumZoomScale;
		zoomRect.size.width = [_scrollView frame].size.width  / _scrollView.minimumZoomScale;
		
		zoomRect.origin.x = tapPoint.x - (zoomRect.size.width  / 2.0);
		zoomRect.origin.y = tapPoint.y - (zoomRect.size.height / 2.0);
		[_scrollView zoomToRect:zoomRect animated:YES];
	} else {
		CGRect zoomRect;
		
		zoomRect.size.height = [_scrollView frame].size.height / _scrollView.maximumZoomScale;
		zoomRect.size.width = [_scrollView frame].size.width  / _scrollView.maximumZoomScale;
		
		zoomRect.origin.x = tapPoint.x - (zoomRect.size.width  / 2.0);
		zoomRect.origin.y = tapPoint.y - (zoomRect.size.height / 2.0);
		[_scrollView zoomToRect:zoomRect animated:YES];
	}
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches began");    
}

@end
