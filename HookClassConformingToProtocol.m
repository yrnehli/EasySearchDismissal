#import "HookClassConformingToProtocol.h"

@implementation HookClassConformingToProtocol
- (void)implementMethodHooks:(Protocol *)hookProtocol selectorName:(NSString *)selectorName {
	unsigned classCount;
	Class *classes = objc_copyClassList(&classCount);
	Class hookMethods = NSClassFromString(@"HookMethods");
	
	for (int i = 0; i < classCount; i++) {
		Class clazz = classes[i];
		SEL selector = NSSelectorFromString(selectorName);

		if (!class_conformsToProtocol(clazz, hookProtocol)) {
			continue;
		}

		Method originalMethod = class_getInstanceMethod(clazz, selector);

		if (originalMethod != NULL) {
			// Replace the implementation of the original placeholder method in HookMethods with the actual original implementation
			class_replaceMethod(
				clazz,
				NSSelectorFromString([@"orig_" stringByAppendingString:selectorName]),
				method_getImplementation(originalMethod),
				method_getTypeEncoding(originalMethod)
			);

			// Replace the implementation of the class method with the hook method
			Method hookMethod = class_getInstanceMethod(hookMethods, NSSelectorFromString([@"hook_" stringByAppendingString:selectorName]));
			class_replaceMethod(
				clazz,
				selector,
				method_getImplementation(hookMethod),
				method_getTypeEncoding(hookMethod)
			);
		}
	}

	free(classes);
}
@end