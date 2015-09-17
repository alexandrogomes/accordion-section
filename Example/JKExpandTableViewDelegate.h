//
//  JKExpandTableViewDelegate.h
//  Example
//
//  Created by Alexandro on 9/17/15.
//  Copyright (c) 2015 Robert Nash. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JKExpandTableViewDelegate <NSObject>

@optional
/*! Optional method the delegate should implement to get notified when a child is clicked on.
 
 @param childIndex The child index in question
 @param parentIndex The parent index in question
 */
- (void) tableView:(UITableView *)tableView didSelectCellAtChildIndex:(BOOL)selected inChild:(NSInteger) childIndex withInParentCellIndex:(NSInteger) parentIndex;
/*! Optional method the delegate should implement to get notified when a child is clicked on.
 
 
 @param parentIndex The parent index in question
 */
- (void) tableView:(UITableView *)tableView didSelectParentCellAtIndex:(BOOL)selected inParent:(NSInteger) parentIndex;

@end
