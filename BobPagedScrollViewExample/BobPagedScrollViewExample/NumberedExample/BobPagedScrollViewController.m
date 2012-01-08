//
//  BobPagedScrollViewController.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "BobPagedScrollViewController.h"

#import "BobPagedScrollView.h"
#import "BobPageNumbered.h"

@implementation BobPagedScrollViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.title = @"Numbered Pages";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    bobPagedScrollView_ = [[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)]; 
    bobPagedScrollView_.datasource = self;
    bobPagedScrollView_.delegate = self;
    bobPagedScrollView_.padding = 10.0f;
    bobPagedScrollView_.pagedScrollView.backgroundColor = [UIColor whiteColor];
    
    [bobPagedScrollView_ reloadData];
    
    [self.view addSubview:bobPagedScrollView_];
}

-(NSUInteger) numberOfPages {
    return 9;
}

-(BobPage *) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView pageForIndex:(NSUInteger)index {
    BobPageNumbered *page = (BobPageNumbered*)[bobPagedScrollView dequeueReusablePageWithIdentifier:@"test"];
    if (!page) {
        page = [[[BobPageNumbered alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height) andReuseIdentifier:@"test"] autorelease];
    }
    
    [page setNumber:index];
    
    return page;
}

-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) index {
    //no-op
    NSLog(@"TeSt %d", index);
}

@end
