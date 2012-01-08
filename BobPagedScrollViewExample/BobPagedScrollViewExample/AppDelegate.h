//
//  AppDelegate.h
//  BobPagedScrollViewExample
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>

@class ExampleSelectionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    ExampleSelectionController *exampleSelectionController;
    
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@end
