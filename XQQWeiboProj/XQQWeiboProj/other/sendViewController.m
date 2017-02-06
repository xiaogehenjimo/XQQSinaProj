//
//  sendViewController.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/6.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "sendViewController.h"
#import "XQQTextView.h"
#import "XQQSendToolbar.h"
#import "XQQFaceView.h"
#import "XQQFaceModel.h"
@interface sendViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  左侧按钮
 */
@property(nonatomic, strong)  UIButton  *  cancelBtn;
/**
 *  右侧按钮
 */
@property(nonatomic, strong)  UIButton  *  sendBtn;
/**
 *  titleView
 */
@property(nonatomic, strong)  UIView    *  titleView;
/**
 *  输入的view
 */
@property(nonatomic, strong)  XQQTextView  *  writerView;
/**
 *  底部的view
 */
@property(nonatomic, strong)  UIView  *  bottomView;
/**
 *  底部工具栏
 */
@property(nonatomic, strong)  XQQSendToolbar * toolbar;
/**
 *  表情的view
 */
@property(nonatomic, strong)  XQQFaceView * faceView;
/**
 *  表情按钮
 */
@property(nonatomic, strong)  UIButton  *  faceBtn;
@end

@implementation sendViewController
{
    BOOL _isFaceViewShow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化UI
    [self initUI];
    //监听键盘  或者发送表情
    [self keyboard];
}
/**
 *  初始化UI
 */
- (void)initUI{
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancelBtn];
        leftItem;
    });
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.sendBtn];
        rightItem.enabled = NO;
        rightItem;
    });
    //titleView
    self.navigationItem.titleView = self.titleView;
    
    //创建textview
    [self.view addSubview:self.writerView];
    //底部的view
    _toolbar = [[XQQSendToolbar alloc]initWithFrame:CGRectMake(0, iphoneHeight - 44, iphoneWidth, 44)];
    self.faceBtn = _toolbar.faceBtn;
    _toolbar.backgroundColor = [UIColor yellowColor];
    __weak typeof(self) weakSelf = self;
    _toolbar.buttonDidPress = ^(NSInteger btnTag){
        [weakSelf bottomBtnDidress:btnTag];
    };
    [self.view addSubview:_toolbar];
    //创建表情view
    _faceView = [[XQQFaceView alloc]initWithFrame:CGRectMake(0, iphoneHeight-250, iphoneWidth, 250)];
    _faceView.bottomFaceTypeBtnPress = ^(NSInteger btnIndex){
        [weakSelf bottomFaceTypeBtnPress:btnIndex];
    };
    _isFaceViewShow = NO;
    
}
- (void)keyboard{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelFace:) name:@"face" object:nil];
}
#pragma mark - activity
/**
 *  选择表情
 *
 *  @param notice 传递的值
 */
- (void)didSelFace:(NSNotification*)notice{
    XQQFaceModel * model = notice.object;
    NSTextAttachment *  Attachment = [[NSTextAttachment alloc]init];
    if ([model.png isEqualToString:@""]||model.png == nil) {
        [self.writerView insertText:model.code.emoji];
    }else{
        Attachment.image = [UIImage imageNamed:model.png];
        
        NSAttributedString * str = [NSAttributedString attributedStringWithAttachment:Attachment];
        [self.writerView insertAttributedText:str];
    }
}
/**
 *  进入相册选择图片
 */
- (void)howToSelPhoto{
    //进入相册选择图片
    UIActionSheet * actionSheet = [UIActionSheet actionSheetWithTitle:@"选择图片" cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册选取" otherButtonTitles:@[@"拍照"] clickBlock:^(NSInteger clickIndex) {
        if (clickIndex == 0) {
            //相册选取
            NSLog(@"相册选取");
            [self LocalPhoto];
            
        }else if(clickIndex == 2){
            //拍照
            NSLog(@"拍照");
            [self takePhoto];
        }else if (clickIndex == 1){
            NSLog(@"取消");
        }
    }];
    [actionSheet showInView:self.view];
}
/**
 * 表情种类按钮点击
 */
- (void)bottomFaceTypeBtnPress:(NSInteger)btnTag{
    
}
#pragma mark - 选择图片
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

/**
 * 底部按钮点击事件
 */
- (void)bottomBtnDidress:(NSInteger)btnTag{
    switch (btnTag) {
        case 0:{
            //进入图片浏览器
            [self howToSelPhoto];
        }
            break;
        case 1:{
            NSLog(@"@人");
        }
            break;
        case 2:{
            NSLog(@"井");
        }
            break;
        case 3:{
            if (self.writerView.inputView == nil) {
                self.writerView.inputView = _faceView;
                //换图片
                [self setFaceBtnImageWithNormalName:@"compose_keyboardbutton_background" HighlightedName:@"compose_keyboardbutton_background_highlighted"];
            }else{
                [self setFaceBtnImageWithNormalName:@"compose_emoticonbutton_background" HighlightedName:@"compose_keyboardbutton_background_highlighted"];
                self.writerView.inputView = nil;
            }
            [self.writerView endEditing:YES];
            [self.writerView becomeFirstResponder];
        }
            break;
        case 4:{
            NSLog(@"加号");
        }
            break;
        default:
            break;
    }
}
/**
 * 顶部按钮点击事件
 */
