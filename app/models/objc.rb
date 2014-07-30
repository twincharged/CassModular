







#import "AppDelegate.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  CGRect viewRect = [[UIScreen mainScreen] bounds];
  self.window = [[UIWindow alloc] initWithFrame:viewRect];
  UIViewController *viewController = [[UIViewController alloc] init];
  UIView *view = [[UIView alloc] initWithFrame:viewRect];
  view.backgroundColor = [UIColor lightGrayColor];

  viewController.view = view;

  self.window.rootViewController = viewController;
  [self.window makeKeyAndVisible];

  NSLog(@"Screen is %f tall and %f wide", viewRect.size.height, viewRect.size.width);
  
  return YES;
}
@end