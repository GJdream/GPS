//
//  BEEDados.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEDados.h"

@implementation BEEDados

- (NSInteger) p2_qtd {
    return [self returnNSInteger:[attrs objectForKey:@"P2_QTD"]];
}

- (NSInteger) p3_qtd {
    return [self returnNSInteger:[attrs objectForKey:@"P3_QTD"]];
}

- (NSInteger) p4_qtd {
    return [self returnNSInteger:[attrs objectForKey:@"P4_QTD"]];
}

- (NSInteger) total_p {
    return 65;
}

- (CGFloat) total {
    return [self returnCGFloat:[attrs objectForKey:@"TOTAL"]];
}

- (NSDate *) data {
    return [self returnNSDate:[attrs objectForKey:@"DATA"]];
}



@end
