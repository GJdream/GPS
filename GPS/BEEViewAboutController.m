//
//  BEEViewAboutController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEViewAboutController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface BEEViewAboutController ()

@end

@implementation BEEViewAboutController


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
    
    int Ytopo = 35;
    
    if(!IS_IPHONE_5)
    {
        Ytopo = 15;
    }
 
    UILabel *lblDesenvolvido =  [[UILabel alloc] initWithFrame:CGRectMake(10,Ytopo, 300, 30)];
    [lblDesenvolvido setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    [lblDesenvolvido setTextColor:[UIColor whiteColor]];
    lblDesenvolvido.backgroundColor = [UIColor clearColor];
    lblDesenvolvido.text = @"Desenvolvido por";
    lblDesenvolvido.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:lblDesenvolvido];
    
    
    UILabel *lblMauricio =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblDesenvolvido.frame.size.height + lblDesenvolvido.frame.origin.y + 5, 300, 40)];
    [lblMauricio setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:35]];
    [lblMauricio setTextColor:[UIColor whiteColor]];
    lblMauricio.backgroundColor = [UIColor clearColor];
    lblMauricio.text = @"Mauricio Meirelles";
    lblMauricio.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:lblMauricio];
    
    
    
    UIImageView *imgGrupo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gps.png"]];
    imgGrupo.frame = CGRectMake(10, lblMauricio.frame.size.height + lblMauricio.frame.origin.y + 30, 300, 192);
    [_scrollView addSubview:imgGrupo];
    
    
    UIImageView *imgSocio = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"socio.png"]];
    imgSocio.frame = CGRectMake(10, imgGrupo.frame.size.height + imgGrupo.frame.origin.y + 30, 300, 56);
    [_scrollView addSubview:imgSocio];

    
    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];
    
    UIButton *btFacebook = [[UIButton alloc] initWithFrame:CGRectMake(0, lblDesenvolvido.frame.origin.y, 320, lblMauricio.frame.size.height + lblDesenvolvido.frame.size.height + 15)];
    [btFacebook addTarget:self action:@selector(gotoFacebook) forControlEvents:UIControlEventTouchUpInside];
    btFacebook.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btFacebook];
    
    UIButton *btGPS = [[UIButton alloc] initWithFrame:CGRectMake(0, btFacebook.frame.origin.y + btFacebook.frame.size.height, 320, imgGrupo.frame.size.height )];
    [btGPS addTarget:self action:@selector(gotoComunidade) forControlEvents:UIControlEventTouchUpInside];
    btGPS.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btGPS];
    

    UIButton *btSocio = [[UIButton alloc] initWithFrame:CGRectMake(0, imgSocio.frame.origin.y - 10, 320, imgSocio.frame.size.height + 50)];
    [btSocio addTarget:self action:@selector(gotoSocio) forControlEvents:UIControlEventTouchUpInside];
    btSocio.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btSocio];
    

    [_scrollView setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];

    
    _scrollView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    [_scrollView setContentSize:CGSizeMake(320, btSocio.frame.size.height + btSocio.frame.origin.y + 20)];
    [self loadData];
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
    
    
    lblTotal.text = [NSString stringWithFormat:@"%.f%%",gpsDados.total];
    lblP2.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p2_qtd, gpsDados.total_p];
    lblP3.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p3_qtd, gpsDados.total_p];
    lblP3.text = [NSString stringWithFormat:@"%d/%d",gpsDados.p3_qtd, gpsDados.total_p];

    
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
