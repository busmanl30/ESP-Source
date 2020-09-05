#include <CoreGraphics/CoreGraphics.h>

@interface CGView : UIView

-(id)initWithFrame;
-(void)drawRect:(CGRect)rect;
-(void) addEnemyBox:(float)x y:(float)y w:(float)w h:(float)h;
-(void) addEnemyLine:(float)x y:(float)y;

-(void) addFriendlyBox:(float)x y:(float)y w:(float)w h:(float)h;
-(void) addFriendlyLine:(float)x y:(float)y;

-(void) clearDraw;

@end 