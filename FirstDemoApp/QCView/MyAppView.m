//
//  MyAppView.m
//  FirstDemoApp
//
//  Created by Gagan on 23/06/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import "MyAppView.h"

@implementation MyAppView
- (BOOL) renderAtTime:(NSTimeInterval)time arguments:(NSDictionary*)arguments
{
	id image;
	if(![super renderAtTime:time arguments:arguments])
        return NO;
	
	if(image== [self valueForOutputKey:@"videoImage" ofType:@"QCImage"])
    {
        [[[QCCompositionPickerPanel sharedCompositionPickerPanel] compositionPickerView] setDefaultValue:image forInputKey:QCCompositionInputImageKey];
	}
	return YES;
}
@end
