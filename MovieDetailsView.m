//
//  MovieDetailsView.m
//  flixnchill
//
//  Created by Greyson Gregory on 12/5/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MovieDetailsView.h"

@interface MovieDetailsView () <UIWebViewDelegate>

@end

@implementation MovieDetailsView

- (void)setUpView:(NSDictionary*)movie {
    NSDictionary *youtubeUrlCodes = @{@"Furious 7": @"Skpu5HaVkOc",
                                      @"Home": @"MyqZf8LiWvM",
                                      @"The Longest Ride": @"FUS_Q7FsfqU",
                                      @"Get Hard": @"lEqrpuU9fYI",
                                      @"Cinderella": @"20DF6U1HcGQ",
                                      @"Insurgent": @"suZcGoRLXkU",
                                      @"Woman in Gold": @"Kd2F3cJwEGc",
                                      @"It Follows": @"QX38jXwnRAM",
                                      @"Danny Collins": @"AndERTFMYd4",
                                      @"Kingsman: The Secret Service": @"kl8F-8tR8to",
                                      @"While We're Young": @"NRUcm9Qw9io",
                                      @"Do You Believe?": @"ogIX2Q7tEdc",
                                      @"The Second Best Exotic Marigold Hotel": @"3REYWGRmLnQ",
                                      @"American Sniper": @"99k3u9ay1gs",
                                      @"McFarland USA": @"j-VAOlHGE6Q",
                                      @"Focus": @"MxCRgtdAuBo",
                                      @"Run All Night": @"7uDuFh-nC-c",
                                      @"Ex Machina": @"XYGzRB4Pnq8",
                                      @"The SpongeBob Movie: Sponge Out of Water": @"TGjbpO1toTc",
                                      @"Chappie": @"l6bmTNadhJE"};

    self.movieId = movie[@"id"];
    self.movieTilteLabel.text = [NSString stringWithFormat:@"%@ (%@)", movie[@"title"], movie[@"year"]];
    self.movieSummaryLabel.text = movie[@"synopsis"];
    [self.movieSummaryLabel sizeToFit];
    self.summaryLabelContainer.contentSize = CGSizeMake(self.movieSummaryLabel.bounds.size.width, self.movieSummaryLabel.bounds.size.height);
    
    self.movieTrailerView.delegate = self;
    NSString *trailerUrl = [NSString stringWithFormat:@"http://www.youtube.com/embed/%@", youtubeUrlCodes[movie[@"title"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:trailerUrl]];
    [self.movieTrailerView loadRequest:request];
    [self.doneButton addTarget:self.delegate action:@selector(onDetailsDoneTap) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1]];
    [self addSubview:self.doneButton];

}

@end
