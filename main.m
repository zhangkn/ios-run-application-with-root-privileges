#import "KNAppDelegate.h"

int main(int argc, char *argv[]) {
	@autoreleasepool {



		        // Set uid and gid
        if (!(setuid(0) == 0 && setgid(0) == 0))
        {
            NSLog(@"Failed to gain root privileges, aborting...");
            exit(EXIT_FAILURE);
        }
        
        // Launch app

		return UIApplicationMain(argc, argv, nil, NSStringFromClass(KNAppDelegate.class));
	}
}
