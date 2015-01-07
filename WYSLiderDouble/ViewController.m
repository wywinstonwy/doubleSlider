//
//  ViewController.m
//  WYSLiderDouble
//
//  Created by WangYun on 15-1-6.
//  Copyright (c) 2015年 WangYun. All rights reserved.
//

#import "ViewController.h"
#import "LDTSelectCarSlide.h"

@interface ViewController ()<LDTSelectCarSlideDelegate>
{
    UILabel *lblPrice;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LDTSelectCarSlide *slide1 = [[LDTSelectCarSlide alloc] initWithFrame:CGRectMake(0, 100, 320, 100)];
    slide1.delegate = self;
    [self.view addSubview:slide1];
    
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 40)];
    lblPrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblPrice];
    
    //    slide1.backgroundColor = setBackGrayColor;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)slideDelegateFunctionmin:(NSInteger)min max:(NSInteger)max
{
    NSString *str = [NSString stringWithFormat:@"%d-%d万",min,max];
    lblPrice.text = str;
}
-(void)slidefinished
{
    NSLog(@"拖动完成执行的方法");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
