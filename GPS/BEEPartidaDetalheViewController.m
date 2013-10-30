//
//  BEEPartidaDetalheViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 9/24/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEPartidaDetalheViewController.h"
#import "UIColor-Expanded.h"

@interface BEEPartidaDetalheViewController ()

@end

@implementation BEEPartidaDetalheViewController

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
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"C22825"];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];
    
    UIImageView *imgTopo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo.png"]];
    imgTopo.frame = CGRectMake(0, 0, 320, 108.5);
    [self.view addSubview:imgTopo];
    
    UIButton *btBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 80, 44)];
    [btBack addTarget:self action:@selector(voltarClick) forControlEvents:UIControlEventTouchUpInside];
    btBack.backgroundColor = [UIColor clearColor];
    [btBack setTitle:@"Voltar" forState:UIControlStateNormal];
    [self.view addSubview:btBack];
    
    
    _btSetorOption.backgroundColor = [UIColor colorWithRed:167/255.0 green:0/255.0 blue:20/255.0 alpha:1];
    
    _btSalvar.backgroundColor = [UIColor colorWithRed:167/255.0 green:0/255.0 blue:20/255.0 alpha:1];
    
    lblVouOption = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _btSetorOption.frame.size.width-10, CGFLOAT_MAX)];

    [_btSetorOption addSubview:lblVouOption];

    _jogoSwitch.onTintColor = [UIColor colorWithRed:167/255.0 green:0/255.0 blue:20/255.0 alpha:1];
   
    
    [self loadData];

}

-(void)loadData
{
    [[BEEManager singleton] getCheckIns:^(NSMutableArray *dados) {
        
        partidaObj = [dados objectAtIndex:0];
        
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];
        
    } erro:^(int error) {
        [_actv performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
        
    } linkJogo:_linkJogo];
}


