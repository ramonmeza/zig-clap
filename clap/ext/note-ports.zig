const clap = @import("clap");

const clap_id = clap.id.clap_id;
const clap_host_t = clap.host.clap_host_t;
const clap_plugin_t = clap.plugin.clap_plugin_t;

const CLAP_NAME_SIZE = clap.string_sizes.CLAP_NAME_SIZE;

pub const CLAP_EXT_NOTE_PORTS = "clap.note-ports";

pub const clap_note_dialect = enum(i32) {
    CLAP_NOTE_DIALECT_CLAP = 1 << 0,
    CLAP_NOTE_DIALECT_MIDI = 1 << 1,
    CLAP_NOTE_DIALECT_MIDI_MPE = 1 << 2,
    CLAP_NOTE_DIALECT_MIDI2 = 1 << 3,
};

pub const clap_note_port_info_t = extern struct {
    id: clap_id,
    supported_dialects: u32,
    preferred_dialect: u32,
    name: [CLAP_NAME_SIZE]u8,
};

pub const clap_plugin_note_ports_t = extern struct {
    count: fn (plugin: *clap_plugin_t, is_input: bool) u32,
    get: fn (plugin: *clap_plugin_t, index: u32, is_input: bool, info: *clap_note_port_info_t) bool,
};

pub const clap_note_port_rescan_types = enum(i32) {
    CLAP_NOTE_PORTS_RESCAN_ALL = 1 << 0,
    CLAP_NOTE_PORTS_RESCAN_NAMES = 1 << 1,
};

pub const clap_host_note_ports_t = extern struct {
    supported_dialects: fn (host: *clap_host_t) u32,
    rescan: fn (host: *clap_host_t, flags: u32) void,
};
