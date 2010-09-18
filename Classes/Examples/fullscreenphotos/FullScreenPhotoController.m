#import "FullScreenPhotoController.h"


@implementation FullScreenPhotoController

- (void)dealloc {
	[bobPageScrollView release];
    [super dealloc];
}

-(void) loadView {
	[super loadView];	
	bobPageScrollView = [[BobPageScrollView alloc] initWithFrame:self.view.frame];
	bobPageScrollView.datasource = self;
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


@end
