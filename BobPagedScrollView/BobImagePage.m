//
//  BobImagePage.m
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobImagePage.h"

@implementation BobImagePage

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier];
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.clipsToBounds = YES;
        
        imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
    return self;
}

-(void) dealloc {
    [imageView release];

    [super dealloc];
}

@end
