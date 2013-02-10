//
//  CardGame.h
//  
//
//  Created by Jorn Nordahl on 2/10/13.
//
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardGame : NSObject

@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of cards
@property (strong, nonatomic) NSMutableArray *flipResults;

// designated initializer
-(id) initWithCardCount:(NSUInteger) count
              usingDeck:(Deck *) deck;


-(void) flipCardAtIndex:(NSUInteger) index;

-(NSString *) flipResultAt:(int)index;

-(Card *)cardAtIndex:(NSUInteger)index;

-(BOOL) isGameOver;

-(NSString *) lastFlipResults;

@end
