#import "Tweak.h"

%hook UIKeyboard
-(void)setReturnKeyEnabled:(BOOL)arg1 {
	%orig(YES);
}
%end

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