//
//  SoundManager.m
//  SoundManager
//
//  Created by undancer on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import "SoundManager.h"

BOOL playWithData(NSData* data){
    AVAudioPlayer* player = [[SoundManager defaultManager] playerWithData:data];
    if (player) {
        return player.play;
    }
    return NO;
}

@implementation SoundManager

@synthesize player = _player;
@synthesize recorder = _recorder;

+(SoundManager *)defaultManager{
    static SoundManager* soundManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[SoundManager alloc] init];
    });
    return soundManager;
}

-(void)clearPlayIfNeeded{
    if (self.player) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        self.player = nil;
    }
}

-(AVAudioPlayer *)playerWithData:(NSData *)data{
    [self clearPlayIfNeeded];
    if (self.player == nil) {
        NSError* error = nil;
        AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithData:data error:&error];
        player.delegate = self;
        [player prepareToPlay];
        self.player = player;
        [player release];
    }
    return self.player;
}

#pragma mark - delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [player release];
}

@end
