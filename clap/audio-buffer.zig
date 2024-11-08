pub const clap_audio_buffer_t = extern struct {
    data32: **f32,
    data64: **f64,
    channel_count: u32,
    latency: u32,
    constant_mask: u64,
};
