#import "Tweak.h"

%hook UISearchTextField
- (BOOL)hasText {
	return YES;
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