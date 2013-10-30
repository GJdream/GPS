//
//  RotationNavigationController.m
//  GPS
//
//  Created by Mauricio Meirelles on 8/1/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "RotationNavigationController.h"
#import "FGalleryViewController.h"

@interface RotationNavigationController ()

@end

@implementation RotationNavigationController


- (BOOL)shouldAutorotate {
    if ([self.topViewController isKindOfClass:[FGalleryViewController class]] )
        return [self.topViewController shouldAutorotate];
    else
        return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([self.topViewController isKindOfClass:[FGalleryViewController class]] )
        return [self.topViewController supportedInterfaceOrientations];
    else
        return UIInterfaceOrientationMaskPortrait;
}


@end
