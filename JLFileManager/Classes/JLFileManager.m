//
//  JLFileManager.m
//  JLFileManager
//
//  Created by xp on 2018/3/12.
//

#import "JLFileManager.h"
#import "AFNetworking.h"
#import "FileInfo.h"

@implementation JLFileManager


/**
 获取文件数据

 @param filInfo 文件信息
 @param dUrl 下载地址（用于外部拼接下载地址）
 @param succesfull 下载成功回调
 */
- (void)getFileDataByInfo:(FileInfo *)filInfo
                 andDUrl:(NSString *)dUrl
              succesfull:(void (^)(FileInfo *filInfo, NSString *mes))succesfull{
    
    NSString *filePath =[NSString stringWithFormat:@"%@/%@",self.filePath,filInfo.f_idName];
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dUrl]];
    //下载Task操作
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"总大小：%lld,当前大小:%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString *mes = @"";
        if(error){
//            [SVProgressHUD showError:((NSError *)error).localizedDescription];
            mes = ((NSError *)error).localizedDescription;
            filInfo.f_localPath = @"";
        }else{
            if (filePath==nil) {
                filInfo.f_localPath = @"";
                mes = @"返回地址为空";
            }else{
                filInfo.f_localPath = filePath.path;
                NSLog(@"下载成功！");
                mes = @"下载成功！";
            }
        }
        
        if (succesfull) {
            succesfull(filInfo,mes);
        }
    }];
    [task resume];
}

//@TODO:是否有该文件
- (BOOL) haveThisFileBy:(NSString *)fileName{
    BOOL have = NO;
    
    if (![self isEffective:self.filePath]) {
        NSLog(@"文件路径为空");
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",self.filePath,fileName]] && [self isEffective:fileName]) {
        have = YES;
    }
    
    return have;
}



- (BOOL)isEffective:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

@end
