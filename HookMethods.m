#import "HookMethods.h"

@implementation HookMethods
- (BOOL)orig_textFieldShouldReturn:(id)arg1 {
	// Return a BOOL for compilation
	// Method implementation will be replaced with the original implementation using HookClassConformingToProtocol
	return YES;
}

- (BOOL)hook_textFieldShouldReturn:(id)arg1 {
	if (![arg1 hasText]) {
		[arg1 resignFirstResponder];
	}
	
	return [self orig_textFieldShouldReturn:arg1];
}
@end