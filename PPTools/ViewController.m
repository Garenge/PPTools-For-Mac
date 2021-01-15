//
//  ViewController.m
//  PPTools
//
//  Created by Garenge on 2019/M/14.
//  Copyright © 2019 鹏鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (weak) IBOutlet NSTextField *picSourceTF;

@property (weak) IBOutlet NSTextField *picNameTF;

@property (unsafe_unretained) IBOutlet NSTextView *resultTextView;

@property (weak) IBOutlet NSTextField *scaleValueTF;

@property (weak) IBOutlet NSTextField *copiedResultL;

/// 单选选中项
@property (nonatomic, assign) BOOL isScalMode;
@property (weak) IBOutlet NSTextField *widthValueTF;
@property (weak) IBOutlet NSTextField *heightValueTF;

@end

@implementation ViewController

#pragma mark action

/// 点击完成
- (IBAction)completeToGenerateCode:(NSButton *)sender {

    [[NSApplication sharedApplication].mainWindow makeFirstResponder:0];

    if (self.picSourceTF.stringValue.length > 0) {
        /**
         <img src="https://garenge-image.oss-cn-hangzhou.aliyuncs.com/mac_dev_img/%E5%88%9B%E5%BB%BAAPP-1.png" style="width:80%; height:80%; display:block;margin:0 auto">
         <p style="text-align:center">
         <span style="border-bottom:1px solid #ccc;padding-bottom:10px;">创建APP-1.png</span>
         </p>
         <br/>
         */
        
        NSMutableString *resultMString = [NSMutableString string];
        //
        [resultMString appendFormat:@"<img src=\"%@\" style=\"%@; display:block;margin:0 auto\">\n", self.picSourceTF.stringValue, [self getStyleSizeString]];
        //
        [resultMString appendFormat:@"\t<p style=\"text-align:center\">\n\t\t<span style=\"border-bottom:1px solid #ccc;color:#aaa;padding-bottom:10px;\">%@</span>\n\t</p>\n<br/>", self.picNameTF.stringValue];
        
        self.resultTextView.string = [resultMString copy];
    } else {
        [self showResult:@"图片地址为空" hidden:NO animated:NO];
        [self showResult:@"" hidden:YES animated:YES];
    }
}

/// 点击复制
- (IBAction)copyAction:(NSButton *)sender {

    [[NSApplication sharedApplication].mainWindow makeFirstResponder:0];

    if (self.resultTextView.string.length > 0) {

        NSPasteboard *paste = [NSPasteboard generalPasteboard];
        [paste clearContents];
        [paste declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];
        BOOL result =  [paste writeObjects:[NSArray arrayWithObject:self.resultTextView.string]];
        [self showResult:result ? @"已经复制到剪切板" : @"复制失败" hidden:NO animated:NO];

        [self showResult:@"" hidden:YES animated:YES];
    } else {
        [self showResult:@"" hidden:YES animated:NO];
    }
}

- (NSString *)getStyleSizeString {

    // self.scaleValueTF.stringValue
    if (self.isScalMode) {
        return [NSString stringWithFormat:@"width:%@%%; height:%@%%", self.scaleValueTF.stringValue, self.scaleValueTF.stringValue];
    } else {
        return [NSString stringWithFormat:@"width:%@px; height:%@px", self.widthValueTF.stringValue, self.heightValueTF.stringValue];
    }

}
/// 点击单选
- (IBAction)genderRadioAction:(NSButton *)sender {

    [[NSApplication sharedApplication].mainWindow makeFirstResponder:0];

    NSInteger tag = sender.tag;
    if (tag % 2 == 1) {
        // 第一个, 缩放比例
        NSLog(@"我选择了1: %ld", tag);
        self.isScalMode = YES;
    } else {
        // 文件尺寸
        NSLog(@"我选择了2: %ld", tag);
        self.isScalMode = NO;
    }

    if (self.resultTextView.string.length > 0) {
        [self completeToGenerateCode:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.copiedResultL.stringValue = @"";
    self.copiedResultL.hidden = YES;
    // Do any additional setup after loading the view.
    self.isScalMode = YES;

    [[NSApplication sharedApplication].mainWindow makeFirstResponder:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)showResult:(NSString *)string hidden:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)), queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.copiedResultL.stringValue = string;
                self.copiedResultL.hidden = hidden;
            });
        });
    } else {
        self.copiedResultL.stringValue = string;
        self.copiedResultL.hidden = hidden;
    }
}


@end
