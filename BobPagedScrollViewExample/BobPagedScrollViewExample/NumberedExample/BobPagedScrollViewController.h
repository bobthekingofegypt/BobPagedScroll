//
//  BobPagedScrollViewController.h
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>
#import "BobPagedScrollView.h"

@interface BobPagedScrollViewController : UIViewController <BobPagedScrollViewDatasource, BobPagedScrollViewDelegate> {
    BobPagedScrollView *bobPagedScrollView_;
}

@end
