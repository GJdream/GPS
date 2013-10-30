//
//  BEEPartidaDetalheViewController.h
//  GPS
//
//  Created by Mauricio Meirelles on 9/24/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"

@interface BEEPartidaDetalheViewController : UIViewController <UIWebViewDelegate>
{
    BEEPartida *partidaObj;
    
    UILabel *lblVouOption;
    BEEVouNaoVouOption *optSelected;
    UIWebView *comprovanteWebView;
    
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actv;
@property (strong) NSString *linkJogo;
@property (weak, nonatomic) IBOutlet UILabel *lblJogo;
@property (weak, nonatomic) IBOutlet UIButton *btSetorOption;
@property (weak, nonatomic) IBOutlet UIButton *btSalvar;
@property (weak, nonatomic) IBOutlet UILabel *lblCampeonato;
@property (weak, nonatomic) IBOutlet UILabel *lblData;
@property (weak, nonatomic) IBOutlet UILabel *lblLocal;
@property (weak, nonatomic) IBOutlet UISwitch *jogoSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lblVaiJogo;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actv2;

@end
