//
//  RRNCollapsableTableViewController.h
//  RRNCollapsableSectionTableView
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "RRNCollapsableSectionHeaderProtocol.h"
#import "JKExpandTableViewDelegate.h"
#import "RRNCollapsableSectionItemProtocol.h"

@interface RRNCollapsableTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RRNCollapsableSectionHeaderReactiveProtocol,JKExpandTableViewDelegate>

//Override required
-(NSArray *)model;
-(UITableView *)collapsableTableView;
-(NSString *)sectionHeaderReuseIdentifier;
-(NSMutableArray*)sections;

//Override optional
-(void)userTapped:(UIView <RRNCollapsableSectionHeaderProtocol> *)view;
-(BOOL)singleOpenSelectionOnly;
-(NSArray *)indexPathsForSection:(NSInteger)section forMenuSection:(id <RRNCollapsableSectionItemProtocol>)menuSection;

@end
