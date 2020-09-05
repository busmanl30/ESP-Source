#import "CGView.h"

@implementation CGView {

unsigned int (*enemyboxes)[4];
unsigned int enemyboxesCount;
unsigned int (*enemylines)[2];
unsigned int enemylinesCount;


unsigned int (*friendlyboxes)[4];
unsigned int friendlyboxesCount;
unsigned int (*friendlylines)[2];
unsigned int friendlylinesCount;

}

UIView *v;


- (id)initWithFrame
{

    v = [UIApplication sharedApplication].keyWindow;
 
    //v = self;
    CGRect screen = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:screen];
    //self.center = mainWindow.center;
    self.layer.opacity = 1.0f;
    self.backgroundColor = [UIColor clearColor];
    
    if (self) {
     enemyboxes = (unsigned int (*)[4])malloc(0);
     enemyboxesCount = 0;

     enemylines = (unsigned int (*)[2])malloc(0);
     enemylinesCount = 0;

     friendlyboxes = (unsigned int (*)[4])malloc(0);
     friendlyboxesCount = 0;

     friendlylines = (unsigned int (*)[2])malloc(0);
     friendlylinesCount = 0;
    }
    
//    [self addSubview:v];
//    [self bringSubviewToFront:v];

//[self drawRect:frame];
    [self setUserInteractionEnabled:NO];
    //[v setNeedsDisplay]; 
    [v addSubview: self];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{

for (int i = 0; i < enemyboxesCount; i++) {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 255);

    CGContextSetLineWidth(context, 2 * ([[UIScreen mainScreen]bounds].size.width * 1/600));
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect outline = CGRectMake(enemyboxes[i][0], enemyboxes[i][1], enemyboxes[i][2], enemyboxes[i][3]);
    CGContextAddRect(context, outline);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, [[UIScreen mainScreen]bounds].size.width * 1/600);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rectangle = CGRectMake(enemyboxes[i][0], enemyboxes[i][1], enemyboxes[i][2], enemyboxes[i][3]);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}

for (int i = 0; i < enemylinesCount; i++)
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    /*
    UIBezierPath *border = [UIBezierPath bezierPath];
    [border moveToPoint:CGPointMake(screenBounds.size.width / 2, screenBounds.size.height * 0)];
    [border addLineToPoint:CGPointMake(enemylines[i][0], enemylines[i][1])];
    border.lineWidth = 3;
    [[UIColor blackColor] setStroke];
    [border stroke];
    */

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(screenBounds.size.width / 2, screenBounds.size.height * 0)];
    [path addLineToPoint:CGPointMake(enemylines[i][0], enemylines[i][1])];
    path.lineWidth = [[UIScreen mainScreen]bounds].size.width * 1/600;
    [[UIColor redColor] setStroke];
    [path stroke];
}

for (int i = 0; i < friendlyboxesCount; i++) {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 255);

    CGContextSetLineWidth(context, 2 * [[UIScreen mainScreen]bounds].size.width * 1/600);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect outline = CGRectMake(friendlyboxes[i][0], friendlyboxes[i][1], friendlyboxes[i][2], friendlyboxes[i][3]);
    CGContextAddRect(context, outline);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, [[UIScreen mainScreen]bounds].size.width * 1/600);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGRect rectangle = CGRectMake(friendlyboxes[i][0], friendlyboxes[i][1], friendlyboxes[i][2], friendlyboxes[i][3]);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}

for (int i = 0; i < friendlylinesCount; i++)
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
 
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(screenBounds.size.width / 2, screenBounds.size.height * 0)];
    [path addLineToPoint:CGPointMake(friendlylines[i][0], friendlylines[i][1])];
    path.lineWidth = [[UIScreen mainScreen]bounds].size.width * 1/600;
    [[UIColor greenColor] setStroke];
    [path stroke];
}

[v setNeedsDisplay];
[self clearDraw];
//[self drawLine:context];
//[self enableSetNeedsDisplay:YES];
}



-(void) addEnemyBox:(float)x y:(float)y w:(float)w h:(float)h {
enemyboxesCount++;
enemyboxes = (unsigned int (*)[4])realloc(enemyboxes, enemyboxesCount*sizeof(unsigned int[4]));
enemyboxes[enemyboxesCount-1][0] = x;
enemyboxes[enemyboxesCount-1][1] = y;
enemyboxes[enemyboxesCount-1][2] = w;
enemyboxes[enemyboxesCount-1][3] = h;
}


-(void) addEnemyLine:(float)x y:(float)y{
enemylinesCount++;
enemylines = (unsigned int (*)[2])realloc(enemylines, enemylinesCount*sizeof(unsigned int[2]));
enemylines[enemylinesCount-1][0] = x;
enemylines[enemylinesCount-1][1] = y;

}

-(void) addFriendlyBox:(float)x y:(float)y w:(float)w h:(float)h {
friendlyboxesCount++;
friendlyboxes = (unsigned int (*)[4])realloc(friendlyboxes, friendlyboxesCount*sizeof(unsigned int[4]));
friendlyboxes[friendlyboxesCount-1][0] = x;
friendlyboxes[friendlyboxesCount-1][1] = y;
friendlyboxes[friendlyboxesCount-1][2] = w;
friendlyboxes[friendlyboxesCount-1][3] = h;
}


-(void) addFriendlyLine:(float)x y:(float)y{
friendlylinesCount++;
friendlylines = (unsigned int (*)[2])realloc(friendlylines, friendlylinesCount*sizeof(unsigned int[2]));
friendlylines[friendlylinesCount-1][0] = x;
friendlylines[friendlylinesCount-1][1] = y;

}

-(void)clearDraw{
enemyboxesCount = 0;
enemyboxes = (unsigned int (*)[4])realloc(enemyboxes, enemyboxesCount*sizeof(unsigned int[4]));
enemylinesCount = 0;
enemylines = (unsigned int (*)[2])realloc(enemylines, enemylinesCount*sizeof(unsigned int[2]));

friendlyboxesCount = 0;
friendlyboxes = (unsigned int (*)[4])realloc(friendlyboxes, friendlyboxesCount*sizeof(unsigned int[4]));
friendlylinesCount = 0;
friendlylines = (unsigned int (*)[2])realloc(friendlylines, friendlylinesCount*sizeof(unsigned int[2]));

}


@end