//
//  MenuItemTableViewCell.m
//  Example
//
//  Created by Alexandro on 9/16/15.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "MenuItemTableViewCell.h"

@implementation MenuItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)markItem:(BOOL)value {
    self.btnMaskItem.selected = value;
    if (self.btnMaskItem.selected) {
        self.btnMaskItem.backgroundColor = [UIColor greenColor];
    } else {
        self.btnMaskItem.backgroundColor = [UIColor grayColor];
    }
}

- (IBAction)actionSelectionItem:(id)sender {
    self.btnMaskItem.selected = !self.btnMaskItem.selected;
    if (self.btnMaskItem.selected) {
        self.btnMaskItem.backgroundColor = [UIColor greenColor];
    } else {
        self.btnMaskItem.backgroundColor = [UIColor grayColor];
    }
    [self.delegateSelection tableView:nil didSelectCellAtChildIndex:self.btnMaskItem.selected inChild:self.tag withInParentCellIndex:[self.lblSection.text integerValue]];
}


@end
