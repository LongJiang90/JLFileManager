//
//  JLFileManager.m
//  JLFileManager
//
//  Created by xp on 2018/3/12.
//

#import "JLFileManager.h"

@implementation JLFileManager

//@TODO:是否有该文件
- (BOOL) haveThisFileBy:(NSString *)fileName{
    BOOL have = NO;
    //存放图片的文件夹
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    NSString *filePath =[NSString stringWithFormat:@"%@/HTFiles",cachePath];
    
    NSString *key = @"";
    if ([attInfo.pdfUrl isEffective]) {
        key = [[attInfo.pdfUrl componentsSeparatedByString:@"/"] lastObject];
    }
    key = attInfo.IdName;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",filePath,key]] && [key isEffective]) {
        //        NSLog(@"File exists");
        if (![attInfo.localPath isEffective]) {
            attInfo.localPath = [NSString stringWithFormat:@"%@/%@",filePath,key];
        }
        
        have = YES;
    }
    
    return have;
}


@end
