//
//  PLayingCard.h
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit; // heart etc...
@property (nonatomic) NSUInteger rank; // 0 and 13

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end
