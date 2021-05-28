#import "Tweak.h"

%hook UITextInputTraits
- (void)setEnablesReturnKeyAutomatically:(BOOL)arg1 {
	%orig(NO);
}
%end

%hook UISearchBar
- (void)_searchFieldReturnPressed {
	%orig;
	
	if (!self.text || !self.text.length) {
		[self _cancelButtonPressed];
	}
}
%end

%ctor {
	HookClassConformingToProtocol *hooker = [[HookClassConformingToProtocol alloc] init];
	[hooker implementMethodHooks:@protocol(UITextFieldDelegate) selectorName:@"textFieldShouldReturn:"];
}