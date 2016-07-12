//
//  WaterLayout.m
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout()

@end

@implementation WaterLayout{

    NSInteger cellCount;//cell个数
    CGFloat cellSpacing;//间距 改变这个参数即可
    CGFloat cellWidth;//cell 宽
    NSMutableArray * columnHeightArray;//列高 数组
    NSMutableArray * cellAttributeArray;//cell 属性 数组
    
    int columnCount;
   __weak id<WaterLayoutDelegate> heightDelegate;
}

-(instancetype)initWithHeightDelegate:(id<WaterLayoutDelegate>)delegate columcCount:(int)count{
    self = [super init];
    if (self) {
        columnCount = count;
        heightDelegate = delegate;
    }
    return self;
}

- (void)dealloc{
    [columnHeightArray removeAllObjects];
    columnHeightArray = nil;
    
    [cellAttributeArray removeAllObjects];
    cellAttributeArray = nil;
    
    heightDelegate = nil;
}

#pragma mark - 重写方法
- (void)prepareLayout{
    [super prepareLayout];
    
    cellSpacing = 10;
    cellWidth = (self.collectionView.frame.size.width-cellSpacing*(columnCount+1))/columnCount;
    
    cellCount = [[self collectionView] numberOfItemsInSection:0];
    cellAttributeArray = [NSMutableArray arrayWithCapacity:cellCount];
    columnHeightArray = [NSMutableArray arrayWithCapacity:columnCount];
    
    for (NSInteger idx = 0; idx < columnCount; idx++) {
        [columnHeightArray addObject:@(cellSpacing)];
    }
    
    // cell 放到最短的一列
    for (NSInteger idx = 0; idx < cellCount; idx++){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGFloat cellHeight = [heightDelegate collectionView:self.collectionView heightForCellAtIndexPath:indexPath];
        
        NSUInteger columnIndex = [self shortestColumnIndex];
        
        CGFloat xOffset = cellSpacing + (cellWidth + cellSpacing) * columnIndex;
        CGFloat yOffset = [(columnHeightArray[columnIndex]) floatValue];
        
        UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, cellWidth, cellHeight);
        
        [cellAttributeArray addObject:attributes];
        columnHeightArray[columnIndex] = @(yOffset + cellHeight + cellSpacing);
    }
}

- (CGSize)collectionViewContentSize{
    if (cellCount == 0){
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.frame.size;
    NSUInteger columnIndex = [self longestColumnIndex];
    
    CGFloat height = [columnHeightArray[columnIndex] floatValue];
    contentSize.height = height;
    
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path{
    return (cellAttributeArray)[path.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return [cellAttributeArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                            ^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings){
                                                                 return CGRectIntersectsRect(rect, [evaluatedObject frame]);
                                                             }]];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

#pragma mark - 私有方法
//获取最短列的 index
- (NSUInteger)shortestColumnIndex{
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    
    [columnHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
         CGFloat height = [obj floatValue];
         if (height < shortestHeight){
             shortestHeight = height;
             index = idx;
         }
     }];
    
    return index;
}

//获取最长列的 index
- (NSUInteger)longestColumnIndex{
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [columnHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop){
         CGFloat height = [obj floatValue];
         if (height > longestHeight){
             longestHeight = height;
             index = idx;
         }
     }];
    
    return index;
}


@end