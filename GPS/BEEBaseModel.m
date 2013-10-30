//
//  BEEBaseModel.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/11/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEBaseModel.h"

@implementation BEEBaseModel
@synthesize attrs;

- (NSInteger) ID
{
    return [self returnNSInteger:[attrs objectForKey:@"ID"]];
}

- (NSString *)returnNSString:(id)object
{
    if (object != [NSNull null])
        return object;
    else
    {
        NSString *a;
        return a;
    }
}

- (NSInteger)returnNSInteger:(id)object
{
    if (object != [NSNull null])
        return [object integerValue];
    else
    {
        NSInteger a = 0;
        return a;
    }
}

- (CGFloat)returnCGFloat:(id)object
{
    if (object != [NSNull null])
        return [object floatValue];
    else
    {
        CGFloat a = 0.0;
        return a;
    }
}

- (BOOL)returnBOOL:(id)object
{
    if (object != [NSNull null])
        return [object boolValue];
    else
    {
        BOOL a;
        return a;
    }
}

- (NSDate *)returnNSDate:(id)object withFormat:(NSString *)format
{
    if (object != [NSNull null])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        //[dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
        //[dateFormat setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormat setDateFormat:format];
        return [dateFormat dateFromString:object];
    }
    else
    {
        NSDate *a;
        return a;
    }
}

- (NSDate *)returnNSDate:(id)object
{
    return [self returnNSDate:object withFormat:@"dd-MM-yyyy HH:mm"];
}

- (NSDictionary *)returnNSDictionary:(id)object
{
    if (object != [NSNull null])
        return (NSDictionary *)object;
    else
    {
        NSDictionary *a;
        return a;
    }
}

- (NSArray *)returnNSArray:(id)object
{
    if (object != [NSNull null])
        return (NSArray *)object;
    else
    {
        NSArray *a;
        return a;
    }
}

- (BEEBaseModel *) returnObject:(id)object withType:(Class) type {
    if (object != [NSNull null])
    {
        BEEBaseModel *a = [[type alloc] init];
        a.attrs = (NSDictionary *)object;
        return a;
    }
    else
    {
        BEEBaseModel *a;
        return a;
    }
}


- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:attrs forKey:@"attrs"];
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.attrs = [coder decodeObjectForKey:@"attrs"];
    }
    
    return self; // this is missing in the example above
    
    
}


@end
