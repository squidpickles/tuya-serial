"""Serial monitor for tuya."""
from datetime import datetime

import serial

MARKER = b"\xbb\x01"


def print_buffer(buffer, timestamp):
    """Print contents of buffer."""
    if buffer.startswith(b"\xbb\x01\x0a"):
        entity = "C"
    elif buffer.startswith(b"\xbb\x01\x00"):
        entity = "A"
    else:
        entity = "?"
    print(timestamp, entity, " ".join([f"{byte:02x}" for byte in buffer]), f"({len(buffer)})")
    print(timestamp, entity, " ".join([f"{byte:>08b}" for byte in buffer]), f"({len(buffer)})")


def main():
    """Main run loop."""
    with serial.Serial("/dev/tty.usbserial-AR0KC21N") as ser:
        buffer = b""
        timestamp = None
        marker_candidate = b""
        while True:
            byte = ser.read()
            if marker_candidate:
                if byte == b"\x01":
                    print_buffer(buffer, timestamp)
                    buffer = marker_candidate + byte
                else:
                    buffer += marker_candidate + byte
                marker_candidate = b""
            elif byte == b"\xbb":
                marker_candidate = byte
                timestamp = datetime.now()
            else:
                buffer += byte


if __name__ == "__main__":
    main()
