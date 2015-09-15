//
//  ViewController.m
//  Example
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "ViewController.h"
#import "MenuSection.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *menu;
@end

@implementation ViewController

static NSString *identifier = @"MenuSectionHeaderView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.menu = [self buildMenu];
}

-(NSString *)sectionHeaderReuseIdentifier {
    return identifier;
}

-(NSArray *)buildMenu {
    
    NSMutableArray *collector = [NSMutableArray new];
    
    //for (NSInteger i = 0; i < 5; i++) {
        
        MenuSection *section1 = [MenuSection new];
        section1.title = @"Class 1";
        section1.isVisible = @NO;
        section1.items = @[@"Student1", @"Student2", @"Student3"];
    
        MenuSection *section2 = [MenuSection new];
        section2.title = @"Class 2";
        section2.isVisible = @NO;
        section2.items = @[@"Student2", @"Student3"];

        
        [collector addObject:section1];
        [collector addObject:section2];
    //}
    
    return [collector copy];
}

-(NSArray *)model {
    return self.menu;
}

-(UITableView *)collapsableTableView {
    return self.tableView;
}

-(BOOL)singleOpenSelectionOnly {
    return NO;
}

#pragma mark - UITableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <RRNCollapsableSectionItemProtocol> mSection = self.menu[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = mSection.items[indexPath.row];
    return cell;
}

@end
