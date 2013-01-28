//
//  PLayingCardDeck.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "PLayingCardDeck.h"

@implementation PLayingCardDeck

- (id) init
{
    self = [super init];
    if (self)
    {
        for (NSString *suit in [PLayingCard validSuits])
        {
            for (NSUInteger rank = 1; rank <= [PLayingCard maxRank]; rank++)
            {
                PLayingCard *card = [[PLayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                
                [self addCard:card atTop:NO];
            }
        }
    }
    
    return self;
}



@end
