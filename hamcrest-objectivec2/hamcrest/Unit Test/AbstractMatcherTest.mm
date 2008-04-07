#import "AbstractMatcherTest.h"

#import <hamcrest/HCMatcher.h>
#import <hamcrest/HCStringDescription.h>


@implementation AbstractMatcherTest

- (void) assertTrue:(BOOL)condition message:(NSString*)message
                inFile:(const char*)fileName atLine:(int)lineNumber;
{
    if (!condition)
    {
        [self failWithException:[NSException failureInFile: [NSString stringWithUTF8String:fileName]
                                                    atLine: lineNumber
                                           withDescription: message]];
    }
}


- (void) assertFalse:(BOOL)condition message:(NSString*)message
                inFile:(const char*)fileName atLine:(int)lineNumber;
{
    if (condition)
    {
        [self failWithException:[NSException failureInFile: [NSString stringWithUTF8String:fileName]
                                                    atLine: lineNumber
                                           withDescription: message]];
    }
}


- (void) assertMatcher:(id<HCMatcher>)matcher hasTheDescription:(NSString*)expected
                inFile:(const char*)fileName atLine:(int)lineNumber
{
    HCStringDescription* description = [HCStringDescription stringDescription];
    [description appendDescriptionOf:matcher];
    NSString* actual = [description description];
    if (![actual isEqualToString:expected])
    {
        [self failWithException:
                [NSException failureInEqualityBetweenObject: actual
                                                  andObject: expected
                                                     inFile: [NSString stringWithUTF8String:fileName]
                                                     atLine: lineNumber
                                            withDescription: @"Expected description"]];
    }
}


- (id<HCMatcher>) createMatcher
{
    return nil;     // Override in subclass
}


- (void) testIsNilSafe
{
    // Should not crash or throw exception.
    [[self createMatcher] matches:nil];
}


- (void) testCopesWithUnknownTypes
{
    // Should not crash or throw exception.
    [[self createMatcher] matches:[[[NSObject alloc] init] autorelease]];
}

@end
