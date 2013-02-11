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


#define DEF_TRIANGLE @"△"
#define DEF_CIRCLE @"◯"
#define DEF_SQUARE @"▢"


-(void) updateUI
{
    for (UIButton *cardbutton in self.cardButtons)
    {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
        NSString *titleString = [self cardTitle:card];
        [cardbutton setTitle:titleString forState:UIControlStateNormal];

        NSMutableAttributedString *mat = [self applyCardValues:[cardbutton.titleLabel.attributedText mutableCopy] toCard:card withTitle:titleString];
        cardbutton.titleLabel.attributedText = mat;
        
        
        
                //[cardbutton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        //cardbutton.selected = card.isSelected;
        //cardbutton.enabled = !card.isUnplayable;
        cardbutton.backgroundColor = (card.isSelected ? [UIColor lightGrayColor] : [UIColor whiteColor]);
    }
    
    // update label on top:
    self.progressLbl.text = [self.game lastFlipResults];
    
    // when is it over?
    // TODO:
    
    // figure out if there are no other cards:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", [self.game score]];
}

// this method should update the mat based on the passed card:
-(NSMutableAttributedString *) applyCardValues:(NSMutableAttributedString *) mat toCard:(SetCard *) card withTitle:(NSString *) title
{
    
    
    
    
    
    return mat;
}

-(NSString *) cardTitle:(SetCard *) card
{
    // first, figure out what kind of shape we are showing on this card:
    NSString *shape = [self cardShape: card];
    
    // then, figure out how many number of the shape we need to show:
    SetCount countEnum = [card number];
    int count = 0;
    switch(countEnum)
    {
        case ONE: count = 1;break;
        case TWO: count = 2;break;
        case TREE:count = 3;break;
    }
    
    // then, finally, create the string for that many items:
    NSString *desc = @"";
    for (int i = 0; i < count; i++)
    {
        desc = [desc stringByAppendingString:shape];
    }
    
    return desc;
}

-(NSString *) cardShape:(SetCard *) card
{
    SetShape shape = [card shape];
    switch (shape)
    {
        case TRIANGLE:  return DEF_TRIANGLE;
        case CIRCLE:    return DEF_CIRCLE;
        case SQUARE:    return DEF_SQUARE;
    }
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
