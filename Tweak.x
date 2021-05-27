#import <UIKit/UIKit.h>

%hook UISearchTextField
- (BOOL)hasText {
	return YES;
}
%end