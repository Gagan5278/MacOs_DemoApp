//
//  MainViewController.h
//  FirstDemoApp
//
//  Created by Gagan on 23/06/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "RatingView.h"
#import "MyAppView.h"
@interface MainViewController : NSViewController<NSTableViewDataSource,NSTableViewDelegate>
{
    NSInteger totalNumberOfItems;
}
@property (strong) IBOutlet NSTableView *myTableView;
@property (strong) IBOutlet NSTextField *myTextField;
@property (strong) IBOutlet NSImageView *myImageView;
@property (strong) IBOutlet RatingView *ratingView;
@property (strong) IBOutlet MyAppView *appQCView;
- (IBAction)AddItemInCell:(id)sender;
- (IBAction)RemoveItemFromCell:(id)sender;
- (IBAction)TakePictureButtonPressed:(id)sender;
- (IBAction)ApplyFilterButtonPressed:(id)sender;
@end
