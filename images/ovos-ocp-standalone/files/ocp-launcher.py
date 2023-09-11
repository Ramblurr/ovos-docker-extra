#!/usr/bin/env python3
from ovos_plugin_common_play.ocp import OCP
from ovos_utils import wait_for_exit_signal
from ovos_utils.log import init_service_logger, LOG


def main():
    try:
        ocp = OCP()
        ocp.start()
    except ImportError:
        print("OCP is not available")
        ocp = None

    wait_for_exit_signal()

    if ocp:
        ocp.shutdown()


if __name__ == "__main__":
    main()
