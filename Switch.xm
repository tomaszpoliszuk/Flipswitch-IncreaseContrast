#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface IncreaseContrastSwitch : NSObject <FSSwitchDataSource>
@end

extern "C" BOOL _AXDarkenSystemColors();
extern "C" void _AXSSetDarkenSystemColors(BOOL);

@implementation IncreaseContrastSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return _AXDarkenSystemColors() ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	_AXSSetDarkenSystemColors(newState == FSSwitchStateOn);
}

@end
