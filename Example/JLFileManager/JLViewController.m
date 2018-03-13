//
//  JLViewController.m
//  JLFileManager
//
//  Created by 983220205@qq.com on 03/12/2018.
//  Copyright (c) 2018 983220205@qq.com. All rights reserved.
//

#import "JLViewController.h"
#import "JLFileManager.h"
#import "ShowFileVC.h"

@interface JLViewController (){
    NSString *_cachePath;
    FileInfo *_fileI;
}

@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonAction:(UIButton *)sender;
- (IBAction)clearBtnAction:(UIButton *)sender;

@property (nonatomic,strong) JLFileManager *jlFileM;

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _cachePath = [cacPath objectAtIndex:0];
    
    self.jlFileM = [JLFileManager new];
    self.jlFileM.filePath = _cachePath;
    
    _fileI = [[FileInfo alloc] init];
    _fileI.f_url = @"http://api.winowe.com/Upload/cad2b7d6-a189-4468-978a-0194c4217692.pdf";
    _fileI.f_name = @"测试文件";
    _fileI.f_idName = [[_fileI.f_url componentsSeparatedByString:@"/"] lastObject];//必须有值，因为是根据这个来存储的
    
    if ([self.jlFileM haveThisFile:_fileI.f_idName inPath:_cachePath]) {
        self.button.tag = 101;
        [self.button setTitle:@"查看文件" forState:UIControlStateNormal];
        _fileI.f_localPath = [_cachePath stringByAppendingString:_fileI.f_idName];
    }else {
        self.button.tag = 102;
        [self.button setTitle:@"下载文件" forState:UIControlStateNormal];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.jlFileM haveThisFile:_fileI.f_idName inPath:_cachePath]) {
        self.button.tag = 101;
        [self.button setTitle:@"查看文件" forState:UIControlStateNormal];
        _fileI.f_localPath = [_cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",_fileI.f_idName]];
    }else {
        self.button.tag = 102;
        [self.button setTitle:@"下载文件" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        ShowFileVC *aVC = [[ShowFileVC alloc] init];
        aVC.aFile = _fileI;
        aVC.view.frame = self.view.frame;
        
        [self presentViewController:aVC animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [aVC dismissViewControllerAnimated:YES completion:nil];
        });
    }else{
        [self downloadFileInPath:_cachePath andFileInfo:_fileI];
    }
    
}

- (IBAction)clearBtnAction:(UIButton *)sender {
    [self.jlFileM clearCacheWithAlterView:_cachePath sureClear:^(){
        _fileI.f_localPath = @"";
        
        self.button.tag = 102;
        [self.button setTitle:@"下载文件" forState:UIControlStateNormal];
    }];
}

-(void)downloadFileInPath:(NSString *)path andFileInfo:(FileInfo *)fileI {
    
    [self.jlFileM getFileDataByInfo:fileI andDUrl:fileI.f_url succesfull:^(FileInfo *filInfo, NSString *mes) {
        
        if (filInfo.f_localPath.length > 1) {
            ShowFileVC *aVC = [[ShowFileVC alloc] init];
            aVC.aFile = filInfo;
            aVC.view.frame = self.view.frame;
            
            [self presentViewController:aVC animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [aVC dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    }];
}



@end
