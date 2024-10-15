--[[

    Table to generate String Objects

--]]

--@local audio : Table
local audio = require('audio')

--@local Object : Table
local Object = require('utils.onigiri.base.prototype.Object')

-- @table String
local AudioPlayer = Object.create({

    -- @var path_audio_file : string
    -- @var audio_player : Object<audio>
    attributes = {'path_audio_file', 'track'},

    -- @return void
    constructor = function(self, _attributes)
        self.attributes.path_audio_file = _attributes.path_audio_file
        self.attributes.track = audio.loadSound(self.attributes.path_audio_file)
    end,

    -- @return Object<audio>
    new = function(self, _constructor)
        return Object.create(self).new(_constructor)
    end,

    -- @return Object<AudioPlayer>
    play = function(self)
        audio.play(self.attributes.track)
        return self
    end,

    -- @return Object<AudioPlayer>
    stop = function(self)
        audio.stop()
        return self
    end,

    -- @return Object<AudioPlayer>
    volumeOn = function(self)
        audio.setVolume(1)
        return self
    end,

    -- @return Object<AudioPlayer>
    volumeOff = function(self)
        audio.setVolume(0)
        return self
    end,

    -- @return void
    destroy = function(self)
        audio.stop()
        audio.dispose(self.attributes.track);
    end,
})

return AudioPlayer
