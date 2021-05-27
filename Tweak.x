#import "Tweak.h"

%hook UISearchTextField
- (BOOL)hasText {
	return YES;
}
%end

%hook UISearchBar
- (void)_searchFieldReturnPressed {
	if (!self.text || !self.text.length) {
		[self _cancelButtonPressed];
	} else {
		return %orig;
	}
}
%end