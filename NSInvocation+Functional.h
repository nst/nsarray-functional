//
//  NSInvocation+Functional.h
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSInvocation (Functional)

+ (NSInvocation *)invocationUsingSelector:(SEL)aSelector onTarget:(id)target argumentList:(va_list)argumentList;

@end
