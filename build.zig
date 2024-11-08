const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const clap = b.addModule("clap", .{
        .root_source_file = b.path("clap/clap.zig"),
        .target = target,
        .optimize = optimize,
    });

    const plugin = b.addSharedLibrary(.{
        .name = "zig_plugin",
        .root_source_file = b.path("plugin/plugin.zig"),
        .target = target,
        .optimize = optimize,
    });
    plugin.root_module.addImport("clap", clap);

    b.installArtifact(plugin);
}
