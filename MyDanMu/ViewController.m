//
//  ViewController.m
//  MyDanMu
//
//  Created by 赵贵 on 16/4/19.
//  Copyright © 2016年 猎暄. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)BOOL isOpended;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isOpended = false;
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addlabel) userInfo:nil repeats:YES];
    
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self _initSwitch];
    
}

-(void)addlabel
{
    //改变弹幕出现矩形
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    NSInteger heigh = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect = CGRectMake(width, rand()%heigh, 300, 50);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    NSArray *content = [NSArray arrayWithObjects:@"我是弹幕～",@"我也是😄",@"嗨森ing",@"66666",nil];
    int index = rand()%content.count;
    label.text = content[index];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    //NSLog(@"正在打印");
    //添加完成后，label需要进行移动
    [self movelabel:label];
    
}

-(void)movelabel:(UILabel *)label
{
    [UIView animateWithDuration:8 animations:^{label.frame = CGRectMake(0-label.frame.size.width, label.frame.origin.y,  label.frame.size.width, label.frame.size.height);
    }completion:^(BOOL finished) {
        //将内存控制在可控范围内，防止手机卡死
        [label removeFromSuperview];
    }];
    
    
}

//手动添加按钮，开启和关闭弹幕
- (void) _initSwitch
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(480, 0, 80, 50);
    [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)clickedbtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (self.isOpended) {
        [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
        self.isOpended = NO;
        [self removelabels];
    }else
    {
        [btn setTitle:@"关闭弹幕" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate date]];
        self.isOpended = YES;
    }
    //改变title内容
    
}

-(void)removelabels
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
