//
//  OCHamcrest - HCHasCount.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

#import "HCHasCount.h"

#import "HCDescription.h"
#import "HCIsEqualToNumber.h"


@implementation HCHasCount

+ (id)hasCount:(id<HCMatcher>)matcher
{
    return [[[self alloc] initWithCount:matcher] autorelease];
}

- (id)initWithCount:(id<HCMatcher>)matcher
{
    self = [super init];
    if (self)
        countMatcher = [matcher retain];
    return self;
}

- (void)dealloc
{
    [countMatcher release];
    [super dealloc];
}

- (BOOL)matches:(id)item
{
    if (![item respondsToSelector:@selector(count)])
        return NO;
    
    NSNumber *count = [NSNumber numberWithUnsignedInteger:[item count]];
    return [countMatcher matches:count];
}

- (void)describeMismatchOf:(id)item to:(id<HCDescription>)mismatchDescription
{
    [super describeMismatchOf:item to:mismatchDescription];
    
    if ([item respondsToSelector:@selector(count)])
    {
        NSNumber *count = [NSNumber numberWithUnsignedInteger:[item count]];
        [[mismatchDescription appendText:@" with count of "] appendDescriptionOf:count];
    }
}

- (void)describeTo:(id<HCDescription>)description
{
    [[description appendText:@"a collection with count of "] appendDescriptionOf:countMatcher];
}

@end


#pragma mark -

OBJC_EXPORT id<HCMatcher> HC_hasCount(id<HCMatcher> matcher)
{
    return [HCHasCount hasCount:matcher];
}

OBJC_EXPORT id<HCMatcher> HC_hasCountOf(NSUInteger value)
{
    return HC_hasCount(HC_equalToUnsignedInteger(value));
}
