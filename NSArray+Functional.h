//
//  NSArray+Functional.h
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (Functional)

- (NSArray *)filterUsingSelector:(SEL)aSelector, ...; // selector returning BOOL
- (NSArray *)mapUsingSelector:(SEL)aSelector, ...; // selector returning id
- (id)reduceUsingSelector:(SEL)aSelector; // selector returning id

@end
