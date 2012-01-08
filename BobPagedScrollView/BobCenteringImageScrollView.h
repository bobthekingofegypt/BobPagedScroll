//
//  BobCenteringImageScrollView.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>
#import "TapDetectingImageView.h"

@class BobCenteringImageScrollView;

/** The delegate of a bob centering image scroll biew must adopt the 
 BobCenteringImageScrollViewDelegate protocol. 
 */
@protocol BobCenteringImageScrollViewDelegate <NSObject>
/** 
 Tells the delegate that the image was single tapped on
 @param BobCenteringImageScrollView An object representing the view reporting this information.
 */
-(void) bobCenteringImageScrollViewSingleClicked:(BobCenteringImageScrollView *)bobCenteringImageScrollView;
@end

@interface BobCenteringImageScrollView : UIScrollView<UIScrollViewDelegate, TapDetectingImageViewDelegate> {
	TapDetectingImageView *imageView;
	BOOL manualZooming;
    CGRect old;
    CGSize oldSize;
    id<BobCenteringImageScrollViewDelegate> touchDelegate;
    BOOL thumbnail;
    
    CGPoint tapLocation;
    BOOL multipleTouches;
}

/**---------------------------------------------------------------------------------------
 * @name Managing the delegate
 *  ---------------------------------------------------------------------------------------
 */
/** The delegate of the centering image scroll view */
@property (nonatomic, assign) id<BobCenteringImageScrollViewDelegate> touchDelegate;

/**---------------------------------------------------------------------------------------
 * @name Updating the image shown
 *  ---------------------------------------------------------------------------------------
 */

/** The thumbnail to be scaled to fill the view */
-(void) setScaledThumbnail:(UIImage *) image;

/** The image to be shown in the view, will replace any thumbnail shown */
-(void) setImage:(UIImage *)image;

/**---------------------------------------------------------------------------------------
 * @name Managing the frame
 *  ---------------------------------------------------------------------------------------
 */
-(void) updateFrame:(CGRect)theFrame;

@end


