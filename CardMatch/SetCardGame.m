//
//  SetCardGame.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/10/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "SetCardGame.h"
#import "SetCard.h"

@implementation SetCardGame


-(void) flipCardAtIndex:(NSUInteger) index
{
    SetCard *card = (SetCard *)[self cardAtIndex:index];
    
    if (card && !card.isUnplayable)
    {
        if (!card.isSelected)
        {
            card.selected = !card.selected;
            
            NSMutableArray *otherCards = [[NSMutableArray alloc] init]; // of cards:
            //[otherCards addObject:card];
            
            // see if there are two other cards:
            for (SetCard *otherCard in self.cards)
            {
                if (otherCard.isSelected && !otherCard.isUnplayable)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            // if we have a total of 3 cards in our array, then we can see if we match:
            if (otherCards.count == 3)
            {
                SetCard *card1 = otherCards[0];
                SetCard *card2 = otherCards[1];
                SetCard *card3 = otherCards[2];
                
                if (((card1.number + card2.number + card3.number)%3 == 0)&&
                    ((card1.shape + card2.shape + card3.shape)%3 == 0) &&
                    ((card1.color + card2.color + card3.color)%3 == 0) &&
                    ((card1.shading + card2.shading + card3.shading)%3 == 0))
                {
                    // we have a match:
                    card1.unplayable = YES;
                    card2.unplayable = YES;
                    card3.unplayable = YES;
                    
                    self.score += 4;
                }
                else
                {
                    // flip all back again:
                    card1.selected = NO;
                    card2.selected = NO;
                    card3.selected = NO;
                    
                    self.score -= 2;
                }
            }
            
            /*
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
             */
        }
        
    }
    
    [self findAllMatches];
    
}

-(void)findAllMatches
{
    NSLog(@"search started");
    SetCard *card1;
    SetCard *card2;
    SetCard *card3;
    int iterations = 0;
    int matchCount = 0;
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    [results addObject:@"hello"];
    
    for(int i = 0; i <= self.cards.count-3; i++)
    {
        card1 = self.cards[i];
        if (card1.isUnplayable) continue;
        
        for(int j = i+1; j <= self.cards.count-2; j++)
        {
            card2 = self.cards[j];
            if (card2.isUnplayable) continue;
            for(int k = j+1; k <= self.cards.count-1; k++)
            {
                card3 = self.cards[k];
                if (card3.isUnplayable)
                {
                    continue;
                }
                
                iterations++;
                
                if (((card1.number + card2.number + card3.number)%3 == 0)&&
                    ((card1.shape + card2.shape + card3.shape)%3 == 0) &&
                    ((card1.color + card2.color + card3.color)%3 == 0) &&
                    ((card1.shading + card2.shading + card3.shading)%3 == 0))
                {
                    [results addObject:[NSString stringWithFormat:@"%@ - %@ - %@",
                                        card1.contents, card2.contents, card3.contents]];
                    matchCount++;
                    break;
                }
            }
        }
    }
    NSLog(@"iterations: %d",iterations);
    NSLog(@"matches: %d",matchCount);
    NSLog(@"results: %@", results);
}


@end
