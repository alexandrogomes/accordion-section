//
//  ViewController.m
//  Example
//
//  Created by Robert Nash on 08/09/2015.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import "ViewController.h"
#import "MenuSection.h"
#import "MenuItemTableViewCell.h"
#import "MenuSectionHeaderView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSMutableArray *sectionsSelected;
@property (strong, nonatomic) NSMutableArray *itemsSelected;
@end

@implementation ViewController

static NSString *identifier = @"MenuSectionHeaderView";
static NSString *identifier2 = @"MenuItemTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    UINib *nib2 = [UINib nibWithNibName:identifier2 bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:identifier2];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.menu = [self buildMenu];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

-(NSString *)sectionHeaderReuseIdentifier {
    return identifier;
}

-(NSArray *)buildMenu {
    
    NSMutableArray *collector = [NSMutableArray new];
    self.sectionsSelected = [NSMutableArray new];
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
    
    for (int index=0; index <collector.count; index++) {
        [self.sectionsSelected addObject:@NO];
        long itemInSection = ((MenuSection*)[collector objectAtIndex:index]).items.count;
        NSMutableArray *itemsInSection = [NSMutableArray array];
        for (int indexItem= 0; indexItem< itemInSection; indexItem++) {
            [itemsInSection addObject:@"NO"];
        }
        [self.itemsSelected addObject:itemsInSection];
    }
    
    return [collector copy];
}

-(NSMutableArray*)sections {
    return self.sectionsSelected;
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
     UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier2];
    id <RRNCollapsableSectionItemProtocol> mSection = self.menu[indexPath.section];
    cell.textLabel.text = mSection.items[indexPath.row];
    cell.tag = indexPath.row;
    ((MenuItemTableViewCell*)cell).delegateSelection = self;
    ((MenuItemTableViewCell*)cell).sectionIndex =indexPath.section;
    //verifica se a secao esta selecionada
    NSArray *itemInSection = [self.itemsSelected objectAtIndex:indexPath.section];
    if ([[itemInSection objectAtIndex:indexPath.row] boolValue] == YES) {
        [((MenuItemTableViewCell*)cell) markItem:YES];
    } 
    
    
    return cell;
}

#pragma mark - methods JKExpandTableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectCellAtChildIndex:(BOOL)selected inChild:(NSInteger)childIndex withInParentCellIndex:(NSInteger)parentIndex{
    NSMutableArray *itemInSection = [self.itemsSelected objectAtIndex:parentIndex];
    if (selected) {
        NSLog(@"didSelectCellAtChildIndex - marcou o filho: %ld - que possui o pai na posição: %ld",childIndex,parentIndex -1);
        [[itemInSection objectAtIndex:childIndex] replaceObjectAtIndex:childIndex withObject:@"YES"];
    } else {
        NSLog(@"didSelectCellAtChildIndex - desmarcou o filho: %ld - que possui o pai na posição: %ld",childIndex,parentIndex -1);

        [[itemInSection objectAtIndex:childIndex] replaceObjectAtIndex:childIndex withObject:@"NO"];
        
    }
    [self.tableView reloadData];
}


- (void) tableView:(UITableView *)tableView didSelectParentCellAtIndex:(BOOL)selected inParent:(NSInteger)parentIndex {
    id <RRNCollapsableSectionItemProtocol> mSection = self.menu[parentIndex];
    NSArray *childArray = [self indexPathsForSection:parentIndex forMenuSection:mSection];
    
    if (selected) {
        NSLog(@"didSelectParentCellAtIndex - está marcado o pai: %ld",parentIndex);

        [[self sections] replaceObjectAtIndex:parentIndex withObject:@YES];
        for (NSIndexPath *indexpath in childArray) {
            MenuItemTableViewCell *cell = (MenuItemTableViewCell*)[self.tableView cellForRowAtIndexPath:indexpath];
            [cell markItem:selected];
        }
        
    } else {
        NSLog(@"didSelectParentCellAtIndex - desmarcou o pai: %ld",parentIndex);

        [[self sections] replaceObjectAtIndex:parentIndex withObject:@NO];
        for (NSIndexPath *indexpath in childArray) {
            MenuItemTableViewCell *cell = (MenuItemTableViewCell*)[self.tableView cellForRowAtIndexPath:indexpath];
            [cell markItem:selected];
        }
        
    }
    
 
    
    //NSLog(@"filhos: %@",childArray);
    
}


@end
