//
//  BobPage.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobPage.h"

@implementation BobPage

@synthesize reuseIdentifier = reuseIdentifier_;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:frame])) {
        reuseIdentifier_ = [reuseIdentifier copy];
    }
    return self;
}

-(void) prepareForReuse {
	//no-op
}

- (void)dealloc {
	[reuseIdentifier_ release];
    [super dealloc];
}


@end
