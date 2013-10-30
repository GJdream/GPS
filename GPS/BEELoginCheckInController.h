//
//  BEELoginCheckInController.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEManager.h"
#import "UIColor-Expanded.h"
#import "IIViewDeckController.h"
#import "KBKeyboardHandler.h"

@interface BEELoginCheckInController : UIViewController <KBKeyboardHandlerDelegate,UITextFieldDelegate, IIViewDeckControllerDelegate, UIScrollViewDelegate>
{
//    BEEDados *gpsDados;
//    
//    
//    //Interface
//    UILabel *lblTotal;
//    UILabel *lblConcluido;
//    
//    UILabel *lblP2;
//    UILabel *lblP3;
//    UILabel *lblP4;
//    
//    UILabel *lblDataHora;
//    
//    UIActivityIndicatorView *loader;

    
    KBKeyboardHandler *keyboard;
    float scrollInitHeight;
    UITextField *selectedTextField;
    BOOL keyboardIsShown;
    
    BOOL askLogin;

}
@property (weak, nonatomic) IBOutlet UIScrollView *txtScrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtMatricula;

@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
@property (weak, nonatomic) IBOutlet UIButton *btLogin;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actvIndicator;
@end
