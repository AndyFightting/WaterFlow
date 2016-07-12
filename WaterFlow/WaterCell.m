//
//  WaterCell.m
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import "WaterCell.h"

@interface WaterCell()
@end

@implementation WaterCell{

    UILabel* tmpLabel;

}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self){
        tmpLabel = [[UILabel alloc] init];
        tmpLabel.textAlignment = NSTextAlignmentCenter;
        tmpLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:tmpLabel];
    }
    
    return self;
}

-(void)showContentWithModel:(WaterModel*)model{
    tmpLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, [WaterModel cellHeightWithModel:model]);
    tmpLabel.text = [NSString stringWithFormat:@"userId: %d",model.userId];
}

@end