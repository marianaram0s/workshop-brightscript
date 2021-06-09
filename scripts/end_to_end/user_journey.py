from support.web_driver import WebDriver
from scenarios.scenario1 import Scenario1
from scenarios.scenario2 import Scenario2

from time import sleep
import sys
import traceback

def setup(ip: str):
    web_driver = WebDriver(ip)
    web_driver.launch_the_channel("dev")
    return web_driver

def tear_down(web_driver: WebDriver):
    web_driver.press_btn('home')
    web_driver.quiet()

def log(s: str):
    ip = sys.argv[1]
    print(f"{ip}: {s}")

def run(ip: str):
    failed_scenarios = 0

    try:
        web_driver = setup(ip)

        # TODO: load scenarios automatically into the array
        scenarios = [
            Scenario2(web_driver)
        ]

        total_scenarios = len(scenarios)

        for n, scenario in enumerate(scenarios, start=1):
            log(f'Scenario {n}: "{scenario.title()}"')

            try:
                scenario.run()
                log(f'Scenario "{scenario.title()}" has passed')
            except Exception as e:
                failed_scenarios += 1
                log(f'Scenario "{scenario.title()}" failed: {e}')

        passed_scenarios = total_scenarios - failed_scenarios
        log(f"{total_scenarios} total, {passed_scenarios} passed, {failed_scenarios} failed.")
    except Exception as e:
        log(f"Error: {e}")
        traceback.print_exc()
        log(f"Test failed")
    finally:
        tear_down(web_driver)

        if failed_scenarios > 0:
            exit(1)
    
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: user_journey.py <ROKU_DEVICE_IP>")
    else:
        run(sys.argv[1])