const clap = @import("clap");

const clap_event_transport_t = clap.events.clap_event_transport_t;
const clap_input_events_t = clap.events.clap_input_events_t;
const clap_output_events_t = clap.events.clap_output_events_t;
const clap_audio_buffer_t = clap.audio_buffer.clap_audio_buffer_t;

pub const clap_process_status = enum(i32) {
    CLAP_PROCESS_ERROR = 0,
    CLAP_PROCESS_CONTINUE = 1,
    CLAP_PROCESS_CONTINUE_IF_NOT_QUIET = 2,
    CLAP_PROCESS_TAIL = 3,
    CLAP_PROCESS_SLEEP = 4,
};

pub const clap_process_t = extern struct {
    steady_time: i64,
    frames_count: u32,
    transport: *clap_event_transport_t,
    audio_inputs: *clap_audio_buffer_t,
    audio_outputs: *clap_audio_buffer_t,
    audio_inputs_count: u32,
    audio_outputs_count: u32,
    in_events: *clap_input_events_t,
    out_events: *clap_output_events_t,
};
