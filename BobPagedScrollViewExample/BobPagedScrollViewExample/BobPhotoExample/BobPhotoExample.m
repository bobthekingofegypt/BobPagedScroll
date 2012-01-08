//
//  BobPhotoExample.m
//  BobPagedScrollViewExample
//
//  Created by Richard Martin on 29/12/2011.
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//

#import "BobPhotoExample.h"

@protocol UIApplicationDeprecatedMethods
- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end

@interface BobPhotoExample()
-(void) updateChrome;
-(void) setupArrows;
-(void) setPageTitle;
@end

@implementation BobPhotoExample

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
    self.wantsFullScreenLayout = YES;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    showingChrome = YES;
    
    bobPagedScrollView_ = [[BobPagedScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)]; 
    bobPagedScrollView_.datasource = self;
    bobPagedScrollView_.delegate = self;
    bobPagedScrollView_.padding = 10.0f;
    bobPagedScrollView_.pagedScrollView.backgroundColor = [UIColor blackColor];
    
    [bobPagedScrollView_ reloadData];
    
    [self.view addSubview:bobPagedScrollView_];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed)];
    play = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play.png"] style:UIBarButtonItemStylePlain target:self action:@selector(playSlideShow)];
    right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed)];
    right.accessibilityLabel = @"right";
    self.toolbarItems = [NSArray arrayWithObjects:space, left, space, play, space, right, space, nil];
    
    [space release];
    [self setupArrows];
    [self setPageTitle];
    
    //
}


-(NSUInteger) numberOfPages {
    return images.count;
}

-(BobPage *) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView pageForIndex:(NSUInteger)index {
    BobZoomImagePage *page = (BobZoomImagePage *)[bobPagedScrollView dequeueReusablePageWithIdentifier:@"test"];
    if (!page) {
        page = [[[BobZoomImagePage alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height) andReuseIdentifier:@"test"] autorelease];
        page.delegate = self;
    }
    
    [page setImage:[UIImage imageNamed:[images objectAtIndex:index]]];
    
    return page;
}


-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) index {
    currentIndex = index;
    if (index == 1) {
        //[[Recorder2 sharedRecorder] saveToFile:@"temp.plist"];
    }
    [self setupArrows];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark
#pragma mark Interaction button and title methods
#pragma mark

-(void) setPageTitle {
    self.title = [NSString stringWithFormat:@"%d of %d", currentIndex + 1, [images count]];
}

-(void) setupArrows {
    [self setPageTitle];
    left.enabled = YES;
    right.enabled = YES;
    if (currentIndex == 0) {
        left.enabled = NO;
    } 
    if (currentIndex == ([images count] - 1)) {
        right.enabled = NO;
    }
}

-(void) leftButtonPressed {
    if (currentIndex  > 0) {
        currentIndex = currentIndex - 1;
        [bobPagedScrollView_ scrollToPage:(currentIndex) animated:NO];
        [self setupArrows];
    }
}

-(void) rightButtonPressed {
    if (currentIndex  < ([images count] - 1)) {
        currentIndex = currentIndex + 1;
        [bobPagedScrollView_ scrollToPage:(currentIndex) animated:NO];
        [self setupArrows];
    }
}

-(void) changePage {
    playingSlideshow = YES;
    [self rightButtonPressed];
}

-(void) playSlideShow {
    
    if (playingSlideshow) {
        if (slideshowTimer) {
            [slideshowTimer invalidate];
            [slideshowTimer release], slideshowTimer = nil;
            playingSlideshow = NO;
        }
    } else {
        if (!slideshowTimer) {
            slideshowTimer = [[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePage) userInfo:nil repeats:YES] retain];
        }
        [play setImage:[UIImage imageNamed:@"pause.png"]];
        showingChrome = NO;
        [self updateChrome];
        playingSlideshow = YES;
        
        return;
    }
}

-(void) setCurrentIndex:(NSUInteger)index {
	[bobPagedScrollView_ reloadData];
}


-(void) updateChrome {
    if([[UIApplication sharedApplication] respondsToSelector:@selector(setStatusBarHidden:withAnimation:)]) {
        [[UIApplication sharedApplication] setStatusBarHidden:!showingChrome withAnimation:UIStatusBarAnimationSlide]; 
    } else { 
        id<UIApplicationDeprecatedMethods> app = (id)[UIApplication sharedApplication];
        [app setStatusBarHidden:!showingChrome animated:YES];
    }
    [self.navigationController setNavigationBarHidden:!showingChrome animated:YES];
    [self.navigationController setToolbarHidden:!showingChrome animated:YES];
}

-(void) zoomImagePageTouched:(BobZoomImagePage *) bobZoomImagePage {
    showingChrome = showingChrome ? NO : YES;
    
    if (slideshowTimer) {
        [slideshowTimer invalidate];
        [slideshowTimer release], slideshowTimer = nil;
        playingSlideshow = NO;
        [play setImage:[UIImage imageNamed:@"play.png"]];
    }
    
    [self updateChrome];
}

@end
