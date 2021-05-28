#import <UIKit/UIKit.h>
#import "HookClassConformingToProtocol.h"

@interface UISearchBar()
- (void)_searchFieldReturnPressed;
- (void)_cancelButtonPressed;
@end

@interface UITextField()
-(void)_detachFieldEditor;
-(void)_willUpdateAfterDetachingFieldEditor;
@end