//
//  WaterLayout.h
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterLayout;
@protocol WaterLayoutDelegate <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
 heightForCellAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WaterLayout : UICollectionViewLayout
-(instancetype)initWithHeightDelegate:(id<WaterLayoutDelegate>)delegate columcCount:(int)columnCount;
@end
