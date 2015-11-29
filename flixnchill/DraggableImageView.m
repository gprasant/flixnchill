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
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nopeLabel;

@property (assign, nonatomic) CGPoint originalCenter;
@property (assign, nonatomic) CGFloat radian;

@end

@implementation DraggableImageView

CGFloat _20_DEGREES = 0.111 * M_PI;


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
    // add border
//    self.contentView.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.contentView.layer.borderWidth = 1.0f;
    self.originalCenter = [self.contentView center];
    [self addSubview:self.contentView];
    // Hide the like and nope initially
    self.likeLabel.alpha = self.nopeLabel.alpha = 0.0;
    self.likeLabel.transform = CGAffineTransformMakeRotation( -_20_DEGREES );
    self.nopeLabel.transform = CGAffineTransformMakeRotation( _20_DEGREES );
}

- (IBAction)onCardPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];

    CGFloat translationX = translation.x;
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.contentView.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y + translation.y);
        CGFloat radian = translationX / 5.0 * (M_PI  / 180.0);
        self.contentView.transform = CGAffineTransformMakeRotation(radian);
        // show like and nope labels
        if (translationX > 0) {
            self.likeLabel.alpha = translationX * 0.01;
        } else if (translationX < 0) {
            self.nopeLabel.alpha = -(translationX * 0.01);
        }
    
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (translationX > 100) {
            [self swipeRight];
        } else if (translationX < -100) {
            [self swipeLeft];
        } else {
            // set back to default position
            [self reset];
        }
    }
    
}

- (void) swipeLeft {
    // swipe left
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = CGPointMake(-640, self.originalCenter.y);
    }];
}

-(void) swipeRight {
    // swipe right
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = CGPointMake(640, self.originalCenter.y);
    }];
}

- (void) reset {
    // center the image and display it in line with the device frame
    self.contentView.center = self.originalCenter;
    self.contentView.transform = CGAffineTransformMakeRotation( -self.radian );
    self.radian = 0.0;
    // hide the like and nope labels
    self.likeLabel.alpha = self.nopeLabel.alpha = 0;
}

@end
