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

static BOOL (*original_textFieldShouldReturn)(id self, SEL _cmd, UITextField *textField);

static BOOL replaced_textFieldShouldReturn(id self, SEL _cmd, UITextField *textField) {
	if (![textField hasText]) {
		[textField resignFirstResponder];
	}
	
	return (*original_textFieldShouldReturn)(self, _cmd, textField);
}

%ctor {
	unsigned classCount;
	Class *classes = objc_copyClassList(&classCount);
	
	for (int i = 0; i < classCount; i++) {
		Class clazz = classes[i];
		SEL selector = @selector(textFieldShouldReturn:);

		if (class_conformsToProtocol(clazz, @protocol(UITextFieldDelegate)) && class_getInstanceMethod(clazz, selector)) {
			MSHookMessageEx(
				clazz,
				selector,
				(IMP)&replaced_textFieldShouldReturn,
				(IMP*)&original_textFieldShouldReturn
			);
		}
	}

	free(classes);
}