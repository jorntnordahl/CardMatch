//
//  CardResult.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/7/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardResult.h"

@interface CardResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation CardResult

#define START_KEY @"StartDate"
#define END_KEY @"StartDate"
#define SCORE_KEY @"Score"
#define ALL_RESULTS_KEY @"GAMERESULTS_ALL"

-(NSArray *)allGameResults
{
    NSMutableArray *allResults = [[NSMutableArray alloc]init];
    
    for (id pList in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues])
    {
        CardResult *result = [[CardResult alloc]initfromPropertyList:pList];
        [allResults addObject: result];
    }
    
    return allResults;
}

-(id) initfromPropertyList: (id) plist
{
    self = [self init];
    if (self)
    {
        if ([plist isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultsDictionary = (NSDictionary *)plist;
            _start = resultsDictionary[START_KEY];
            _end = resultsDictionary[END_KEY];
            _score = resultsDictionary[SCORE_KEY];
        }
    }
}




-(void) synchronize
{
    NSMutableDictionary *resultsMap = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!resultsMap)
    {
        resultsMap = [[NSMutableDictionary alloc] init];
    }
    
    resultsMap[[self.start description]] = [self asPropertyList];
    
    [[NSUserDefaults standardUserDefaults] setObject:resultsMap forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



-(id) asPropertyList
{
    return @{START_KEY: self.start, END_KEY: self.end, SCORE_KEY: @(self.score) };
}

-(id) init
{
    self = [super init];
    if (self)
    {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval) duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void) setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}




@end
