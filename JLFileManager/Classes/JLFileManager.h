//
//  JLFileManager.h
//  JLFileManager
//
//  Created by xp on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "FileInfo.h"

@interface JLFileManager : NSObject

///存入文件的路径
@property (nonatomic, copy) NSString *filePath;/**< 可以随意修改 */

/**
 获取文件数据
 
 @param filInfo 文件信息
 @param dUrl 下载地址（用于外部拼接下载地址）
 @param succesfull 下载成功回调
 */
- (void)getFileDataByInfo:(FileInfo *)filInfo
                  andDUrl:(NSString *)dUrl
               succesfull:(void (^)(FileInfo *filInfo, NSString *mes))succesfull;
/**
 清理传入路径下的缓存文件（直接清理）

 @param path 需要清理的路径
 */
- (void)clearCache:(NSString *)path;
/**
 清除路径下的缓存（会弹出一个提示框展示文件总大小，然后选择清理 才会删除缓存）
 
 @param path 路径
 */
- (void)clearCacheWithAlterView:(NSString *)path sureClear:(void (^)(void))sureBlock;
/**
 计算路径下文件的大小

 @param path 需要计算大小的路径
 @return 文件总大小
 */
- (float)folderSizeAtPath:(NSString *)path;

/**
 是否存在该文件

 @param fileName 文件名称
 @return 是否存在
 */
- (BOOL)haveThisFile:(NSString *)fileName inPath:(NSString *)path;



@end
