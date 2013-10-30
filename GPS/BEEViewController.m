//
//  BEEViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEViewController.h"

@interface BEEViewController ()

@end

@implementation BEEViewController


-(void)reloadAllData
{
    
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadAllData)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    
    
    //Interface
    
    UIImageView *imgTopo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo.png"]];
    imgTopo.frame = CGRectMake(0, 0, 320, 108.5);
    [self.view addSubview:imgTopo];

    
    // Total Label
    
    lblTotal =  [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 270, 90)];
    [lblTotal setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:90]];
    [lblTotal setTextColor:[UIColor whiteColor]];
    lblTotal.backgroundColor = [UIColor clearColor];
    lblTotal.text = @"76.5%";
    lblTotal.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:lblTotal];
    
    
    lblConcluido =  [[UILabel alloc] initWithFrame:CGRectMake(150, lblTotal.frame.size.height + lblTotal.frame.origin.y , 170, 30)];
    [lblConcluido setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [lblConcluido setTextColor:[UIColor whiteColor]];
    lblConcluido.backgroundColor = [UIColor clearColor];
    lblConcluido.text = @"Concluído";
    lblConcluido.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:lblConcluido];
    
    
    //P2
    
    UIImageView *imgP2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p2.png"]];
    imgP2.frame = CGRectMake(240, lblConcluido.frame.size.height + lblConcluido.frame.origin.y + 40, 51.5, 68);
    [_scrollView addSubview:imgP2];
    
    
    lblP2 =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblConcluido.frame.size.height + lblConcluido.frame.origin.y + 25, 210, 90)];
    [lblP2 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70]];
    [lblP2 setTextColor:[UIColor whiteColor]];
    lblP2.backgroundColor = [UIColor clearColor];
    lblP2.text = @"27/65";
    lblP2.textAlignment = NSTextAlignmentRight;
    [_scrollView addSubview:lblP2];
    
    
    //P3
    
    UIImageView *imgP3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p3.png"]];
    imgP3.frame = CGRectMake(235, lblP2.frame.size.height + lblP2.frame.origin.y + 32, 64, 32.5);
    [_scrollView addSubview:imgP3];
    
    lblP3 =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblP2.frame.size.height + lblP2.frame.origin.y + 2, 210, 90)];
    [lblP3 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70]];
    [lblP3 setTextColor:[UIColor whiteColor]];
    lblP3.backgroundColor = [UIColor clearColor];
    lblP3.text = @"6/65";
    lblP3.textAlignment = NSTextAlignmentRight;
    [_scrollView addSubview:lblP3];
    
    
    //P4
    
    UIImageView *imgP4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p4.png"]];
    imgP4.frame = CGRectMake(235, lblP3.frame.size.height + lblP3.frame.origin.y + 32, 64, 32.5);
    [_scrollView addSubview:imgP4];
    
    
    lblP4 =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblP3.frame.size.height + lblP3.frame.origin.y + 2, 210, 90)];
    [lblP4 setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70]];
    [lblP4 setTextColor:[UIColor whiteColor]];
    lblP4.backgroundColor = [UIColor clearColor];
    lblP4.text = @"0/65";
    lblP4.textAlignment = NSTextAlignmentRight;
    [_scrollView addSubview:lblP4];
    
    
    
    lblDataHora =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblP4.frame.size.height + lblP4.frame.origin.y + 7, 300, 20)];
    [lblDataHora setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [lblDataHora setTextColor:[UIColor blackColor]];
    lblDataHora.backgroundColor = [UIColor clearColor];
    lblDataHora.text = @"";
    lblDataHora.textAlignment = NSTextAlignmentCenter;
    lblDataHora.alpha = 0.4;
    [_scrollView addSubview:lblDataHora];
    
 
    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];

    [_scrollView setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];

    _scrollView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    
    [_scrollView setContentSize:CGSizeMake(320, lblDataHora.frame.size.height + lblDataHora.frame.origin.y + 20)];
    [self loadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openMenu
{
    [self.viewDeckController openLeftViewAnimated:YES];
}

-(void)gotoComunidade
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://gpsbr.me"]];
}


-(void)gotoFacebook
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/mauriciomeirelles"]];
}

-(void)gotoSocio
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.internacional.com.br/sejasocio/"]];
}

- (void)loadData {
    
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
    if(gpsDados != nil)
        gpsDados = [[BEEDados alloc] init];
    
    // Load from prefs
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *gpsDadosSaved = [currentDefaults objectForKey:@"gpsDados2"];
    if (gpsDadosSaved != nil) {
        gpsDados = [NSKeyedUnarchiver unarchiveObjectWithData:gpsDadosSaved];
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];

    }
    else
    {
        gpsDados = nil;
    }
    
    [loader startAnimating];
    
    [[BEEManager singleton] ListaDados:^(BEEDados *dados) {
        gpsDados = dados;
        
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];

        
    } erro:^(int error) {
        [self performSelectorOnMainThread:@selector(alertFecharComErro:) withObject:[NSNumber numberWithInt:error] waitUntilDone:NO];
    }];
}

- (void)atualizaDados
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:gpsDados.data];
    
    double tx = gpsDados.total - floor(gpsDados.total);
    
    if(tx > 0)
        lblTotal.text = [NSString stringWithFormat:@"%.1f%%",gpsDados.total];
    else
        lblTotal.text = [NSString stringWithFormat:@"%.f%%",gpsDados.total];
    
    
    lblP2.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p2_qtd, gpsDados.total_p];
    lblP3.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p3_qtd, gpsDados.total_p];
    lblP4.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p4_qtd, gpsDados.total_p];

    
    lblDataHora.text = [NSString stringWithFormat:@"Última atualização - %@",strDate];
    
    [loader stopAnimating];

   
}


- (void)alertFecharComErro:(NSNumber *) nErro
{
    
    [loader stopAnimating];

}



- (BOOL)shouldAutorotate {
        return NO;
}

- (NSUInteger)supportedInterfaceOrientations {

        return UIInterfaceOrientationMaskPortrait;
}
 


@end
