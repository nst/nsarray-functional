#import <Foundation/Foundation.h>
#import "NSArray+Functional.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
		
	NSLog(@"-- f1: %@", [a filterUsingSelector:@selector(hasPrefix:), @"a", nil]);
	
	NSLog(@"-- m1: %@", [a mapUsingSelector:@selector(uppercaseString), nil]);
	
	NSLog(@"-- m2: %@", [a mapUsingSelector:@selector(stringByReplacingOccurrencesOfString:withString:), @"b", @"+", nil]);
	
	NSLog(@"-- r1: %@", [a reduceUsingSelector:@selector(stringByAppendingString:)]);
	
	[pool drain];
	 
    return 0;
}
