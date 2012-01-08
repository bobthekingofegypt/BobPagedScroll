//
//  BobZoomImagePage.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>

#import "BobPage.h"
#import "BobCenteringImageScrollView.h"

@class BobZoomImagePage;

@protocol BobZoomImagePageTouchDelegate <NSObject>
@optional
-(void) zoomImagePageTouched:(BobZoomImagePage *) bobZoomImagePage;
@end

/** This is a subclass of BobPage, it is setup to display a zoomable image and handle the 
 double tap to zoom and pinch gestures.
 */
@interface BobZoomImagePage : BobPage <BobCenteringImageScrollViewDelegate> {
	BobCenteringImageScrollView *scrollView;
    
    id<BobZoomImagePageTouchDelegate> delegate;
}

/**---------------------------------------------------------------------------------------
 * @name Initializing a BobZoomImagePage object
 *  ---------------------------------------------------------------------------------------
 */

/** 
 Initializes and returns a newly allocated BobZoomImagePage object with the secified frame and reuse identifier 
 
 @param frame A CGRect to be used as the views frame.
 @param reuseIdentifier A string that can unique identify this page for use when recycling pages.
 @return An initialized bob page object or nil if the object couldn't be created.
 */
- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier;


/**---------------------------------------------------------------------------------------
 * @name Managing the BobZoomImagePage 
 *  ---------------------------------------------------------------------------------------
 */

/** The image to be displayed in this page */
-(void)setImage:(UIImage *) image;


/**---------------------------------------------------------------------------------------
 * @name Managing the delegate
 *  ---------------------------------------------------------------------------------------
 */

/** The delegate for the zoom image page */
@property (nonatomic, assign) id<BobZoomImagePageTouchDelegate> delegate;

@end
