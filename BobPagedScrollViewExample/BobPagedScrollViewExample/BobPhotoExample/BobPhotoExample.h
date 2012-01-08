//
//  BobPhotoExample.h
//  BobPagedScrollViewExample
//
//  Created by Richard Martin on 29/12/2011.
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BobPagedScrollView.h"
#import "BobZoomImagePage.h"

@interface BobPhotoExample : UIViewController <BobPagedScrollViewDatasource, BobPagedScrollViewDelegate, BobZoomImagePageTouchDelegate> {
    BobPagedScrollView *bobPagedScrollView_;
    NSArray *images;
    
    BOOL showingChrome;
    NSTimer *slideshowTimer;
    BOOL playingSlideshow;
    UIBarButtonItem *play;
    UIBarButtonItem *left;
    UIBarButtonItem *right;
    
    NSInteger currentIndex;
}

@end
