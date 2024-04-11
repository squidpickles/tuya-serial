# Pioneer WYT UART reverse engineering mess

This is a bunch of random stuff -- serial captures, notes, utility programs -- that I've been using to reverse engineer the
serial protocol between the Pioneer WYT-series mini-split air conditioners and the Tuya-based WiFi module that they use.

The goal is to be able to control the air conditioner remotely without needing any Tuya cloud services.

## Files/directories
 - `msgs` binary captures of commands (or responses for files ending in `_response`) sent to the air conditioner
 - `logic` - captures in [Salae Logic 2](https://support.saleae.com/logic-software/sw-download) format of serial communication
 - `boot-log` - console log from the ESP8266-based Tuya module booting
 - `cmds` - hex dumps of various commands sent to the air conditioner (`C`) and responses (`A`)
 - `header` - a map of all bytes in a response message from the air conditioner, and their meanings. This will be the most up to date source of information. Many things may be wrong or missing.
 - `monitor.py` - a script used to log the serial communications to a file before I started using a dedicated [esp-link](https://github.com/jeelabs/esp-link) board to capture serial data continuously
 - `power-on-sequence` - some observations on what the system does as it powers on. This has been somewhat helpful for decoding some of the less-commonly changed fields.
 - `tuya.ksy` - a [Kaitai Struct](https://kaitai.io/) file that describes the structure of the command messages sent to the air conditioner. I haven't been putting as much effort into commands as responses, so it may be a little out of date. Works with files in `msgs`.
  - `tuya-response.ksy` - a Kaitai Struct file that describes the structure of the response messages from the air conditioner. The `header` file is probably more up to date, but this is probably more readable, and it's nice to use for visualization. Works with response files in `msgs`.

## Stuff I'm pretty sure about
 - Serial protocol is 9600-8-E-1
 - Each command sends the entire state of the air conditioner, not just the fields that have changed

## See also
 - [pioneer-uart](https://github.com/squidpickles/pioneer-uart) beginnings of an Arduino library implementation based on this work
 - [pioneer_wyt_rs232](https://github.com/jspadaro/pioneer_wyt_rs232) another library in Python based on a separate reverse engineering effort
 - [Pioneer WYT mini split wifi integration](https://community.home-assistant.io/t/pioneer-wyt-mini-split-wifi-integration/434616) a thread on the Home Assistant forums giving some more background on the Tuya module
