#import "FullScreenPhotoController.h"
#import "BobPageImage.h"

@implementation FullScreenPhotoController

-(id) init {
	if (self = [super init]) {
		images = [[NSMutableArray alloc] initWithObjects:
					[UIImage imageNamed:@"content__yet_disturbing_by_woxys-d2zv869.jpg"],
  					[UIImage imageNamed:@"nanga__the_beauty_queen_by_woxys-d2yfqxy.jpg"],
				    [UIImage imageNamed:@"Monika_was_delicious_by_woxys.jpg"],
				    [UIImage imageNamed:@"Obviously_dangerous_by_woxys.jpg"],
					[UIImage imageNamed:@"Screenshot 2010.10.04 21.58.51.png"],
					nil];
	}
	
	return self;
}

- (void)dealloc {
	[_bobPageScrollView release];
	[images release];
    [super dealloc];
}

-(void) loadView {
	[super loadView];	
	[self setWantsFullScreenLayout:YES];
	
	_bobPageScrollView = [[BobPageScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)];
	_bobPageScrollView.padding = 10.0f;
	_bobPageScrollView.datasource = self;
	
	[self.view addSubview:_bobPageScrollView];
	
	[_bobPageScrollView reloadData];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


 - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
	 [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	 
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
										 duration:(NSTimeInterval)duration {
	[_bobPageScrollView reloadData];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark -
#pragma mark BobPageScrollViewDatasource methods

-(NSUInteger) numberOfPages {
	return [images count];
}

-(BobPage *) bobPageScrollView:(BobPageScrollView *)bobPageScrollView pageForIndex:(NSUInteger)index {
	static NSString *reuseIdentifier = @"PhotoPage";
	
	BobPageImage *page = (BobPageImage *)[bobPageScrollView dequeueReusablePageWithIdentifier:reuseIdentifier];
	if (!page) {
		page = [[[BobPageImage alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f) andReuseIdentifier:reuseIdentifier] autorelease];
	}
	
	[page setImage:[images objectAtIndex:index]];
	
	return page;
}

@end
