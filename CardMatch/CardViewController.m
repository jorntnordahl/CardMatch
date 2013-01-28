//
//  CardViewController.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PLayingCardDeck *deck;

@end

@implementation CardViewController

@synthesize flipsLabel;
@synthesize deck = _deck;

-(PLayingCardDeck *) deck
{
    if (!_deck)
    {
        _deck = [[PLayingCardDeck alloc] init];
    }
    return _deck;
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}
        
                           
- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected)
    {
        // get a new card:
        Card *randomCard = [self.deck drawRandomCard];
        [sender setTitle:randomCard.contents forState:UIControlStateSelected];
    }
    self.flipCount++;
}
@end
