//
//  BEEPartidasViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "IIViewDeckController.h"


@interface BEEPartidasViewController : UIViewController
{

    UIActivityIndicatorView *actv;
    NSMutableArray *partidasArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL shouldAskLogin;
@property (weak, nonatomic) IBOutlet UILabel *lblNoPartidas;

@end
