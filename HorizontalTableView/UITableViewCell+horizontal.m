//
//  UITableViewCell+horizontal.m
//
//  Created by DING FENG on 13-12-10.
//

#import "UITableViewCell+horizontal.h"
static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";
@implementation UITableViewCell (horizontal)
@dynamic haveRotated;



-(NSString *)haveRotated
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}
-(void)setHaveRotated:(NSString*)haveRotated
{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, haveRotated, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)rotateCoordinat
{
    if (![self.haveRotated isEqualToString:@"haveRotated"])
    {
        self.transform  =CGAffineTransformMakeRotation(M_PI);
        for (UIView *subView in self.contentView.subviews)
        {

            float Ay= (subView.frame.origin.y + subView.frame.size.height/2)-(subView.frame.origin.x+subView.frame.size.width/2);

            float Ax= (subView.frame.origin.x + subView.frame.size.width/2)-(self.frame.size.height-subView.frame.origin.y-subView.frame.size.height/2);

            subView.transform=CGAffineTransformConcat( CGAffineTransformMakeRotation(-M_PI/2),CGAffineTransformMakeTranslation(Ay,-Ax));
        }
        self.haveRotated = @"haveRotated";
    }
}

@end