- (void)atualizaDados
{
    
    [_actv stopAnimating];
    
    
    _lblJogo.hidden = _lblCampeonato.hidden = _lblData.hidden = _lblLocal.hidden = _btSetorOption.hidden = _btSalvar.hidden = _lblVaiJogo.hidden = _jogoSwitch.hidden= NO;
    
    [BEEManager singleton].optionsArray = partidaObj.vouSetor;
    
    _lblJogo.text = partidaObj.name;
    
    
    
    NSArray *cpDtLocal = [partidaObj.campeonatoDataLocal componentsSeparatedByString:@"-"];
    

    _lblCampeonato.text = [[cpDtLocal objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _lblData.text = [[cpDtLocal objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    _lblLocal.text = [[cpDtLocal objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
    BEEVouNaoVouOption *vouOpt = [partidaObj.vouNaoVou objectAtIndex:0];
    
    if(vouOpt.selected)
        _jogoSwitch.on = YES;
    else
        _jogoSwitch.on = NO;
    
    
    for(BEEVouNaoVouOption *optAux in partidaObj.vouSetor)
    {
        if(optAux.selected)
        {
            optSelected = optAux;
            break;
        }
    }
    
    [self fixBtText];
    
    if((_jogoSwitch.isOn && optSelected.value != 1) || !_jogoSwitch.isOn)
    {
        _btSalvar.enabled = YES;
        _btSalvar.alpha = 1;
    }
    else
    {
        _btSalvar.enabled = NO;
        _btSalvar.alpha = 0.3;
    }
    
    
    if(_jogoSwitch.isOn)
        _btSetorOption.hidden = NO;
    else
        _btSetorOption.hidden = YES;
    
    
    if(partidaObj.encerrado)
    {
        [self partidaEncerrada];
    }
    
    
}

-(void)partidaEncerrada
{
    
    lblVouOption.frame = CGRectMake(5, 5, _btSetorOption.frame.size.width-10, CGFLOAT_MAX);
    lblVouOption.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    lblVouOption.text = @"O Check-In foi finalizado";
    lblVouOption.numberOfLines = 0;
    lblVouOption.textColor = [UIColor whiteColor];
    lblVouOption.textAlignment = NSTextAlignmentCenter;
    lblVouOption.backgroundColor = [UIColor clearColor];
    [lblVouOption sizeToFit];
    
    lblVouOption.frame = CGRectMake(5,5, _btSetorOption.frame.size.width-10, lblVouOption.frame.size.height);
    
    _btSetorOption.frame = CGRectMake(_btSetorOption.frame.origin.x, _btSetorOption.frame.origin.y, _btSetorOption.frame.size.width, lblVouOption.frame.size.height + 10);
    
    _btSetorOption.enabled = NO;
    _btSetorOption.hidden = NO;
    
    _lblVaiJogo.hidden = _btSalvar.hidden = _jogoSwitch.hidden= YES;

}



-(void)viewWillAppear:(BOOL)animated
{
    [self fixBtText];
}

-(void)fixBtText
{
    
    for(BEEVouNaoVouOption *optAux in partidaObj.vouSetor)
    {
        if(optAux.selected)
        {
            optSelected = optAux;
            break;
        }
    }
    
    lblVouOption.frame = CGRectMake(5, 5, _btSetorOption.frame.size.width-10, CGFLOAT_MAX);
    lblVouOption.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    lblVouOption.text = optSelected.name;
    lblVouOption.numberOfLines = 0;
    lblVouOption.textColor = [UIColor whiteColor];
    lblVouOption.textAlignment = NSTextAlignmentCenter;
    lblVouOption.backgroundColor = [UIColor clearColor];
    [lblVouOption sizeToFit];
    
    lblVouOption.frame = CGRectMake(5,5, _btSetorOption.frame.size.width-10, lblVouOption.frame.size.height);
    
    _btSetorOption.frame = CGRectMake(_btSetorOption.frame.origin.x, _btSetorOption.frame.origin.y, _btSetorOption.frame.size.width, lblVouOption.frame.size.height + 10);
    
    
    if((_jogoSwitch.isOn && optSelected.value != 1) || !_jogoSwitch.isOn)
    {
        _btSalvar.enabled = YES;
        _btSalvar.alpha = 1;
    }
    else
    {
        _btSalvar.enabled = NO;
        _btSalvar.alpha = 0.3;
    }

}


-(void)voltarClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClick:(id)sender {
    
    _btSalvar.hidden = YES;
    [_actv2 startAnimating];
    
    
    _btSetorOption.enabled = _jogoSwitch.enabled = NO;
    
    [[BEEManager singleton] checkinSocio:^(int isSucesso) {
        
        
        [self performSelectorOnMainThread:@selector(loadComprovante) withObject:nil waitUntilDone:NO];
        
    } withPartida:partidaObj];
    
}

-(void)loadComprovante
{
    //Salvar comprovante
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.internacional.com.br/socios/checkincolorado_comprovante.php?cartao=%@&id_jogo=%@", partidaObj.cartao,partidaObj.idJogo]];
    
    comprovanteWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 550, 450)];
    comprovanteWebView.delegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 5.0];
    [comprovanteWebView loadRequest:request];
}


-(void)alertNow
{
    
    _btSetorOption.enabled = _jogoSwitch.enabled = YES;
    
    _btSalvar.hidden = NO;
    [_actv2 stopAnimating];
    
    NSString *strMsg;
    
    if(_jogoSwitch.isOn)
        strMsg = @"A comunicação de que você VAI a esta partida foi enviada e o comprovante salvo no seu Álbum de Fotos!";
    else
        strMsg = @"A comunicação de que você NÃO VAI a esta partida foi enviada e o comprovante salvo no seu Álbum de Fotos!";
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check in" message:strMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIGraphicsBeginImageContext(webView.bounds.size);
    [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(resultImageView, nil, nil, nil);
    
    [self alertNow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeVaiJogo:(id)sender {
    
    if((_jogoSwitch.isOn && optSelected.value != 1) || !_jogoSwitch.isOn)
    {
        _btSalvar.enabled = YES;
        _btSalvar.alpha = 1;
    }
    else
    {
        _btSalvar.enabled = NO;
        _btSalvar.alpha = 0.3;
    }
    
    
    if(_jogoSwitch.isOn)
    {
        _btSetorOption.hidden = NO;
        
        BEEVouNaoVouOption *vouAux = [partidaObj.vouNaoVou objectAtIndex:0];
        vouAux.selected = YES;
        
        vouAux = [partidaObj.vouNaoVou objectAtIndex:1];
        vouAux.selected = NO;
    }
    else
    {
        _btSetorOption.hidden = YES;
        
        BEEVouNaoVouOption *vouAux = [partidaObj.vouNaoVou objectAtIndex:0];
        vouAux.selected = NO;
        
        vouAux = [partidaObj.vouNaoVou objectAtIndex:1];
        vouAux.selected = YES;
    }
}

@end
