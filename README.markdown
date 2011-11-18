Map, filter and reduce in Objective-C/Cocoa
-------------------------------------------

This is a category to add Python like map, filter and reduce methods to Cocoa NSArray:

    @interface NSArray (Functional)
    
    - (NSArray *)filterUsingSelector:(SEL)aSelector, ...;
    - (NSArray *)mapUsingSelector:(SEL)aSelector, ...;
    - (id)reduceUsingSelector:(SEL)aSelector;
    
    @end

You can then program in functional style:

    NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];
    
    NSArray *x = [a filterUsingSelector:@selector(hasPrefix:), @"a", nil];
    NSArray *y = [a mapUsingSelector:@selector(uppercaseString), nil];
    NSArray *z = [a reduceUsingSelector:@selector(stringByAppendingString:)];

Results:

    x: (a, ab, abc)
    y: (A, AB, ABC, BC, C)
    z: aababcbcc

---

#### Functional style programming with Cocoa NSArray

When programming in Objective-C, I often miss functions like `map()`, `filter()` and `reduce()`, as they exist in Python.

When you think about it, there is no need to wait the upcoming "blocks" in Snow Leopard. It is already possible to do this on Mac OS X 10.5, 10.4 and probably below, thanks to [NSInvocation](http://developer.apple.com/documentation/Cocoa/Reference/Foundation/Classes/nsinvocation_Class/Reference/Reference.html) and variable length arguments lists.

Here is a neat NSArray category to do this properly: [nsarray-functional](http://github.com/nst/nsarray-functional).

Your [comments](http://seriot.ch/contact.php) are welcome.

#### Functional programming in Python

In Python, `map()`, `filter()` and `reduce()` are normally used with lambda functions, ie anonymous functions:

    >>> l = ['a', 'ab', 'abc', 'bc', 'c']
    
    >>> filter(lambda x:x.startswith('a'), l)
    ['a', 'ab', 'abc']
    
    >>> map(lambda x:x.upper(), l)
    ['A', 'AB', 'ABC', 'BC', 'C']
    
    >>> reduce(lambda x,y:x+y, l)
    aababcbcc

#### When Objective-C will have blocks

Apple has added a new syntax to C allowing to write anonymous functions with "blocks". Blocks will be available in Snow Leopard and allow passing blocks as arguments to methods, so that we can easily implement and call `-[NSArray map:]` and `-[NSArray filter:]` methods.

    l = [l map:^(id obj){ return [obj uppercaseString]; }];
    l = [l filter:^(id obj){ return [obj hasPrefix:@"a"]; }];

#### NSArray filtering with NSPredicate

[NSPredicate can already filter](http://developer.apple.com/documentation/Cocoa/Conceptual/Predicates/predicates.html) an [NSArray](http://developer.apple.com/DOCUMENTATION/Cocoa/Reference/Foundation/Classes/NSArray_Class/Reference/Reference.html), using [Key-Value Coding](http://developer.apple.com/documentation/Cocoa/Conceptual/KeyValueCoding/KeyValueCoding.html):

	NSPredicate *p = [NSPredicate predicateWithFormat: @"SELF beginswith 'a'"];
	NSLog(@"-- p: %@", [a filteredArrayUsingPredicate:p]);

Unfortunately, NSPredicate is not part of iPhone SDK.

#### NSArray "mapping" with makeObjectsPerformSelector:

The following methods exists on NSArray:

	-(void)makeObjectsPerformSelector:(SEL)aSelector;
	-(void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)anObject;

Unfortunately, this is not mapping as we mean it in Python, because:

- it doesn't return anything
- it should not modify the receiver
- it prevents using selectors with primitive type argument or several arguments

#### A 'Functional' category to NSArray

The following category provides filter, map and reduce to NSArray:

    @interface NSArray (Functional)
    - (NSArray *)filterUsingSelector:(SEL)aSelector, ...; // selector returning BOOL
    - (NSArray *)mapUsingSelector:(SEL)aSelector, ...;    // selector returning id
    - (id)reduceUsingSelector:(SEL)aSelector;             // selector returning id
    @end

You can then program in functional style:

	NSArray *a = [NSArray arrayWithObjects:@"a", @"ab", @"abc", @"bc", @"c", nil];

	NSArray *x = [a filterUsingSelector:@selector(hasPrefix:), @"a", nil];
	NSArray *y = [a mapUsingSelector:@selector(uppercaseString), nil];
	id z = [a reduceUsingSelector:@selector(stringByAppendingString:)];

Results:

	x: (a, ab, abc)
	y: (A, AB, ABC, BC, C)
	z: aababcbcc

We can also perform custom selectors, by implementing them in categories on the classes of the objects that are in the array. Notice that we can use privitive types arguments.

    NSArray *f = [a filterUsingSelector:@selector(isLongerThan:), 1, nil]);

    f: (ab, abc, ab)

Purists are free to rename these methods according to Cocoa conventions:

    -arrayByFilteringArrayUsingSelector:
    -arrayByMappingArrayUsingSelector:
    -objectByReducingArrayUsingSelector:

#### Implementation

NSArray+Functional does not need any NSProxy subclass. No trampoline object needed. Basically, `filterUsingSelector:` and `mapUsingSelector:` will fill an NSMutableArray according to the result of the invocation of the selector with its parameters on each object in the array, when `reduceUsingSelector:` is trivial.

#### Trampolines

Another way to achieve this so-called [High Order Messaging](http://cocoadev.com/index.pl?HigherOrderMessaging) is using sophisticated trampolines that allow writing beautiful code like this:

    NSArray *a = [[array select] hasPrefix:@"a"]; // filter
    NSArray *b = [[array reject] hasSuffix:@"z"];
    NSArray *c = [[array collect] stringByAppendingString:@"_"]; // map

Still I have yet to find a simple implementation that I like and that does not use private methods. The last thing I want is a relying on classes which can break at any time.

_[2009-01-17] Marcel Weiher answered to my complain by publishing a short, clean and clear HOM implementation: [Simple HOM](http://www.metaobject.com/blog/2009/01/simple-hom.html)._

#### A word on Python 3.0

Python 3.0 dropped map(), filter() and reduce(). Guido van Rossum [explains](http://www.artima.com/weblogs/viewpost.jsp?thread=98196) why he prefers the new syntax:

    filter(lambda x:x.startswith('a'), l) # old
    [x for x in l if x.startswith('a')]   # new
