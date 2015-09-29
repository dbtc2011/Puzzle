//
//  PuzzleControllerViewController.h
//  iPuzzle
//
//  Created by DT_Macmini_Mark Angeles on 2/5/14.
//  Copyright (c) 2014 DT_Macmini_Mark Angeles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PuzzleControllerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>{
    
}

@property (nonatomic, strong) NSMutableArray *arrayPoints;
@property (nonatomic, strong) NSMutableArray *arrayImages;
@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, assign) CGPoint newPoint;
@property (nonatomic, assign) CGPoint oldPoint;

@property (nonatomic, strong) UIView *viewFrame;
@property (nonatomic, strong) UIView *viewDrag;
@property (nonatomic, strong) UIImage *imageOriginal;

@property (nonatomic, strong) UIPopoverController *popOver;

@property (nonatomic, assign) BOOL pause;

@end
