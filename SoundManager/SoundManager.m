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
@synthesize recordSettings = _recordSettings;

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

-(void)clearRecorderIfNeeded{
    if (self.recorder) {
        if ([self.recorder isRecording]) {
            [self.recorder stop];
        }
        self.recorder = nil;
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

-(AVAudioRecorder *)recorderWithURL:(NSURL *)url{
    [self clearRecorderIfNeeded];
    NSDictionary* settings = self.recordSettings ? self.recordSettings : defaultSettings;
    NSError* error = nil;
    AVAudioRecorder* recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    recorder.delegate = self;
    [recorder prepareToRecord];
    return recorder;
}

#pragma mark - delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [player release];
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [recorder release];
}

@end
