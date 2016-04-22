//
//  ViewController.m
//  CIQRCodeGeneratorDemo
//
//  Created by xuwei on 16/4/21.
//  Copyright © 2016年 xuwei. All rights reserved.
//

#import "ViewController.h"
#import "CIQRCodeGenerator/CIQRCodeGeneratorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat codeWidth = 150;
    CIQRCodeGeneratorView *codeGenrator = [[CIQRCodeGeneratorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - codeWidth) / 2.0, (self.view.frame.size.height - codeWidth) / 2.0, codeWidth, codeWidth)];
    BOOL success = [codeGenrator generatedCIQRCodeWithAddress:@"http://www.baidu.com"];
    success = [codeGenrator generatedCIQRCodeWithAddress:@"http://www.baidu.com" withHexColorString:@"#FF0000"];
    if (success) {
        [self.view addSubview:codeGenrator];
    } else {
        NSLog(@"创建失败");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
