//
//  PLayingCard.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "PLayingCard.h"

@implementation PLayingCard

@synthesize suit = _suit;
@synthesize rank = _rank;


-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        PLayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if (self.rank == otherCard.rank)
        {
            score = 4;
        }
    }
    
    return score;
}



- (NSString *) contents
{
    NSArray *rankStrings = [PLayingCard validRanks];
    
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

+(NSArray *) validSuits
{
    return @[@"♠", @"♣",@"♥",@"♦"];
}

+(NSArray *) validRanks
{
    return @[@"?", @"A",@"1",@"2",@"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank
{
    return [self validRanks].count - 1;
}

-(void) setSuit: (NSString *) suit
{
    if ([[PLayingCard validSuits] containsObject:suit])
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
        if (rank <= [PLayingCard maxRank])
        {
            _rank = rank;
        }

}

@end
