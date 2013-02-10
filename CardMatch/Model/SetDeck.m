//
//  SetDeck.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/10/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "SetDeck.h"


@implementation SetDeck

- (id) init
{
    self = [super init];
    if (self)
    {
        int cardCount = 0;
        
        for (NSNumber *count in [SetCard validCounts])
        {
            SetCount countEnum = [count intValue];
            for (NSNumber *color in [SetCard validColors])
            {
                SetColor colorEnum = [color intValue];
                for (NSNumber *shading in [SetCard validShadings])
                {
                    SetShading shadingEnum = [shading intValue];
                    for (NSNumber *shape in [SetCard validShapes])
                    {
                        SetShape shapeEnum = [shape intValue];
                        
                        cardCount++;
                        
                        
                        SetCard *card = [[SetCard alloc] init];
                        card.number = countEnum;
                        card.color = colorEnum;
                        card.shading = shadingEnum;
                        card.shape = shapeEnum;
                        
                        [self addCard:card atTop:NO];
                        
                        NSLog(@"Card: %d = %@", cardCount, card.description);
                    }
                }
            }
        }
    }
    
    return self;
}

@end
