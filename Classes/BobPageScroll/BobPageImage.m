#import "BobPageImage.h"

@interface BobPageImage (Private)
-(void) setScrollViewZoomScales;
@end

@implementation BobPageImage

//@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		_scrollView = [[UIScrollView alloc] initWithFrame:frame];
		_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_scrollView.delegate = self;
		_scrollView.bouncesZoom = YES;
		_scrollView.clipsToBounds = YES;
		_scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
		
		_imageView = [[TapDetectingImageView alloc] initWithFrame:CGRectZero];
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
	_scrollView.zoomScale = 1.0f;
	[self setNeedsLayout];
}


#pragma mark -
#pragma mark BobPageImage Methods

-(void) setImage:(UIImage *)image {
	CGSize imageSize = image.size;
	_imageView.image = image;
	_imageView.frame = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
	
	[self setScrollViewZoomScalesForBounds:self.bounds.size andImageSize:imageSize];
    _scrollView.zoomScale = _scrollView.minimumZoomScale;
}

-(void) setScrollViewZoomScalesForBounds:(CGSize)boundsSize andImageSize:(CGSize)imageSize {	
    CGFloat xScale = boundsSize.width / imageSize.width; 
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    CGFloat maxScale = 1.0;
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		maxScale = [[UIScreen mainScreen] scale];
	}
	
    if (minScale > maxScale) {
        minScale = maxScale;
    }
	
	_scrollView.zoomScale = 1.0f;
    _scrollView.contentSize = imageSize;
    _scrollView.maximumZoomScale = maxScale;
    _scrollView.minimumZoomScale = minScale;
}


- (void)layoutSubviews {
    [super layoutSubviews];
	
    CGSize boundsSize = _scrollView.bounds.size;
    CGRect frameToCenter = _imageView.frame;
    
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    _imageView.frame = frameToCenter;
}

-(void) setFrame:(CGRect)theFrame {
	[super setFrame:theFrame];

	BOOL isMin = (_scrollView.zoomScale == _scrollView.minimumZoomScale);
	float old = _scrollView.zoomScale;
	
	_scrollView.zoomScale = 1.0f;
	_imageView.frame = CGRectMake(0.0f, 0.0f, _imageView.image.size.width, _imageView.image.size.height);
	_scrollView.frame = CGRectMake(0.0f,0.0f,theFrame.size.width, theFrame.size.height);
	
	[self setScrollViewZoomScalesForBounds:theFrame.size andImageSize:_imageView.image.size];
	
	if (isMin) {
		_scrollView.zoomScale = _scrollView.minimumZoomScale;
	} else {
		_scrollView.zoomScale = old;
	}
}


#pragma mark -
#pragma mark ScrollView Delegate methods

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	[self setNeedsLayout];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	[self setNeedsLayout];
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

@end
