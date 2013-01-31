//
//  CardMatchingGame.h
//  CardMatch
//
//  Created by Jorn Nordahl on 1/30/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h" 

@interface CardMatchingGame : NSObject

@property (readonly, nonatomic) int score;

// designated initializer
-(id) initWithCardCount:(NSUInteger) count
              usingDeck:(Deck *) deck;


-(void) flipCardAtIndex:(NSUInteger) index;

-(Card *)cardAtIndex:(NSUInteger)index;

@end
