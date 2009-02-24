//
//  NSInvocation+Functional.m
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import "NSInvocation+Functional.h"


@implementation NSInvocation (Functional)

+ (NSInvocation *)invocationUsingSelector:(SEL)aSelector onTarget:(id)target argumentList:(va_list)argumentList {
	NSAssert2([target respondsToSelector:aSelector], @"object %@ does not respond to selector %@", target, NSStringFromSelector(aSelector));
	
	NSMethodSignature *sig = [target methodSignatureForSelector:aSelector];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
	[invocation setSelector:aSelector];
	
	const char* argType;
	NSUInteger i;
	NSUInteger argc = [sig numberOfArguments];
	
	for(i = 2; i < argc; i++) { // self and _cmd are at index 0 and 1
		
		argType = [sig getArgumentTypeAtIndex:i];
		
		if(!strcmp(argType, @encode(id))) {
			id arg = va_arg(argumentList, id);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(SEL))) {
			SEL arg = va_arg(argumentList, SEL);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(Class))) {
			Class arg = va_arg(argumentList, Class);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(char))) {
			char arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(unsigned char))) {
			unsigned char arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(int))) {
			int arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(bool))) {
			bool arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(BOOL))) {
			BOOL arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];			
		} else if(!strcmp(argType, @encode(short))) {
			short arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(unichar))) {
			unichar arg = va_arg(argumentList, int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(float))) {
			float arg = va_arg(argumentList, double);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(double))) {
			double arg = va_arg(argumentList, double);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(long))) {
			long arg = va_arg(argumentList, long);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(long long))) {
			long long arg = va_arg(argumentList, long long);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(unsigned int))) {
			unsigned int arg = va_arg(argumentList, unsigned int);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(unsigned long))) {
			unsigned long arg = va_arg(argumentList, unsigned long);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(unsigned long long))) {
			unsigned long long arg = va_arg(argumentList, unsigned long long);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(char*))) {
			char* arg = va_arg(argumentList, char*);
			[invocation setArgument:&arg atIndex:i];
		} else if(!strcmp(argType, @encode(void*))) {
			void* arg = va_arg(argumentList, void*);
			[invocation setArgument:&arg atIndex:i];
		} else {
			NSAssert1(NO, @"-- Unhandled type: %s", argType);
		}
	}
	
	return invocation;
}

@end
