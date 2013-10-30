//
//  BEEBaseModel.h
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEEBaseModel : NSObject
{
    NSDictionary *attrs;
}

@property (strong) NSDictionary *attrs;

- (NSInteger) ID;

- (NSString *) returnNSString:(id)object;
- (NSInteger) returnNSInteger:(id)object;
- (CGFloat) returnCGFloat:(id)object;
- (BOOL) returnBOOL:(id)object;
- (NSDate *) returnNSDate:(id)object withFormat:(NSString *)format;
- (NSDate *) returnNSDate:(id)object;
- (NSDictionary *) returnNSDictionary:(id)object;
- (NSArray *) returnNSArray:(id)object;
- (BEEBaseModel *) returnObject:(id)object withType:(Class) type;


- (void)encodeWithCoder:(NSCoder *)coder;
- (id) initWithCoder: (NSCoder *)coder;


@end
