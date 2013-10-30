//
//  BEEPhotos.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEPhotos.h"

@implementation BEEPhotos

- (NSString *) picture {
    return [self returnNSString:[attrs objectForKey:@"picture"]];
}

- (NSString *) source {
    return [self returnNSString:[attrs objectForKey:@"source"]];
}

- (NSString *) name {
    return [self returnNSString:[attrs objectForKey:@"name"]];
}

- (CGFloat) height {
    return [self returnCGFloat:[attrs objectForKey:@"height"]];
}

- (CGFloat) width {
    return [self returnCGFloat:[attrs objectForKey:@"width"]];
}


@end
