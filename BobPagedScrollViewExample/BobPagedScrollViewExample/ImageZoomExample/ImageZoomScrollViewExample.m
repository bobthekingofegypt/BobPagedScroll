//
//  ImageZoomScrollViewExample.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "ImageZoomScrollViewExample.h"
#import "BobZoomImagePage.h"

@implementation ImageZoomScrollViewExample

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"Image Example";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"image_list" ofType:@"plist"];
        images = [[NSArray alloc] initWithContentsOfFile:path];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    bobPagedScrollView_ = [[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)]; 
    bobPagedScrollView_.datasource = self;
    bobPagedScrollView_.delegate = self;
    bobPagedScrollView_.padding = 10.0f;
    bobPagedScrollView_.pagedScrollView.backgroundColor = [UIColor blackColor];
    
    [bobPagedScrollView_ reloadData];
    
    [self.view addSubview:bobPagedScrollView_];
}


-(NSUInteger) numberOfPages {
    return images.count;
}

-(BobPage *) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView pageForIndex:(NSUInteger)index {
    BobZoomImagePage *page = (BobZoomImagePage *)[bobPagedScrollView dequeueReusablePageWithIdentifier:@"test"];
    if (!page) {
        page = [[[BobZoomImagePage alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height) andReuseIdentifier:@"test"] autorelease];
    }
    
    [page setImage:[UIImage imageNamed:[images objectAtIndex:index]]];
    
    return page;
}


-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) index {
    //no-op
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
