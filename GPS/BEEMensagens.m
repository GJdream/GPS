//
//  BEEMensagens.m
//  GPS
//
//  Created by Mauricio Meirelles on 9/2/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEMensagens.h"

@implementation BEEMensagens

- (NSString *) msg {
    return [self returnNSString:[attrs objectForKey:@"MSG"]];
}


- (NSDate *) data {
    return [self returnNSDate:[attrs objectForKey:@"DATA"]];
}

@end
