//
//  AppDelegate.m
//  PPTools
//
//  Created by Garenge on 2019/M/14.
//  Copyright © 2019 鹏鹏. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (!flag) {
        [NSApp activateIgnoringOtherApps:NO];// 取消其他程序的响应
        NSWindowController *windowController = [NSStoryboard mainStoryboard].instantiateInitialController;
        [windowController.window makeKeyAndOrderFront:self]; // 点击APP icon打开主界面, 方法一
        [windowController.window orderFront:nil];// 方法二
        return YES;
    }
    return NO;
}

// 让app点击关闭之后程序退出
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}


@end
