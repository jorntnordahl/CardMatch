//
//  CardMatchinGame3.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/31/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardMatchinGame3.h"

@implementation CardMatchinGame3

#define MATCH_BONUS_3 8;
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
            
            NSMutableArray *otherUpCards = [[NSMutableArray alloc]init];
            
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherUpCards addObject:otherCard];
                }
            }
            
            // now we may have one or more cards in the list:
            
            // if none, then we flipped the first card:
            if (otherUpCards.count == 0)
            {
                // nothing to do really...
            }
            else
            {
                if (otherUpCards.count == 1)
                {
                    // we just flipped the 2nd card.
                    // if flipping the second card, and it matches the first, leave both flipped...
                    // if flipping two cards, and the second card does not match, flipe the first back...
                    
                    int matchScore = [card match:otherUpCards];
                    if (matchScore)
                    {
                        // the card just flipped match the one already flipped, leave the two alone:
                        
                    }
                    else
                    {
                        // the flipped card does not match the one already flipped, flip the other back over:
                        Card *otherCard = [otherUpCards objectAtIndex:0];
                        otherCard.faceUp = NO;
                    }
                }
                else if (otherUpCards.count == 2)
                {
                    // we just flipped the 3d card
                    // if flipping the third card, and it matches both the other two, then we have a win - all 3 cards are unplayable and score is added
                    // if flipping a third card, and we do not have a match, flip the other two cards back and leave the 3rd face up....
                    
                    int matchScore = [card match:otherUpCards];
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        Card *otherCard1 = [otherUpCards objectAtIndex:0];
                        otherCard1.unplayable = YES;
                        Card *otherCard2 = [otherUpCards objectAtIndex:1];
                        otherCard2.unplayable = YES;
                        
                        self.score += matchScore * MATCH_BONUS_3;
                        int bonus = matchScore * MATCH_BONUS_3;
                        flipResult = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points", card.contents, otherCard1.contents, otherCard2.contents, bonus];
                    }
                    else
                    {
                        Card *otherCard1 = [otherUpCards objectAtIndex:0];
                        otherCard1.faceUp = NO;
                        Card *otherCard2 = [otherUpCards objectAtIndex:1];
                        otherCard2.faceUp = NO;
                    }
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

@end
