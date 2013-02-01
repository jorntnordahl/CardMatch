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
@property (strong, nonatomic) NSMutableArray *flipResults;
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
                        self.score += matchScore * MATCH_BONUS;
                        int bonus = matchScore * MATCH_BONUS;
                        flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, bonus];
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        flipResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
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
    for (Card *otherCard in self.cards)
    {
        if (!otherCard.isUnplayable)
        {
            return NO;
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

@end
