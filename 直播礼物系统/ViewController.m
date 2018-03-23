//
//  ViewController.m
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LSLivingGiftShowLayerView.h"
@interface ViewController ()

@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设备之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层


@property (nonatomic, strong) LSLivingGiftShowLayerView * showLayerView;
@property (nonatomic, strong) NSArray * giftNameArray;
@property (nonatomic, strong) NSArray * personNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
        return;
    }
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    //初始化设备输出对象，用于获得输出数据
    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer=self.view.layer;
    layer.masksToBounds=YES;
    
    _captureVideoPreviewLayer.frame=layer.bounds;
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    [layer addSublayer:_captureVideoPreviewLayer];
    
    
    
    self.giftNameArray = @[@"飞机",@"玫瑰花",@"赛车",@"大礼包",@"火炮"];
    self.personNameArray = @[@"张三",@"李四",@"王五",@"赵六",@"遂宁",@"时雨",@"",@"夏至",@"钱伟豪",@"张启三",@"李弘彬",];
    [self.view addSubview:self.showLayerView];
    [self.showLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(120);
        make.height.mas_equalTo(170);
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.captureSession){
        [self.captureSession startRunning];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}

- (LSLivingGiftShowLayerView *) showLayerView
{
    if (!_showLayerView) {
        
        _showLayerView = [[LSLivingGiftShowLayerView alloc] init];
    }
    return _showLayerView;
}

#pragma mark - 私有方法

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_captureDeviceInput) {
        return;
    }
    //生成 0-9 十个人
    int personId = arc4random() % 10;
    NSString * person_id = [NSString stringWithFormat:@"person_%d",personId];
    NSString * personName = self.personNameArray[personId];
    //设置礼物
    int giftId = arc4random() % 5;
    NSString * gift_id = [NSString stringWithFormat:@"lw%d",giftId];

    NSString * giftName = self.giftNameArray[giftId];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:person_id forKey:@"person_id"];
    [dic setObject:personName forKey:@"personName"];
    [dic setObject:gift_id forKey:@"gift_id"];
    [dic setObject:giftName forKey:@"giftName"];
    
    [self.showLayerView addGigtData:dic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