- (void)navBtnClicked:(UIButton*)button{
    switch (button.tag) {
        case 12345:{//取消
            [self dismissViewControllerAnimated:YES completion:^{
                _cancelBtnPress();
            }];
        }
            break;
        case 23456:{//发送
            
        }
            break;
            
        default:
            break;
    }
}
- (void)textChange:(NSNotification*)not{
    if (not.object == _writerView) {
        if (_writerView.hasText) {
            self.navigationItem.rightBarButtonItem.enabled = _writerView.hasText;
            self.sendBtn.backgroundColor = [UIColor yellowColor];
        }else{
            self.navigationItem.rightBarButtonItem.enabled = _writerView.hasText;
            self.sendBtn.backgroundColor = [UIColor grayColor];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@", info);
   // NSURL* localUrl =(NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //获取到图片
        // 保存图片到相册中
        //[self sendImageMessageWithImage:theImage andURL:localUrl];
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){/*
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        [picker dismissViewControllerAnimated:YES completion:^{
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"isShowPicker"];
        }];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        EMChatVideo *chatVideo = [[EMChatVideo alloc] initWithFile:[mp4 relativePath] displayName:@"video.mp4"];
        [self sendVideoMessageWithLocalPath:chatVideo AndLocalPath:[mp4 relativePath]];
    */}
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //改变toolbar的Y
    CGRect toolbarFrame = _toolbar.frame;
//    _faceView .frame = CGRectMake(0, iphoneHeight-height, iphoneWidth, height);
    _toolbar.frame = CGRectMake(toolbarFrame.origin.x, iphoneHeight - height - toolbarFrame.size.height, toolbarFrame.size.width, toolbarFrame.size.height);
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    CGRect toolbarFrame = _toolbar.frame;
    _toolbar.frame = CGRectMake(toolbarFrame.origin.x, iphoneHeight - toolbarFrame.size.height, toolbarFrame.size.width, toolbarFrame.size.height);
}
#pragma mark - setter&getter
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _cancelBtn.tag = 12345;
        [_cancelBtn addTarget:self action:@selector(navBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _sendBtn.tag = 23456;
        _sendBtn.backgroundColor = [UIColor grayColor];
        [_sendBtn addTarget:self action:@selector(navBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
- (UITextView *)writerView{
    if (!_writerView) {
        _writerView = [[XQQTextView alloc]initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 44)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:_writerView];
    }
    return _writerView;
}
- (UIView *)titleView{
    if (!_titleView) {
        NSString * userName = [[LPUtility unarchiveDataFromCache:@"userName"] firstObject];
        CGSize size = [userName boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        CGFloat titleViewX = iphoneWidth / 2 - size.width;
        CGFloat titleViewY = 0;
        CGFloat titleViewW = size.width;
        CGFloat titleViewH = 40;
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH)];
        //label
        CGFloat titleLabelX = titleViewW/2 - 30;
        CGFloat titleLabelY = 0;
        CGFloat titleLabelW = 60;
        CGFloat titleLabelH = 20;
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"发微博";
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_titleView addSubview:titleLabel];
        //userName
        CGFloat userNameLabelX = titleViewW/2-titleViewW/2;
        CGFloat userNameLabelY = CGRectGetMaxY(titleLabel.frame);
        CGFloat userNameLabelW = titleViewW;
        CGFloat userNameLabelH = 20;
        UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(userNameLabelX, userNameLabelY, userNameLabelW, userNameLabelH)];
        userNameLabel.textAlignment = NSTextAlignmentCenter;
        userNameLabel.text = userName;
        [_titleView addSubview:userNameLabel];
    }
    return _titleView;
}
- (void)faceViewShow{
    CGRect faceViewFrame = _faceView.frame;
    CGRect toolbarFrame = _toolbar.frame;
    _faceView.frame = CGRectMake(faceViewFrame.origin.x, iphoneHeight - 300, faceViewFrame.size.width, 300);
    _toolbar.frame = CGRectMake(toolbarFrame.origin.x, iphoneHeight - toolbarFrame.size.height - 300, toolbarFrame.size.width, toolbarFrame.size.height);
}
- (void)faceViewHide{
    CGRect faceViewFrame = _faceView.frame;
    CGRect toolbarFrame = _toolbar.frame;
    _faceView.frame = CGRectMake(faceViewFrame.origin.x, iphoneHeight, faceViewFrame.size.width, 300);
    _toolbar.frame = CGRectMake(toolbarFrame.origin.x, iphoneHeight - toolbarFrame.size.height, toolbarFrame.size.width, toolbarFrame.size.height);
}
//给表情btn设置图片
- (void)setFaceBtnImageWithNormalName:(NSString*)normalName HighlightedName:(NSString*)HighlightedName{
    [self.faceBtn setBackgroundImage:[[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self.faceBtn setBackgroundImage:[[UIImage imageNamed:HighlightedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateHighlighted];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
