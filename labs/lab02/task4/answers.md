# Task 4 observations

The unchanged testbench changes inputs every 2 time units. The ideal AND is high during [4,6), [8,10), and [12,14).

| Delay | Dataflow | Delay before assignment | Intra-assignment delay |
|---|---|---|---|
| 1 | Correct AND waveform delayed by 1: high at 5–7, 9–11, 13–15. | Same correct waveform. | Same correct waveform. |
| 2 | Correct delayed waveform in this run: high at 6–8, 10–12, 14–16. | Stays 0; misses all high pulses. | Becomes 1 at 6 and stays 1, missing later falling edges. |
| 3 | Stays 0 after initialization: all 2-unit high pulses are rejected by the 3-unit inertial delay. | Stays 0: samples after each high pulse has ended. | Becomes 1 at 7 and stays 1: writes an old sampled value and misses changes while waiting. |

With delay 1, all three reproduce the intended logic after the propagation delay. With delay 2, only dataflow reproduces the delayed pulses in this simulation. The procedural blocks can miss an input event while their blocking delay is active. At delay 2, stimulus and delayed statements also run at identical timestamps, so active-region scheduling creates races; this boundary should not be relied upon as a portable timing result.

With delay 3, none reproduces every ideal AND pulse as a simple shifted waveform. Dataflow is nevertheless correct for an inertial gate model: pulses shorter than the delay are filtered. The before-assignment block reads current inputs only after waiting; the intra-assignment block captures inputs immediately but writes that stale value later. Both procedural blocks are unable to respond to events during the wait and do not automatically evaluate again when it ends.

Delay placement changes simulation semantics, not just the timestamp of an otherwise identical result. Allow sufficient settling time, avoid testbench transitions at the same instant as delayed updates, and distinguish inertial pulse filtering from missed events in a blocking procedural model. The three source files retain #3, the last requested experiment; the same unchanged testbench was run with #1, #2, and #3.
