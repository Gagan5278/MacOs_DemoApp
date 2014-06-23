//
//  AppDelegate.m
//  FirstDemoApp
//
//  Created by Gagan on 23/06/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize mainController;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.mainController=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self.window.contentView addSubview:self.mainController.view];
    self.mainController.view.frame=[((NSView*)self.window.contentView) bounds];
}

@end
