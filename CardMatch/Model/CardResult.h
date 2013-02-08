//
//  CardResult.h
//  CardMatch
//
//  Created by Jorn Nordahl on 2/7/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;


@end
