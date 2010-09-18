#import "FullScreenNumberController.h"


@implementation FullScreenNumberController

- (void)dealloc {
	[bobPageScrollView release];
    [super dealloc];
}

-(void) loadView {
	[super loadView];	
	bobPageScrollView = [[BobPageScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, self.view.frame.size.height)];
	bobPageScrollView.datasource = self;
	
	[self.view addSubview:bobPageScrollView];
	
	[bobPageScrollView reloadData];
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
	return 0;
}

-(UIView *) viewForPage:(NSUInteger)page {
	return nil;
}


@end
