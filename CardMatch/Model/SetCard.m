//
//  SetCard.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/10/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+(NSArray *) validCounts
{
    return [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithInt:ONE],
    [NSNumber numberWithInt:TWO],
    [NSNumber numberWithInt:TREE], nil];
}
+(NSString *) nameForCount:(SetCount) count
{
    switch (count) {
        case ONE:  return @"ONE";
        case TWO:  return @"TWO";
        case TREE: return @"TREE";
    }
    return @"unknown";
}

+ (NSArray *) validColors
{
    return [[NSMutableArray alloc] initWithObjects:
            [NSNumber numberWithInt:BLUE],
            [NSNumber numberWithInt:RED],
            [NSNumber numberWithInt:GREEN], nil];
}
+(NSString *) nameForColor:(SetColor) count
{
    switch (count) {
        case BLUE:  return @"BLUE";
        case RED:  return @"RED";
        case GREEN: return @"GREEN";
    }
    return @"unknown";
}

+ (NSArray *) validShadings
{
    return [[NSMutableArray alloc] initWithObjects:
            [NSNumber numberWithInt:NONE],
            [NSNumber numberWithInt:PARTIAL],
            [NSNumber numberWithInt:SOLID], nil];
}
+(NSString *) nameForShading:(SetShading) count
{
    switch (count) {
        case NONE:  return @"NONE";
        case PARTIAL:  return @"PARTIAL";
        case SOLID: return @"SOLID";
    }
    return @"unknown";
}

+ (NSArray *) validShapes
{
    return [[NSMutableArray alloc] initWithObjects:
            [NSNumber numberWithInt:TRIANGLE],
            [NSNumber numberWithInt:CIRCLE],
            [NSNumber numberWithInt:SQUARE], nil];
}
+(NSString *) nameForShape:(SetShape) count
{
    switch (count) {
        case TRIANGLE:  return @"TRIANGLE";
        case CIRCLE:  return @"CIRCLE";
        case SQUARE: return @"SQUARE";
    }
    return @"unknown";
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",
            [SetCard nameForCount:self.number],
            [SetCard nameForColor:self.color],
            [SetCard nameForShading:self.shading],
            [SetCard nameForShape:self.shape]];
}

/*
 
Example:
card 1:    3   blue    solid triangles
card 2:    3   purble  solid circles
case 3:    3   green   solid circles
---------------------------------------
ALL:     SAME  DIFF    SAME  INVALID (not all same|diff)
 
 
 
Numbers: 3/3/3 GOOD!
Colors: Blue/Purple/Green GOOD!
Shading: Solid/Solid/Solid GOOD!
Shapes: Triangles/Circles/Circles BAD!
 
 Basically, all 3 cards need to have the same or different:
 - number of shapes
 - colors
 - shading
 - shape
 
 .. as the example above states/// 
*/
-(int) match:(NSArray *)otherCards
{
    return 0;
}

@end
