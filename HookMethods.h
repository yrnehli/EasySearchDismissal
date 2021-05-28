#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HookMethods : NSObject
- (BOOL)hook_textFieldShouldReturn:(id)arg1;
- (BOOL)orig_textFieldShouldReturn:(id)arg1;
@end