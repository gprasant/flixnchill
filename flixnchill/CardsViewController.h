//
//  ViewController.h
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeMoviesView.h"

@interface CardsViewController : UIViewController
@property (strong, nonatomic) IBOutlet ThreeMoviesView *movieCardsView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;

@end

