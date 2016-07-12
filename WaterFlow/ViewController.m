//
//  ViewController.m
//  WaterFlow
//
//  Created by 苏贵明 on 16/7/11.
//  Copyright © 2016年 苏贵明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{

    UICollectionView * waterCollectionView;
    NSMutableArray* modelArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    modelArray = [[NSMutableArray alloc]init];
    for (int i=0; i<50; i++) {
        WaterModel* md = [[WaterModel alloc]init];
        md.userId = i;
        [modelArray addObject:md];
    }
    
    waterCollectionView =[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[WaterLayout alloc]initWithHeightDelegate:self columcCount:4]];
    waterCollectionView.backgroundColor=[UIColor redColor];
    [waterCollectionView registerClass :[WaterCell class] forCellWithReuseIdentifier : @"hotFeedCell"];//必须注册
    waterCollectionView.dataSource=self;
    waterCollectionView.delegate=self;
    waterCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:waterCollectionView];
}

#pragma mark  - collection delegate

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1;
}

-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section{
    return modelArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForCellAtIndexPath:(NSIndexPath *)indexPath{
    WaterModel* md = [modelArray objectAtIndex:indexPath.row];
    return [WaterModel cellHeightWithModel:md];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"hotFeedCell";
    WaterCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell showContentWithModel:[modelArray objectAtIndex:indexPath.row]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterModel* md = [modelArray objectAtIndex:indexPath.row];
    NSLog(@"点击了cell %d",md.userId);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
