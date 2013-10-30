//
//  BEELeftMenuViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 8/1/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "UIColor-Expanded.h"

@interface BEELeftMenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
