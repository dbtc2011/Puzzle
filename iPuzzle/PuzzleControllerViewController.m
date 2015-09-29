//
//  PuzzleControllerViewController.m
//  iPuzzle
//
//  Created by DT_Macmini_Mark Angeles on 2/5/14.
//  Copyright (c) 2014 DT_Macmini_Mark Angeles. All rights reserved.
//

#import "PuzzleControllerViewController.h"

@interface PuzzleControllerViewController ()

@end

@implementation PuzzleControllerViewController

#pragma mark - Overriden Setter
@synthesize viewDrag = _viewDrag;
@synthesize viewFrame = _viewFrame;
@synthesize arrayPoints = _arrayPoints;
@synthesize arrayImages = _arrayImages;
@synthesize imageOriginal = _imageOriginal;
@synthesize popOver = _popOver;
@synthesize originalPoint;
@synthesize newPoint;
@synthesize oldPoint;
@synthesize pause;

#pragma mark - Overriden Getter
- (UIView *)viewFrame{
    //didStartFunction;
    if (!_viewFrame) {
        _viewFrame = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)/2)-(600/2)
                                                            ,(CGRectGetHeight(self.view.frame)/2)-(750/2),
                                                            600,
                                                            750)];
        [_viewFrame setBackgroundColor:[UIColor blackColor]];
        
    }
    //didEndFunction;
    return _viewFrame;
}
- (UIView *)viewDrag{
    //didStartFunction;
    if (!_viewDrag) {
        _viewDrag = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 250)];
    }
    //didEndFunction;
    return _viewDrag;
}
- (UIImage *)imageOriginal{
    //didStartFunction;
    if (!_imageOriginal) {
        _imageOriginal = (UIImage *)[self arrangeOrientation:[UIImage imageNamed:@"IMG_2334.jpg"]];
    }
    //didEndFunction;
    return _imageOriginal;
}
- (NSMutableArray *)arrayPoints{
    //didStartFunction;
    if (!_arrayPoints) {
        _arrayPoints = @[].mutableCopy;
        CGPoint first = CGPointMake(0, 0);
        [_arrayPoints addObject:NSStringFromCGPoint(first)];
        
        CGPoint second = CGPointMake(200, 0);
        [_arrayPoints addObject:NSStringFromCGPoint(second)];
        
        CGPoint third = CGPointMake(400, 0);
        [_arrayPoints addObject:NSStringFromCGPoint(third)];
        
        CGPoint fouth = CGPointMake(0, 250);
        [_arrayPoints addObject:NSStringFromCGPoint(fouth)];
        
        CGPoint five = CGPointMake(200, 250);
        [_arrayPoints addObject:NSStringFromCGPoint(five)];
        
        CGPoint six = CGPointMake(400, 250);
        [_arrayPoints addObject:NSStringFromCGPoint(six)];
        
        CGPoint seven = CGPointMake(00, 500);
        [_arrayPoints addObject:NSStringFromCGPoint(seven)];
        
        CGPoint eight = CGPointMake(200, 500);
        [_arrayPoints addObject:NSStringFromCGPoint(eight)];
        
        CGPoint nine = CGPointMake(400, 500);
        [_arrayPoints addObject:NSStringFromCGPoint(nine)];
    }
    //didEndFunction;
    return _arrayPoints;
}
- (NSMutableArray *)arrayImages{
    //didStartFunction;
    if (!_arrayImages) {
        _arrayImages = @[].mutableCopy;
    }
    //didEndFunction;
    
    return _arrayImages;
}
- (UIPopoverController *)popOver{
    //didStartFunction;
    if (!_popOver) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        _popOver = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
        [_popOver setDelegate:self];
        
        
    }
    //didEndFunction;
    return _popOver;
}
#pragma mark - Setup 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //didStartFunction;
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        // Custom initialization
        
    }
    //didEndFunction;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //didStartFunction;
    
    self.pause = NO;
    [self prepareToCutImage];
    UIButton *btnPhotos = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnPhotos setFrame:CGRectMake((CGRectGetWidth(self.view.frame)/2)-(200/2), CGRectGetMinY(self.viewFrame.frame)-60, 200, 40)];
    [btnPhotos setTitle:@"Select from Photo Library" forState:UIControlStateNormal];
    [btnPhotos addTarget:self action:@selector(selectPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPhotos];
    
    UIButton *btnShuffle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnShuffle setFrame:CGRectMake(CGRectGetMidX(btnPhotos.frame)-150, CGRectGetMaxY(self.viewFrame.frame)+20, 100, 40)];
    [btnShuffle addTarget:self action:@selector(shuffleView:) forControlEvents:UIControlEventTouchUpInside];
    [btnShuffle setTitle:@"Shuffle" forState:UIControlStateNormal];
    [self.view addSubview:btnShuffle];
    
    UIButton *btnCheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnCheck setFrame:CGRectMake(CGRectGetMaxX(btnShuffle.frame)+100, CGRectGetMinY(btnShuffle.frame), 100, 40)];
    [btnCheck addTarget:self action:@selector(checkPuzzle:) forControlEvents:UIControlEventTouchUpInside];
    [btnCheck setTitle:@"Check" forState:UIControlStateNormal];
    [self.view addSubview:btnCheck];
    
    [self.view addSubview:self.viewFrame];
    //[self cutImage:0];
    [self setupPuzzle];
    //didEndFunction;
    
    
    
	// Do any additional setup after loading the view.
}
- (void)setupPuzzle{
    //didStartFunction;
    int xLocation = 0;
    int yLocation = 0;
    for (int count = 1; count < 10; count++) {
        
        UIView *_viewPuzzlePiece = [[UIView alloc]initWithFrame:CGRectMake(xLocation, yLocation, 200, 250)];
        UIImage *image = (UIImage *)self.arrayImages[count-1];
        [_viewPuzzlePiece setBackgroundColor:[UIColor colorWithPatternImage:image]];
        [_viewPuzzlePiece setTag:count];
        _viewPuzzlePiece.layer.borderWidth = 1;
        _viewPuzzlePiece.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.viewFrame addSubview:_viewPuzzlePiece];
        
        UIPanGestureRecognizer *_panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [_panGesture setDelegate:self];
        [_panGesture setMaximumNumberOfTouches:1];
        [self.viewFrame addGestureRecognizer:_panGesture];
        
        
        xLocation = xLocation + 200;
        if (count == 3 || count == 6) {
            xLocation = 0;
            yLocation = yLocation + 250;
        }
        
    }
    //didEndFunction;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sub Functions
