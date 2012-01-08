//
//  BobPageNumbered.h
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>
#import "BobPage.h"

@interface BobPageNumbered : BobPage {
    UILabel *numberLabel;
}

-(void) setNumber:(NSInteger) number;

@end
