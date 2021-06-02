/* Flipswitch toggle for Darken Colors/Increase Contrast
 * Copyright (C) 2020 Tomasz Poliszuk
 *
 * Flipswitch toggle for Darken Colors/Increase Contrast is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License, or (at your option) version 2.1 of the License
 *
 * Flipswitch toggle for Darken Colors/Increase Contrast is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Flipswitch toggle for Darken Colors/Increase Contrast. If not, see <https://www.gnu.org/licenses/>.
 */


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
	NSURL *url = [NSURL URLWithString:(kCFCoreFoundationVersionNumber >= 1665.0f ? @"prefs:root=ACCESSIBILITY&path=DISPLAY_AND_TEXT#TEXT_COLORS_DARKEN" : @"prefs:root=General&path=ACCESSIBILITY/ENHANCE_BACKGROUND_CONTRAST#DARKEN_COLORS")];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
	return (kCFCoreFoundationVersionNumber > 1665.0f ? @"Increase Contrast" : @"Darken Colors");
}

@end
