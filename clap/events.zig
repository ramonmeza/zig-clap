const clap = @import("clap");

const clap_id = clap.id.clap_id;
const clap_beattime = clap.fixedpoint.clap_beattime;
const clap_sectime = clap.fixedpoint.clap_sectime;

pub const clap_event_header_t = extern struct {
    size: u32,
    time: u32,
    space_id: u16,
    type: u16,
    flags: u32,
};

pub const CLAP_CORE_EVENT_SPACE_ID: u16 = 0;

pub const clap_event_flags = enum(i32) {
    CLAP_EVENT_IS_LIVE = 1 << 0,
    CLAP_EVENT_DONT_RECORD = 1 << 1,
};

pub const clap_event_type = enum(i32) {
    CLAP_EVENT_NOTE_ON = 0,
    CLAP_EVENT_NOTE_OFF = 1,
    CLAP_EVENT_NOTE_CHOKE = 2,
    CLAP_EVENT_NOTE_END = 3,
    CLAP_EVENT_NOTE_EXPRESSION = 4,
    CLAP_EVENT_PARAM_VALUE = 5,
    CLAP_EVENT_PARAM_MOD = 6,
    CLAP_EVENT_PARAM_GESTURE_BEGIN = 7,
    CLAP_EVENT_PARAM_GESTURE_END = 8,
    CLAP_EVENT_TRANSPORT = 9,
    CLAP_EVENT_MIDI = 10,
    CLAP_EVENT_MIDI_SYSEX = 11,
    CLAP_EVENT_MIDI2 = 12,
};

pub const clap_event_note_t = extern struct {
    header: clap_event_header_t,
    node_id: i32,
    port_index: i16,
    key: i16,
    velocity: f64,
};

pub const clap_note_expressions = enum(i32) {
    CLAP_NOTE_EXPRESSION_VOLUME = 0,
    CLAP_NOTE_EXPRESSION_PAN = 1,
    CLAP_NOTE_EXPRESSION_TUNING = 2,
    CLAP_NOTE_EXPRESSION_VIBRATO = 3,
    CLAP_NOTE_EXPRESSION_EXPRESSION = 4,
    CLAP_NOTE_EXPRESSION_BRIGHTNESS = 5,
    CLAP_NOTE_EXPRESSION_PRESSURE = 6,
};

pub const clap_event_note_expression_t = extern struct {
    header: clap_event_header_t,
    expression_id: clap_note_expressions,
    note_id: i32,
    port_index: i16,
    channel: i16,
    key: i16,
    value: f64,
};

pub const clap_event_param_value_t = extern struct {
    header: clap_event_header_t,
    param_id: clap_id,
    cookie: ?*anyopaque,
    note_id: i32,
    port_index: i16,
    channel: i16,
    key: i16,
    value: f64,
};

pub const clap_event_param_mod_t = extern struct {
    header: clap_event_header_t,
    param_id: clap_id,
    cookie: ?*anyopaque,
    note_id: i32,
    port_index: i16,
    channel: i16,
    key: i16,
    amount: f64,
};

pub const clap_event_param_gesture_t = extern struct {
    header: clap_event_header_t,
    param_id: clap_id,
};

pub const clap_transport_flags = enum(i32) {
    CLAP_TRANSPORT_HAS_TEMPO = 1 << 0,
    CLAP_TRANSPORT_HAS_BEATS_TIMELINE = 1 << 1,
    CLAP_TRANSPORT_HAS_SECONDS_TIMELINE = 1 << 2,
    CLAP_TRANSPORT_HAS_TIME_SIGNATURE = 1 << 3,
    CLAP_TRANSPORT_IS_PLAYING = 1 << 4,
    CLAP_TRANSPORT_IS_RECORDING = 1 << 5,
    CLAP_TRANSPORT_IS_LOOP_ACTIVE = 1 << 6,
    CLAP_TRANSPORT_IS_WITHIN_PRE_ROLL = 1 << 7,
};

const clap_event_transport_t = extern struct {
    header: clap_event_header_t,

    flags: u32,

    song_pos_beats: clap_beattime,
    song_pos_seconds: clap_sectime,

    tempo: f64,
    tempo_inc: f64,

    loop_start_beats: clap_beattime,
    loop_end_beats: clap_beattime,
    loop_start_seconds: clap_sectime,
    loop_end_seconds: clap_sectime,

    bar_start: clap_beattime,
    bar_number: i32,

    tsig_num: u16,
    tsig_denom: u16,
};

pub const clap_event_midi_t = extern struct {
    header: clap_event_header_t,
    port_index: u16,
    data: [3]u8,
};

pub const clap_event_midi_sysex_t = extern struct {
    header: clap_event_header_t,
    port_index: u16,
    buffer: *const u8,
    size: u32,
};

pub const clap_event_midi2_t = extern struct {
    header: clap_event_header_t,
    port_index: u16,
    data: [4]u32,
};

pub const clap_input_events_t = extern struct {
    ctx: ?*anyopaque,
    size: fn (list: *clap_input_events_t) u32,
    get: fn (list: *clap_input_events_t, index: u32) clap_event_header_t,
};

pub const clap_output_events_t = extern struct {
    ctx: ?*anyopaque,
    try_push: fn (list: *clap_output_events_t, event: *clap_event_header_t) bool,
};
