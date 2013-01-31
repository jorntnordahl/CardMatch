//
//  CardViewController.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardViewController.h"
#import "CardMatchingGame.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
//@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (weak, nonatomic) IBOutlet UIButton *newGameBtn;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@end

@implementation CardViewController

@synthesize flipsLabel;
//@synthesize deck = _deck;


-(CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PLayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (IBAction)restartGame:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

-(void) updateUI
{
    for (UIButton *cardbutton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardbutton.selected = card.isFaceUp;
        cardbutton.enabled = !card.isUnplayable;
        cardbutton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    
    // figure out if there are no other cards:
    /*
    BOOL hasMoreMatches = NO;
    for (int i = 0; i < [self.cardButtons count]; i++)
    {
        for (int j = 0; j < [self.cardButtons count]; j++)
        {
            if (i != j)
            {
                Card *card1 = [self.game cardAtIndex:self.cardButtons[i]];
                Card *card2 = [self.game cardAtIndex:self.cardButtons[j]];
                
                if (!card1.isUnplayable && !card2.isUnplayable)
                {
                    int matchCount = [card1 match:@[card2]];
                    if (matchCount)
                    {
                        hasMoreMatches = YES;
                        break;
                    }
                }
            }
        }
        
        if (hasMoreMatches)
        {
            break;
        }
    }
    
    if (!hasMoreMatches)
    {
        for (UIButton *cardbutton in self.cardButtons)
        {
            Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
            if (!card.isUnplayable)
            {
                cardbutton.hidden = YES;
            }
        }
    }
    */
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", [self.game score]];
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject: sender]];
    self.flipCount++;
    [self updateUI];
}

@end