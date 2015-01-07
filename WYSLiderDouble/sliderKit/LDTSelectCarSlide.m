//
//  LDTSelectCarSlide.m
//  HelpBuyCar
//
//  Created by WangYun on 14-11-17.
//  Copyright (c) 2014年 北京智阅网络科技有限公司. All rights reserved.
//

#import "LDTSelectCarSlide.h"

@implementation LDTSelectCarSlide

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        lblmax = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 40, 20)];
        lblmin = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 40, 20)];
        
        lblmin.backgroundColor = lblmax.backgroundColor = [UIColor clearColor];
        lblmin.font = lblmax.font = [UIFont systemFontOfSize:10];
        lblmin.textColor = lblmax.textColor = [UIColor whiteColor];
        lblmin.textAlignment = lblmax.textAlignment = NSTextAlignmentCenter;
        lblmin.text = @"0";
        lblmax.text = @"100";

        UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 270, 35)];
//        imageViewBack.centerX = SCREEN_WIDTH/2.0f;
        imageViewBack.image   = [UIImage imageNamed:@"pricebg"];
        [self addSubview:imageViewBack];
        
        UILabel *lblBackSlide=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 260, 10)];
        lblBackSlide.textColor=[UIColor grayColor];
        lblBackSlide.text = @"   10      20       30      40      50        60      80      100";
        lblBackSlide.font=[UIFont systemFontOfSize:10];
        [self addSubview:lblBackSlide];
        
        lblSlide=[[UILabel alloc] initWithFrame:CGRectMake(40, 21, 240, 13)];
        lblSlide.backgroundColor=[UIColor redColor];
        lblSlide.tag=10;
        [self addSubview:lblSlide];
        
        
        btnMin=[UIButton buttonWithType:UIButtonTypeCustom];
        btnMin.frame=CGRectMake(30, lblSlide.frame.origin.y, 40, 65);
        [btnMin addTarget:self action:@selector(dragLeftMoving:withEvent:) forControlEvents:(UIControlEventTouchDragInside|UIControlEventTouchDragOutside)];
      //  [btnMin setImage:[UIImage imageNamed:@"price"] forState:(UIControlStateNormal)];
        [btnMin addSubview:lblmin];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 10, 0, 10);
        [btnMin setImageEdgeInsets:insets];
        [self addSubview:btnMin];
        
        
        btnMax=[UIButton buttonWithType:UIButtonTypeCustom];
        btnMax.frame=CGRectMake(320-50, lblSlide.frame.origin.y, 40, 65);
     //   [btnMax setImage:[UIImage imageNamed:@"price"] forState:(UIControlStateNormal)];
        [btnMax addTarget:self action:@selector(dragMaxMoving:withEvent:) forControlEvents:(UIControlEventTouchDragInside|UIControlEventTouchDragOutside)];
        [btnMax addSubview:lblmax];
        [self addSubview:btnMax];

        UIImageView *imageViewPrice = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 51)];
        imageViewPrice.contentMode = UIViewContentModeScaleAspectFit;
        imageViewPrice.image = [UIImage imageNamed:@"price"];
        
        UIImageView *imageViewPrice2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 51)];
        imageViewPrice2.contentMode = UIViewContentModeScaleAspectFit;
        imageViewPrice2.image = [UIImage imageNamed:@"price"];
       
        [btnMin addSubview:imageViewPrice];
        [btnMax addSubview:imageViewPrice2];
        
//        //添加拖动结束后的事件
        [btnMin addTarget:self action:@selector(dragmovingFinished) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside];
        [btnMax addTarget:self action:@selector(dragmovingFinished) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside];//UIControlEventTouchDragOutside

        btnMin.centerX = 40;
        btnMax.centerX = 265;
        
//        x1 = 40;
//        x2 = 265;
        
        lblSlide.width = btnMax.centerX - btnMin.centerX;
        lblSlide.left  = btnMin.centerX;
//        btnMin.backgroundColor = setBackGrayColor;
      //  [self createPanGesturecognizer ];
    }
    return self;
}

