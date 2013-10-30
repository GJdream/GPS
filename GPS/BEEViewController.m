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
    
//    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_inter.png"]];
//    imgLogo.frame = CGRectMake(2, 2, 60, 60);
//    [_scrollView addSubview:imgLogo];
    
    
//    loader = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    loader.frame = CGRectMake(290, 10, 20, 20);
//    [_scrollView addSubview:loader];
//    [loader startAnimating];
    
    
    // Total Label
    
    lblTotal =  [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 270, 90)];
    [lblTotal setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:90]];
    [lblTotal setTextColor:[UIColor whiteColor]];
//    lblTotal.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblTotal.shadowOffset = CGSizeMake(0, 2.0);
    lblTotal.backgroundColor = [UIColor clearColor];
    lblTotal.text = @"76.5%";
    lblTotal.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:lblTotal];
    
    
    lblConcluido =  [[UILabel alloc] initWithFrame:CGRectMake(150, lblTotal.frame.size.height + lblTotal.frame.origin.y , 170, 30)];
    [lblConcluido setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [lblConcluido setTextColor:[UIColor whiteColor]];
//    lblConcluido.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblConcluido.shadowOffset = CGSizeMake(0, 2.0);
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
//    lblP2.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblP2.shadowOffset = CGSizeMake(0, 2.0);
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
//    lblP3.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblP3.shadowOffset = CGSizeMake(0, 2.0);
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
//    lblP4.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblP4.shadowOffset = CGSizeMake(0, 2.0);
    lblP4.backgroundColor = [UIColor clearColor];
    lblP4.text = @"0/65";
    lblP4.textAlignment = NSTextAlignmentRight;
    [_scrollView addSubview:lblP4];
    
    
    
    lblDataHora =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblP4.frame.size.height + lblP4.frame.origin.y + 7, 300, 20)];
    [lblDataHora setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [lblDataHora setTextColor:[UIColor blackColor]];
//    lblDataHora.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblDataHora.shadowOffset = CGSizeMake(0, 2.0);
    lblDataHora.backgroundColor = [UIColor clearColor];
    lblDataHora.text = @"";
    lblDataHora.textAlignment = NSTextAlignmentCenter;
    lblDataHora.alpha = 0.4;
    [_scrollView addSubview:lblDataHora];
    
    
    
    
 
//    UILabel *lblDesenvolvido =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblDataHora.frame.size.height + lblDataHora.frame.origin.y + 25, 300, 30)];
//    [lblDesenvolvido setFont:[UIFont boldSystemFontOfSize:18]];
//    [lblDesenvolvido setTextColor:[UIColor whiteColor]];
//    lblDesenvolvido.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblDesenvolvido.shadowOffset = CGSizeMake(0, 2.0);
//    lblDesenvolvido.backgroundColor = [UIColor clearColor];
//    lblDesenvolvido.text = @"Desenvolvido por";
//    lblDesenvolvido.textAlignment = NSTextAlignmentCenter;
//    [_scrollView addSubview:lblDesenvolvido];
//    
//    
//    UILabel *lblMauricio =  [[UILabel alloc] initWithFrame:CGRectMake(10, lblDesenvolvido.frame.size.height + lblDesenvolvido.frame.origin.y + 5, 300, 40)];
//    [lblMauricio setFont:[UIFont boldSystemFontOfSize:31]];
//    [lblMauricio setTextColor:[UIColor whiteColor]];
//    lblMauricio.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
//    lblMauricio.shadowOffset = CGSizeMake(0, 2.0);
//    lblMauricio.backgroundColor = [UIColor clearColor];
//    lblMauricio.text = @"Mauricio Meirelles";
//    lblMauricio.textAlignment = NSTextAlignmentCenter;
//    [_scrollView addSubview:lblMauricio];
//    
//    
//    
//    UIImageView *imgGrupo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gps.png"]];
//    imgGrupo.frame = CGRectMake(10, lblMauricio.frame.size.height + lblMauricio.frame.origin.y + 50, 300, 114);
//    [_scrollView addSubview:imgGrupo];
//    
//    
//    UIImageView *imgSocio = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"socio.png"]];
//    imgSocio.frame = CGRectMake(10, imgGrupo.frame.size.height + imgGrupo.frame.origin.y + 50, 300, 56);
//    [_scrollView addSubview:imgSocio];
//    
//    
////    [_scrollView setBackgroundColor:[UIColor colorWithHexString:@"6E1311"]];
//    
//    
//    
    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];
////
////    UIButton *btFacebook = [[UIButton alloc] initWithFrame:CGRectMake(0, lblDesenvolvido.frame.origin.y, 320, lblMauricio.frame.size.height + lblDesenvolvido.frame.size.height + 15)];
////    [btFacebook addTarget:self action:@selector(gotoFacebook) forControlEvents:UIControlEventTouchUpInside];
////    btFacebook.backgroundColor = [UIColor clearColor];
////    [_scrollView addSubview:btFacebook];
////    
////    UIButton *btGPS = [[UIButton alloc] initWithFrame:CGRectMake(0, btFacebook.frame.origin.y + btFacebook.frame.size.height, 320, imgGrupo.frame.size.height + 60)];
////    [btGPS addTarget:self action:@selector(gotoComunidade) forControlEvents:UIControlEventTouchUpInside];
////    btGPS.backgroundColor = [UIColor clearColor];
////    [_scrollView addSubview:btGPS];
////    
//
//    UIButton *btSocio = [[UIButton alloc] initWithFrame:CGRectMake(0, imgSocio.frame.origin.y - 10, 320, imgSocio.frame.size.height + 50)];
//    [btSocio addTarget:self action:@selector(gotoSocio) forControlEvents:UIControlEventTouchUpInside];
//    btSocio.backgroundColor = [UIColor clearColor];
//    [_scrollView addSubview:btSocio];
    

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
    
//    [self paraAnimacao];
//    
//    NSInteger erro = [nErro integerValue];
//    NSString *key = [NSString stringWithFormat:@"erro%d",erro];
//    
//    NSString *mensagem = [self localized:key];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[self localized:@"txtErro"] message:mensagem delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [alert setTag:999];
//    
//    if (self.navigationController.topViewController==self)
//        [alert show];
}



- (BOOL)shouldAutorotate {
        return NO;
}

- (NSUInteger)supportedInterfaceOrientations {

        return UIInterfaceOrientationMaskPortrait;
}
 


@end
