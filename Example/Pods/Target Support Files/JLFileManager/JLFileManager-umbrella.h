#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FileInfo.h"
#import "JLFileManager.h"
#import "ShowFileVC.h"

FOUNDATION_EXPORT double JLFileManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char JLFileManagerVersionString[];

