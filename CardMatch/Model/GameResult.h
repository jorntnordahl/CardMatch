//
//  CardResult.h
//  CardMatch
//
//  Created by Jorn Nordahl on 2/7/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+(NSArray *)allGameResults; // of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

- (NSComparisonResult)compareByDate:(GameResult *)other;
- (NSComparisonResult)compareByScore:(GameResult *)other;
- (NSComparisonResult)compareByTime:(GameResult *)other;

@end
