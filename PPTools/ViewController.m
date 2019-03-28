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

@end

@implementation ViewController

- (IBAction)completeToGenerateCode:(NSButton *)sender {
    
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
        [resultMString appendFormat:@"<img src=\"%@\" style=\"width:%@%%; height:%@%%; display:block;margin:0 auto\">\n", self.picSourceTF.stringValue, self.scaleValueTF.stringValue, self.scaleValueTF.stringValue];
        //
        [resultMString appendFormat:@"<p style=\"text-align:center\">\n\t<span style=\"border-bottom:1px solid #ccc;padding-bottom:10px;\">%@</span>\n</p>\n<br/>", self.picNameTF.stringValue];
        
        self.resultTextView.string = [resultMString copy];
    } else {
        [self showResult:@"图片地址为空" hidden:NO animated:NO];
        [self showResult:@"" hidden:YES animated:YES];
    }
    
    
}

- (IBAction)copyAction:(NSButton *)sender {
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.copiedResultL.stringValue = @"";
    self.copiedResultL.hidden = YES;
    // Do any additional setup after loading the view.
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
