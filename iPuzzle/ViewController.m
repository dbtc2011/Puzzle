//
//  ViewController.m
//  iPuzzle
//
//  Created by DT_Macmini_Mark Angeles on 2/5/14.
//  Copyright (c) 2014 DT_Macmini_Mark Angeles. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor brownColor]];
    [self performSelector:@selector(loadPuzzle) withObject:nil afterDelay:2];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)loadPuzzle{
    PuzzleControllerViewController *puzzle = [[PuzzleControllerViewController alloc]initWithNibName:nil bundle:nil];
    [puzzle setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:puzzle animated:YES completion:^(void){
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