//左边滑动
- (void)dragLeftMoving:(UIButton *)sender withEvent:event
{
    CGPoint centerPoint = [[[event allTouches] anyObject] locationInView:self];
  //  NSLog(@"左边滑动btnMin：%f",btnMin.centerX);

    //滑动左边是间距计算
    if (btnMax.centerX - btnMin.centerX <= 10 && btnMax.centerX<300)
    {
        btnMax.centerX = btnMin.centerX+15;
    }
   if(centerPoint.x >= 248)
   {
       centerPoint.x = 248;
   }
    if (centerPoint.x >= 20 && centerPoint.x <= 300)
    {
        sender.left =  centerPoint.x-10;
        lblSlide.left=sender.centerX;
        lblSlide.width = abs(btnMax.centerX-btnMin.centerX) ;
   //     NSLog(@"左边滑动：%f",centerPoint.x);

    }
    if(btnMin.centerX <=41)
    {
        btnMin.centerX = 40;
    }
    //
    if(btnMax.centerX - btnMin.centerX <=10 && btnMin.centerX >= 320-40)
    {
        btnMin.centerX    = 320-40;
        lblSlide.width = abs(btnMax.right-btnMin.left-20);
    }
    //当左边滑动到最小时候
    if (btnMin.centerX <= 40)
    {
        btnMin.centerX    = 40;
        lblSlide.width    = btnMax.centerX-btnMin.centerX;
        lblSlide.left     = btnMin.centerX;
    }
    //左边滑动到最大的时候
    if (btnMin.left >= 250)
    {
        btnMin.left    = 250;
        lblSlide.width = btnMax.centerX-btnMin.centerX;
        lblSlide.left  = btnMin.centerX;

    }
    
  
    [self calculatePrice];


}
//右滑最大边
-(void)dragMaxMoving:(UIButton *)sender withEvent:event
{
    CGPoint centerPoint = [[[event allTouches] anyObject] locationInView:self];
   // NSLog(@"右边滑动btnMax：%f",btnMax.centerX);

    if(btnMin.centerX <=31)
    {
        btnMin.centerX = 30;
        
    }
    if (centerPoint.x<=53) {
        centerPoint.x = 53;
    }
    if (btnMax.centerX - btnMin.centerX <10)
    {
        btnMin.centerX = btnMax.centerX-22;
        
    }
    
    if (centerPoint.x > 40 && centerPoint.x <= 271) {
        sender.left =  centerPoint.x-10;
        lblSlide.width = btnMax.centerX-btnMin.centerX;
        lblSlide.right = btnMax.right-10;
        lblSlide.left  = btnMin.centerX;
     //   NSLog(@"右边滑动：%f",centerPoint.x);

    }
    
    
    if(btnMax.centerX - btnMin.centerX >10 && btnMax.left>=320-50)
    {
        btnMax.left = 320-50;
        lblSlide.width = btnMax.centerX-btnMin.centerX;
        lblSlide.left = btnMin.centerX;
   
    }
    //右边滑到动最小时候，设置左边最靠左，右边和左边保持一定距离
    if (btnMin.left <= 30 && btnMax.left <= 40)
    {
        btnMin.centerX    = 30;
        lblSlide.left  = btnMin.centerX;
        btnMax.left    = btnMin.centerX+20;
        lblSlide.width = btnMax.centerX-btnMin.centerX;

    }
    
    [self calculatePrice];


    

    
}
#pragma mark 拖动完成时候
-(void)dragmovingFinished:(UIGestureRecognizer *)recognizer

{
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if ([_delegate respondsToSelector:@selector(slidefinished)]) {
            [_delegate slidefinished];
            NSLog(@"完成价格拖动！");
        }
        NSLog(@"完成价格拖动！");
    }
   

}
-(void)dragmovingFinished
{
    if ([_delegate respondsToSelector:@selector(slidefinished)]) {
        [_delegate slidefinished];
        NSLog(@"完成价格拖动！");
    }
    NSLog(@"完成价格拖动！");
}
#pragma mark 计算价格区间值
-(void)calculatePrice
{
    priceMinNumber=0.0,priceMaxNumber = 0.0;
    
    if (btnMin.centerX>40 && btnMin.centerX<=55) {
        priceMinNumber = (10/15.0f)*(btnMin.centerX-40);
        
    }
    if (btnMin.centerX>55 && btnMin.centerX <= 205)
    {
        priceMinNumber = 10+(50/150.0f)*(btnMin.centerX-55);
        
    }
    else if (btnMin.centerX>205 && btnMin.centerX<265)
    {
        priceMinNumber = 60 +(40/60.0f)*(btnMin.centerX - 205);
    }
    
    //最大值计算
    if (btnMax.centerX>40 && btnMax.centerX<=55) {
        priceMaxNumber = (10/15.0f)*(btnMax.centerX-40);
        
    }
    if (btnMax.centerX>55 && btnMax.centerX <= 205)
    {
        priceMaxNumber = 10+(50/150.0f)*(btnMax.centerX-55);
        
    }
    else if (btnMax.centerX>205 && btnMax.centerX<=265)
    {
        priceMaxNumber = 60 +(40/60.0f)*(btnMax.centerX - 205);
    }
    else if (btnMax.centerX >= 255)
    {
        priceMaxNumber = 100+btnMax.centerX-266;
    }
   
//    [btnMin setTitle:[NSString stringWithFormat:@"%.0f",priceMinNumber] forState:UIControlStateNormal];
//    [btnMax setTitle:[NSString stringWithFormat:@"%.0f",priceMaxNumber] forState:UIControlStateNormal];
 
    

    if ([_delegate respondsToSelector:@selector(slideDelegateFunctionmin:max:)])
    {
        lblmin.text =[NSString stringWithFormat:@"%d",[[NSNumber numberWithFloat:priceMinNumber] integerValue]];
        lblmax.text =[NSString stringWithFormat:@"%d",[[NSNumber numberWithFloat:priceMaxNumber] integerValue]];
        if (priceMaxNumber>100) {
            lblmax.text =[NSString stringWithFormat:@"100+"];
   
        }
        [_delegate slideDelegateFunctionmin:priceMinNumber max:priceMaxNumber];
      //  [self dragmovingFinished];
    }
}

