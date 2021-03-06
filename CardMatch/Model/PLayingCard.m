//
//  PLayingCard.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;
@synthesize rank = _rank;



-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if (self.rank == otherCard.rank)
        {
            score = 4;
        }
    }
    else
    {
        PlayingCard *otherCard1 = [otherCards objectAtIndex:0];
        PlayingCard *otherCard2 = [otherCards objectAtIndex:1];
        if ([otherCard1.suit isEqualToString:self.suit] &&
            [otherCard2.suit isEqualToString:self.suit])
        {
            score = 3;
        }
        else if (self.rank == otherCard1.rank &&
                 self.rank == otherCard2.rank)
        {
            score = 12;
        }

    }
    
    return score;
}



- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard validRanks];
    
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

+(NSArray *) validSuits
{
    return @[@"♠", @"♣",@"♥",@"♦"];
}

+(NSArray *) validRanks
{
    return @[@"?", @"A",@"1",@"2",@"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
}

+(NSUInteger) maxRank
{
    return [self validRanks].count - 1;
}

-(void) setSuit: (NSString *) suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit: @"?";
}

- (void) setRank: (NSUInteger) rank
{
        if (rank <= [PlayingCard maxRank])
        {
            _rank = rank;
        }

}

-(NSString *) suitAsString
{
    if ([self.suit isEqualToString:@"♠"])
    {
        return @"spade";
    }
    else if ([self.suit isEqualToString:@"♣"])
    {
        return @"club";
    }
    else if ([self.suit isEqualToString:@"♥"])
    {
        return @"heart";
    }
    else if ([self.suit isEqualToString:@"♦"])
    {
        return @"diamond";
    }
    return @"?";
}

@end
