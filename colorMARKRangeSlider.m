//
//  colorMARKRangeSlider.m
//  flixnchill
//
//  Created by Alex Lester on 12/10/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "colorMARKRangeSlider.h"

@implementation colorMARKRangeSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setForegroundColor:(UIColor *)newForegroundColor{
	_foregroundColor = newForegroundColor;
	[self setNeedsDisplay];
}

-(void) drawRect: (CGRect) rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
 
	UIColor * netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
 
	CGContextSetFillColorWithColor(context, netflixRed.CGColor);
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	
	CGContextFillRect(context, self.bounds);
}



@end
