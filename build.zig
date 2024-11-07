const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zig-clap",
        .root_source_file = b.path("src/clap.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();

    b.installArtifact(lib);
}
