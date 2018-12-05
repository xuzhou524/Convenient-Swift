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

#import "Jastor.h"
#import "JastorRuntimeHelper.h"

FOUNDATION_EXPORT double jastorVersionNumber;
FOUNDATION_EXPORT const unsigned char jastorVersionString[];

