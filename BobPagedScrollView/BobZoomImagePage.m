//
//  BobZoomImagePage.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobZoomImagePage.h"

@implementation BobZoomImagePage

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		scrollView = [[BobCenteringImageScrollView alloc] initWithFrame:frame];
        scrollView.touchDelegate = self;
		[self addSubview:scrollView];
    }
    return self;
}

-(void) dealloc {
	[scrollView release];
    
	[super dealloc];
}

-(void) setFrame:(CGRect)theFrame {
	[super setFrame:theFrame];
	[scrollView updateFrame:theFrame];	
}


#pragma mark -
#pragma mark BobPage Methods

-(void) prepareForReuse {
	scrollView.zoomScale = 1.0f;
	[self setNeedsLayout];
}


#pragma mark -
#pragma mark BobPageImage Methods

-(void) setImage:(UIImage *)image {
	[scrollView setImage:image];
}

#pragma mark -
#pragma mark BobCenteringImageScrollViewDelegate methods

-(void) bobCenteringImageScrollViewSingleClicked:(BobCenteringImageScrollView *)bobCenteringImageScrollView {
    if ([delegate respondsToSelector:@selector(zoomImagePageTouched:)]) {
        [delegate zoomImagePageTouched:self];
    }
}

@end
