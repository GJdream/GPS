//
//  BEELiveVideoViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 8/6/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEELiveVideoViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>
{
    UIActivityIndicatorView *actv2;
    BOOL isOnlineAux;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (strong) NSString *strUrl;

@end
