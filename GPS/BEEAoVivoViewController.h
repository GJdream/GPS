//
//  BEEAoVivoViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "FGalleryViewController.h"
#import "IIViewDeckController.h"


@interface BEEAoVivoViewController : UIViewController<FGalleryViewControllerDelegate> 
{
    NSMutableArray *photos;
    NSArray *localCaptions;
    NSArray *localImages;
    NSMutableArray *networkCaptions;
    NSMutableArray *networkImages;
	FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    int tblCount;
    UIActivityIndicatorView *actv;
    NSMutableDictionary *dicPhotos;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
