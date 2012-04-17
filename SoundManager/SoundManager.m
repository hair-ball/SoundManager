//
//  SoundManager.m
//  SoundManager
//
//  Created by 涛 魏 on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

@synthesize player = _player;

+(SoundManager *)defaultManager{
    static SoundManager* soundManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[SoundManager alloc] init];
    });
    return soundManager;
}

+(BOOL)playWithString:(NSString *)file{
    return [self playWithData:[NSData dataWithContentsOfFile:file]];
}

+(BOOL)playWithData:(NSData *)data{
    
    SoundManager* manager = [SoundManager defaultManager];
    [manager clearPlayIfNeeded];
    if (manager.player == nil) {
        AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithData:data error:nil];
        player.delegate = manager;
        [player prepareToPlay];
        manager.player = player;
        [player release];
        if (manager.player) {
            [manager.player play];
            return YES;
        }
    }
    return NO;
}

-(void)clearPlayIfNeeded{
    if (self.player) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        self.player = nil;
    }
}

#pragma mark - delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [player autorelease];
}

@end
