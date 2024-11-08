const clap_version_t = @import("clap").version.clap_version_t;

pub const clap_host_t = extern struct {
    clap_version: clap_version_t,

    host_data: ?*anyopaque,

    name: [*:0]const u8,
    vendor: [*:0]const u8,
    url: [*:0]const u8,
    version: [*:0]const u8,

    get_extension: fn (host: *clap_host_t, extension_id: [*:0]const u8) void,
    request_restart: fn (host: *clap_host_t) void,
    request_process: fn (host: *clap_host_t) void,
    request_callback: fn (host: *clap_host_t) void,
};
