//
//  JLFileManager.h
//  JLFileManager
//
//  Created by xp on 2018/3/12.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CachesDirectory = 0,
    DocumentDirectory,
} FileDirectory;

@interface JLFileManager : NSObject

///存入文件的路径
@property (nonatomic, copy) NSString *filePath;/**< 文件层次路径 需要自定义时使用， */
@property (nonatomic, assign) FileDirectory fileDirectory;/**< 是存在缓存里还是文档里 */





@end
