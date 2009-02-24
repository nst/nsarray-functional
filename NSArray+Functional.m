//
//  NSArray+Functional.m
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import "NSArray+Functional.h"
#import "NSInvocation+Functional.h"

@implementation NSArray (Functional)

- (NSArray *)mapUsingSelector:(SEL)aSelector, ... {
	if (!aSelector) return nil;
	if (![self lastObject]) return [NSArray array];
	
	va_list argumentList;
	va_start(argumentList, aSelector);
	NSInvocation *invocation = [NSInvocation invocationUsingSelector:aSelector onTarget:[self lastObject] argumentList:argumentList];
	va_end(argumentList);
	
	NSMutableArray *a = [NSMutableArray array];
	id ret;
	for(id o in self) {
		[invocation invokeWithTarget:o];
		[invocation getReturnValue:&ret];
		
		[a addObject:ret?ret:[NSNull null]];
	}
	return a;
}

- (NSArray *)filterUsingSelector:(SEL)aSelector, ... {
	if (!aSelector) return nil;
	if (![self lastObject]) return [NSArray array];
	
	va_list argumentList;
	va_start(argumentList, aSelector);
	NSInvocation *invocation = [NSInvocation invocationUsingSelector:aSelector onTarget:[self lastObject] argumentList:argumentList];
	va_end(argumentList);
	
	NSMutableArray *a = [NSMutableArray array];
	BOOL ret;
	for(id o in self) {
		[invocation invokeWithTarget:o];
		[invocation getReturnValue:&ret];
		
		if(ret) {
			[a addObject:o];
		}
	}
	return a;
}

- (id)reduceUsingSelector:(SEL)aSelector {
	NSAssert1([self count] > 0, @"array is empty: %@", self);
	
	id result = [self objectAtIndex:0];
	
	int i;
	for(i = 1; i < [self count]; i++) {
		result = [result performSelector:aSelector withObject:[self objectAtIndex:i]];
	}
	
	return result;
}

@end
