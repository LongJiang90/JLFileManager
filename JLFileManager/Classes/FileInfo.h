//
//  FileInfo.h
//  AFNetworking
//
//  Created by xp on 2018/3/12.
//

#import <Foundation/Foundation.h>

@interface FileInfo : NSObject
//文档、音频
@property (nonatomic,copy) NSString *f_url;/**< 文件的下载网址 */
@property (nonatomic,copy) NSString *f_name;/**< 文件的显示名称 */
@property (nonatomic,copy) NSString *f_idName;/**< 文件的保存名称 用它来判断本地是否已经下载过该文件（一般取文件网址中最后一个反斜杠后的值） */
@property (nonatomic,copy) NSString *f_localPath;/**< 文件的本地路径 */
//视频
@property (nonatomic,strong) UIImage *f_videoImg;/**< 视频文件首帧图片 */
@property (nonatomic,copy) NSString *f_videoImgUrl;/**< 视频首帧图片Url */
@property (nonatomic,assign) NSUInteger f_duration;/**< 音视频的时长 */

@end
