//
//  RRNCollapsableTableViewController.m
//  RRNCollapsableSectionTableView
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "RRNCollapsableSectionTableViewController.h"
#import "RRNCollapsableSectionItemProtocol.h"
#import "MenuSectionHeaderView.h"

@interface RRNCollapsableTableViewController ()

@property (nonatomic, strong) UIView *footerView;
@end

@implementation RRNCollapsableTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"MenuSectionHeaderView" bundle:nil];
    [[self collapsableTableView] registerNib:nib forHeaderFooterViewReuseIdentifier:@"MenuSectionHeaderViewID"];
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30.0)];
    self.footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

-(UITableView *)collapsableTableView {
    return nil;
}

-(NSArray *)model {
    return nil;
}

-(NSMutableArray *)sections {
    return nil;
}


-(BOOL)singleOpenSelectionOnly {
    return NO;
}

-(NSString *)sectionHeaderReuseIdentifier {
    return nil;
}

#pragma mark - UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self model].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <RRNCollapsableSectionItemProtocol> menuSection = [[self model] objectAtIndex:section];
    return (menuSection.isVisible.boolValue) ? menuSection.items.count : 0;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    id <RRNCollapsableSectionItemProtocol> menuSection = [[self model] objectAtIndex:section];
    
    id <RRNCollapsableSectionHeaderProtocol> sectionView = (id <RRNCollapsableSectionHeaderProtocol>)view;
    
    if (menuSection.isVisible.boolValue) {
        [sectionView openAnimated:NO];
    } else {
        [sectionView closeAnimated:NO];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    id <RRNCollapsableSectionItemProtocol> menuSection = [[self model] objectAtIndex:section];
    
    MenuSectionHeaderView <RRNCollapsableSectionHeaderProtocol> *view = (MenuSectionHeaderView <RRNCollapsableSectionHeaderProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[self sectionHeaderReuseIdentifier]];
    view.interactionDelegate = self;
    view.tag = section;
    view.titleLabel.text = menuSection.title;
    view.delegateSelection = self;
    if ([[[self sections] objectAtIndex:section] boolValue] == YES){
        [view markItem:YES];
    } else {
        [view markItem:NO];
    }
        
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

#pragma mark - ReactiveSectionHeaderProtocol

-(void)userTapped:(UIView *)view {
    
    
    UITableView *tableView = [self collapsableTableView];
    
    [tableView beginUpdates];
    
    BOOL foundOpenUnchosenMenuSection = NO;
    
    NSArray *menu = [self model];
    
    for (id <RRNCollapsableSectionItemProtocol> menuSection in menu) {
        
        BOOL chosenMenuSection = menuSection == [menu objectAtIndex:view.tag];
        
        BOOL isVisible = menuSection.isVisible.boolValue;
        
        if (isVisible && chosenMenuSection) {
            
            menuSection.isVisible = @NO;
            
            if ([view conformsToProtocol:@protocol(RRNCollapsableSectionHeaderProtocol)]) {
                [((id <RRNCollapsableSectionHeaderProtocol>)view) closeAnimated:YES];
            }
            
            NSInteger section = view.tag;
            
            NSArray *indexPaths = [self indexPathsForSection:section
                                              forMenuSection:menuSection];
            
            [tableView deleteRowsAtIndexPaths:indexPaths
                             withRowAnimation:(foundOpenUnchosenMenuSection) ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
            
        } //Abrir menu
        else if (!isVisible && chosenMenuSection) {
            
            menuSection.isVisible = @YES;
            
            if ([view conformsToProtocol:@protocol(RRNCollapsableSectionHeaderProtocol)]) {
                [((id <RRNCollapsableSectionHeaderProtocol>)view) openAnimated:YES];
            }
            
            NSInteger section = view.tag;
            
            NSArray *indexPaths = [self indexPathsForSection:section
                                              forMenuSection:menuSection];
            
            [tableView insertRowsAtIndexPaths:indexPaths
                             withRowAnimation:(foundOpenUnchosenMenuSection) ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
            
            
        } else if (isVisible && !chosenMenuSection && [self singleOpenSelectionOnly]) {
            
            foundOpenUnchosenMenuSection = YES;
            
            menuSection.isVisible = @NO;
            
            NSInteger section = [menu indexOfObject:menuSection];
            
            UIView *headerView = [tableView headerViewForSection:section];
            
            if ([headerView conformsToProtocol:@protocol(RRNCollapsableSectionHeaderProtocol)]) {
                [((id <RRNCollapsableSectionHeaderProtocol>)headerView) closeAnimated:YES];
            }
            
            NSArray *indexPaths = [self indexPathsForSection:section
                                              forMenuSection:menuSection];
            
            [tableView deleteRowsAtIndexPaths:indexPaths
                             withRowAnimation:(view.tag > section) ? UITableViewRowAnimationTop : UITableViewRowAnimationBottom];
            
            
        }
        
    }
    
    [tableView endUpdates];
}

-(NSArray *)indexPathsForSection:(NSInteger)section forMenuSection:(id <RRNCollapsableSectionItemProtocol>)menuSection {
    NSMutableArray *collector = [NSMutableArray new];
    NSInteger count = menuSection.items.count;
    NSIndexPath *indexPath;
    for (NSInteger i = 0; i < count; i++) {
        indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [collector addObject:indexPath];
    }
    return [collector copy];
}

@end
