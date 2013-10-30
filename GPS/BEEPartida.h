//
//  BEEPartida.h
//  GPS
//
//  Created by Mauricio Meirelles on 9/23/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEEPartida : NSObject

@property (strong) NSString *name;
@property (strong) NSString *idJogo;
@property (strong) NSString *cartao;
@property (strong) NSString *campeonatoDataLocal;
@property (strong) NSMutableArray *vouNaoVou;
@property (strong) NSMutableArray *vouSetor;
@property (strong) NSString *linkJogo;
@property (assign) BOOL encerrado;




@end
