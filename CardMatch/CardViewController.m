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
@property (weak, nonatomic) IBOutlet UIButton *cardBtn1;
@property (weak, nonatomic) IBOutlet UIButton *cardBtn2;
@property (strong, nonatomic) NSString *firstCard;

@end

@implementation CardViewController

@synthesize flipsLabel;
@synthesize deck = _deck;
@synthesize firstCard;
@synthesize cardBtn1;
@synthesize cardBtn2;

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
        if (!cardBtn1)
        {
            cardBtn1 = sender;
        }
        else
        {
            cardBtn2 = sender;
        }
        
        NSString *currentFlippedTitle = [sender titleForState:UIControlStateSelected];
        if ([@"" isEqualToString:currentFlippedTitle])
        {
            // get a new card:
            Card *randomCard = [self.deck drawRandomCard];
            [sender setTitle:randomCard.contents forState:UIControlStateSelected];
        }
        
        //if ([[sender titleForState:UIControlStateSelected] isEqualToString:firstCard])
        {
            if (cardBtn1)
            {
                [cardBtn1 setEnabled:NO];
            }
            if (cardBtn2)
            {
                [cardBtn2 setEnabled:NO];
            }
        }
    }
    else
    {
        cardBtn1 = nil;
        cardBtn2 = nil;
    }
    self.flipCount++;
}

@end