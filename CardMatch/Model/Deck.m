//
//  Deck.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "Deck.h"


@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

@synthesize cards = _cards;

-(NSMutableArray *) cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void) addCard: (Card *)card atTop:(BOOL) atTop
{
    if (card)
    {
        if (atTop)
        {
            [self.cards insertObject:card atIndex:0];
        }
        else
        {
            [self.cards addObject:card];
        }
    }
}

-(Card *) drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
