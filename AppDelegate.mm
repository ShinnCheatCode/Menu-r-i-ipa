#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate {
    UIButton *floatingBtn;
    UIView *menuView;
    BOOL isVisible;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.0];
    
    // Màn hình chính của app độc lập
    UIViewController *rootVC = [[UIViewController alloc] init];
    
    // Tạo tiêu đề chào mừng trên màn hình chính
    UILabel *bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
    bgLabel.text = @"SHINNTHIEUU CORE V2.0\nApp độc lập hoạt động ổn định";
    bgLabel.numberOfLines = 2;
    bgLabel.textColor = [UIColor lightGrayColor];
    bgLabel.textAlignment = NSTextAlignmentCenter;
    bgLabel.font = [UIFont boldSystemFontOfSize:16];
    [rootVC.view addSubview:bgLabel];
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    // Khởi tạo giao diện nổi sau khi app mở
    [self performSelector:@selector(setupFloatingUI) withObject:nil afterDelay:1.0];
    
    return YES;
}

- (void)setupFloatingUI {
    UIWindow *window = self.window;
    if (!window) return;

    // Nút bấm nổi ST
    floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    floatingBtn.frame = CGRectMake(40, 100, 45, 45);
    floatingBtn.backgroundColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:0.9];
    [floatingBtn setTitle:@"ST" forState:UIControlStateNormal];
    [floatingBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    floatingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    floatingBtn.layer.cornerRadius = 22.5f;
    floatingBtn.layer.borderWidth = 1.5f;
    floatingBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    [floatingBtn addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveBtn:)];
    [floatingBtn addGestureRecognizer:pan];

    // Bảng Menu ON/OFF
    menuView = [[UIView alloc] initWithFrame:CGRectMake(100, 70, 260, 340)];
    menuView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.96];
    menuView.layer.cornerRadius = 14.0f;
    menuView.layer.borderWidth = 1.0f;
    menuView.layer.borderColor = [UIColor cyanColor].CGColor;
    menuView.hidden = YES;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 260, 30)];
    titleLabel.text = @"SHINNTHIEUU // STANDALONE";
    titleLabel.textColor = [UIColor cyanColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [menuView addSubview:titleLabel];

    NSArray *features = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6"];
    for (int i = 0; i < features.count; i++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50 + (i * 42), 160, 30)];
        lbl.text = features[i];
        lbl.textColor = [UIColor whiteColor];
        lbl.font = [UIFont systemFontOfSize:12];
        [menuView addSubview:lbl];

        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(190, 50 + (i * 42), 50, 30)];
        sw.on = (i < 2);
        [menuView addSubview:sw];
    }

    [window addSubview:floatingBtn];
    [window addSubview:menuView];
}

- (void)toggleMenu {
    isVisible = !isVisible;
    menuView.hidden = !isVisible;
}

- (void)moveBtn:(UIPanGestureRecognizer *)tap {
    UIWindow *window = self.window;
    CGPoint pt = [tap translationInView:window];
    CGPoint center = CGPointMake(tap.view.center.x + pt.x, tap.view.center.y + pt.y);
    tap.view.center = center;
    [tap setTranslation:CGPointZero inView:window];
}

@end
