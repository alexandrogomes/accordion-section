//
//  MenuSectionHeaderView.m
//  Example
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "MenuSectionHeaderView.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface MenuSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MenuSectionHeaderView {
    BOOL isRotating;
}

@synthesize interactionDelegate = _interactionDelegate;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.interactionDelegate userTapped:self];
}

-(void)openAnimated:(BOOL)animated {
    
    if (animated && !isRotating) {
        
        isRotating = YES;
        
        [UIView animateWithDuration:0.2 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            //self.lineView.backgroundColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {
            isRotating = NO;
            self.lineView.alpha = 1;
        }];
        
    } else {
        [self.layer removeAllAnimations];
        self.imageView.transform = CGAffineTransformIdentity;
        
        isRotating = NO;
    }
}

-(void)closeAnimated:(BOOL)animated {
    
    if (animated && !isRotating) {
        
        isRotating = YES;
        
        [UIView animateWithDuration:0.2 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180.0f));

        } completion:^(BOOL finished) {
            isRotating = NO;
            self.lineView.alpha = 0;
        }];
        
    } else {
        [self.layer removeAllAnimations];
        self.imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180.0f));
        isRotating = NO;
    }
}

- (IBAction)actionMarkSection:(id)sender {
    self.btnCheck.selected = !self.btnCheck.selected;
    if (self.btnCheck.selected) {
        self.btnCheck.backgroundColor = [UIColor greenColor];
    } else {
        self.btnCheck.backgroundColor = [UIColor grayColor];
    }

    [self.delegateSelection tableView:nil didSelectParentCellAtIndex:self.btnCheck.selected inParent:self.tag];
    
}

-(void)markItem:(BOOL)value {
    self.btnCheck.selected = value;
    if (self.btnCheck.selected) {
        self.btnCheck.backgroundColor = [UIColor greenColor];
    } else {
        self.btnCheck.backgroundColor = [UIColor grayColor];
    }
}

@end
