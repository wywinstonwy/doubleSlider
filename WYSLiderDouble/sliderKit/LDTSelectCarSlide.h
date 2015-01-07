//
//  LDTSelectCarSlide.h
//  HelpBuyCar
//
//  Created by WangYun on 14-11-17.
//  Copyright (c) 2014年 北京智阅网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extend.h"
@protocol LDTSelectCarSlideDelegate<NSObject>
-(void)slideDelegateFunctionmin:(NSInteger)min max:(NSInteger )max;
-(void)slidefinished;//拖动完成后
@end
@interface LDTSelectCarSlide : UIView
{
    UILabel *lblSlide;
    
    UIButton *btnMin;
    UIButton *btnMax;
    
    UILabel *lblmax;
    UILabel *lblmin;
    
    float priceMinNumber;
    float priceMaxNumber;

//    float x1;
//    float x2;
}
@property(nonatomic,assign) id<LDTSelectCarSlideDelegate>delegate;
@end
