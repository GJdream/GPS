//
//  BEEViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "IIViewDeckController.h"

#import "UIColor-Expanded.h"

@interface BEEViewController : UIViewController
{
    BEEDados *gpsDados;
    
    
    UIImageView *imgTopo;
    
    //Interface
    UILabel *lblTotal;
    UILabel *lblConcluido;
    
    UILabel *lblP2;
    UILabel *lblP3;
    UILabel *lblP4;
    
    UIImageView *imgP2;
    UIImageView *imgP3;
    UIImageView *imgP4;
    
    UILabel *lblDataHora;
    
    UIActivityIndicatorView *loader;
    
    NSTimer *printData;
    
    BOOL showCountdown;
    
    UILabel *lblFalta;
    
    UILabel *lblDias;
    UILabel *lblDiasTxt;
    
    UILabel *lblHoras;



}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
