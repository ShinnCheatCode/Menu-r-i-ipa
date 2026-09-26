#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface ShinnThieuuCore : NSObject
+ (instancetype)sharedInstance;
- (void)setupShinnThieuuUI;
@end

@implementation ShinnThieuuCore {
    UIButton *floatingBtn;
    UIView *menuView;
    BOOL isVisible;
}

+ (instancetype)sharedInstance {
    static ShinnThieuuCore *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ShinnThieuuCore inits] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        isVisible = NO;
        [self performSelector:@selector(setupShinnThieuuUI) withObject:nil afterDelay:5.0];
    }
    return self;
}

- (void)setupShinnThieuuUI {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) return;

    // Tạo biểu tượng nổi (Floating Icon)
    floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    floatingBtn.frame = CGRectMake(30, 100, 45, 45);
    floatingBtn.backgroundColor = [UIColor blackColor];
    [floatingBtn setTitle:@"ST" forState:UIControlStateNormal];
    [floatingBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    floatingBtn.layer.cornerRadius = 22.5f;
    floatingBtn.layer.borderWidth = 1.5f;
    floatingBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    [floatingBtn addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveBtn:)];
    [floatingBtn addGestureRecognizer:pan];

    // Tạo bảng Menu ON/OFF phong cách ShinnThieuu
    menuView = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 260, 320)];
    menuView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.92];
    menuView.layer.cornerRadius = 12.0f;
    menuView.layer.borderWidth = 1.0f;
    menuView.layer.borderColor = [UIColor cyanColor].CGColor;
    menuView.hidden = YES;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 260, 30)];
    titleLabel.text = @"SHINNTHIEUU // VIP";
    titleLabel.textColor = [UIColor cyanColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [menuView addSubview:titleLabel];

    NSArray *features = @[@"ESP Line", @"ESP Box 3D", @"ESP Head Red", @"Thanh máu", @"Aim khi mở ngắm", @"Speed Hack x3"];
    for (int i = 0; i < features.count; i++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50 + (i * 40), 160, 30)];
        lbl.text = features[i];
        lbl.textColor = [UIColor whiteColor];
        lbl.font = [UIFont systemFontOfSize:12];
        [menuView addSubview:lbl];

        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(190, 50 + (i * 40), 50, 30)];
        sw.on = (i < 4); // Mặc định bật vài tính năng
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
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint pt = [tap translationInView:window];
    CGPoint center = CGPointMake(tap.view.center.x + pt.x, tap.view.center.y + pt.y);
    tap.view.center = center;
    [tap setTranslation:CGPointZero inView:window];
}

@end

__attribute__((constructor)) static void initShinnThieuu() {
    [ShinnThieuuCore sharedInstance];
}
