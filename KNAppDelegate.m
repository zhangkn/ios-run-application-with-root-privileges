#import "KNAppDelegate.h"
#import "KNRootViewController.h"

@implementation KNAppDelegate

int	 system(const char *);
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[UINavigationController alloc] initWithRootViewController:[[KNRootViewController alloc] init]];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];


//         //http://blog.ib-soft.net/2013/01/ios-run-application-with-root-privileges.html

    // setuid(0);
    // setgid(0);


	 NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/Frameworks/UIKit.Framework"];
    BOOL success = [b load];
    Class UIApplication = NSClassFromString(@"UIApplication");
    id app = [UIApplication sharedApplication];
    Class UIWebClip = NSClassFromString(@"UIWebClip");
    id clip = [[UIWebClip class] performSelector:@selector(webClipWithIdentifier:)
                                      withObject:nil];
    NSLog(@"%@",clip);
    NSLog(@"%@", [[UIWebClip class] performSelector:@selector(webClipsDirectoryPath)]);
    if ([clip respondsToSelector:@selector(createOnDisk)]) {
        [clip performSelector:@selector(createOnDisk) withObject:nil];//Couldn't create WebClip bundle
        // Couldn't save WebClip Info.plist
    }
    if ([clip respondsToSelector:@selector(setIconImage:isPrecomposed:)]) {
        [clip performSelector:@selector(setIconImage:isPrecomposed:)
                   withObject:[UIImage imageNamed:@"maps"]
                   withObject:[NSNumber numberWithBool:YES]];
    }
    if ([clip respondsToSelector:@selector(setIdentifier:)]) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        NSString *uuidstr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
        [clip performSelector:@selector(setIdentifier:) withObject:uuidstr];
    }
    if ([clip respondsToSelector:@selector(setPageURL:)]) {
        //[clip performSelector:@selector(setPageURL:) withObject:[NSURL URLWithString:@"sms:9738203842"]];
    }
    if ([clip respondsToSelector:@selector(setTitle:)]) {
        [clip setValue:@"Test" forKeyPath:@"title"];
    }
    
     // if ([clip respondsToSelector:@selector(updateOnDisk)]) {
     // [clip performSelector:@selector(updateOnDisk) withObject:nil];// Couldn't save WebClip Info.plist
     // }
     
    NSLog(@"%@",[clip valueForKeyPath:@"identifier"]);
    if ([app respondsToSelector:@selector(addWebClipToHomeScreen:)]) {
        [app performSelector:@selector(addWebClipToHomeScreen:) withObject:[clip valueForKeyPath:@"identifier"]];
    }

// /System/Library/PrivateFrameworks/WebApp.framework/Info.plist

// /var/mobile/Library/Preferences
// /private/var/mobile/Containers/Data/Application/316F71CA-00FE-4990-9F79-D4B490844E8F/Library/Preferences/com.apple.webapp.plist

//     5) devzkndeMacBook-Pro:~ devzkn$ plutil -p  com.apple.webapp.plist
// {
//   "WebDatabaseDirectory" => "/var/mobile/Library/WebClips/34FB814D12744D389BC18AC2FB08222C.webclip/Storage"
//   "WebKitDiskImageCacheSavedCacheDirectory" => ""
//   "WebKitLocalCache" => "/var/mobile/Containers/Data/Application/316F71CA-00FE-4990-9F79-D4B490844E8F/Library/Caches/WebClips/34FB814D12744D389BC18AC2FB08222C"
//   "WebKitLocalStorageDatabasePathPreferenceKey" => "/var/mobile/Library/WebClips/34FB814D12744D389BC18AC2FB08222C.webclip/Storage"
//   "WebKitMediaPlaybackAllowsInline" => 1
//   "WebKitMediaPlaybackRequiresUserGesture" => 0
//   "WebKitOfflineWebApplicationCacheEnabled" => 1
//   "WebKitShrinksStandaloneImagesToFit" => 1
//   "WebKitStandalonePreferenceKey" => 1
//   "WebKitStorageTrackerEnabledPreferenceKey" => 1
// }

    // system("reboot");
}

- (void)dealloc {
	[_window release];
	[_rootViewController release];
	[super dealloc];
}

@end
