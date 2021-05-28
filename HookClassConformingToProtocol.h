#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface HookClassConformingToProtocol : NSObject
- (void)implementMethodHooks:(Protocol *)hookProtocol selectorName:(NSString *)selectorName;
@end