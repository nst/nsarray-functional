//
//  UnitTests.m
//  Functional
//
//  Created by Nicolas Seriot on 17.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import "UnitTests.h"
#import "NSArray+Functional.h"
#import "NSString+Cat.h"

@implementation UnitTests

- (void)setUp {
	
}

- (void)tearDown {
	
}

- (void)testFilterEmptyArray {
	NSArray *a = [NSArray array];
	NSArray *b = [a filterUsingSelector:@selector(hasPrefix:), @"a", nil];
	NSArray *c = [NSArray array];
	
	STAssertEqualObjects(b, c, nil);	
}

- (void)testMapEmptyArray {
	NSArray *a = [NSArray array];
	NSArray *b = [a mapUsingSelector:@selector(uppercaseString:), nil];
	NSArray *c = [NSArray array];
	
	STAssertEqualObjects(b, c, nil);	
}

- (void)testFilter {
	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
	NSArray *b = [a filterUsingSelector:@selector(hasPrefix:), @"a", nil];
	NSArray *c = [NSArray arrayWithObjects:@"a", @"ab", @"abc", nil];
	
	STAssertEqualObjects(b, c, nil);
}

- (void)testMap {
	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
	NSArray *b = [a mapUsingSelector:@selector(uppercaseString), nil];
	NSArray *c = [NSArray arrayWithObjects:@"A", @"AB", @"ABC", @"BC", @"C", nil];
	
	STAssertEqualObjects(b, c, nil);
}

- (void)testReduce {
	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
	NSString *s = [a reduceUsingSelector:@selector(stringByAppendingString:)];
	
	STAssertEqualObjects(@"aababcbcc", s, nil);
}

- (void)testMultipleArguments {
	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
	NSArray *b = [a mapUsingSelector:@selector(stringByReplacingOccurrencesOfString:withString:), @"b", @"+", nil];
	NSArray *c = [NSArray arrayWithObjects:@"a", @"a+", @"a+c", @"+c", @"c", nil];
		
	STAssertEqualObjects(b, c, nil);
}

- (void)testArgumentTypes {
	NSArray *a1 = [NSArray arrayWithObject:@"xxx"];
	NSArray *a2;
	char* ptr = "asd";
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForBool:), YES, nil];
	STAssertEqualObjects(@"1", [a2 lastObject], nil);
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForInt:), -12, nil];
	STAssertEqualObjects(@"-12", [a2 lastObject], nil);

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForFloat:), (float)-12.345678, nil];
	STAssertEqualObjects(@"-12.345678", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForDouble:), (double)-12.345678, nil];
	STAssertEqualObjects(@"-12.345678", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForSelector:), @selector(foo:bar:), nil];
	STAssertEqualObjects(@"foo:bar:", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForChar:), (char)'x', nil];
	STAssertEqualObjects(@"x", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForShort:), (short)-123, nil];
	STAssertEqualObjects(@"-123", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForCppBool:), (bool)1, nil];
	STAssertEqualObjects(@"1", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForUChar:), (unsigned char)'x', nil];
	STAssertEqualObjects(@"x", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForUShort:), (unsigned short)123, nil];
	STAssertEqualObjects(@"123", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForLong:), (NSInteger)123456789, nil];
	STAssertEqualObjects(@"123456789", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForLongLong:), (long long)1234567890123, nil];
	STAssertEqualObjects(@"1234567890123", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForUInt:), (unsigned int)123, nil];
	STAssertEqualObjects(@"123", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForULong:), (unsigned long)123, nil];
	STAssertEqualObjects(@"123", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForULongLong:), (unsigned long long)123, nil];
	STAssertEqualObjects(@"123", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForObject:), @"asd", nil];
	STAssertEqualObjects(@"asd", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForClass:), [NSObject class], nil];
	STAssertEqualObjects(@"NSObject", [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForNSInteger:), (NSInteger)-123, nil];
	STAssertEqualObjects(@"-123", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForNSUInteger:), (NSUInteger)123, nil];
	STAssertEqualObjects(@"123", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForCGFloat:), (CGFloat)-123.45, nil];
	STAssertEqualObjects(@"-123.45", [a2 lastObject], @"");

	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForCharPtr:), ptr, nil];
	STAssertEqualObjects(@"asd", [a2 lastObject], @"");	
	
	a2 = [a1 mapUsingSelector:@selector(stringRepresentationForPointer:), ptr, nil];
	NSString *s = [NSString stringWithFormat:@"%p", ptr];
	STAssertEqualObjects(s, [a2 lastObject], @"");
	
	a2 = [a1 mapUsingSelector:@selector(arrayWithStringRepresentationsForBool:string:charPtr:aFloat:aDouble:),
		  YES, @"asd", "sdf", (float)-1.2, (double)-3.4, nil];
	STAssertEqualObjects(@"1 asd sdf -1.200000 -3.400000", [a2 lastObject], nil);
	
	BOOL exceptionWasRaised = NO;
	@try {
		a2 = [a1 mapUsingSelector:@selector(stringByReplacingCharactersInRange:withString:), NSMakeRange(0, 1), @"*", nil];
	} @catch (NSException *e) {
		exceptionWasRaised = YES;
	}
	STAssertEquals(YES, exceptionWasRaised, @"");
}

@end
