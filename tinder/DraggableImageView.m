//
//  DraggableImageView.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "DraggableImageView.h"

@interface DraggableImageView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (assign, nonatomic) CGPoint originalCenter;
@property (assign, nonatomic) CGFloat radian;
@end

@implementation DraggableImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;

}

-(void) initSubviews {
    UINib *nib = [UINib nibWithNibName:@"DraggableImageView" bundle:nil];
    [nib instantiateWithOwner:self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
}

- (IBAction)onProfilePanned:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    CGPoint velocity = [sender velocityInView:self];

    CGFloat translationX = translation.x;
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = [self.contentView center];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.contentView.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y);
        CGFloat radian = translationX / 5.0 * (M_PI  / 180.0);
        self.contentView.transform = CGAffineTransformMakeRotation(radian);
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (translationX > 50) {
            // move right
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.center = CGPointMake(640, self.originalCenter.y);
            }];
        } else if (translationX < -50) {
            // move left
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.center = CGPointMake(-640, self.originalCenter.y);
            }];
        } else {
            // set back to default position
            [self reset];
        }
    }
    
}

- (void) reset {
    self.contentView.center = self.originalCenter;
    self.contentView.transform = CGAffineTransformMakeRotation( -self.radian );
    self.radian = 0.0;
}


@end
