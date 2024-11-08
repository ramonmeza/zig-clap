pub const ext = struct {
    pub const draft = struct {};

    pub const audio_ports = @import("ext/audio-ports.zig");
    pub const note_ports = @import("ext/note-ports.zig");
};

pub const factory = struct {
    pub const draft = struct {};

    pub const plugin_factory = @import("factory/plugin-factory.zig");
};

//
pub const audio_buffer = @import("audio-buffer.zig");
pub const entry = @import("entry.zig");
pub const events = @import("events.zig");
pub const fixedpoint = @import("fixedpoint.zig");
pub const host = @import("host.zig");
pub const id = @import("id.zig");
pub const plugin_features = @import("plugin-features.zig");
pub const plugin = @import("plugin.zig");
pub const process = @import("process.zig");
pub const string_sizes = @import("string-sizes.zig");
pub const version = @import("version.zig");
