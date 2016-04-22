//
//  HYCIQRCodeGenerator.h
//  ErWeiMa
//
//  Created by xuwei on 16/4/7.
//  Copyright © 2016年 xuwei. All rights reserved.
//

/**
 * 使用方法如下：
 * 1.提供一个二维码 宽度的变量
 * CGFloat codeWidth = 150;
 * 2.创建生成二维码的view(位置可以指定)
 * CIQRCodeGeneratorView *codeGenrator = [[CIQRCodeGeneratorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - codeWidth) / 2.0, (self.view.frame.size.height - codeWidth) / 2.0, codeWidth, codeWidth)];
 * 3.调用创建生成二位的方法
 * [codeGenrator generatedCIQRCodeWithAddress:@"http://www.baidu.com" withHexColorString:@"#00FF00"];
 * [self.view addSubview:codeGenrator];
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CIQRCodeGeneratorView : UIView

/**
 *  根据url地址生成 带高清二维码
 *
 *  @param codeAddress 二维码的url地址:地址不能为空 否则创建失败
 *
 *  @return 如有地址为空 返回NO  地址不为空 返回YES
 */
- (BOOL)generatedCIQRCodeWithAddress:(NSString *)codeAddress;

/**
 *  根据url地址和十六进制颜色生成 带颜色的二维码
 *  如果传入的十六进制颜色为空 或者 nil 生产默认黑色的二维码
 *
 *  @param codeAddress    二维码的url地址:地址不能为空 否则创建失败
 *
 *  @param hexColorString 十六进制的颜色: 必须要以#开头
 *
 *  @return 如有地址为空 返回NO  地址不为空 返回YES
 */
- (BOOL)generatedCIQRCodeWithAddress:(NSString *)codeAddress withHexColorString:(NSString *)hexColorString;
@end


