<<<<<<< HEAD
# CIQRCodeGenerator

### 用来生成一个高清二维码以及指定颜色的高清二维码<br/>
```
pod 'CIQRCodeGenerator', '~> 1.0.2'
```

#### 主要代码如下:
  ```
  CGFloat codeWidth = 150;
    
  HYCIQRCodeGenerator *codeGenrator = [[HYCIQRCodeGenerator alloc] initWithFrame:CGRectMake((self.view.frame.size.width - codeWidth) / 2.0, (self.view.frame.size.height - codeWidth) / 2.0, codeWidth, codeWidth)];
    
  //生成普通的高清二维码<br/>
  BOOL success = [codeGenrator generatedCIQRCodeWithAddress:@"http://www.baidu.com"];
    
  //生成带颜色的高清二维码<br/>
  success = [codeGenrator generatedCIQRCodeWithAddress:@"http://www.baidu.com" withHexColorString:@"#FF0000"];
  ```
  ![](https://github.com/hotwill07/CIQRCodeGenerator/blob/master/normal.png)  ![](https://github.com/hotwill07/CIQRCodeGenerator/blob/master/color.png)
=======
# CIQRCodeGenerator
>>>>>>> 904a03c01de940775f316a9738ad8c64585cc8f9
