const clap = @import("clap.zig");
const clap_version_t = clap.version.clap_version_t;
const clap_process_t = clap.process.clap_process_t;

pub const clap_plugin_descriptor_t = extern struct {
    clap_version: clap_version_t,
    id: [*:0]const u8,
    name: [*:0]const u8,
    vendor: [*:0]const u8,
    url: [*:0]const u8,
    manual_url: [*:0]const u8,
    support_url: [*:0]const u8,
    version: [*:0]const u8,
    description: [*:0]const u8,
    features: [*][*:0]const u8,
};

pub const clap_plugin_t = extern struct {
    desc: *clap_plugin_descriptor_t,
    plugin_data: ?*anyopaque,

    init: fn (plugin: *clap_plugin_t) bool,
    destroy: fn (plugin: *clap_plugin_t) void,
    activate: fn (plugin: *clap_plugin_t, sample_rate: f64, min_frames_count: u32, max_frames_count: u32) bool,
    deactivate: fn (plugin: *clap_plugin_t) void,
    start_processing: fn (plugin: *clap_plugin_t) bool,
    stop_processing: fn (plugin: *clap_plugin_t) void,
    reset: fn (plugin: *clap_plugin_t) void,
    process: fn (plugin: *clap_plugin_t, process: *clap_process_t) i32,
    get_extension: fn (plugin: *const clap_plugin_t, id: [*:0]const u8) ?*anyopaque,
    on_main_thread: fn (plugin: *const clap_plugin_t) void,
};
