//
//  GameResultViewController.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/7/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController


-(void) updateUI:(NSArray *) results
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    
    
    NSString *displayText = @"";
    for (GameResult *result in results)
    {
        NSString *dateString = [dateFormat stringFromDate:result.end];
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n\n", result.score, dateString, round(result.duration)];
    }
    self.display.text = displayText;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI:[GameResult allGameResults]];
}


-(void) setup
{
    // init that cant wait untill viewDidLoad
}


-(void) awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sortByDate {
    NSArray *sortedResults = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareByDate:)];
    [self updateUI:sortedResults];
}

- (IBAction)sortByScore {
    NSArray *sortedResults = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareByScore:)];
    [self updateUI:sortedResults];
}

- (IBAction)sortByDuration {
    NSArray *sortedResults = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareByTime:)];
    [self updateUI:sortedResults];
}

@end
