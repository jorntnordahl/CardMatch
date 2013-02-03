//
//  CardMatchingGame.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/30/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@end

@implementation CardMatchingGame

-(NSMutableArray *) flipResults
{
    if (!_flipResults)
    {
        _flipResults = [[NSMutableArray alloc]init];
    }
    return _flipResults;
}

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
          andMatchCount:(NSUInteger) matchCount
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

#define MATCH_BONUS_2 4;
#define MATCH_BONUS_3 8;
#define MISMATCH_PENALTY_2 2
#define MISMATCH_PENALTY_3 3
#define FLIP_COST 1

-(void) flipCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            NSString *flipResult = nil;
            
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS_2;
                        int bonus = matchScore * MATCH_BONUS_2;
                        flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, bonus];
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY_2;
                        flipResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY_2];
                    }
                    
                    break;
                }
            }
            
            // did not find a match or miss match:
            if (flipResult == nil)
            {
                flipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            
            // add flipResult to history of flips:
            [self.flipResults insertObject:flipResult atIndex:0];
            
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

-(BOOL) isGameOver
{
    for (int i = 0; i < [self.cards count]; i++)
    {
        for (int j = 0; j < [self.cards count]; j++)
        {
            if (i != j)
            {
                Card *card1 = [self cardAtIndex:i];
                Card *card2 = [self cardAtIndex:j];
                
                if (!card1.isUnplayable && !card2.isUnplayable)
                {
                    int matchCount = [card1 match:@[card2]];
                    if (matchCount)
                    {
                        return NO;
                    }
                }
            }
        }
     }
    
    return YES;
}

-(NSString *) lastFlipResults
{
    if (self.flipResults.count > 0)
    {
        return [self.flipResults objectAtIndex:0];
    }
    return nil;
}

-(NSString *) flipResultAt:(int)index
{
    return [self.flipResults objectAtIndex:index];
}

@end
