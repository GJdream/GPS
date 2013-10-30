//
//  BEELiveVideoViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 8/6/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEELiveVideoViewController.h"
#import "BEEManager.h"

@interface BEELiveVideoViewController ()

@end

@implementation BEELiveVideoViewController

@synthesize strUrl = _strUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Ao Vivo";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _webview.backgroundColor = [UIColor blackColor];
    

    [[BEEManager singleton] CheckVideo:^(BOOL isOnline) {
        isOnlineAux = isOnline;
        
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];
        
        
    } erro:^(int error) {
    }
      withUrl:_strUrl];
    
    _webview.hidden = YES;

    actv2 = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 320, ([ [ UIScreen mainScreen ] bounds ].size.height-44-20/2)-20)];
    [actv2 startAnimating];
    [self.view addSubview:actv2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)atualizaDados
{
    if(isOnlineAux)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: _strUrl] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];

        [_webview loadRequest: request];

    }
    else
    {
        
        [actv2 stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Offline"
                                                       message:@"O streaming está offline no momento"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if ([viewControllers indexOfObject:self] == NSNotFound) {
        // View is disappearing because it was popped from the stack
        NSLog(@"View controller was popped");
        
        [_webview stopLoading];
        _webview.delegate = nil;
        _webview = nil;
        
    }
    else
    {
        _webview.hidden = NO;
        [actv2 stopAnimating];
    }
    
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webview.hidden = NO;
    [actv2 stopAnimating];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline" message:@"Câmera está offline" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
    
//    [self.navigationController popViewControllerAnimated:YES];

    
    
//    _webview.hidden = NO;
//    [actv2 stopAnimating];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    
    [self.navigationController popViewControllerAnimated:YES];

}







@end
