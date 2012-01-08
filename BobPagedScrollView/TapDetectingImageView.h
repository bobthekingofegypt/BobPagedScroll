//
//  TapDetectingImageView.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>

@class TapDetectingImageView;

/** The delegate of a tap detecting image view can adopt the TapDetectingImageViewDelegate protocol. 
 */
@protocol TapDetectingImageViewDelegate <NSObject>
@optional
/** 
 Tells the delegate that the image view was tapped on
 @param TapDetectingImageView An object representing the tap detecting image view reporting this information.
 @param tapPoint the point where the tap occurred.
 */
- (void)tapDetectingImageView:(TapDetectingImageView *)view singleTapAtPoint:(CGPoint)tapPoint;
/** 
 Tells the delegate that the image view was double tapped on
 @param TapDetectingImageView An object representing the tap detecting image view reporting this information.
 @param tapPoint the point where the double tap occurred.
 */
- (void)tapDetectingImageView:(TapDetectingImageView *)view doubleTapAtPoint:(CGPoint)tapPoint;
@end

/** This is a subclass on UIImageView that adds single and multi touch reporting to a delegate
 */
@interface TapDetectingImageView : UIImageView {
	id<TapDetectingImageViewDelegate> delegate;
    
    CGPoint tapLocation;
    BOOL multipleTouches;
}

/** The delegate for this tap detecting image view */
@property (nonatomic, assign) id<TapDetectingImageViewDelegate> delegate;

@end


