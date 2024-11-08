const clap_version_t = @import("clap.zig").version.clap_version_t;

pub const clap_plugin_entry_t = extern struct {
    clap_version: clap_version_t,
    init: fn (plugin_path: [*:0]const u8) bool,
    deinit: fn () void,
    get_factory: fn (factory_id: [*:0]const u8) ?*const void,
};
