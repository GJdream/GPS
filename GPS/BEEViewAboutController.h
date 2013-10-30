//
//  BEEViewAboutController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "UIColor-Expanded.h"
#import "IIViewDeckController.h"


@interface BEEViewAboutController : UIViewController
{
    BEEDados *gpsDados;
    
    
    //Interface
    UILabel *lblTotal;
    UILabel *lblConcluido;
    
    UILabel *lblP2;
    UILabel *lblP3;
    UILabel *lblP4;
    
    UILabel *lblDataHora;
    
    UIActivityIndicatorView *loader;


}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
