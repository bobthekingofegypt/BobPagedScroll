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
		
		_imageView = [[UIImageView alloc] initWithFrame:frame];
		_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		
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
/*
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // center the image as it becomes smaller than the size of the screen
	
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
*/

#pragma mark -
#pragma mark ScrollView Delegate methods

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

@end
