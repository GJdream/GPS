//
//  BEEMensagensViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "IIViewDeckController.h"


@interface BEEMensagensViewController : UIViewController
{

    UIActivityIndicatorView *actv;
    NSMutableArray *msgArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
