//
//  ViewController.m
//  SimulRecognizer
//
//  Created by Hoàng Thái on 3/18/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController {
    UIImageView *photo;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ngoctrinh.jpg"]];
    photo.center = CGPointMake(self.view.bounds.size.width/ 2, self.view.bounds.size.height / 2);
    photo.userInteractionEnabled = YES;
    photo.multipleTouchEnabled = YES;
    [self.view addSubview:photo];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onPinch:)];
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(onRotate:)];
    [photo addGestureRecognizer:pinch];
    [photo addGestureRecognizer:rotate];
//    [pinch requireGestureRecognizerToFail:rotate];
//    [rotate requireGestureRecognizerToFail:pinch];
}

- (void) adjustAnchorPointForGestureRecognizer: (UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperView = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperView;
    }
}

- (void) onPinch: (UIPinchGestureRecognizer *)pinch {
    [self adjustAnchorPointForGestureRecognizer:pinch];
    if (pinch.state == UIGestureRecognizerStateBegan ||
        pinch.state == UIGestureRecognizerStateChanged) {
        
        photo.transform = CGAffineTransformScale(photo.transform, pinch.scale, pinch.scale);
        pinch.scale = 1.0;
    }
}

- (void) onRotate: (UIRotationGestureRecognizer *)rotate {
    [self adjustAnchorPointForGestureRecognizer:rotate];
    if (rotate.state == UIGestureRecognizerStateChanged ||
        rotate.state == UIGestureRecognizerStateBegan) {
        
        photo.transform = CGAffineTransformRotate(photo.transform, rotate.rotation);
        rotate.rotation = 0.0;
    }
}

@end
