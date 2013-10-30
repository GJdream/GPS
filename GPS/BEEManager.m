//
//  BEEManager.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEManager.h"


@implementation BEEManager

@synthesize queue;

+ (BEEManager *)singleton {
    static BEEManager *instance;
    
    if (instance == nil)
        instance = [[BEEManager alloc] init];
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

#pragma mark Conexão com o Servidor

- (void)conexaoServico:(NSString *) servico
                 dados:(NSString *) dados
                metodo:(NSString *) metodo
               sucesso:(void (^)(NSData *data)) sucesso
                  erro:(void (^)(int error)) erro
{

    [queue addOperationWithBlock:^{
        
//        if([self checkInternet])
//        {
            NSError *err = nil;
            
            NSURL *target = [NSURL URLWithString:servico];

            NSLog(@"Conexão: %@",target);
            
            if (dados)
                NSLog(@"Dados: %@",dados);
            
            NSMutableURLRequest* urlReq = [[NSMutableURLRequest alloc] initWithURL:target];
            [urlReq setTimeoutInterval:75];
            
            [urlReq setHTTPMethod:metodo];
            [urlReq setHTTPBody:[dados dataUsingEncoding:NSUTF8StringEncoding]];
        
            NSURLResponse *response;
            NSData *data = [NSURLConnection sendSynchronousRequest:urlReq returningResponse:&response error:&err];
            
            if (data)
            {
                NSString *resposta = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSLog(@"Resposta do servidor: %@", resposta);
                

                NSString *strUrlResp = [response.URL absoluteString];
                
                if([strUrlResp rangeOfString:@"encontrada"].location != NSNotFound)
                {
                    sucesso([@"M" dataUsingEncoding:NSUTF8StringEncoding]);
                }
                else if([[[response.URL absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"senha"].location != NSNotFound)
                {
                    sucesso([@"S" dataUsingEncoding:NSUTF8StringEncoding]);
                }
                else
                {
                  sucesso(data);
                }
                
                
            } else {
                NSString *log = [NSString stringWithFormat:@"Erro: %@",err.localizedDescription];
                NSLog(@"%@",log);
                if ([err.localizedDescription isEqualToString:@"The request timed out."])
                    erro(98);
                else
                    erro(2);
            }
//        }
//        else
//        {
//            erro(98);
//        }
    }];

}




- (void)ListaDados:(void (^)(BEEDados *dados)) sucesso
              erro:(void (^)(int error)) erro
{
    NSString *url = @"http://api.gps.beelieve.com.br/dados/";
    
    [self conexaoServico:url
                   dados:nil
                  metodo:@"GET"
                 sucesso:^(NSData *data) {
                     JSONDecoder* decoder = [[JSONDecoder alloc]
                                             initWithParseOptions:JKParseOptionPermitTextAfterValidJSON];
                     
                     BEEDados *objDados;
                     
                     id obj = [decoder objectWithData:data];
                     if ([obj isKindOfClass:[NSArray class]]) {
                         NSArray *obj2 = obj;
                         for (int i = 0; i < obj2.count; i++)
                         {
                             objDados = [[BEEDados alloc] init];
                             objDados.attrs = [obj2 objectAtIndex:i];
                             
                         }
 
                         NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                         [currentDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject: objDados] forKey:@"gpsDados2"];
                         [currentDefaults synchronize];
    
                         
                         sucesso(objDados);
                     } else {
                         erro(99);
                     }
                 } erro:^(int error) {
                     erro(error);
                 }];
}

- (void)checkinSocio:(void (^)(int isSucesso)) retorno
         withPartida:(BEEPartida *) partidaObj
{
    NSString *url = @"http://www.internacional.com.br/socios/checkincolorado_res.php";
    
    
    //    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    //    NSString *strMatricula = (NSString *)[currentDefaults objectForKey:@"socioMatricula"];
    //    NSString *strSenha = (NSString *)[currentDefaults objectForKey:@"socioSenha"];
    
    
    BEEVouNaoVouOption *vouSwitch = [partidaObj.vouNaoVou objectAtIndex:0];
    
    if(!vouSwitch.selected)
        vouSwitch = [partidaObj.vouNaoVou objectAtIndex:1];
    
    
    BEEVouNaoVouOption *optSelected;
    
    for(BEEVouNaoVouOption *optAux in partidaObj.vouSetor)
    {
        if(optAux.selected)
        {
            optSelected = optAux;
            break;
        }
    }
    
    
    NSString *params = [[NSString alloc] initWithFormat:@"id_jogo=%@&cartao=%@&opcao=%d&setor=%d", partidaObj.idJogo,partidaObj.cartao,vouSwitch.value,optSelected.value ];
    
    //    NSString *params = @"matricula=41784006&senha=536000";
    
    NSLog(@"Login - URL: %@",url);
    NSLog(@"Login - PARAMS: %@",params);
    
    [self conexaoServico:url
                   dados:params
                  metodo:@"POST"
                 sucesso:^(NSData *data) {
                     NSString *resposta = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                     
//                     if ([resposta isEqualToString:@"M"])
//                     {
//                         retorno(1);
//                     }
//                     else if ([resposta isEqualToString:@"S"])
//                     {
//                         retorno(2);
//                     }
//                     else
//                     {
                         retorno(0);
//                     }
                     
                     
                     
                 } erro:^(int error) {
                     retorno(0);
                 }];
    
}



- (void)loginSimplesSocioInter:(void (^)(int isSucesso)) retorno
                 withMatricula: (NSString *)matricula
                      andSenha: (NSString *)senha
{
    NSString *url = @"http://www.internacional.com.br/socios/logar.php";
    
    
//    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
//    NSString *strMatricula = (NSString *)[currentDefaults objectForKey:@"socioMatricula"];
//    NSString *strSenha = (NSString *)[currentDefaults objectForKey:@"socioSenha"];
    
    
    NSString *params = [[NSString alloc] initWithFormat:@"matricula=%@&senha=%@", matricula,senha];
    
    //    NSString *params = @"matricula=41784006&senha=536000";
    
    NSLog(@"Login - URL: %@",url);
    NSLog(@"Login - PARAMS: %@",params);
    
    [self conexaoServico:url
                   dados:params
                  metodo:@"POST"
                 sucesso:^(NSData *data) {
                     NSString *resposta = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                     
                     if ([resposta isEqualToString:@"M"])
                     {
                         retorno(1);
                     }
                     else if ([resposta isEqualToString:@"S"])
                     {
                         retorno(2);
                     }
                     else
                     {
                         retorno(0);
                     }

                     
  
                 } erro:^(int error) {
                     retorno(3);
                 }];
    
}


- (void)loginSocioInter:(void (^)(NSMutableArray *dados)) sucesso
                   erro:(void (^)(int error)) erro
{
    NSString *url = @"http://www.internacional.com.br/socios/logar.php";
    
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *strMatricula = (NSString *)[currentDefaults objectForKey:@"socioMatricula"];
    NSString *strSenha = (NSString *)[currentDefaults objectForKey:@"socioSenha"];
    

    NSString *params = [[NSString alloc] initWithFormat:@"matricula=%@&senha=%@", strMatricula,strSenha];
    
//    NSString *params = @"matricula=41784006&senha=536000";
    
    NSLog(@"Login - URL: %@",url);
    NSLog(@"Login - PARAMS: %@",params);
    
    [self conexaoServico:url
                   dados:params
                  metodo:@"POST"
                 sucesso:^(NSData *data) {
                     
                     
                     [self getCheckIns:^(NSMutableArray *dados)
                      {
                          sucesso(dados);
                          
                      } erro:^(int error) {
                          erro(error);
                      } linkJogo:@""];
                     
                     
                     
                 } erro:^(int error) {
                     
                     erro(error);
                 }];
    
}


- (void)getCheckIns:(void (^)(NSMutableArray *dados)) sucesso
               erro:(void (^)(int error)) erro
           linkJogo:(NSString *) strLinkJogo
{
    
    NSString *url = @"http://www.internacional.com.br/socios/checkincolorado.php";
    
    if(![strLinkJogo isEqualToString:@""])
    {
        url  = [NSString stringWithFormat:@"%@?%@", url,strLinkJogo];
    }
    
    [self conexaoServico:url
                   dados:nil
                  metodo:@"GET"
                 sucesso:^(NSData *data) {
                     
                     NSString *resposta = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

                     
                     //Get array checkins
                     
                     DocumentRoot* document = [Element parseHTML: resposta];
                     
                     
                     NSArray* elements = [document selectElements: @"td.SOCIO_destaque_titulo"];
                     NSMutableArray* partidasArray = [NSMutableArray array];
                     
                     for (Element* element in elements){
                         
                         BEEPartida *partida = [[BEEPartida alloc] init];
                         
                         //SOCIO_destaque_titulo
                         Element *nomePartida = [element selectElement:@"strong"];
                         partida.name = nomePartida.contentsText;
                         
                         //SOCIO_destaque_titulo2
                         Element *campDatLocal = [element selectElement:@"span.SOCIO_texto_destaque_titulo2"];
                         partida.campeonatoDataLocal = campDatLocal.contentsText;
                         
                         
                         //SOCIO_destaque_titulo2
                         NSArray *vouNaoVouArray = [element selectElements:@"select.associacao_input"];
                         
                         for(Element *vouNaoVouElement in vouNaoVouArray)
                         {
                             
                             if([[vouNaoVouElement.attributes objectForKey:@"name"] isEqualToString:@"opcao"])
                             {
                                 NSMutableArray *vouNaoVouOptions = [NSMutableArray array];
                                 
                                 for(Element *vouNaoVouChild in vouNaoVouElement.childElements)
                                 {
                                     BEEVouNaoVouOption *opt = [[BEEVouNaoVouOption alloc] init];
                                     
                                     opt.name = vouNaoVouChild.contentsText;
                                     opt.value = [[vouNaoVouChild.attributes objectForKey:@"value"] intValue];
                                     
                                     if([vouNaoVouChild.attributes objectForKey:@"selected"])
                                     {
                                         opt.selected = YES;
                                     }
                                     else
                                     {
                                         opt.selected = NO;
                                     }
                                     
                                     [vouNaoVouOptions addObject:opt];

                                 }

                                 partida.vouNaoVou = vouNaoVouOptions;

                             }
                             else
                             {
                                 
                                 NSMutableArray *vouSetorArray = [NSMutableArray array];
                                 
                                 for(Element *vouNaoVouChild in vouNaoVouElement.childElements)
                                 {
                                     BEEVouNaoVouOption *opt = [[BEEVouNaoVouOption alloc] init];
                                     
                                     opt.name = vouNaoVouChild.contentsText;
                                     opt.value = [[vouNaoVouChild.attributes objectForKey:@"value"] intValue];
                                     
                                     if([vouNaoVouChild.attributes objectForKey:@"selected"])
                                     {
                                         opt.selected = YES;
                                     }
                                     else
                                     {
                                         opt.selected = NO;
                                     }
                                     
                                     [vouSetorArray addObject:opt];
                                     
                                 }
                                 
                                 partida.vouSetor = vouSetorArray;
                                 
                             }
  
                         }
                         
                         //linkMapaCheckin
                         Element *urlJogo = [element selectElement:@"a.linkMapaCheckin"];
                         partida.linkJogo = [[[urlJogo.attributes objectForKey:@"href"] componentsSeparatedByString:@"?"] objectAtIndex:1];

                         
                         //linkMapaCheckin
                         NSArray *itemsJogo = [element selectElements:@"input"];
                         
                         if(itemsJogo.count > 2)
                         {
                             Element *jogoId = [itemsJogo objectAtIndex:0];
                             partida.idJogo = [jogoId.attributes objectForKey:@"value"];
                             
                             Element *cartaoId = [itemsJogo objectAtIndex:1];
                             partida.cartao = [cartaoId.attributes objectForKey:@"value"];
                         }
                         
                         //Encerrado Check-In?
                          if([resposta rangeOfString:@"do site foi finalizado"].location != NSNotFound)
                            partida.encerrado = YES;
                         else
                            partida.encerrado = NO;

                         
                         if(partida.name.length > 0)
                             [partidasArray addObject: partida];
                     }
                     
                     sucesso(partidasArray);


                 } erro:^(int error) {
                     erro(error);
                 }];
}





- (void)savePushUser:(NSString *) pushId
{
    NSString *url = @"http://api.gps.beelieve.com.br/addUser/";
    
    NSString *params = [[NSString alloc] initWithFormat:@"PUSH_USER=%@", pushId];
    
    NSLog(@"Login - URL: %@",url);
    NSLog(@"Login - PARAMS: %@",params);
    
    [self conexaoServico:url
                   dados:params
                  metodo:@"POST"
                 sucesso:^(NSData *data) {
                 } erro:^(int error) {
                 }];

}


- (void)ListaPhotos:(void (^)(NSMutableDictionary *dados)) sucesso
              erro:(void (^)(int error)) erro
{

    NSDictionary *dicUrl = [[NSDictionary alloc] initWithObjectsAndKeys:@"https://graph.facebook.com/440161216030719/photos?fields=source,name", @"Obras Beira Rio", @"https://graph.facebook.com/566217323417523/photos?fields=source,name",@"Colorados no Instagram",@"https://graph.facebook.com/180677965304796/photos?fields=source,name",@"Timeline do Inter", nil];

    
    
    NSMutableDictionary *dictFotos = [[NSMutableDictionary alloc] init];
    
    
    [queue addOperationWithBlock:^{
        
        for (int i =0; i<dicUrl.allKeys.count; i++)
        {
            
        
            //        if([self checkInternet])
            //        {
            NSError *err = nil;
            
            NSURL *target = [NSURL URLWithString:[dicUrl objectForKey:[dicUrl.allKeys objectAtIndex:i]]];
            
            
            NSMutableURLRequest* urlReq = [[NSMutableURLRequest alloc] initWithURL:target];
            [urlReq setTimeoutInterval:75];
            
            [urlReq setHTTPMethod:@"GET"];
//            [urlReq setHTTPBody:[dados dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSData *data = [NSURLConnection sendSynchronousRequest:urlReq returningResponse:nil error:&err];
            
            if (data)
            {
                NSString *resposta = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSLog(@"Resposta do servidor: %@", resposta);
                JSONDecoder* decoder = [[JSONDecoder alloc]
                                        initWithParseOptions:JKParseOptionPermitTextAfterValidJSON];
                
                NSMutableArray *objPhotosArray = [[NSMutableArray alloc] init];
                
                id obj2 = [decoder objectWithData:data];
                id obj = [obj2 objectForKey:@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSArray *obj2 = obj;
                    for (int i = 0; i < obj2.count; i++)
                    {
                        BEEPhotos *objPhotos = [[BEEPhotos alloc] init];
                        objPhotos.attrs = [obj2 objectAtIndex:i];
                        
                        [objPhotosArray addObject:objPhotos];
                    }
                    
                    [dictFotos setObject:objPhotosArray forKey:[dicUrl.allKeys objectAtIndex:i]];
                }

            }
        }
        sucesso(dictFotos);
    }];
      
            

}





- (void)CheckVideo:(void (^)(BOOL isOnline)) sucesso
               erro:(void (^)(int error)) erro
            withUrl:(NSString *)strUrl
{
    
    
    [queue addOperationWithBlock:^{
        
        BOOL isOnline = YES;
        
        
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
        
        [request setHTTPMethod:@"GET"];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        NSData *data1= [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
        if([data1 length]<120 ) // Here i atempt to define a min. size to verify if streaming is active.
        {
            isOnline = NO;
            
        }
        
        sucesso(isOnline);

        
    }];
    
 
}



- (void)ListaMensagens:(void (^)(NSMutableArray *mensagens)) sucesso
                  erro:(void (^)(int error)) erro
{
    NSString *url = @"http://api.gps.beelieve.com.br/mensagens/";
    
    [self conexaoServico:url
                   dados:nil
                  metodo:@"GET"
                 sucesso:^(NSData *data) {
                     JSONDecoder* decoder = [[JSONDecoder alloc]
                                             initWithParseOptions:JKParseOptionPermitTextAfterValidJSON];
                                          
                     id obj = [decoder objectWithData:data];
                     if ([obj isKindOfClass:[NSArray class]]) {
                         
                         NSMutableArray *mensagensArray = [[NSMutableArray alloc] init];
                         
                         NSArray *obj2 = obj;
                         for (int i = 0; i < obj2.count; i++)
                         {
                             BEEMensagens *objMsg = [[BEEMensagens alloc] init];
                             objMsg.attrs = [obj2 objectAtIndex:i];
                             
                             [mensagensArray addObject:objMsg];
                             
                         }
                         
                         NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                         [currentDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject: mensagensArray] forKey:@"gpsMensagens"];
                         [currentDefaults synchronize];
                         
                         
                         sucesso(mensagensArray);
                     } else {
                         erro(99);
                     }
                 } erro:^(int error) {
                     erro(error);
                 }];
}



@end
