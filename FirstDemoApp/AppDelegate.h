//
//  AppDelegate.h
//  FirstDemoApp
//
//  Created by Gagan on 23/06/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property(nonatomic,strong)IBOutlet MainViewController *mainController;

@end
