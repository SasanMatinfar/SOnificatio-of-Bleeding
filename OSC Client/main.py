"""OSC client
"""
import argparse
import random
import time

from pythonosc import osc_message_builder
from pythonosc import udp_client


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", default="127.0.0.1",
        help="The ip of the OSC server")
    parser.add_argument("--port", type=int, default=57120,
        help="The port the OSC server is listening on")
    args = parser.parse_args()

    client = udp_client.SimpleUDPClient(args.ip, args.port)

fx0 = 0
fx1 = 0
dx = 0
sx = 0
for x in range(1000):
    try:
        temp = fx0 + round(random.uniform(-50, 50))
        if temp < 0:
            fx1 = 0
        elif 0 <= temp <= 100:
            fx1 = temp
        else:
            fx1 = 100
        print("x = " + str(x))
        print("fx1 = " + str(fx1))
        dx = fx1 - fx0
        print("dx = " + str(dx))
        fx0 = fx1
        sx = sx + fx1
        print("sx = " + str(sx))
        client.send_message("/root/x", x)
        client.send_message("/root/fx", fx1)
        client.send_message("/root/dx", dx)
        client.send_message("/root/sx", sx)
        time.sleep(1)
    except (KeyboardInterrupt, SystemExit):
        print("Manual break by user!")
        raise








