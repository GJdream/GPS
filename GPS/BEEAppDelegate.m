//
//  BEEAppDelegate.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEAppDelegate.h"
#import "BEEManager.h"
#import "IIViewDeckController.h"
#import "BEELeftMenuViewController.h"
#import "BEEViewController.h"

@implementation BEEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    application.applicationIconBadgeNumber = 0;
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        self.window.tintColor = [UIColor whiteColor];
    
    
    // Override point for customization after application launch.
    
    BEELeftMenuViewController *leftVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"leftMenu"];
    
    BEEViewController *mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"statusVC"];
    
    
    
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:mainVC
                                                                                    leftViewController:leftVC
                                                                                   rightViewController:nil];
    deckController.leftSize = 130;
    deckController.elastic = NO;
    deckController.panningCancelsTouchesInView = YES;
    
    /* To adjust speed of open/close animations, set either of these two properties. */
    // deckController.openSlideAnimationDuration = 0.15f;
    // deckController.closeSlideAnimationDuration = 0.5f;
    
    self.window.rootViewController = deckController;
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *pushId = [[[[deviceToken description]
                stringByReplacingOccurrencesOfString:@"<" withString:@""]
               stringByReplacingOccurrencesOfString:@">" withString:@""]
              stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[BEEManager singleton] savePushUser:pushId];
    
//    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"token" message:pushId delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [aler show];
    
    NSLog(@"My token is: %@", pushId);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    application.applicationIconBadgeNumber = 0;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
