//
//  WaterModel.m
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import "WaterModel.h"

@implementation WaterModel


+(float)cellHeightWithModel:(WaterModel*)md{
    if (md.cellHeight<=0) {//这里计算cellHeight并赋值
        if (md.userId%3==0) {
            md.cellHeight =100;
        }else if (md.userId%3==1){
            md.cellHeight = 150;
        }else{
            md.cellHeight = 200;
        }
    }
    
    return md.cellHeight;
}
@end
