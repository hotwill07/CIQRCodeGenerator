//
//  HYCIQRCodeGenerator.m
//  ErWeiMa
//
//  Created by xuwei on 16/4/7.
//  Copyright © 2016年 xuwei. All rights reserved.
//

#import "CIQRCodeGeneratorView.h"

@implementation CIQRCodeGeneratorView


- (BOOL)generatedCIQRCodeWithAddress:(NSString *)codeAddress {
    return [self generatedCIQRCodeWithAddress:codeAddress withHexColorString:nil];
}

- (BOOL)generatedCIQRCodeWithAddress:(NSString *)codeAddress withHexColorString:(NSString *)hexColorString{
    if ([codeAddress isEqualToString:@""] || codeAddress == nil) {
        return NO;
    }

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *erWeimaAddress = codeAddress;
    NSData *data = [erWeimaAddress dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"InputMessage"];
    CIImage *outputImage = [filter outputImage];

    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:self.frame.size.width withHexColorString:hexColorString];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
    return YES;
}

//生产高清带颜色的二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size withHexColorString:(NSString *)hexColorString{

    CGRect extent = CGRectIntegral(image.extent);

    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 创建bitmap;

    size_t width = CGRectGetWidth(extent) * scale;

    size_t height = CGRectGetHeight(extent) * scale;

    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();

    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);

    CIContext *context = [CIContext contextWithOptions:nil];

    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];

    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);

    CGContextScaleCTM(bitmapRef, scale, scale);

    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 保存bitmap到图片

    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);

    CGContextRelease(bitmapRef);

    CGImageRelease(bitmapImage);
    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
    return [self imageBlackToTransparent:newImage withHexStringColor:hexColorString];
}


void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

// 改变二维码的颜色(传入十六进制的字符串)
- (UIImage*)imageBlackToTransparent:(UIImage*)image withHexStringColor:(NSString *)hexStringColor{
    if ([hexStringColor isEqualToString:@""] || hexStringColor == nil || ![hexStringColor hasPrefix:@"#"]) {
        return image;
    }
    
    CGFloat red = strtoul([[hexStringColor substringWithRange:NSMakeRange(1, 2)] UTF8String] , 0, 16);
    CGFloat green = strtoul([[hexStringColor substringWithRange:NSMakeRange(3, 2)] UTF8String] , 0, 16);;
    CGFloat blue = strtoul([[hexStringColor substringWithRange:NSMakeRange(5, 2)] UTF8String] , 0, 16);
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {   // 将白色变成透明
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }

    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end
