# 集成步骤
* 将ZQPayKit.framework和ZQPayKitResource.bundle拖到工程中
* `Linked Frameworks and Libraries`里添加以下项
```
libstdc++.6.0.9.tbd
AudioToolbox.framework
Security.framework
```
* CocoaPods依赖以下三方库
```
pod 'YTKNetwork', '2.0.4’
pod 'MBProgressHUD', '1.1.0’
pod 'SDWebImage', '4.2.3’
pod 'Masonry', '1.1.0’
pod 'YYModel', '1.0.4’
pod 'YYText', '1.0.7'
pod 'MJRefresh', '3.1.15.1’
pod 'IQKeyboardManager', '5.0.7’
pod 'ZXingObjC', '3.2.2'
```
* `Build Settings的Other Linker Flags`添加`-ObjC`

#### 接口说明和调用请参考demo工程以及framework中的.h文件
