//
//  GFTableView.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "GFTableView.h"
#import <objc/runtime.h>

@interface GFTableView ()

@property (nonatomic, strong)   NSMutableArray          *cache;
@property (nonatomic, strong)   NSMutableDictionary     *tempCells;

@end

@implementation GFTableView

- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
                            indexPath:(NSIndexPath *)indexPath
                           fixedWidth:(CGFloat)width
                        configuration:(void (^)(__kindof UITableViewCell *))configuration {
    BOOL hasCache = [self hasCacheForIndexPath:indexPath];
    if (hasCache) {
        NSNumber *value = [self heightCacheForIndexPath:indexPath];
        if ([value floatValue] > 0) {
            return [value floatValue];
        }
    }
    
    // has no size chche
    UITableViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    
    NSLayoutConstraint *widthConstrait;
    if (width > 0) {
        widthConstrait = [NSLayoutConstraint constraintWithItem:cell.contentView
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1.
                                                       constant:width];
        [cell.contentView addConstraint:widthConstrait];
    }
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (widthConstrait) {
        [cell.contentView removeConstraint:widthConstrait];
    }
    
    //for the separate line
    size.height += .5;
    
    NSNumber *value = @(size.height);
    NSMutableArray *arr = self.cache[indexPath.section];
    if (hasCache) {
        [arr replaceObjectAtIndex:indexPath.row withObject:value];
    }
    else {
        //防止是从最后面刷新的
        while ([arr count] < indexPath.row) {
            [arr addObject:[NSNumber numberWithFloat:0]];
        }
        
        [arr insertObject:value atIndex:indexPath.row];
    }
    
    return size.height;
}

- (void)clearCache {
    [self.cache removeAllObjects];
}

- (void)clearCacheForIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *section;
    if (indexPath.section < [self.cache count]) {
        section = self.cache[indexPath.section];
    }
    
    if (indexPath.row < [section count]) {
        [section replaceObjectAtIndex:indexPath.row withObject:@0];
    }
}

#pragma mark - swizzled methods

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
    
    id cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:identifier];
    self.tempCells[identifier] = cell;
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [super registerNib:nib forCellReuseIdentifier:identifier];
    
    id cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
    self.tempCells[identifier] = cell;
}

#pragma mark - section changes

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesWithOptions:NSEnumerationReverse
                               usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                                   if (idx < [self.cache count]) {
                                       [self.cache replaceObjectAtIndex:idx withObject:@[].mutableCopy];
                                   }
                               }];
    
    [super reloadSections:sections withRowAnimation:animation];
}

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesWithOptions:NSEnumerationReverse
                               usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                                   while ([self.cache count] < idx) {
                                       [self.cache addObject:@[].mutableCopy];
                                   }
                                   
                                   [self.cache insertObject:@[].mutableCopy atIndex:idx];
                               }];
    
    [super insertSections:sections withRowAnimation:animation];
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesWithOptions:NSEnumerationReverse
                               usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                                   if (idx < [self.cache count]) {
                                       [self.cache removeObjectAtIndex:idx];
                                   }
                               }];
    
    [super deleteSections:sections withRowAnimation:animation];
}

- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (section < [self.cache count] && newSection < [self.cache count]) {
        [self.cache exchangeObjectAtIndex:section withObjectAtIndex:newSection];
    }
    
    [super moveSection:section toSection:newSection];
}

#pragma mark - row changes

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [indexPaths enumerateObjectsWithOptions:NSEnumerationReverse
                                 usingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                     if (obj.section < [self.cache count]) {
                                         NSMutableArray *section = self.cache[obj.section];
                                         if (obj.row < [section count]) {
                                             [section insertObject:@0 atIndex:obj.row];
                                         }
                                         else {
                                             [section addObject:@0];
                                         }
                                     }
                                 }];
    
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [indexPaths enumerateObjectsWithOptions:NSEnumerationReverse
                                 usingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                     if (obj.section < [self.cache count]) {
                                         NSMutableArray *section = self.cache[obj.section];
                                         if (obj.row < [section count]) {
                                             [section removeObjectAtIndex:obj.row];
                                         }
                                     }
                                 }];
    
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [indexPaths enumerateObjectsWithOptions:NSEnumerationReverse
                                 usingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                     if (obj.section < [self.cache count]) {
                                         NSMutableArray *section = self.cache[obj.section];
                                         if (obj.row < [section count]) {
                                             [section replaceObjectAtIndex:obj.row withObject:@0];
                                         }
                                     }
                                 }];
    
    [super reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if ([self hasCacheForIndexPath:indexPath] && [self hasCacheForIndexPath:newIndexPath]) {
        NSNumber *value = [self heightCacheForIndexPath:indexPath];
        NSNumber *newValue = [self heightCacheForIndexPath:newIndexPath];
        
        NSMutableArray *section = self.cache[indexPath.section];
        NSMutableArray *newSection = self.cache[newIndexPath.section];
        
        [section replaceObjectAtIndex:indexPath.row withObject:newValue];
        [newSection replaceObjectAtIndex:newIndexPath.row withObject:value];
    }
    
    [super moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)reloadData {
    [self.cache removeAllObjects];
    [super reloadData];
}

#pragma mark - private methods

- (NSMutableArray *)cache {
    if (!_cache) {
        _cache = [NSMutableArray new];
    }
    
    return _cache;
}

- (NSMutableDictionary *)tempCells {
    if (!_tempCells) {
        _tempCells = [NSMutableDictionary new];
    }
    
    return _tempCells;
}

- (id)templeCaculateCellWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *templeCells = self.tempCells;
    id cell = [templeCells objectForKey:identifier];
    if (cell == nil) {
        NSDictionary *cellNibDict = [self valueForKey:@"_cellNibDict"];
        UINib *cellNIb = cellNibDict[identifier];
        cell = [[cellNIb instantiateWithOwner:nil options:nil] lastObject];
        templeCells[identifier] = cell;
    }
    
    return cell;
}

#pragma mark - cache methods

- (BOOL)hasCacheForIndexPath:(NSIndexPath *)indexPath {
    return [self heightCacheForIndexPath:indexPath] != nil;
}

- (NSNumber *)heightCacheForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [self.cache count]) {
        NSMutableArray *arr = self.cache[indexPath.section];
        if (indexPath.row < [arr count]) {
            return arr[indexPath.row];
        }
    }
    else {
        for (NSInteger index = [self.cache count]; index <= indexPath.section; index++) {
            [self.cache addObject:@[].mutableCopy];
        }
    }
    
    return nil;
}

@end
