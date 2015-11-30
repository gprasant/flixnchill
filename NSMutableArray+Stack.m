//
//  NSMutableArray+Stack.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (StackExtension)

- (void) push:(id)object {
    [self addObject:object];
}

- (id) pop {
    id lastObject = [self lastObject];
    if (lastObject) {
        [self removeLastObject];
    }
    return lastObject;
}

@end
