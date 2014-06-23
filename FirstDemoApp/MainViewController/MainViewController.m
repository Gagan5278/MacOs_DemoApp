//
//  MainViewController.m
//  FirstDemoApp
//
//  Created by Gagan on 23/06/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//
#define  CompositionIdentifier @"compositionIdentifier"
#import "MainViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize appQCView;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nil bundle:nil];
    if(self)
    {
        totalNumberOfItems=10;
        [self.appQCView setHidden:YES];
    }
    return self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return totalNumberOfItems;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView=[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if([tableColumn.identifier isEqualToString:@"TableCell"])
    {
        cellView.imageView.image=[NSImage imageNamed:@"image.png"];
        cellView.textField.stringValue=[NSString stringWithFormat:@"Row : %ld",(long)row];
    }
    else  if([tableColumn.identifier isEqualToString:@"Gagan"])  //Currently not in use because there uis only one column in TableView
    {
        cellView.imageView.image=[NSImage imageNamed:@"AllApps.png"];
        cellView.textField.stringValue=[NSString stringWithFormat:@"Row : %ld",(long)row];
    }
    return cellView;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger selectedInt=[self.myTableView selectedRow];
    self.myTextField.stringValue=[NSString stringWithFormat:@"Table Selected Row is : %ld",(long)selectedInt];
    self.myImageView.image=[NSImage imageNamed:@"image.png"];
}

- (IBAction)AddItemInCell:(id)sender {
    totalNumberOfItems++;
    [self.myTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:totalNumberOfItems] withAnimation:NSTableViewAnimationSlideRight];
}

- (IBAction)RemoveItemFromCell:(id)sender {
    totalNumberOfItems--;
    [self.myTableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:totalNumberOfItems] withAnimation:NSTableViewAnimationSlideRight];
}

- (IBAction)TakePictureButtonPressed:(id)sender {
    [[IKPictureTaker pictureTaker]beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void) pictureTakerDidEnd:(IKPictureTaker *) picker returnCode:(NSInteger) code contextInfo:(void*) contextInfo
{
    NSImage *image=[picker outputImage];
    if(image && code==NSOKButton)
    {
        self.myImageView.image=image;
    }
}

- (IBAction)ApplyFilterButtonPressed:(id)sender {
    QCCompositionPickerPanel *compositionPicker=[QCCompositionPickerPanel sharedCompositionPickerPanel];
    if(![compositionPicker isVisible])
    {
        [self.appQCView setHidden:NO];
        
        if([self.appQCView loadCompositionFromFile:[[NSBundle mainBundle]pathForResource:@"Composition" ofType:@"qtz"]])
        {
            [self.appQCView startRendering];
        }
        [[compositionPicker compositionPickerView]setAllowsEmptySelection:YES];
        [[compositionPicker compositionPickerView] setShowsCompositionNames:YES];
        [[compositionPicker compositionPickerView] setCompositionsFromRepositoryWithProtocol:QCCompositionProtocolImageFilter andAttributes:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_didSelectComposition:) name:QCCompositionPickerViewDidSelectCompositionNotification object:nil];
        [compositionPicker orderFront:sender];
    }
    else{
        [compositionPicker orderOut:sender];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:QCCompositionPickerViewDidSelectCompositionNotification object:nil];
    }
}

- (void) _didSelectComposition:(NSNotification*)notification
{
        NSLog(@"[notification userInfo] is : %@",[notification userInfo]);
	    QCComposition *composition = [[notification userInfo] objectForKey:@"QCComposition"];
		[self.appQCView setValue:[composition identifier] forInputKey:CompositionIdentifier];
}

/*
- (void) saveInPNGFormat
{
	NSSavePanel*							savePanel = [NSSavePanel savePanel];
	CGImageRef								imageRef;
	CGImageDestinationRef					destinationRef;
	
	[savePanel setRequiredFileType:@"png"];
	if([savePanel runModalForDirectory:nil file:@"My Picture"] == NSFileHandlingPanelOKButton) {
		if(imageRef = (CGImageRef)[qcView createSnapshotImageOfType:@"CGImage"]) {
			if(destinationRef = CGImageDestinationCreateWithURL((CFURLRef)[NSURL fileURLWithPath:[savePanel filename]], kUTTypePNG, 1, NULL)) {
				CGImageDestinationAddImage(destinationRef, imageRef, NULL);
				if(!CGImageDestinationFinalize(destinationRef))
                    NSBeep();
				CFRelease(destinationRef);
			}
			else
                NSBeep();
			CGImageRelease(imageRef);
		}
		else
            NSBeep();
	} 
}
 */

@end
