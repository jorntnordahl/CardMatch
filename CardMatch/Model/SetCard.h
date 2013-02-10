//
//  SetCard.h
//  CardMatch
//
//  Created by Jorn Nordahl on 2/10/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef enum
{
   ONE = 1,
   TWO = 2,
   TREE = 3
} SetCount;

typedef enum
{
    BLUE = 1,
    RED = 2,
    GREEN = 3
} SetColor;

typedef enum
{
    NONE = 1,
    PARTIAL = 2,
    SOLID = 3
} SetShading;

typedef enum
{
    TRIANGLE = 1,
    CIRCLE = 2,
    SQUARE = 3
} SetShape;

+ (NSArray *) validCounts;
+ (NSArray *) validColors;
+ (NSArray *) validShadings;
+ (NSArray *) validShapes;

@property (nonatomic) SetCount *number;
@property (nonatomic) SetShape *shape;
@property (nonatomic) SetShading *shading;
@property (nonatomic) SetColor *color;


@end
