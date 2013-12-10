//
//  BEELoginCheckInController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEELoginCheckInController.h"
#import "BEEPartidasViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface BEELoginCheckInController ()

@end

@implementation BEELoginCheckInController


- (void)viewDidLoad
{
    [super viewDidLoad];

    //Interface
    
    UIImageView *imgTopo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo.png"]];
    imgTopo.frame = CGRectMake(0, 0, 320, 108.5);
    [self.view addSubview:imgTopo];

    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];
    
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];
    
    keyboard = [[KBKeyboardHandler alloc] init];
    keyboard.delegate = self;

    
    self.viewDeckController.delegate = self;
    
    _txtScrollView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    scrollInitHeight = _txtScrollView.frame.size.height;
    
    [_txtScrollView setContentSize:CGSizeMake(320,  _txtScrollView.frame.size.height + 10)];
    
    _btLogin.backgroundColor = [UIColor colorWithRed:167/255.0 green:0/255.0 blue:20/255.0 alpha:1];
    _btLogin.alpha = 0.3;
    
    
    askLogin = NO;
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    if(![[currentDefaults objectForKey:@"socioMatricula"] isEqualToString:@""] && [currentDefaults objectForKey:@"socioMatricula"])
    {
        askLogin = YES;
        [self performSegueWithIdentifier:@"gotoPartidas" sender:nil];
    }
    
    
    [_actvIndicator stopAnimating];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    BEEPartidasViewController *bel = (BEEPartidasViewController *)segue.destinationViewController;
    
    bel.shouldAskLogin = askLogin;
    
    
}

-(void)viewDeckController:(IIViewDeckController *)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    
    [selectedTextField resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    selectedTextField = textField;
}

- (void)keyboardSizeChanged:(CGSize)delta
{
    
    if(delta.height > 0)
    {
        
        CGPoint txtPoint = [_txtScrollView convertPoint:selectedTextField.frame.origin toView:self.view];
        
        if(txtPoint.y + selectedTextField.frame.size.height > ( [[ UIScreen mainScreen ] bounds ].size.height - delta.height ))
        {
            
            
            [_txtScrollView setContentOffset:CGPointMake(0, (txtPoint.y + selectedTextField.frame.size.height + 40)- ( [[ UIScreen mainScreen ] bounds ].size.height - delta.height )) animated:YES];
            
            
        }

    }
    else
    {
        [_txtScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    _btLogin.alpha = 0.3;
    _btLogin.enabled = NO;
    
    if(textField == _txtMatricula)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;

        if(newLength > 8)
        {

            return NO;
        }
        else
        {

            
            return YES;
            
        }
        
    }
    else
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        

        
        if(newLength > 6)
        {

            return NO;
        }
        else
            return YES;
    }
    
    
    return YES;
}
- (IBAction)senhaChanged:(id)sender {
    if(_txtSenha.text.length > 3)
    {
        _btLogin.alpha = 1;
        _btLogin.enabled = YES;
        
        if(_txtSenha.text.length == 6)
        {
            [_txtSenha resignFirstResponder];
                
        }
    }
    
}
- (IBAction)matriculaChanged:(id)sender {
    if(_txtMatricula.text.length == 8)
    {
        [_txtMatricula resignFirstResponder];
        [_txtSenha becomeFirstResponder];
        
        if(_txtSenha.text.length > 3)
        {
            _btLogin.alpha = 1;
            _btLogin.enabled = YES;
        }
    }
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(selectedTextField.isFirstResponder)
        [selectedTextField resignFirstResponder];
}


-(void)openMenu
{
    [self.viewDeckController openLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [_txtMatricula becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated
{
    keyboard.delegate = nil;
    keyboard = nil;
    
    //    [scrollingTimer invalidate];
    //    scrollingTimer = nil;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)clickLogin:(id)sender {
    
    _btLogin.hidden = YES;
    
    [_actvIndicator startAnimating];
    
    [[BEEManager singleton] loginSimplesSocioInter:^(int isSucesso) {
        
        
        if(isSucesso == 0)
        {
            [self performSelectorOnMainThread:@selector(sucessoRetorno) withObject:nil waitUntilDone:NO];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(erroRetorno:) withObject:[NSNumber numberWithInt:isSucesso] waitUntilDone:NO];
        }
    }
     withMatricula:_txtMatricula.text andSenha:_txtSenha.text];
        
    

    

}

-(void)sucessoRetorno
{
    [_actvIndicator stopAnimating];
    
    _btLogin.hidden = NO;
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    [currentDefaults setObject:_txtMatricula.text forKey:@"socioMatricula"];
    [currentDefaults setObject:_txtSenha.text forKey:@"socioSenha"];
    [currentDefaults synchronize];
    
    [self performSegueWithIdentifier:@"gotoPartidas" sender:nil];
    
}

-(void)erroRetorno: (NSNumber *) erroNum
{
    [_actvIndicator stopAnimating];
    
    _btLogin.hidden = NO;
    
    NSString *erroMsg;
    if([erroNum intValue] == 1)
    {
        erroMsg = @"Matrícula não encontrada";
    }
    else if([erroNum intValue] == 2)
    {
        erroMsg = @"Senha não confere";
    }
    else
    {
        erroMsg = @"Erro";
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:erroMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}


@end
