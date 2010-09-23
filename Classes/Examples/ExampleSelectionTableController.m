#import "ExampleSelectionTableController.h"
#import "FullScreenPhotoController.h"
#import "FullScreenNumberController.h"


@implementation ExampleSelectionTableController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test Selection";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
}

-(void) viewWillAppear:(BOOL)animated {	
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#define kFullScreenNumbers 0
#define kFullScreenPhotos 1

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExampleSelectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	if (indexPath.row == kFullScreenNumbers) {
		cell.textLabel.text = @"Full Screen Numbers";
	} else if (indexPath.row == kFullScreenPhotos) {
		cell.textLabel.text = @"Full Screen Photos";
	}
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == kFullScreenNumbers) {
		FullScreenNumberController *viewController = [[FullScreenNumberController alloc] init];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
	} else if (indexPath.row == kFullScreenPhotos) {
		FullScreenPhotoController *viewController = [[FullScreenPhotoController alloc] init];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end

