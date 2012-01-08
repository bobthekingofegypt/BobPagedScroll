//
//  BobImagePage.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>
#import "BobPage.h"

/** This is a subclass of BobPage, it contains a single image view which is centered
 and set to aspect fit.
 */

@interface BobImagePage : BobPage {
    UIImageView *imageView;
}

/**---------------------------------------------------------------------------------------
 * @name Initializing a BobImagePage object
 *  ---------------------------------------------------------------------------------------
 */

/** 
 Initializes and returns a newly allocated BobImagePage object with the secified frame and reuse identifier 
 
 @param frame A CGRect to be used as the views frame.
 @param reuseIdentifier A string that can unique identify this page for use when recycling pages.
 @return An initialized bob page object or nil if the object couldn't be created.
 */

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier;

/**---------------------------------------------------------------------------------------
 * @name Managing the BobImagePage image view
 *  ---------------------------------------------------------------------------------------
 */

/** The image view for this BobImagePage */
@property (nonatomic, retain) UIImageView *imageView;

@end
