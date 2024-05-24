meta:
  id: tuya_response
  file-extension: tuya_response
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
  - id: state_size
    type: u1
  - id: unknown1
    size: 2
  - id: strong
    type: b1
  - id: eco
    type: b1
  - id: display
    type: b1
  - id: power
    type: b1
  - id: unknown2 # always off
    type: b1
  - id: mode
    type: b3
    enum: opmode
  - id: unknown3 # always on
    type: b1
  - id: fan_speed
    type: b3
    enum: fan_speed
  - id: temp_set_base
    type: b4
  - id: unknown6
    type: b5
  - id: health
    type: b1
  - id: unknown7 # always off
    type: b1
  - id: temp_set_half_base
    type: b1
  - id: unknown9 # always on
    type: b1
  - id: vertical_flow
    type: b1
  - id: horizontal_flow
    type: b1
  - id: unknown10
    type: b5 # always zeroes
  - id: unknown11
    size: 6
    doc: zeroes
  - id: indoor_temp_base
    type: u1
  - id: unknown12
    doc: bits corresponding to byte 0x1e and 0x11, checksum?
    type: u1
  - id: four_way_valve_on
    type: b1
  - id: unknown13
    type: b5
  - id: sleep
    type: b2
    enum: sleep
  - id: unknown14
    size: 10
  - id: indoor_heat_exchanger_temp_base
    type: u1
  - id: unknown15
    type: u1
    doc: always 0xff
  - id: antifreeze
    type: b1
  - id: unknown16
    type: b7
  - id: mute
    type: b1
  - id: unknown17
    type: b7
  - id: indoor_fan_speed
    type: u1
    enum: indoor_fan_speed
  - id: outdoor_temp_base
    type: u1
  - id: condenser_coil_temp_base
    type: u1
  - id: compressor_discharge_temp_base
    type: u1
  - id: compressor_frequency
    type: u1
  - id: outdoor_fan_speed
    type: u1
  - id: unknown18
    type: b1 # always on
  - id: heat_mode
    type: b1
  - id: unknown19
    type: b2
  - id: outdoor_stuff_running
    type: b4
    enum: outdoor_status # uncertain. Seems to be on when compressor runs, more or less
  - id: unknown20
    size: 4
  - id: supply_voltage
    type: u1
  - id: current_used_amps # range seems to be about 1-3A
    type: u1
  - id: unknown21
    size: 3
  - id: unknown22
    type: b6
  - id: clean_filter
    type: b1
  - id: unknown23
    type: b1
  - id: up_down_flow
    type: u1
    enum: up_down_flow
  - id: left_right_flow
    type: u1
    enum: left_right_flow
  - id: unknown24
    size: 7
  - id: checksum
    type: u1
instances:
  temp_set_in_c:
    value: "16 + temp_set_base + (temp_set_half_base ? 0.5 : 0)"
  temp_set_in_f:
    value: temp_set_in_c * 9/5 + 32
  temp_indoor_in_c:
    value: indoor_temp_base * .3 - 11.5 # yeah, suspicious
  temp_indoor_in_f:
    value: temp_indoor_in_c * 9/5 + 32
  temp_outdoor_in_c:
    value: outdoor_temp_base - 20
  temp_outdoor_in_f:
    value: temp_outdoor_in_c * 9/5 + 32
enums:
  source:
    0x0001: controller
    0x0100: appliance
  command:
    0x03: set_state_response
    0x04: query_state_response
  fan_speed:
    0x00: auto
    0x01: low
    0x02: med
    0x03: high
    0x04: mid_low
    0x05: mid_high
  opmode:
    0x01: cool
    0x02: fan
    0x03: dehumidify
    0x04: heat
    0x05: auto
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
    0x00: auto
    0x01: left_fix
    0x02: middle_left_fix
    0x03: middle_fix
    0x04: middle_right_fix
    0x05: right_fix
    0x08: left_right_flow
    0x10: left_flow
    0x18: middle_flow
    0x20: right_flow
  sleep:
    0x00: off
    0x01: standard
    0x02: elderly
    0x03: child
  indoor_fan_speed:
    0x00: off
    0x3c: low
    0x55: medium
    0x62: high
  outdoor_status:
    0x00: no
    0x0a: yes
