pub const clap_version_t = extern struct {
    major: u32,
    minor: u32,
    revision: u32,
};

pub const CLAP_VERSION_MAJOR: u32 = 1;
pub const CLAP_VERSION_MINOR: u32 = 2;
pub const CLAP_VERSION_REVISION: u32 = 2;
pub const CLAP_VERSION_INIT: clap_version_t = .{
    .major = 1,
    .minor = 2,
    .revision = 2,
};
pub const CLAP_VERSION: clap_version_t = CLAP_VERSION_INIT;

pub extern "c" fn clap_version_is_compatible(version: clap_version_t) bool;
