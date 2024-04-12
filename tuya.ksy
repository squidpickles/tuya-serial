meta:
  id: tuya
  file-extension: tuya
  endian: be
seq:
  - id: magic
    contents: [0xbb]
  - id: source
    type: u2
    enum: source
  - id: command
    type: u1
    enum: command
  - id: unknown1
    size: 3
  - id: eco
    type: b1
  - id: display
    type: b1
  - id: beeper
    type: b1
  - id: unknown2
    type: b2
  - id: power
    type: b1
  - id: unknown3
    type: b2
  - id: mute
    type: b1
  - id: strong
    type: b1
  - id: unknown4
    type: b1
  - id: health
    type: b1
  - id: mode
    enum: opmode
    type: b4
  - id: unknown5
    type: b4
  - id: temp_whole
    type: b4
  - id: antifreeze
    type: b1
  - id: unknown6
    type: b1
  - id: vertical_flow
    type: b3
  - id: fan_speed
    enum: fan_speed
    type: b3
  - id: unknown7
    type: b5
  - id: temp_frac
    type: b2
  - id: unknown8
    type: b1
  - id: unknown9
    size: 7
  - id: sleep
    type: u1
    enum: sleep
  - id: unknown10
    size: 12
  - id: up_down_flow
    enum: up_down_flow
    type: u1
  - id: left_right_flow
    type: u1
    enum: left_right_flow
  - id: checksum
    doc: "All bytes except this one XORd together"
    type: u1
instances:
  temp_in_c:
    value: "31 - temp_whole + (temp_frac * 0.25)"
  temp_in_f:
    value: temp_in_c * 9/5 + 32
enums:
  source:
    0x0001: controller
    0x0100: appliance
  command:
    0x03: set_state
    0x04: query_state
  fan_speed:
    0x00: auto
    0x02: low
    0x03: medium
    0x05: high
    0x06: mid_low
    0x07: mid_high
  opmode:
    0x01: heat
    0x02: dehumidify
    0x03: cool
    0x07: fan
    0x08: auto
  up_down_flow:
    0x00: auto
    0x01: top_fix
    0x02: upper_fix
    0x03: middle_fix
    0x04: lower_fix
    0x05: bottom_fix
    0x08: up_down_flow
    0x10: up_flow
    0x18: down_flow
  left_right_flow:
    0x80: auto
    0x81: left_fix
    0x82: middle_left_fix
    0x83: middle_fix
    0x84: middle_right_fix
    0x85: right_fix
    0x88: left_right_flow
    0x90: left_flow
    0x98: middle_flow
    0xa0: right_flow
  sleep:
    0x00: off
    0x01: standard
    0x02: elderly
    0x03: child
