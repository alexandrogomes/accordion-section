//
//  MenuItemTableViewCell.h
//  Example
//
//  Created by Alexandro on 9/16/15.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKExpandTableViewDelegate.h"

@interface MenuItemTableViewCell : UITableViewCell

@property (weak,nonatomic) id <JKExpandTableViewDelegate> delegateSelection;
@property (assign,nonatomic) NSInteger sectionIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnMaskItem;
@property (weak, nonatomic) IBOutlet UILabel *lblSection;

-(void)markItem:(BOOL)value;
@end
