//
//  BobPageNumbered.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobPageNumbered.h"

@implementation BobPageNumbered

- (id)initWithFrame:(CGRect)frame andReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:frame andReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
        numberLabel.center = self.center;
        numberLabel.backgroundColor = [UIColor redColor];
        numberLabel.font = [UIFont boldSystemFontOfSize:50.0f];
        numberLabel.textAlignment = UITextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:numberLabel];
    }
    return self;
}

-(void) prepareForReuse {
    [super prepareForReuse];
    numberLabel.text = @"";
}

-(void) setNumber:(NSInteger) number {
    numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

-(void) dealloc {
    [numberLabel release];
    
    [super dealloc];
}

@end
