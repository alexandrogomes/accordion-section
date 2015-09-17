//
//  MenuSectionHeaderView.h
//  Example
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "RRNCollapsableSectionHeaderProtocol.h"
#import "JKExpandTableViewDelegate.h"

@interface MenuSectionHeaderView : UITableViewHeaderFooterView <RRNCollapsableSectionHeaderProtocol>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak,nonatomic) id <JKExpandTableViewDelegate> delegateSelection;

- (IBAction)actionMarkSection:(id)sender;
-(void)markItem:(BOOL)value;
@end
