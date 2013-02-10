//
//  SetCardViewController.m
//  CardMatch
//
//  Created by Jorn Nordahl on 2/10/13.
//  Copyright (c) 2013 Jorn Nordahl. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardGame.h"
#import "SetDeck.h"
#import "GameResult.h"

@interface SetCardViewController ()

// outlets
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// properties

@property (strong, nonatomic) SetCardGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) GameResult *gameResult;


@end

@implementation SetCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(SetCardGame *) game
{
    if (!_game)
    {
        _game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[[SetDeck alloc] init]];
    }
    
    return _game;
}



-(void) updateUI
{
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
            //
            
            //[cardbutton setBackgroundImage:btnImage forState:UIControlStateNormal];
        }
        else
        {
            //[cardbutton setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    
    // update label on top:
    self.progressLbl.text = [self.game lastFlipResults];
    
    // when is it over?
    // TODO:
    
    // figure out if there are no other cards:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", [self.game score]];
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

- (IBAction)dealClicked:(id)sender
{

}

- (IBAction)flipCard:(UIButton *)sender
{
    // no need for animation, these cards are going to always show the 'face up':
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject: sender]];
    self.flipCount++;
    [self updateUI];
    //self.historySlider.maximumValue = [[self.game flipResults] count] - 1;
    //self.historySlider.value = self.historySlider.maximumValue;
    self.gameResult.score = self.game.score;
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

@end
