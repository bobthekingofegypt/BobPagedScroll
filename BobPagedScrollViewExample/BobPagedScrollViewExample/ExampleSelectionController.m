//
//  ExampleSelectionController.m
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import "ExampleSelectionController.h"

#import "BobPagedScrollViewController.h"
#import "ImageScrollViewExample.h"
#import "ImageZoomScrollViewExample.h"
#import "BobPhotoExample.h"

#define kNumberExample 0
#define kImageExample 1
#define kImageZoomExample 2
#define kBobPhotoExample 3

@implementation ExampleSelectionController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Examples";
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"exampleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case kNumberExample:
            cell.textLabel.text = @"Numbered views example";
            break;
        case kImageExample:
            cell.textLabel.text = @"Image views example";
            break;
        case kImageZoomExample:
            cell.textLabel.text = @"Image zoom example";
            break;
        case kBobPhotoExample:
            cell.textLabel.text = @"Bob photo example";
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Simple Examples";
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = nil;
    
    switch (indexPath.row) {
        case kNumberExample:
            controller = [[[BobPagedScrollViewController alloc] init] autorelease];
            break;
        case kImageExample:
            controller = [[[ImageScrollViewExample alloc] init] autorelease];
            break;
        case kImageZoomExample:
            controller = [[[ImageZoomScrollViewExample alloc] init] autorelease];
            break;
        case kBobPhotoExample:
            controller = [[[BobPhotoExample alloc] init] autorelease];
            break;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
