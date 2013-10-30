//
//  KBKeyboardHandler.h
//  GameCoderBase
//
//  Created by Mauricio Meirelles on 8/28/13.
//  Copyright (c) 2013 Mauricio Meirelles. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBKeyboardHandlerDelegate;

@interface KBKeyboardHandler : NSObject

- (id)init;

// Put 'weak' instead of 'assign' if you use ARC
@property(nonatomic, assign) id<KBKeyboardHandlerDelegate> delegate;
@property(nonatomic) CGRect frame;

@end

@protocol KBKeyboardHandlerDelegate

- (void)keyboardSizeChanged:(CGSize)delta;

@end