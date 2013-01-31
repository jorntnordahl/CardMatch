//
//  CardMatchingGame.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/30/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of cards
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}


-(id) initWithCardCount:(NSUInteger) count
              usingDeck:(Deck *) deck
{
    self = [super init];
    
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards insertObject:card atIndex:i];
        
            }
        }
    }
    
    return self;
}

#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void) flipCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
        
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    Card *card = nil;
    if (index < self.cards.count)
    {
        card = self.cards[index];
    }
    return card;
}

@end