/*
#pragma mark 手势拖动
-(void)createPanGesturecognizer
{
    UIPanGestureRecognizer *panMin = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMin:)];
    [btnMin addGestureRecognizer:panMin];
    
    
    UIPanGestureRecognizer *panMax = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMax:)];
    [btnMax addGestureRecognizer:panMax];
}

-(void)panMin:(UIPanGestureRecognizer *)recognizer
{
    CGPoint centerPoint = [recognizer translationInView:self];
    NSLog(@"%f",centerPoint.x);
    
    //滑动左边是间距计算
    if (btnMax.centerX - btnMin.centerX <= 10 && btnMax.centerX<300)
    {
        btnMax.centerX = btnMin.centerX+15;
    }
    if(centerPoint.x >= 248)
    {
        centerPoint.x = 248;
    }
    if (centerPoint.x >= 20 && centerPoint.x <= 300)
    {
        btnMin.left =  centerPoint.x-10;
        lblSlide.left=btnMin.centerX;
        lblSlide.width = abs(btnMax.centerX-btnMin.centerX) ;
        //     NSLog(@"左边滑动：%f",centerPoint.x);
        
    }
    if(btnMin.centerX <=41)
    {
        btnMin.centerX = 40;
    }
    //
    if(btnMax.centerX - btnMin.centerX <=10 && btnMin.centerX >= SCREEN_WIDTH-40)
    {
        btnMin.centerX    = SCREEN_WIDTH-40;
        lblSlide.width = abs(btnMax.right-btnMin.left-20);
    }
    //当左边滑动到最小时候
    if (btnMin.centerX <= 40)
    {
        btnMin.centerX    = 40;
        lblSlide.width    = btnMax.centerX-btnMin.centerX;
        lblSlide.left     = btnMin.centerX;
    }
    //左边滑动到最大的时候
    if (btnMin.left >= 250)
    {
        btnMin.left    = 250;
        lblSlide.width = btnMax.centerX-btnMin.centerX;
        lblSlide.left  = btnMin.centerX;
        
    }
    
    
    [self calculatePrice];
    
}

-(void)panMax:(UIPanGestureRecognizer *)recognizer
{

    CGPoint centerPoint1 = [recognizer translationInView:self];
    [recognizer setTranslation:CGPointMake(btnMax.centerX, 0) inView:self];

//    CGPoint centet2 = [recognizer velocityInView:self];
    NSLog(@"centerPoint1:%f",centerPoint1.x);
    
    float centetPointX = centerPoint1.x;

//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        if (centerPoint1.x<=0 ) {
//            centetPointX = btnMax.centerX+centetPointX;
//        }
//    else
//    {
//        centetPointX = btnMax.centerX+centerPoint1.x;
//    }
//    }

    
  //  btnMax.centerX =recognizer.view.center.x + centerPoint1.x;
        if(btnMin.centerX <=31)
        {
            btnMin.centerX = 30;
            
        }
        if (centetPointX<=53) {
            centetPointX = 53;
        }
        if (btnMax.centerX - btnMin.centerX <10)
        {
            btnMin.centerX = btnMax.centerX-22;
            
        }
        
        if (centetPointX > 40 && centetPointX <= 271) {
            btnMax.left =  centetPointX-10;
            lblSlide.width = btnMax.centerX-btnMin.centerX;
            lblSlide.right = btnMax.right-10;
            lblSlide.left  = btnMin.centerX;
            //   NSLog(@"右边滑动：%f",centerPoint.x);
            
        }
        
        
        if(btnMax.centerX - btnMin.centerX >10 && btnMax.left>=SCREEN_WIDTH-50)
        {
            btnMax.left = SCREEN_WIDTH-50;
            lblSlide.width = btnMax.centerX-btnMin.centerX;
            lblSlide.left = btnMin.centerX;
            
        }
        //右边滑到动最小时候，设置左边最靠左，右边和左边保持一定距离
        if (btnMin.left <= 30 && btnMax.left <= 40)
        {
            btnMin.centerX    = 30;
            lblSlide.left  = btnMin.centerX;
            btnMax.left    = btnMin.centerX+20;
            lblSlide.width = btnMax.centerX-btnMin.centerX;
            
        }
     
        
       // x2 = btnMax.centerX;
        [self calculatePrice];
  
}
 */
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"End");
//
//}
//
//- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    
////    [super endTrackingWithTouch:touch withEvent:event];
//}
@end
