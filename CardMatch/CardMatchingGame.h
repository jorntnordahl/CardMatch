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
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of cards
@property (strong, nonatomic) NSMutableArray *flipResults;
@property (nonatomic, readwrite) int matchCount;

// designated initializer
-(id) initWithCardCount:(NSUInteger) count
              usingDeck:(Deck *) deck
          andMatchCount:(NSUInteger) matchCount;


-(void) flipCardAtIndex:(NSUInteger) index;

-(NSString *) flipResultAt:(int)index;

-(Card *)cardAtIndex:(NSUInteger)index;

-(BOOL) isGameOver;

-(NSString *) lastFlipResults;

@end
