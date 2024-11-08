const clap = @import("clap");

const clap_id = clap.id.clap_id;
const clap_host_t = clap.host.clap_host_t;
const clap_plugin_t = clap.plugin.clap_plugin_t;

pub const CLAP_NAME_SIZE = clap.string_sizes.CLAP_NAME_SIZE;

pub const CLAP_EXT_AUDIO_PORTS = "clap.audio-ports";
pub const CLAP_PORT_MONO = "mono";
pub const CLAP_PORT_STEREO = "stereo";

pub const CLAP_AUDIO_PORT_IS_MAIN: i32 = 1 << 0;
pub const CLAP_AUDIO_PORT_SUPPORTS_64BITS: i32 = 1 << 1;
pub const CLAP_AUDIO_PORT_PREFERS_64BITS: i32 = 1 << 2;
pub const CLAP_AUDIO_PORT_REQUIRES_COMMON_SAMPLE_SIZE: i32 = 1 << 3;

pub const clap_audio_port_info_t = extern struct {
    id: clap_id,
    name: [CLAP_NAME_SIZE]u8,
    flags: u32,
    channel_count: u32,
    port_type: *const u8,
    in_pplace_pair: clap_id,
};

pub const clap_plugin_audio_ports_t = extern struct {
    count: fn (plugin: *clap_plugin_t, is_input: bool) u32,
    get: fn (plugin: *clap_plugin_t, index: u32, is_input: bool, info: *clap_audio_port_info_t) bool,
};

pub const CLAP_AUDIO_PORTS_RESCAN_NAMES: i32 = 1 << 0;
pub const CLAP_AUDIO_PORTS_RESCAN_FLAGS: i32 = 1 << 1;
pub const CLAP_AUDIO_PORTS_RESCAN_CHANNEL_COUNT: i32 = 1 << 2;
pub const CLAP_AUDIO_PORTS_RESCAN_PORT_TYPE: i32 = 1 << 3;
pub const CLAP_AUDIO_PORTS_RESCAN_IN_PLACE_PAIR: i32 = 1 << 4;
pub const CLAP_AUDIO_PORTS_RESCAN_LIST: i32 = 1 << 5;

pub const clap_host_audio_ports_t = extern struct {
    is_rescan_flag_supported: fn (host: *clap_host_t, flag: u32) bool,
    rescan: fn (host: *clap_host_t, flags: u32) void,
};
