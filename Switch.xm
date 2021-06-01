#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface IncreaseContrastSwitch : NSObject <FSSwitchDataSource>
@end

extern "C" BOOL _AXDarkenSystemColors();
extern "C" void _AXSSetDarkenSystemColors(BOOL);

@implementation IncreaseContrastSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	return _AXDarkenSystemColors() ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
	if (newState == FSSwitchStateIndeterminate) {
		return;
	}
	_AXSSetDarkenSystemColors(newState == FSSwitchStateOn);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier {
	NSURL *url = [NSURL URLWithString:(kCFCoreFoundationVersionNumber > 1665.0f ? @"prefs:root=ACCESSIBILITY&path=DISPLAY_AND_TEXT#TEXT_COLORS_DARKEN" : @"prefs:root=General&path=ACCESSIBILITY/ENHANCE_BACKGROUND_CONTRAST#DARKEN_COLORS")];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
	return (kCFCoreFoundationVersionNumber > 1665.0f ? @"Increase Contrast" : @"Darken Colors");
}

@end
