// This file is part of Background Music.
//
// Background Music is free software: you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation, either version 2 of the
// License, or (at your option) any later version.
//
// Background Music is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Background Music. If not, see <http://www.gnu.org/licenses/>.

//
//  BGMRadiantPlayer.m
//  BGMApp
//
//  Copyright © 2016 Kyle Neideck
//  Portions copyright (C) 2012 Peter Ljunglöf. All rights reserved.
//

// Self Include
#import "BGMRadiantPlayer.h"

// Auto-generated Scripting Bridge header
#import "RadiantPlayer.h"

// PublicUtility Includes
#undef CoreAudio_ThreadStampMessages
#define CoreAudio_ThreadStampMessages 0  // Requires C++
#include "CADebugMacros.h"


@implementation BGMRadiantPlayer

BGM_MUSIC_PLAYER_DEFAULT_LOAD_METHOD

+ (NSString*) name {
    return @"Radiant Player";
}

- (CFNumberRef) pid {
    return NULL;
}

+ (CFStringRef) bundleID {
    return CFSTR("com.sajidanwar.Radiant-Player");
}

- (RadiantPlayerApplication* __nullable) radiantplayer {
    return (RadiantPlayerApplication*) self.sbApplication;
}

- (BOOL) isRunning {
    return self.radiantplayer && [self.radiantplayer isRunning];
}

- (BOOL) pause {
    // isPlaying checks isRunning, so we don't need to check it here and waste an Apple event
    BOOL wasPlaying = [self isPlaying];
    
    if (wasPlaying) {
        DebugMsg("BGMRadiantPlayer::pause: Pausing RadiantPlayer");
        [self togglePlay];
    }
    
    return wasPlaying;
}

- (BOOL) unpause {
    // isPaused checks isRunning, so we don't need to check it here and waste an Apple event
    BOOL wasPaused = [self isPaused];
    
    if (wasPaused) {
        DebugMsg("BGMRadiantPlayer::unpause: Unpausing RadiantPlayer");
        [self togglePlay];
    }
    
    return wasPaused;
}

- (BOOL) isPlaying {
    DebugMsg("BGMRadiantPlayer::isPlaying: player state %ld", [self.radiantplayer playerState]);
    return [self isRunning] && [self.radiantplayer playerState] == 2;
}

- (BOOL) isPaused {
    DebugMsg("BGMRadiantPlayer::isPaused: player state %ld", [self.radiantplayer playerState]);
    return [self isRunning] && [self.radiantplayer playerState] == 1;
}

// need to execute RadiantPlayerApplication playpause
- (void) togglePlay {
    if ([self isRunning])
        [self.radiantplayer playpause];
}

@end

