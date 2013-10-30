//
//  BEEManager.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "BEEDados.h"
#import "BEEPhotos.h"
#import "BEEMensagens.h"
#import "BEEPartida.h"
#import "Element.h"
#import "DocumentRoot.h"
#import "BEEVouNaoVouOption.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface BEEManager : NSObject
{
    NSMutableData       *responseData;
    NSURLConnection     *conn;
}

@property (strong) NSOperationQueue *queue;

@property (strong) NSMutableArray *optionsArray;


+ (BEEManager *)singleton;

- (void)ListaDados:(void (^)(BEEDados *dados)) sucesso
               erro:(void (^)(int error)) erro;

- (void)savePushUser:(NSString *) pushId;

- (void)ListaPhotos:(void (^)(NSMutableDictionary *dados)) sucesso
              erro:(void (^)(int error)) erro;


- (void)CheckVideo:(void (^)(BOOL isOnline)) sucesso
              erro:(void (^)(int error)) erro
           withUrl:(NSString *)strUrl;

- (void)ListaMensagens:(void (^)(NSMutableArray *mensagens)) sucesso
                  erro:(void (^)(int error)) erro;

- (void)loginSimplesSocioInter:(void (^)(int isSucesso)) retorno
                 withMatricula: (NSString *)matricula
                      andSenha: (NSString *)senha;

- (void)loginSocioInter:(void (^)(NSMutableArray *dados)) sucesso
                   erro:(void (^)(int error)) erro;

- (void)getCheckIns:(void (^)(NSMutableArray *dados)) sucesso
               erro:(void (^)(int error)) erro
           linkJogo:(NSString *) strLinkJogo;

- (void)checkinSocio:(void (^)(int isSucesso)) retorno
         withPartida:(BEEPartida *) partidaObj;

@end
