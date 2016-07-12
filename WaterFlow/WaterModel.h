//
//  WaterModel.h
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaterModel : NSObject
@property(nonatomic) float cellHeight;//必须有
@property(nonatomic) int userId;//demo属性

+(float)cellHeightWithModel:(WaterModel*)md;
@end
