const std = @import("std");
const clap = @import("clap");

const clap_plugin_descriptor_t = clap.plugin.clap_plugin_descriptor_t;
const clap_plugin_entry_t = clap.entry.clap_plugin_entry_t;
const clap_plugin_t = clap.plugin.clap_plugin_t;
const clap_plugin_factory_t = clap.factory.plugin_factory.clap_plugin_factory_t;
const clap_host_t = clap.host.clap_host_t;
const clap_process_t = clap.process.clap_process_t;
const clap_plugin_note_ports_t = clap.ext.note_ports.clap_plugin_note_ports_t;
const clap_note_port_info_t = clap.ext.note_ports.clap_note_port_info_t;

const CLAP_PLUGIN_FACTORY_ID = clap.plugin_factory.CLAP_PLUGIN_FACTORY_ID;
const CLAP_PLUGIN_FEATURE_INSTRUMENT = clap.plugin_features.CLAP_PLUGIN_FEATURE_INSTRUMENT;
const CLAP_PLUGIN_FEATURE_SYNTHESIZER = clap.plugin_features.CLAP_PLUGIN_FEATURE_SYNTHESIZER;
const CLAP_PLUGIN_FEATURE_STEREO = clap.plugin_features.CLAP_PLUGIN_FEATURE_STEREO;
const CLAP_VERSION = clap.version.CLAP_VERSION;
const CLAP_VERSION_INIT = clap.version.CLAP_VERSION_INIT;
const CLAP_PROCESS_CONTINUE = clap.process.clap_process_status.CLAP_PROCESS_CONTINUE;
const CLAP_EXT_NOTE_PORTS = clap.ext.note_ports.CLAP_EXT_NOTE_PORTS;
const CLAP_EXT_AUDIO_PORTS = clap.ext.audio_ports.CLAP_EXT_AUDIO_PORTS;

const clap_version_is_compatible = clap.version.clap_version_is_compatible;

const allocator = std.heap.page_allocator;

// entry
fn init(plugin_path: [*:0]const u8) bool {
    _ = plugin_path;
    return true;
}

fn deinit() void {}

fn get_factory(factory_id: [*:0]const u8) ?*const void {
    if (std.mem.eql(u8, factory_id, CLAP_PLUGIN_FACTORY_ID)) {
        return pluginFactory;
    } else {
        return null;
    }
}

export const clap_entry: clap_plugin_entry_t = .{
    .clap_version = CLAP_VERSION,
    .init = &init,
    .deinit = &deinit,
    .get_factory = &get_factory,
};

// factory
fn get_plugin_count(factory: *const clap_plugin_factory_t) u32 {
    _ = factory;
    return 1;
}

fn get_plugin_descriptor(factory: *const clap_plugin_factory_t, index: u32) *const clap_plugin_descriptor_t {
    _ = factory;

    if (index == 0) {
        return &pluginDescriptor;
    } else {
        return null;
    }
}

fn create_plugin(factory: *const clap_plugin_factory_t, host: *const clap_host_t, plugin_id: [*:0]const u8) *const clap_plugin_t {
    _ = factory;

    if (!clap_version_is_compatible(host.clap_version) or std.mem.eql(u8, plugin_id, pluginDescriptor.id)) {
        return null;
    }

    var plugin: MyZigPlugin = try allocator.zeroed(MyZigPlugin);
    plugin.host = host;
    plugin.plugin = pluginClass;
    plugin.plugin.plugin_data = plugin;
    return plugin.plugin;
}

const pluginFactory: clap_plugin_factory_t = .{
    .get_plugin_count = &get_plugin_count,
    .get_plugin_descriptor = &get_plugin_descriptor,
    .create_plugin = &create_plugin,
};

// MyZigPlugin
const Voice = struct {
    held: bool,
    noteID: i32,
    channel: i16,
    key: i16,
    phase: f32,
};

const MyZigPlugin = struct {
    plugin: clap_plugin_t,
    host: *clap_host_t,
    sampleRate: f32,
    voices: std.ArrayList(Voice),
};

