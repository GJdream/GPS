//
//  BEEAppDelegate.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEPhotosViewController.h"
#import "BEEManager.h"

@interface BEEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) BEEPhotosViewController *viewController;

@end
