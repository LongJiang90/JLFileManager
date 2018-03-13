//
//  JLFileManager.m
//  JLFileManager
//
//  Created by xp on 2018/3/12.
//

#import "JLFileManager.h"
#import "AFNetworking.h"


@implementation JLFileManager
///获取文件数据
- (void)getFileDataByInfo:(FileInfo *)filInfo
                 andDUrl:(NSString *)dUrl
              succesfull:(void (^)(FileInfo *filInfo, NSString *mes))succesfull{
    
    if (![self isEffective:filInfo.f_idName]) {
        if (succesfull) {
            succesfull(filInfo,@"FileInfo对象的f_idName是必须有值，用于存储的唯一标识符");
        }
        return;
    }
    
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
- (BOOL)haveThisFile:(NSString *)fileName inPath:(NSString *)path{
    BOOL have = NO;
    
    if (![self isEffective:path]) {
        NSLog(@"文件路径为空");
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",path,fileName]] && [self isEffective:fileName]) {
        have = YES;
    }
    
    return have;
}

//@TODO:清理缓存
- (void)clearCacheWithAlterView:(NSString *)path sureClear:(void (^)(void))sureBlock{
    UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aW.rootViewController = [[UIViewController alloc]init];
    aW.windowLevel = UIWindowLevelAlert + 1;
    [aW makeKeyAndVisible];
    
    float fileSize = [self folderSizeAtPath:path];
    
    NSString *message = [NSString stringWithFormat:@"共计缓存:%.1fM,确定要清理缓存吗？",fileSize];
    if (fileSize < 0.1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"暂时没有缓存文件" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController view];
        [aW.rootViewController presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachePath = [cacPath objectAtIndex:0];
            [self clearCache:cachePath];
            
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [alertController view];
        [aW.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
//@TODO:计算目录大小
- (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
//        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
//@TODO:计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//@TODO:清理缓存文件
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
//    [[SDImageCache sharedImageCache] clearMemory];
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
