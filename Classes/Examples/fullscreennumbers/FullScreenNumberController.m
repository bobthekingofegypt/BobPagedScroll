#import "FullScreenNumberController.h"
#import "FullScreenNumberPage.h"

@implementation FullScreenNumberController

- (void)dealloc {
	[_bobPageScrollView release];
    [super dealloc];
}

-(void) loadView {
	[super loadView];	
	self.title = @"Numbers";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	_bobPageScrollView = [[BobPageScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)];
	_bobPageScrollView.datasource = self;
	_bobPageScrollView.padding = 20.0f;
	
	[self.view addSubview:_bobPageScrollView];
	
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
	return 45;
}

-(BobPage *) bobPageScrollView:(BobPageScrollView *)bobPageScrollView pageForIndex:(NSUInteger)index {
	static NSString *reuseIdentifier = @"Test";
	
	FullScreenNumberPage *page = (FullScreenNumberPage *)[bobPageScrollView dequeueReusablePageWithIdentifier:reuseIdentifier];
	if (!page) {
		page = [[[FullScreenNumberPage alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f) andReuseIdentifier:reuseIdentifier] autorelease];
	}
	
	page.number.text = [NSString stringWithFormat:@"%d", index];

	return page;
}


@end
