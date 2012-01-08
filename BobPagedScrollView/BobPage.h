//
//  BobPage.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>

/** This is a base class for all Bob pages.  It is a subclass of
 UIView so makes available all functionality of UIViews.
 
 This class is designed to be subclassed and does not provide any implementation.  
 You can create an instance of this class and add views directly if you do not 
 wish to subclass.
 */
@interface BobPage : UIView {
@private
	NSString *reuseIdentifier_;
}

/**---------------------------------------------------------------------------------------
 * @name Initializing a BobPage object
 *  ---------------------------------------------------------------------------------------
 */

/** 
 Initializes and returns a newly allocated BobPage object with the secified frame and reuse identifier 
 
 @param frame A CGRect to be used as the views frame.
 @param reuseIdentifier A string that can unique identify this page for use when recycling pages.
 @return An initialized bob page object or nil if the object couldn't be created.
 */
-(id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier;

/**---------------------------------------------------------------------------------------
 * @name Managing Entry reuse
 *  ---------------------------------------------------------------------------------------
 */

/** The reuseIdentifier for this BSGEntryView */
@property (nonatomic, readonly) NSString *reuseIdentifier;

/**
 Prepare the entry view for reuse.
 Subclasses should override this method to remove any state from this entry so it 
 is ready to be reused.
 */
-(void) prepareForReuse;

@end