// plugin descriptor
const pluginDescriptor: clap_plugin_descriptor_t = .{
    .clap_version = CLAP_VERSION_INIT,
    .id = "ramonmeza.MyZigPlugin",
    .name = "MyZigPlugin",
    .vendor = "ramonmeza",
    .url = "https://ramonmeza.github.io",
    .manual_url = "https://ramonmeza.github.io",
    .support_url = "https://ramonmeza.github.io",
    .version = "1.2.2",
    .description = "A CLAP plugin made with Zig!",
    .features = [*][*:0]const u8{
        CLAP_PLUGIN_FEATURE_INSTRUMENT,
        CLAP_PLUGIN_FEATURE_SYNTHESIZER,
        CLAP_PLUGIN_FEATURE_STEREO,
        null,
    },
};

// plugin class
fn plugin_init(_plugin: *clap_plugin_t) bool {
    const plugin: ?*MyZigPlugin = @as(?*MyZigPlugin, _plugin.plugin_data);
    _ = plugin.?.*;
    return true;
}

fn plugin_destroy(_plugin: *clap_plugin_t) void {
    var plugin: ?*MyZigPlugin = @as(?*MyZigPlugin, _plugin.plugin_data);
    plugin.?.voices.deinit();
    allocator.free(plugin);
}

fn plugin_activate(_plugin: *clap_plugin_t, sample_rate: f64, min_frames_count: u32, max_frames_count: u32) bool {
    _ = min_frames_count;
    _ = max_frames_count;

    var plugin: ?*MyZigPlugin = @as(?*MyZigPlugin, _plugin.plugin_data);
    plugin.?.sampleRate = sample_rate;

    return true;
}

fn plugin_deactivate(_plugin: *clap_plugin_t) void {
    _ = _plugin;
}

fn plugin_start_processing(_plugin: *clap_plugin_t) bool {
    _ = _plugin;
    return true;
}

fn plugin_stop_processing(_plugin: *clap_plugin_t) void {
    _ = _plugin;
}

fn plugin_reset(_plugin: *clap_plugin_t) void {
    var plugin: ?*MyZigPlugin = @as(?*MyZigPlugin, _plugin.plugin_data);
    plugin.?.voices.deinit();
}

fn plugin_process(_plugin: *clap_plugin_t, process: *clap_process_t) i32 {
    _ = process;
    _ = _plugin;

    // const plugin: ?*MyZigPlugin = @as(?*MyZigPlugin, _plugin.plugin_data);
    // todo
    return CLAP_PROCESS_CONTINUE;
}

fn plugin_get_extension(_plugin: *const clap_plugin_t, id: [*:0]const u8) ?*anyopaque {
    _ = _plugin;
    _ = id;

    if (std.mem.eql(u8, id, CLAP_EXT_NOTE_PORTS)) {
        return &extensionNotePorts;
    }
    if (std.mem.eql(u8, id, CLAP_EXT_AUDIO_PORTS)) {
        return &extensionAudioPorts;
    }

    return null;
}

fn plugin_on_main_thread(_plugin: *const clap_plugin_t) void {
    _ = _plugin;
}

const pluginClass: clap_plugin_t = .{
    .desc = &pluginDescriptor,
    .plugin_data = null,
    .init = &plugin_init,
    .destroy = &plugin_destroy,
    .activate = &plugin_activate,
    .deactivate = &plugin_deactivate,
    .start_processing = &plugin_start_processing,
    .stop_processing = &plugin_stop_processing,
    .reset = &plugin_reset,
    .process = &plugin_process,
    .get_extension = &plugin_get_extension,
    .on_main_thread = &plugin_on_main_thread,
};

// implement extensions
fn ext_note_ports_count(_plugin: *clap_plugin_t, is_input: bool) u32 {
    _ = _plugin;
    _ = is_input;
}

fn ext_note_ports_get(_plugin: *clap_plugin_t, index: u32, is_input: bool, info: *clap_note_port_info_t) bool {
    _ = _plugin;
    _ = index;
    _ = is_input;
    _ = info;
}

const extensionNotePorts: clap_plugin_note_ports_t = .{
    .count = &ext_note_ports_count,
    .get = &ext_note_ports_get,
};
