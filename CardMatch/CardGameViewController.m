//
//  CardViewController.m
//  CardMatch
//
//  Created by Jorn Nordahl on 1/27/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()

// outlets:
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;

// properies:
//@property (nonatomic) NSInteger matchCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

@synthesize flipsLabel;


- (GameResult *) gameResult
{
    if (!_gameResult)
    {
        _gameResult = [[GameResult alloc]init];
    }
    
    return _gameResult;
}

-(CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    
    }
    
    return _game;
}

- (IBAction)restartGame:(UIButton *)sender {
    
    // create a simple alert
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Deal new cards?"
                          message:@"Your current game and score\nwill be lost !"
                          delegate:self
                          cancelButtonTitle:@"Back to the game"
                          otherButtonTitles:@"Start a new game", nil];
    // and display it
    [alert show];
}

// protocole UIAlertViewDelegate
// this method will be called with a "click" on an UIALertView button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // if it's the "OK" button (Cancel is 0 (by default))
    if (buttonIndex == 1)
    {
        // reset
        self.game = nil;
        self.gameResult = nil;
        [self initUI];
    }
    // dismiss the alert (and go back to the app)
    //[alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(void) initUI
{
   self.game = nil;
    self.flipCount = 0;
    [self updateUI];
    self.progressLbl.text = @"Welcome to Match This Card!";
    self.game = nil;
}

-(void) updateUI
{
    UIImage *btnImage = [UIImage imageNamed:@"red-card-2.png"];
    
    for (UIButton *cardbutton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardbutton.selected = card.isFaceUp;
        cardbutton.enabled = !card.isUnplayable;
        cardbutton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        if (!card.isFaceUp)
        {
            [cardbutton setBackgroundImage:btnImage forState:UIControlStateNormal];
        }
        else
        {
            [cardbutton setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    
    
    // update label on top:
    self.progressLbl.text = [self.game lastFlipResults];
    
    
    // figure out if there are no other cards:
    if ([self.game isGameOver])
    {
        for (UIButton *cardbutton in self.cardButtons)
        {
            Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
            if (!card.isUnplayable)
            {
                cardbutton.hidden = YES;
            }
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", [self.game score]];
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    int sliderValue = sender.value;
    NSLog(@"Slider: %d", sliderValue);
    NSString *flipResult = [self.game flipResultAt:sliderValue];
    self.progressLbl.text = flipResult;
}


-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [UIView beginAnimations:@"flipCard" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:sender cache:YES];
    [UIView setAnimationDuration:0.4];
    [UIView commitAnimations];
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject: sender]];
    self.flipCount++;
    [self updateUI];
    self.historySlider.maximumValue = [[self.game flipResults] count] - 1;
    self.historySlider.value = self.historySlider.maximumValue;
    self.gameResult.score = self.game.score;
}


@end