/*
 Function called when Button "Select from Photo Library" clicked
 Open the photo Library using Image Picker and Popover
 
 */
- (void)selectPhotoLibrary: (UIButton *)sender{
    //didStartFunction;
    CGRect rect = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
    [self.popOver presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    //didEndFunction;
    
}
/*
 Function to re-arrange the views
 */
- (void)shuffleView: (UIButton *)sender{
    //didStartFunction;
    NSMutableArray *_arrShuffledPoints = [NSMutableArray arrayWithArray:[self getShuffledContents]];
    [self.viewFrame.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger index, BOOL *stop){
        int _indexOfPoint = [_arrShuffledPoints indexOfObject:[NSString stringWithFormat:@"%d",view.tag]];
        CGPoint _point = CGPointFromString(self.arrayPoints[_indexOfPoint]);
        [UIView animateWithDuration:1 animations:^(void){
            [view setFrame:CGRectMake(_point.x, _point.y, 200, 250)];
        }];
    }];
    //didEndFunction;
}
/*
 Function to check the puzzle
 */
- (void)checkPuzzle: (UIButton *)sender{
    BOOL returnValue = YES;
    for (id Subviews in self.viewFrame.subviews) {
        if ([Subviews isKindOfClass:[UIView class]]) {
            UIView *_subViews = (UIView *)Subviews;
            CGPoint _point = CGPointFromString(self.arrayPoints[_subViews.tag-1]);
            if (_subViews.frame.origin.x != _point.x && _subViews.frame.origin.y != _point.y) {
                returnValue = NO;
            }
        }
    }
    if (returnValue) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Puzzle" message:@"Congratulations!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Puzzle" message:@"Try Again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}
/* 
 Function to rescale the image
 */
- (UIImage *)rescaleImage: (UIImage *)image{
    //didStartFunction;
    CGImageRef imageRef = [image CGImage];
    
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipFirst;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, 600, 750, CGImageGetBitsPerComponent(imageRef), 4*600, CGImageGetColorSpace(imageRef), alphaInfo);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, 600, 750), imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    //didEndFunction;
    return newImage;
}

/*
 Function to re-arrange the image orientation
 */
- (UIImage *)arrangeOrientation: (UIImage *)image{
    //didStartFunction;
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    //didEndFunction;
    return img;
}
/*
 Function to cut and save the image to array
 */
- (void)cutImage: (NSUInteger)index{
    //didStartFunction;
    CGPoint pointCrop = CGPointFromString(self.arrayPoints[index]);
    CGRect rectImage = CGRectMake(pointCrop.x, pointCrop.y, 200, 250);
    CGImageRef sourceImageRef = [self.imageOriginal CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rectImage);
    UIImage *cutImage = [UIImage imageWithCGImage:newImageRef];
    [self.arrayImages addObject:cutImage];
    //didEndFunction;
}
/*
 Function to produce a shuffled arrangement of numbers
 */
- (NSArray*)getShuffledContents{
    //didStartFunction;
    NSLog(@"DITO NAG ERROR");
    NSMutableArray *arrReturn = [NSMutableArray array];
    NSMutableArray *arrContents = [NSMutableArray array];
    for (int count = 1; count < 10; count++) {
        [arrContents addObject:[NSString stringWithFormat:@"%d",count]];
    }
    for (int count = 10; count > 1; count--) {
        int _index = arc4random()%[arrContents count];
        [arrReturn addObject:[arrContents objectAtIndex:_index]];
        [arrContents removeObjectAtIndex:_index];
    }
    NSLog(@"arr Return = %@",arrReturn);
    //didEndFunction;
    return arrReturn;
    
}
/*
 Reset Images
 */
