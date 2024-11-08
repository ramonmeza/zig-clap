const plugin = @import("clap.zig").plugin;
const clap_plugin_descriptor_t = plugin.clap_plugin_descriptor_t;
const clap_plugin_t = plugin.clap_plugin_t;
const clap_host_t = @import("clap.zig").host_clap_host_t;

pub const CLAP_PLUGIN_FACTORY_ID = "clap.plugin-factory";

pub const clap_plugin_factory_t = extern struct {
    get_plugin_count: fn (factory: *const clap_plugin_factory_t) u32,
    get_plugin_descriptor: fn (factory: *const clap_plugin_factory_t, index: u32) *const clap_plugin_descriptor_t,
    create_plugin: fn (factory: *const clap_plugin_factory_t, host: *const clap_host_t, plugin_id: [*:0]const u8) *const clap_plugin_t,
};
