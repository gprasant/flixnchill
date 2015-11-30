//
//  NSMutableArray+Stack.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (StackExtension)

- (void) push: (id) object;
- (id) pop;

@end