- (void)resetImage{
    for (UIView *view in self.viewFrame.subviews) {
        UIImage *image = (UIImage *)self.arrayImages[view.tag-1];
        [view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
}
/*
 Function to setup Image cutting
 */
- (void)prepareToCutImage{
    //didStartFunction;
    //NSLog(@"Prepare tu CUT");
    [self.arrayImages removeAllObjects];
    [self.arrayPoints enumerateObjectsUsingBlock:^(NSString *points, NSUInteger index, BOOL *stop){
        [self cutImage:index];
    }];
    //didEndFunction;
    //NSLog(@"ERROR");
}
/*
 Function to controll the panning of objects
 */
- (void)panGesture: (UIPanGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // Start Pan gesture
        self.originalPoint = [gesture locationInView:self.viewFrame];
        self.newPoint = self.originalPoint;
        self.viewDrag = (UIView *)[self getViewWithStartPoint:self.originalPoint];
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        // Start panning/moving
        
        [self.viewFrame bringSubviewToFront:self.viewDrag];
        self.oldPoint = self.newPoint;
        self.newPoint = [gesture locationInView:self.viewFrame];
        [self.viewDrag setFrame:CGRectMake(CGRectGetMinX(self.viewDrag.frame)+ (self.newPoint.x - self.oldPoint.x), CGRectGetMinY(self.viewDrag.frame) + (self.newPoint.y - self.oldPoint.y), CGRectGetWidth(self.viewDrag.frame), CGRectGetHeight(self.viewDrag.frame))];
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded){
        // End Pan gesture
        
        CGPoint _endPoint = CGPointMake(self.viewDrag.frame.origin.x, self.viewDrag.frame.origin.y);
        UIView *_viewEnd = (UIView *)[self getViewWithEndPoint:_endPoint];
        int _xPoint = (self.originalPoint.x/200);
        int _yPoint = (self.originalPoint.y/250);
        CGPoint _pointOfView = CGPointMake(_xPoint*200, _yPoint*250);
        if (_viewEnd == nil) {
            [UIView animateWithDuration:.5 animations:^(void){
                
                [self.viewDrag setFrame:CGRectMake(_pointOfView.x, _pointOfView.y, CGRectGetWidth(self.viewDrag.frame), CGRectGetHeight(self.viewDrag.frame))];
                
            }];
        }else{
            [UIView animateWithDuration:.5 animations:^(void){
                
                [self.viewDrag setFrame:CGRectMake(CGRectGetMinX(_viewEnd.frame), CGRectGetMinY(_viewEnd.frame), CGRectGetWidth(self.viewDrag.frame), CGRectGetHeight(self.viewDrag.frame))];
                [_viewEnd setFrame:CGRectMake(_pointOfView.x, _pointOfView.y, CGRectGetWidth(_viewEnd.frame), CGRectGetHeight(_viewEnd.frame))];
            }];
        }
        
        
        self.viewDrag = nil;
        
    }
}
- (UIView *)getViewWithStartPoint :(CGPoint)point{
    
    int _xPoint = (point.x/200);
    int _yPoint = (point.y/250);
    CGPoint _pointOfView = CGPointMake(_xPoint*200, _yPoint*250);
  
    for (id subViews in self.viewFrame.subviews) {
        if ([subViews isKindOfClass:[UIView class]]) {
            UIView *_subViews = (UIView *)subViews;
            if (_subViews.frame.origin.x == _pointOfView.x && _subViews.frame.origin.y == _pointOfView.y) {
                return _subViews;
            }
        }
    }
    
    return nil;
}

- (UIView *)getViewWithEndPoint: (CGPoint)point{
    int xMin = 100;
    int yMin = 125;
    CGPoint _endPoint = CGPointMake(0, 0);
    for (int count = 0; count < 2; count++) {
        if (point.x > xMin) {
            _endPoint.x = _endPoint.x + 200;
        }
        if (point.y > yMin) {
            _endPoint.y = _endPoint.y + 250;
        }
        xMin = xMin + 200;
        yMin = yMin + 250;
    }
    for (id subViews in self.viewFrame.subviews) {
        if ([subViews isKindOfClass:[UIView class]]) {
            UIView *_subViews = (UIView *)subViews;
            if (_subViews.frame.origin.x == _endPoint.x && _subViews.frame.origin.y == _endPoint.y) {
                return _subViews;
            }
        }
    }
    
    return nil;
    
}

#pragma mark Delegates
#pragma mark Pop Over
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
   
    //didStartFunction;
    self.popOver = nil;
    //didEndFunction;
}
#pragma mark Image Picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //didStartFunction;
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    self.imageOriginal = [self arrangeOrientation:img];
    self.imageOriginal = [self rescaleImage:self.imageOriginal];
    
    [self.popOver dismissPopoverAnimated:YES];
    self.popOver = nil;
    [self prepareToCutImage];
    [self resetImage];
    //didEndFunction;
    
}
#pragma mark AlerView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
@end
